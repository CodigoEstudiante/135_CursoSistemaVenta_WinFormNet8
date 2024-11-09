
use DBTienda

select * from rol
select * from Usuario

insert into Rol(Nombre) values
('Administrador'),
('Ventas')


insert into Usuario(IdRol,NombreCompleto,Correo,NombreUsuario,Clave,ResetearClave) values
(1,'Jose Mendez','codigo@gmail.com','jmendez',
'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3',0)


--procedimientos rol

create procedure sp_listaRol
as
begin
	select IdRol,Nombre from Rol 
end

exec sp_listaRol

--procedimientos usuario

sp_helptext 'sp_listaCategoria'

  
create procedure sp_listaUsuario
(  
@Buscar varchar(50) = ''  
)  
as  
begin  
 
 select
 u.IdUsuario,
 r.IdRol,
 r.Nombre[NombreRol],
 u.NombreCompleto,
 u.Correo,
 u.NombreUsuario,
 u.Activo
 from 
 Usuario u
 inner join Rol r on r.IdRol = u.IdRol
 where concat(r.Nombre,u.NombreCompleto,u.Correo,u.NombreUsuario,iif(u.activo =1 ,'SI','NO'))   
 like '%' + @Buscar + '%'  
end  

sp_helptext 'sp_crearCategoria'
sp_help Usuario
  
CREATE PROCEDURE sp_crearUsuario(  
@IdRol int,
@NombreCompleto varchar(50),
@Correo varchar(50),
@NombreUsuario varchar(50),
@Clave varchar(100),
@MsjError varchar(100) output  
)  
as  
begin  
 set @MsjError = ''  
  
 if(exists(select * from Usuario where Correo = @Correo))  
 begin  
  set @MsjError = 'El correo ya existe'  
  return  
 end  

  if(exists(select * from Usuario where NombreUsuario = @NombreUsuario))  
 begin  
  set @MsjError = 'El nombre de usuario ya existe'  
  return  
 end  
  
 insert into Usuario(IdRol,NombreCompleto,Correo,NombreUsuario,Clave)  
 values(@IdRol,@NombreCompleto,@Correo,@NombreUsuario,@Clave)  
  
end


ALTER PROCEDURE sp_editarUsuario(
@IdUsuario int,
@IdRol int,
@NombreCompleto varchar(50),
@Correo varchar(50),
@NombreUsuario varchar(50),
@Activo int,
@MsjError varchar(100) output  
)  
as  
begin  
 set @MsjError = ''  
  
 if(exists(select * from Usuario where Correo = @Correo
 and IdUsuario != @IdUsuario
 ))  
 begin  
  set @MsjError = 'El correo ya existe'  
  return  
 end  

  if(exists(select * from Usuario where NombreUsuario = @NombreUsuario
  and IdUsuario != @IdUsuario
  ))  
 begin  
  set @MsjError = 'El nombre de usuario ya existe'  
  return  
 end  
  
  update Usuario set
  IdRol = @IdRol,
  NombreCompleto = @NombreCompleto,
  Correo = @Correo,
  NombreUsuario = @NombreUsuario,
  Activo = @Activo
  where IdUsuario = @IdUsuario

end