CREATE DATABASE EmpresaRespaldo;
GO

USE EmpresaRespaldo;
GO

CREATE TABLE Clientes (
    ID_Cliente INT PRIMARY KEY IDENTITY(1,1),
    Nombre VARCHAR(100),
    Correo VARCHAR(100)
);

CREATE TABLE Ventas (
    ID_Venta INT PRIMARY KEY IDENTITY(1,1),
    ID_Cliente INT,
    Fecha DATE,
    Monto DECIMAL(10,2),
    FOREIGN KEY (ID_Cliente) REFERENCES Clientes(ID_Cliente)
);
GO

INSERT INTO Clientes (Nombre, Correo)
VALUES
('Ana López', 'ana@gmail.com'),
('Carlos Ruiz', 'carlos@gmail.com'),
('María Torres', 'maria@gmail.com'),
('José Pérez', 'jose@gmail.com'),
('Lucía Gómez', 'lucia@gmail.com'),
('Pedro Martínez', 'pedro@gmail.com'),
('Sofía Ramírez', 'sofia@gmail.com'),
('Miguel Herrera', 'miguel@gmail.com'),
('Valeria Cruz', 'valeria@gmail.com'),
('Noel Gavarrete', 'noel@gmail.com');
GO

INSERT INTO Ventas (ID_Cliente, Fecha, Monto)
VALUES
(1, '2026-04-01', 150.00),
(2, '2026-04-02', 300.00),
(3, '2026-04-03', 450.00),
(4, '2026-04-04', 200.00),
(5, '2026-04-05', 600.00),
(6, '2026-04-06', 275.00),
(7, '2026-04-07', 325.00),
(8, '2026-04-08', 180.00),
(9, '2026-04-09', 500.00),
(10, '2026-04-10', 700.00);
GO

select * from Clientes;
select * from Ventas;

-- Respaldo completo--

use master;
go

backup database EmpresaRespaldo
to disk = 'C:\Respaldos\EmpresaRespaldo_Completo.bak'
with init, stats = 10;
go

-- Respaldo diferencial -- 

use EmpresaRespaldo;
go

insert into Ventas(ID_Cliente, Fecha, Monto)
values (1, '2026-04-11', 250.00), (2, '2026-04-12', 350.00);
go

-- comando -- 
use master;
go

backup database EmpresaRespaldo
to disk = 'C:\Respaldos\EmpresaRespaldo_Diferencial.bak'
with differential, init, stats = 10;
go

-- Respaldo del log de transacciones --
alter database EmpresaRespaldo
set recovery full;
go

backup database EmpresaRespaldo
to disk = 'C:\Respaldos\EmpresaRespaldo_Completo_LogBase.bak'
with init, stats = 10;
go

-- hay que hacer otro cambio para que el log tenga actividad nueva -- 
use EmpresaRespaldo;
go

insert into Ventas(ID_Cliente, Fecha, Monto)
values (3, '2026-04-13', 420.00), (4, '2026-04-14', 510.00);
go

-- comando respaldo del log -- 
use master;
go

backup log EmpresaRespaldo
to disk = 'C:\Respaldos\EmpresaRespaldo_Log.trn'
with init, stats = 10;
go

-- Respaldo solo copia

use master;
go

backup database EmpresaRespaldo
to disk = 'C:\Respaldos\EmpresaRespaldo_CopyOnly.bak'
with copy_only, init, stats = 10;
go

-- Restauracion de un respaldo --
restore filelistonly
from disk = 'C:\Respaldos\EmpresaRespaldo_Completo.bak';
go

restore database EmpresaRespaldo_Restaurada
from disk = 'C:\Respaldos\EmpresaRespaldo_Completo_LogBase.bak'
with
    move 'EmpresaRespaldo' to 'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\EmpresaRespaldo_Restaurada.mdf',
    move 'EmpresaRespaldo_log' to 'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\EmpresaRespaldo_Restaurada_log.ldf',
    replace,
    stats = 10;
go

-- despues hay que verificar -- 

use EmpresaRespaldo_Restaurada;
go

select * from Clientes;
select * from Ventas;