IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'SeguridadDB')
BEGIN
CREATE DATABASE SeguridadDB;
END
GO

USE SeguridadDB;
Go

CREATE TABLE UsuariosSistema(
UsuarioID INT IDENTITY(1,1) PRIMARY KEY,
Nombre VARCHAR(50),
Apellido VARCHAR(50),
Correo VARCHAR(100),
FechaRegistro DATE
);

CREATE TABLE RolesSistema(
RolID INT IDENTITY(1,1) PRIMARY KEY,
NombreRol VARCHAR(30),
Descripcion VARCHAR(70)
);

CREATE TABLE Permisos(
PermisoID INT IDENTITY(1,1) PRIMARY KEY,
NombrePermiso VARCHAR(30),
Descripcion VARCHAR(70)
);

CREATE TABLE UsuariosRoles(
UsuarioID INT,
RolID INT,
FechaAsignacion DATE,
PRIMARY KEY (UsuarioID, RolID),
FOREIGN KEY (UsuarioID) REFERENCES UsuariosSistema(UsuarioID),
FOREIGN KEY (RolID) REFERENCES RolesSistema(RolID)
);

CREATE TABLE RegistroActividad(
RegistroID INT IDENTITY(1,1) PRIMARY KEY,
UsuarioID INT,
AccionRealizada VARCHAR(100),
FechaAccion DATETIME,
Estado VARCHAR(20),
FOREIGN KEY (UsuarioID) REFERENCES UsuariosSistema(UsuarioID)
);

CREATE TABLE Sesiones(
SesionID INT IDENTITY(1,1) PRIMARY KEY,
UsuarioID INT,
FechaInicio DATETIME,
FechaFin DATETIME,
FOREIGN KEY (UsuarioID) REFERENCES UsuariosSistema(UsuarioID)
);

-- Creación de Logins y usuarios
CREATE LOGIN gabo_login WITH PASSWORD = 'ilovechocomonkey';
CREATE LOGIN gabriel_login WITH PASSWORD = 'Chocoboy';
CREATE LOGIN valeria_login WITH PASSWORD = '123';
CREATE LOGIN manuel_login WITH PASSWORD = '31416';
CREATE LOGIN dani_login WITH PASSWORD = 'cityboy67';

Use SeguridadDB;
GO

CREATE USER gabo_user FOR LOGIN gabo_login;
CREATE USER gabriel_user FOR LOGIN gabriel_login;
CREATE USER valeria_user FOR LOGIN valeria_login;
CREATE USER manuel_user FOR LOGIN manuel_login;
CREATE USER dani_user FOR LOGIN dani_login;