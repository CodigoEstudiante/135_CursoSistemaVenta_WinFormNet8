

 use DBTienda

 sp_help negocio
 select * from Negocio

 insert into Negocio(RazonSocial,RUC,Direccion,Celular,Correo,SimboloMoneda,NombreLogo,UrlLogo)
 values ('CodigoEstudiante','100100100','av.esperanza 123','900800700','ce@gmail.com','S/.','','')


 CREATE PROCEDURE sp_obtenerNegocio
 as
 begin
	 select RazonSocial,RUC,Direccion,Celular,Correo,SimboloMoneda,NombreLogo,UrlLogo
	 from Negocio where IdNegocio = 1
 end

 exec sp_obtenerNegocio


 create procedure sp_editarNegocio
 (
@RazonSocial varchar(100),
@RUC varchar(20),
@Direccion varchar(100),
@Celular varchar(10),
@Correo varchar(30),
@SimboloMoneda varchar(5),
@NombreLogo varchar(100),
@UrlLogo varchar(200)
 )
 as
 begin
	update Negocio set
	RazonSocial = @RazonSocial,
	RUC = @RUC,
	Direccion = @Direccion,
	Celular = @Celular,
	Correo = @Correo,
	SimboloMoneda = @SimboloMoneda,
	NombreLogo = @NombreLogo,
	UrlLogo = @UrlLogo
	where IdNegocio = 1
 end