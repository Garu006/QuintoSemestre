create database InventarioDB
go

use InventarioDB
go

create table Inventario(
	idProducto int primary key,
	stock int
)
go

insert into Inventario(idProducto, stock)
values(1, 100), (2, 30), (3,20)