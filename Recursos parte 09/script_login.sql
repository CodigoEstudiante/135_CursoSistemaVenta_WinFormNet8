

select * from usuario


create procedure sp_login(
@NombreUsuario varchar(10),
@Clave varchar(100)
)
as
begin

	select
	u.IdUsuario,
	u.NombreCompleto,
	r.IdRol,
	r.Nombre[NombreRol],
	u.Correo,
	u.NombreUsuario,
	u.ResetearClave,
	u.Activo
	from Usuario u 
	inner join rol r on r.IdRol = u.IdRol
	where 
	NombreUsuario = @NombreUsuario and
	Clave = @Clave

end


create proc sp_verificarCorreo(
@Correo varchar(50),
@IdUsuario int output
)
as
begin
	if(exists(select * from Usuario where Correo = @Correo))
		set @IdUsuario = (select IdUsuario from Usuario where Correo = @Correo)
	else
		set @IdUsuario = 0
end

create proc sp_actualizarClave(
@IdUsuario int,
@NuevaClave varchar(100),
@Resetear bit
)
as
begin
	update Usuario
	set Clave = @NuevaClave , ResetearClave = @Resetear
	where IdUsuario = @IdUsuario
end