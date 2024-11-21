
use dbtienda



create procedure sp_reporteVenta(
@FechaInicio varchar(10),
@FechaFin varchar(10)
)
as
begin
	
	set dateformat dmy

	select
	v.NumeroVenta,
	u.NombreUsuario,
	convert(char(10),v.fechaRegistro,103)[FechaRegistro],
	p.Descripcion[Producto],
	p.PrecioCompra,
	dv.PrecioVenta,
	dv.Cantidad,
	dv.PrecioTotal
	from Venta v
	inner join Usuario u on u.IdUsuario = v.IdUsuarioRegistro
	inner join DetalleVenta dv on dv.IdVenta = v.IdVenta
	inner join Producto p on p.IdProducto = dv.IdProducto
	where
	CONVERT(date,v.fecharegistro) between convert(date,@FechaInicio) and convert(date,@FechaFin)
	
end