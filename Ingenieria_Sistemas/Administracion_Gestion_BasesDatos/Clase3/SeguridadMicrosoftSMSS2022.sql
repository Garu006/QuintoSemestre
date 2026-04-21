DROP DATABASE EmpresaDB;
DROP LOGIN usuario_reportes;

CREATE DATABASE EmpresaDB;
CREATE LOGIN usuario_reportes
WITH PASSWORD = '1234'

USE EmpresaDB;
GO

CREATE USER usuario_reportes
FOR LOGIN usuario_reportes

CREATE ROLE rol_reportes;
CREATE TABLE Clientes (
	Id INT PRIMARY KEY,
	Nombre VARCHAR(50)
);

GRANT SELECT, INSERT ON Clientes TO rol_reportes;

ALTER ROLE rol_reportes
ADD MEMBER usuario_reportes 