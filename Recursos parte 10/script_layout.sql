
select * from Menu
select * from Rol
select * from MenuRol


--insertar los menus principales
insert into menu(NombreMenu) values
('ventas'),
('inventario'),
('reportes'),
('usuarios'),
('configuracion')

insert into menu(NombreMenu,IdMenuPadre) values
('nuevo',1),
('historial',1)

insert into menu(NombreMenu,IdMenuPadre) values
('productos',2),
('categorias',2)

insert into menu(NombreMenu,IdMenuPadre) values
('ventas',3)

--administrador
insert into MenuRol(IdMenu,IdRol) values
(1,1),
(2,1),
(3,1),
(4,1),
(5,1),
(6,1),
(7,1),
(8,1),
(9,1),
(10,1)



--ventas
insert into MenuRol(IdMenu,IdRol) values
(1,2),
(6,2),
(7,2)



create proc sp_obtenerMenus(
@IdRol int
)
as
begin
	select 
	m.NombreMenu,
	m.IdMenuPadre,
	mr.Activo
	from MenuRol mr
	inner join Menu m on m.IdMenu = mr.IdMenu
	where mr.IdRol = @IdRol
end