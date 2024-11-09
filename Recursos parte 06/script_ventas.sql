

use dbtienda

--001-001

select * from CorrelativoVenta

insert into CorrelativoVenta(Serie,Numero,Activo)
values
('001',0,1),
('002',0,0)


create procedure sp_obtenerProducto
(
@Codigo varchar(50)
)
as
begin
	
	select
	p.IdProducto,
	c.Nombre[NombreCategoria],
	m.Equivalente,
	m.Valor,
	p.Codigo,
	p.Descripcion,
	p.PrecioVenta,
	p.Cantidad
	from Producto p
	inner join Categoria c on c.IdCategoria = p.IdCategoria
	inner join Medida m on m.IdMedida = c.IdMedida
	where
	p.Cantidad > 0 and
	p.Activo = 1 and
	p.Codigo = @Codigo

end


create procedure sp_registrarVenta(
@VentaXml xml,
@NumeroVenta varchar(10) output
)
as
begin

	declare @idVenta int

	declare @venta table (
	IdUsuarioRegistro int,
	NombreCliente varchar(60),
	PrecioTotal decimal(10,2),
	PagoCon decimal(10,2),
	Cambio decimal(10,2)
	)

	declare @detalleventa table (
	IdProducto int,
	Cantidad int,
	PrecioVenta decimal(10,2),
	PrecioTotal decimal(10,2)
	)

	begin try

		begin transaction

			insert into @venta(IdUsuarioRegistro,NombreCliente,PrecioTotal,PagoCon,Cambio)
			select
			x.value('IdUsuarioRegistro[1]','INT') as IdUsuarioRegistro,
			x.value('NombreCliente[1]','varchar(60)') as NombreCliente,
			x.value('PrecioTotal[1]', 'decimal(10,2)') as PrecioTotal,
			x.value('PagoCon[1]', 'decimal(10,2)') as PagoCon,
			x.value('Cambio[1]', 'decimal(10,2)') as Cambio
			from
			@VentaXml.nodes('Venta') as T(x)

			insert into @detalleventa(IdProducto,Cantidad,PrecioVenta,PrecioTotal)
			select
			x.value('IdProducto[1]', 'int') as IdProducto,
			x.value('Cantidad[1]', 'int') as Cantidad,
			x.value('PrecioVenta[1]', 'decimal(10,2)') as PrecioVenta,
			x.value('PrecioTotal[1]', 'decimal(10,2)') as PrecioTotal
			from
			@VentaXml.nodes('Venta/DetalleVenta/Item') as T(x)

			update CorrelativoVenta set
			Numero = Numero + 1,
			@NumeroVenta = Concat(Serie,'-', right('000000' + cast(Numero + 1 as varchar),6))
			where Activo = 1

			insert into Venta(NumeroVenta,IdUsuarioRegistro,NombreCliente,PrecioTotal,PagoCon,Cambio)
			select @NumeroVenta,IdUsuarioRegistro,NombreCliente,PrecioTotal,PagoCon,Cambio from @venta

			set @idVenta = scope_identity()

			insert into DetalleVenta(IdVenta,IdProducto,Cantidad,PrecioVenta,PrecioTotal)
			select @idVenta, IdProducto,Cantidad,PrecioVenta,PrecioTotal from @detalleventa

			update p set 
			p.Cantidad = p.cantidad - dv.cantidad
			from Producto p 
			inner join @detalleventa dv on dv.IdProducto = p.IdProducto


		commit transaction
	end try
	begin catch
		rollback transaction
		set @NumeroVenta = ''
	end catch
end

create procedure sp_ObtenerVenta(
@NumeroVenta varchar(10)
)
as
begin
	select 
	v.IdVenta,
	v.NumeroVenta,
	u.NombreUsuario,
	v.NombreCliente,
	v.PrecioTotal,
	v.PagoCon,
	v.Cambio,
	convert(char(10), v.FechaRegistro,103)[FechaRegistro]
	from Venta v
	inner join Usuario u on u.IdUsuario = v.IdUsuarioRegistro
	where v.NumeroVenta = @NumeroVenta

end



create procedure sp_ObtenerDetalleVenta(
@NumeroVenta varchar(10)
)
as
begin

	select 
	p.Descripcion,
	m.Abreviatura,
	m.Valor,
	dv.Cantidad,
	dv.PrecioVenta,
	dv.PrecioTotal
	from DetalleVenta dv
	inner join Venta v on v.IdVenta = dv.IdVenta
	inner join Producto p on p.IdProducto = dv.IdProducto
	inner join Categoria c on c.IdCategoria = p.IdCategoria
	inner join Medida m on m.IdMedida = c.IdMedida
	where v.NumeroVenta = @NumeroVenta
end


sp_help venta
sp_help Detalleventa