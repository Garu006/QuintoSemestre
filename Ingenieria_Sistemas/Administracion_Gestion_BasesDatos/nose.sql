--procedimiento almacenado
create procedure SP_Show_Cliente
as
begin
	select * from Clientes
end

exec SP_Show_Cliente

--procedimiento para buscar nombre de los clientes
create procedure SP_Buscar_Clr_Nombre
	@nombre nvarchar(100)
as
begin
	if(@nombre is null)
	begin
		print('Debe ingresar un nombre')
		return
	end -- like sirve para comparar
	select * from Clientes where Nombres like '%' + @nombre + '%'
end

exec SP_Buscar_Clr_Nombre ''

-- procedimiento para buscar apellido de los clientes
create procedure SP_Buscar_Clr_Apellido
	@apellido nvarchar(100)
as
begin
	if(@apellido is null)
	begin
		print('Debe ingresar un apellido')
		return
	end
	select * from Clientes where Apellidos like '%' + @apellido + '%'
end

exec SP_Buscar_Clr_Apellido ''

--procedimiento para buscar ciudadID
create procedure SP_Buscar_CiuID
as
begin
	select * from Ciudades
end

exec SP_Buscar_CiuID 

--procedimiento para buscar correo electronico
create procedure SP_Search_Email
	@email nvarchar(150)
as
begin
	if(@email is null)
	begin 
		print('Debe ingresar un correo electrónico')
		return
	end
	select * from Clientes where Email like '%' + @email + '%'
end

exec SP_Search_Email ''

--procedimiento para buscar telefono
create procedure SP_buscar_telefono
	@telefono nvarchar(20)
as
begin
	if(@telefono is null)
	begin
		print('Debe ingresar un número telefonico')
		return
	end
	select * from Clientes where Telefono like '%' + @telefono + '%'
end

exec SP_buscar_telefono ''

--procedimiento para insertar cliente
create procedure SP_Insertar_Cliente
as
begin
	insert into Clientes(Nombres, Apellidos, CiudadID, Email, Telefono)
	values ('gabriel', 'rojas', 10,'garojas@uamv.edu.ni' '78579233')
	print 'registro guardado'
end
go

exec SP_Insertar_Cliente
	@nombre = 'gabriel',
	@apellido = 'rojas',
	@CiuID = 10,
	@email = 'garojas@uamv.edu.ni',
	@telefono = '78579233'