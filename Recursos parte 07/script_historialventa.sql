

select * from venta


alter procedure sp_listaVenta(
@FechaInicio varchar(10),
@FechaFin varchar(10),
@Buscar varchar(50) = ''
)as
begin
	set dateformat dmy
	
	select
	v.NumeroVenta,
	u.NombreUsuario,
	v.NombreCliente,
	v.PrecioTotal,
	v.PagoCon,
	v.Cambio,
	CONVERT(char(10),v.FechaRegistro,103)[FechaRegistro]
	from
	Venta v
	inner join Usuario u on u.IdUsuario = v.IdUsuarioRegistro
	where
	CONVERT(date,v.FechaRegistro) between CONVERT(date,@FechaInicio) and CONVERT(date,@FechaFin)
	and CONCAT(v.NumeroVenta,u.NombreUsuario,v.NombreCliente) like '%' + @Buscar + '%'

end