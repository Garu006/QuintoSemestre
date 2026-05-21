/* ============================================================
   PROYECTO: Recursos Académicos UAM
   OBJETIVO:
   Crear una base de datos para que los profesores puedan
   registrar, consultar y organizar recursos académicos como
   videos, libros, PDF, presentaciones o enlaces, clasificados
   por carrera y clase.
   ============================================================ */

-- Creación de la base de datos principal del proyecto
CREATE DATABASE RecursosAcademicosUAM;
GO

-- Se selecciona la base de datos para trabajar dentro de ella
USE RecursosAcademicosUAM;
GO

/* ============================================================
   TABLA: Facultades
   Esta tabla almacena las facultades de la universidad.
   Ejemplo: Facultad de Ingeniería y Arquitectura.
   ============================================================ */
CREATE TABLE Facultades (
    IdFacultad INT IDENTITY(1,1) PRIMARY KEY, -- Identificador único de la facultad
    NombreFacultad VARCHAR(100) NOT NULL UNIQUE -- Nombre de la facultad, no se puede repetir
);
GO

/* ============================================================
   TABLA: Carreras
   Esta tabla almacena las carreras disponibles en la UAM.
   Cada carrera pertenece a una facultad.
   ============================================================ */
CREATE TABLE Carreras (
    IdCarrera INT IDENTITY(1,1) PRIMARY KEY, -- Identificador único de la carrera
    NombreCarrera VARCHAR(150) NOT NULL, -- Nombre de la carrera
    IdFacultad INT NOT NULL, -- Facultad a la que pertenece la carrera

    CONSTRAINT FK_Carreras_Facultades 
    FOREIGN KEY (IdFacultad)
    REFERENCES Facultades(IdFacultad)
);
GO

/* ============================================================
   TABLA: Profesores
   Esta tabla almacena los datos de los profesores que podrán
   registrar o administrar recursos académicos.
   ============================================================ */
CREATE TABLE Profesores (
    IdProfesor INT IDENTITY(1,1) PRIMARY KEY, -- Identificador único del profesor
    Nombre VARCHAR(100) NOT NULL, -- Nombre completo del profesor
    Correo VARCHAR(150) NOT NULL UNIQUE, -- Correo institucional o académico
    Departamento VARCHAR(100) -- Departamento al que pertenece
);
GO

/* ============================================================
   TABLA: Clases
   Esta tabla representa las asignaturas o clases.
   Cada clase pertenece a una carrera.
   ============================================================ */
CREATE TABLE Clases (
    IdClase INT IDENTITY(1,1) PRIMARY KEY, -- Identificador único de la clase
    NombreClase VARCHAR(150) NOT NULL, -- Nombre de la clase
    Codigo VARCHAR(20) NOT NULL UNIQUE, -- Código único de la clase
    IdCarrera INT NOT NULL, -- Carrera a la que pertenece la clase

    CONSTRAINT FK_Clases_Carreras 
    FOREIGN KEY (IdCarrera)
    REFERENCES Carreras(IdCarrera)
);
GO

/* ============================================================
   TABLA: TiposRecurso
   Esta tabla sirve como catálogo para clasificar los recursos.
   Ejemplo: Video, Libro, PDF, Presentación, Enlace web.
   ============================================================ */
CREATE TABLE TiposRecurso (
    IdTipoRecurso INT IDENTITY(1,1) PRIMARY KEY, -- Identificador del tipo de recurso
    NombreTipo VARCHAR(50) NOT NULL UNIQUE -- Nombre del tipo de recurso
);
GO

/* ============================================================
   TABLA: Recursos
   Esta es la tabla principal del sistema.
   Almacena los recursos académicos y los relaciona con:
   - una clase
   - un profesor
   - un tipo de recurso
   ============================================================ */
CREATE TABLE Recursos (
    IdRecurso INT IDENTITY(1,1) PRIMARY KEY, -- Identificador único del recurso
    Titulo VARCHAR(150) NOT NULL, -- Título del recurso académico
    Descripcion VARCHAR(300), -- Breve descripción del recurso
    Enlace VARCHAR(300) NOT NULL, -- URL o ubicación del recurso
    FechaPublicacion DATETIME DEFAULT GETDATE(), -- Fecha automática de publicación
    IdClase INT NOT NULL, -- Clase a la que pertenece el recurso
    IdProfesor INT NOT NULL, -- Profesor que registró el recurso
    IdTipoRecurso INT NOT NULL, -- Tipo de recurso

    CONSTRAINT FK_Recursos_Clases 
    FOREIGN KEY (IdClase)
    REFERENCES Clases(IdClase),

    CONSTRAINT FK_Recursos_Profesores 
    FOREIGN KEY (IdProfesor)
    REFERENCES Profesores(IdProfesor),

    CONSTRAINT FK_Recursos_TiposRecurso 
    FOREIGN KEY (IdTipoRecurso)
    REFERENCES TiposRecurso(IdTipoRecurso)
);
GO

/* ============================================================
   INSERCIÓN DE DATOS DE PRUEBA
   Estos datos permiten probar que las tablas y relaciones
   funcionan correctamente.
   ============================================================ */

-- Registro de facultades
INSERT INTO Facultades (NombreFacultad) VALUES
('Facultad de Ingeniería y Arquitectura'),
('Facultad de Ciencias Económicas y Administrativas');
GO

-- Registro de carreras asociadas a facultades
INSERT INTO Carreras (NombreCarrera, IdFacultad) VALUES
('Ingeniería en Sistemas de Información', 1),
('Arquitectura', 1),
('Administración de Empresas', 2);
GO

-- Registro de profesores
INSERT INTO Profesores (Nombre, Correo, Departamento) VALUES
('Carlos Mendoza', 'carlos.mendoza@uam.edu.ni', 'Sistemas'),
('Ana López', 'ana.lopez@uam.edu.ni', 'Matemática'),
('Luis Ramírez', 'luis.ramirez@uam.edu.ni', 'Administración');
GO

-- Registro de clases o asignaturas
INSERT INTO Clases (NombreClase, Codigo, IdCarrera) VALUES
('Administración y Gestión de Bases de Datos', 'SIS0211', 1),
('Programación Orientada a Objetos II', 'SIS0208', 1),
('Cálculo I', 'MAT0101', 1),
('Gestión Empresarial', 'ADM0101', 3);
GO

-- Registro de tipos de recursos académicos
INSERT INTO TiposRecurso (NombreTipo) VALUES
('Video'),
('Libro'),
('PDF'),
('Presentación'),
('Enlace web');
GO

-- Registro de recursos académicos
INSERT INTO Recursos (Titulo, Descripcion, Enlace, IdClase, IdProfesor, IdTipoRecurso) VALUES
('Guía introductoria de SQL Server', 
 'Documento de apoyo para consultas básicas y creación de tablas.', 
 'https://ejemplo.com/sqlserver-guia', 
 1, 1, 3),

('Video sobre Docker y SQL Server', 
 'Clase grabada sobre despliegue de SQL Server usando Docker.', 
 'https://ejemplo.com/docker-sqlserver', 
 1, 1, 1),

('Libro básico de programación orientada a objetos', 
 'Material de lectura para reforzar conceptos de clases y objetos.', 
 'https://ejemplo.com/libro-poo', 
 2, 1, 2),

('Presentación de cálculo diferencial', 
 'Diapositivas utilizadas en clase para explicar límites y derivadas.', 
 'https://ejemplo.com/calculo-presentacion', 
 3, 2, 4),

('Lectura sobre gestión administrativa', 
 'Recurso complementario para la clase de gestión empresarial.', 
 'https://ejemplo.com/gestion-admin', 
 4, 3, 5);
GO

/* ============================================================
   CONSULTAS DE VERIFICACIÓN
   Estas consultas sirven para comprobar que los datos fueron
   insertados correctamente.
   ============================================================ */

SELECT * FROM Facultades;
SELECT * FROM Carreras;
SELECT * FROM Profesores;
SELECT * FROM Clases;
SELECT * FROM TiposRecurso;
SELECT * FROM Recursos;
GO

/* ============================================================
   CONSULTA GENERAL DE RECURSOS
   Esta consulta muestra los recursos junto con su clase,
   carrera, profesor y tipo de recurso.
   Es útil para comprobar las relaciones entre tablas.
   ============================================================ */
SELECT 
    r.Titulo,
    tr.NombreTipo AS TipoRecurso,
    c.NombreClase,
    ca.NombreCarrera,
    p.Nombre AS Profesor,
    r.Enlace
FROM Recursos r
INNER JOIN Clases c 
    ON r.IdClase = c.IdClase
INNER JOIN Carreras ca 
    ON c.IdCarrera = ca.IdCarrera
INNER JOIN Profesores p 
    ON r.IdProfesor = p.IdProfesor
INNER JOIN TiposRecurso tr 
    ON r.IdTipoRecurso = tr.IdTipoRecurso;
GO

/* ============================================================
   SEGURIDAD Y GOBIERNO DE DATOS
   En esta sección se crean logins, usuarios, roles y permisos.
   Esto permite controlar quién puede ver, insertar, modificar
   o eliminar información en la base de datos.
   ============================================================ */

-- Creación de logins a nivel servidor
CREATE LOGIN admin_recursos WITH PASSWORD = 'AdminUAM2026*';
CREATE LOGIN profesor_recursos WITH PASSWORD = 'ProfesorUAM2026*';
CREATE LOGIN consulta_recursos WITH PASSWORD = 'ConsultaUAM2026*';
GO

-- Se selecciona nuevamente la base de datos
USE RecursosAcademicosUAM;
GO

-- Creación de usuarios dentro de la base vinculados a los logins
CREATE USER admin_recursos FOR LOGIN admin_recursos;
CREATE USER profesor_recursos FOR LOGIN profesor_recursos;
CREATE USER consulta_recursos FOR LOGIN consulta_recursos;
GO

-- Creación de roles personalizados
CREATE ROLE rol_administrador_recursos;
CREATE ROLE rol_profesor_recursos;
CREATE ROLE rol_consulta_recursos;
GO

-- Asignación de usuarios a sus roles correspondientes
ALTER ROLE rol_administrador_recursos ADD MEMBER admin_recursos;
ALTER ROLE rol_profesor_recursos ADD MEMBER profesor_recursos;
ALTER ROLE rol_consulta_recursos ADD MEMBER consulta_recursos;
GO

/* ============================================================
   ASIGNACIÓN DE PERMISOS
   Aquí se define qué puede hacer cada rol.
   ============================================================ */

-- El administrador puede consultar, insertar, actualizar y eliminar datos
GRANT SELECT, INSERT, UPDATE, DELETE ON Facultades TO rol_administrador_recursos;
GRANT SELECT, INSERT, UPDATE, DELETE ON Carreras TO rol_administrador_recursos;
GRANT SELECT, INSERT, UPDATE, DELETE ON Profesores TO rol_administrador_recursos;
GRANT SELECT, INSERT, UPDATE, DELETE ON Clases TO rol_administrador_recursos;
GRANT SELECT, INSERT, UPDATE, DELETE ON TiposRecurso TO rol_administrador_recursos;
GRANT SELECT, INSERT, UPDATE, DELETE ON Recursos TO rol_administrador_recursos;

-- El profesor puede consultar catálogos y administrar recursos académicos
GRANT SELECT ON Facultades TO rol_profesor_recursos;
GRANT SELECT ON Carreras TO rol_profesor_recursos;
GRANT SELECT ON Profesores TO rol_profesor_recursos;
GRANT SELECT ON Clases TO rol_profesor_recursos;
GRANT SELECT ON TiposRecurso TO rol_profesor_recursos;
GRANT SELECT, INSERT, UPDATE ON Recursos TO rol_profesor_recursos;

-- El usuario de consulta solo puede visualizar información
GRANT SELECT ON Facultades TO rol_consulta_recursos;
GRANT SELECT ON Carreras TO rol_consulta_recursos;
GRANT SELECT ON Profesores TO rol_consulta_recursos;
GRANT SELECT ON Clases TO rol_consulta_recursos;
GRANT SELECT ON TiposRecurso TO rol_consulta_recursos;
GRANT SELECT ON Recursos TO rol_consulta_recursos;
GO

/* ============================================================
   AUDITORÍA BÁSICA DE ACCESOS
   Esta tabla permite registrar acciones importantes dentro del
   sistema, como creación, actualización o consulta de recursos.
   ============================================================ */
CREATE TABLE AuditoriaAccesos (
    IdAuditoria INT IDENTITY(1,1) PRIMARY KEY, -- Identificador único de auditoría
    Usuario VARCHAR(100), -- Usuario que realizó la acción
    Accion VARCHAR(100), -- Acción realizada
    TablaAfectada VARCHAR(100), -- Tabla donde ocurrió la acción
    FechaAccion DATETIME DEFAULT GETDATE() -- Fecha automática de la acción
);
GO

-- Ejemplos manuales de auditoría
INSERT INTO AuditoriaAccesos (Usuario, Accion, TablaAfectada)
VALUES 
('admin_recursos', 'Creación de recurso académico', 'Recursos'),
('profesor_recursos', 'Actualización de enlace de recurso', 'Recursos'),
('consulta_recursos', 'Consulta de recursos por clase', 'Recursos');
GO

-- Consulta para verificar los registros de auditoría
SELECT * FROM AuditoriaAccesos;
GO

/* ============================================================
   2. OPTIMIZACIÓN Y MANTENIMIENTO
   ============================================================ */

/* ============================================================
   IDENTIFICACIÓN DE PROBLEMAS DE RENDIMIENTO
   Estas consultas ayudan a detectar posibles problemas
   relacionados con índices faltantes, consultas lentas
   y uso de recursos en SQL Server.
   ============================================================ */

-- Ver estadísticas generales de uso de índices
SELECT 
    OBJECT_NAME(s.object_id) AS Tabla,
    i.name AS Indice,
    s.user_seeks,
    s.user_scans,
    s.user_lookups,
    s.user_updates
FROM sys.dm_db_index_usage_stats s
INNER JOIN sys.indexes i
    ON s.object_id = i.object_id
    AND s.index_id = i.index_id
WHERE database_id = DB_ID()
ORDER BY s.user_scans DESC;
GO

-- Detectar índices faltantes sugeridos por SQL Server
SELECT 
    mid.statement AS Tabla,
    mid.equality_columns AS ColumnasIgualdad,
    mid.inequality_columns AS ColumnasRango,
    mid.included_columns AS ColumnasIncluidas,
    migs.unique_compiles,
    migs.user_seeks,
    migs.avg_total_user_cost
FROM sys.dm_db_missing_index_details mid
INNER JOIN sys.dm_db_missing_index_groups mig
    ON mid.index_handle = mig.index_handle
INNER JOIN sys.dm_db_missing_index_group_stats migs
    ON mig.index_group_handle = migs.group_handle
ORDER BY migs.avg_total_user_cost DESC;
GO

/* ============================================================
   IMPLEMENTACIÓN DE ÍNDICES
   Se crean índices para mejorar el rendimiento de búsquedas,
   joins y consultas frecuentes.
   ============================================================ */

-- Índice para búsquedas de clases por carrera
CREATE INDEX IX_Clases_IdCarrera
ON Clases(IdCarrera);
GO

-- Índice para búsquedas de recursos por clase
CREATE INDEX IX_Recursos_IdClase
ON Recursos(IdClase);
GO

-- Índice para búsquedas de recursos por profesor
CREATE INDEX IX_Recursos_IdProfesor
ON Recursos(IdProfesor);
GO

-- Índice para búsquedas de recursos por tipo
CREATE INDEX IX_Recursos_IdTipoRecurso
ON Recursos(IdTipoRecurso);
GO

-- Índice para búsquedas rápidas por título del recurso
CREATE INDEX IX_Recursos_Titulo
ON Recursos(Titulo);
GO

/* ============================================================
   OPTIMIZACIÓN DE CONSULTAS
   Ejemplo de consulta optimizada utilizando joins correctos
   y selección específica de columnas.
   ============================================================ */

SELECT 
    r.Titulo,
    c.NombreClase,
    p.Nombre AS Profesor,
    tr.NombreTipo,
    r.FechaPublicacion
FROM Recursos r
INNER JOIN Clases c
    ON r.IdClase = c.IdClase
INNER JOIN Profesores p
    ON r.IdProfesor = p.IdProfesor
INNER JOIN TiposRecurso tr
    ON r.IdTipoRecurso = tr.IdTipoRecurso
WHERE tr.NombreTipo = 'PDF'
ORDER BY r.FechaPublicacion DESC;
GO

/* ============================================================
   REVISIÓN DE CONFIGURACIONES CRÍTICAS
   Estas consultas permiten verificar configuraciones
   importantes del servidor SQL Server.
   ============================================================ */

-- Ver configuración de memoria del servidor
EXEC sp_configure 'max server memory';
GO

-- Ver configuración de conexiones remotas
EXEC sp_configure 'remote access';
GO

-- Ver configuración de procesos de usuario
EXEC sp_configure 'user connections';
GO

-- Mostrar configuraciones avanzadas habilitadas
EXEC sp_configure 'show advanced options';
GO

/* ============================================================
   MANTENIMIENTO PREVENTIVO
   Acciones recomendadas para mantener el rendimiento
   y estabilidad de la base de datos.
   ============================================================ */

-- Actualizar estadísticas de toda la base de datos
EXEC sp_updatestats;
GO

-- Reorganizar índices fragmentados
ALTER INDEX ALL ON Recursos REORGANIZE;
ALTER INDEX ALL ON Clases REORGANIZE;
ALTER INDEX ALL ON Carreras REORGANIZE;
GO

-- Reconstruir índices completamente
ALTER INDEX ALL ON Recursos REBUILD;
ALTER INDEX ALL ON Clases REBUILD;
ALTER INDEX ALL ON Carreras REBUILD;
GO

-- Verificar integridad de la base de datos
DBCC CHECKDB ('RecursosAcademicosUAM');
GO

-- Liberar caché de procedimientos (solo para mantenimiento avanzado)
-- DBCC FREEPROCCACHE;
-- GO

/* ============================================================
   CONSULTA PARA MONITOREAR TAMAÑO DE TABLAS
   ============================================================ */

EXEC sp_spaceused 'Recursos';
EXEC sp_spaceused 'Clases';
EXEC sp_spaceused 'Profesores';
GO

/* ============================================================
   CONSULTA PARA DETECTAR FRAGMENTACIÓN DE ÍNDICES
   ============================================================ */

SELECT 
    OBJECT_NAME(ps.object_id) AS Tabla,
    i.name AS Indice,
    ps.avg_fragmentation_in_percent,
    ps.page_count
FROM sys.dm_db_index_physical_stats
    (DB_ID(), NULL, NULL, NULL, 'LIMITED') ps
INNER JOIN sys.indexes i
    ON ps.object_id = i.object_id
    AND ps.index_id = i.index_id
WHERE ps.avg_fragmentation_in_percent > 10
ORDER BY ps.avg_fragmentation_in_percent DESC;
GO

/* =========================================================
   3. RESPALDO Y RECUPERACIÓN - RECURSOS ACADÉMICOS UAM
   ========================================================= */

USE master;
GO

/* ---------------------------------------------------------
   3.1. CONFIGURACIÓN DEL MODO DE RECUPERACIÓN
   --------------------------------------------------------- */
-- Cambiar a modelo FULL para permitir respaldos de Log y recuperación Point-in-Time
ALTER DATABASE RecursosAcademicosUAM SET RECOVERY FULL;
GO

-- Verificación 
SELECT name, recovery_model_desc 
FROM sys.databases 
WHERE name = 'RecursosAcademicosUAM';
GO


/* ---------------------------------------------------------
   3.2. CREACIÓN DE RESPALDOS
   --------------------------------------------------------- */

-- A. Respaldo Completo (Full)
BACKUP DATABASE RecursosAcademicosUAM
TO DISK = 'C:\Respaldos\RecursosAcademicosUAM_Full.bak'
WITH FORMAT, 
     INIT, 
     NAME = 'Respaldo Completo - Recursos Académicos UAM',
     STATS = 10;
GO

-- B. Respaldo Diferencial
BACKUP DATABASE RecursosAcademicosUAM
TO DISK = 'C:\Respaldos\RecursosAcademicosUAM_Diff.bak'
WITH DIFFERENTIAL,
     NOINIT,
     NAME = 'Respaldo Diferencial - Recursos Académicos UAM',
     STATS = 10;
GO

-- C. Respaldo del Registro de Transacciones (Log)
BACKUP LOG RecursosAcademicosUAM
TO DISK = 'C:\Respaldos\RecursosAcademicosUAM_Log.trn'
WITH NOINIT,
     NAME = 'Respaldo del Log - Recursos Académicos UAM',
     STATS = 10;
GO


/* ---------------------------------------------------------
   3.3. PRUEBAS DE RESTAURACIÓN
   --------------------------------------------------------- */

-- Paso 1: Restaurar el respaldo completo original con NORECOVERY
RESTORE DATABASE RecursosUAM_Prueba
FROM DISK = 'C:\Respaldos\RecursosAcademicosUAM_Full.bak'
WITH MOVE 'RecursosAcademicosUAM' TO 'C:\Respaldos\RecursosUAM_Prueba.mdf',
     MOVE 'RecursosAcademicosUAM_log' TO 'C:\Respaldos\RecursosUAM_Prueba_log.ldf',
     NORECOVERY, 
     REPLACE;
GO

-- Paso 2: Aplicar el respaldo diferencial con NORECOVERY
RESTORE DATABASE RecursosUAM_Prueba
FROM DISK = 'C:\Respaldos\RecursosAcademicosUAM_Diff.bak'
WITH NORECOVERY;
GO

-- Paso 3: Aplicar el log de transacciones y poner la BD en línea (RECOVERY)
RESTORE LOG RecursosUAM_Prueba
FROM DISK = 'C:\Respaldos\RecursosAcademicosUAM_Log.trn'
WITH RECOVERY;
GO

-- Verificación para confirmar que la BD de prueba está operativa
SELECT name, state_desc FROM sys.databases WHERE name = 'RecursosUAM_Prueba';
GO


/* ---------------------------------------------------------
   3.4. POLÍTICAS DE RETENCIÓN DE DATOS (Desarrollado y ejecutable)
   --------------------------------------------------------- */
-- Definimos la variable para calcular la fecha límite (Ejemplo: borrar archivos de más de 30 días)
DECLARE @FechaLimite DATETIME;
SET @FechaLimite = DATEADD(day, -30, GETDATE());

-- 1. Purga lágica: Elimina el historial antiguo de respaldos dentro de la base de datos 'msdb'
EXEC msdb.dbo.sp_delete_backuphistory @oldest_date = @FechaLimite;

-- 2. Purga física: Elimina del disco C:\Respaldos los archivos físicos obsoletos
-- Parámetros de xp_delete_file: (0 = Archivo de backup, 'Ruta\', 'Extensión', FechaLímite, Subcarpetas 0=No/1=Sí)
EXEC master.dbo.xp_delete_file 0, N'C:\Respaldos\', N'bak', @FechaLimite, 0;
EXEC master.dbo.xp_delete_file 0, N'C:\Respaldos\', N'trn', @FechaLimite, 0;

PRINT 'Política de retención ejecutada: Historial y archivos físicos de más de 30 días purgados con éxito.';
GO

/* ============================================================
   4. MONITOREO Y AUTOMATIZACIÓN - RECURSOS ACADÉMICOS UAM
   
   Cubre los 4 puntos de la rúbrica:
   4.1 Uso de logs y eventos extendidos
   4.2 Configuración de jobs y mantenimiento
   4.3 Automatización de tareas administrativas
   4.4 Monitoreo proactivo
   ============================================================ */
USE RecursosAcademicosUAM;
GO

/* ============================================================
   4.1 USO DE LOGS Y EVENTOS EXTENDIDOS
   Captura consultas lentas y errores en la base de datos.
   ============================================================ */

USE master;
GO

-- Eliminar sesión si ya existe (para re-ejecuciones)
IF EXISTS (SELECT * FROM sys.server_event_sessions WHERE name = 'Monitoreo_RecursosUAM')
BEGIN
    ALTER EVENT SESSION Monitoreo_RecursosUAM ON SERVER STATE = STOP;
    DROP EVENT SESSION Monitoreo_RecursosUAM ON SERVER;
END
GO

-- Crear sesión de Extended Events
CREATE EVENT SESSION Monitoreo_RecursosUAM
ON SERVER
ADD EVENT sqlserver.sql_statement_completed
(
    ACTION (sqlserver.database_name, sqlserver.username, sqlserver.sql_text)
    WHERE sqlserver.database_name = N'RecursosAcademicosUAM'
      AND duration > 1000000  -- consultas mayores a 1 segundo
),
ADD EVENT sqlserver.error_reported
(
    ACTION (sqlserver.database_name, sqlserver.username)
    WHERE severity >= 11
)
ADD TARGET package0.event_file
(
    SET filename = N'C:\Bases de datos\Backups\RecusosAcademicosUAM\Monitoreo_RecursosUAM.xel',
        max_file_size = 10,
        max_rollover_files = 3
)
WITH (STARTUP_STATE = ON);
GO

-- Iniciar la sesión
ALTER EVENT SESSION Monitoreo_RecursosUAM ON SERVER STATE = START;
GO

-- Verificar que la sesión esté activa
SELECT name, startup_state 
FROM sys.server_event_sessions 
WHERE name = 'Monitoreo_RecursosUAM';
GO


/* ============================================================
   4.2 CONFIGURACIÓN DE JOBS Y MANTENIMIENTO
   Dos jobs automatizados con SQL Server Agent.
   ============================================================ */

USE msdb;
GO

-- ----------------------------------------------------------
-- JOB 1: Respaldo Completo Diario (2:00 AM)
-- ----------------------------------------------------------
IF EXISTS (SELECT job_id FROM msdb.dbo.sysjobs WHERE name = N'Job_Respaldo_RecursosUAM')
    EXEC msdb.dbo.sp_delete_job @job_name = N'Job_Respaldo_RecursosUAM';
GO

EXEC msdb.dbo.sp_add_job
    @job_name = N'Job_Respaldo_RecursosUAM',
    @enabled = 1,
    @description = N'Respaldo completo diario de RecursosAcademicosUAM.';
GO

EXEC msdb.dbo.sp_add_jobstep
    @job_name = N'Job_Respaldo_RecursosUAM',
    @step_name = N'Backup Full',
    @subsystem = N'TSQL',
    @command = N'BACKUP DATABASE RecursosAcademicosUAM
                 TO DISK = ''C:\Respaldos\RecursosAcademicosUAM_Auto.bak''
                 WITH FORMAT, INIT, STATS = 10;',
    @database_name = N'RecursosAcademicosUAM';
GO

EXEC msdb.dbo.sp_add_schedule
    @schedule_name = N'Diario_2AM',
    @freq_type = 4,
    @freq_interval = 1,
    @active_start_time = 020000;
GO

EXEC msdb.dbo.sp_attach_schedule
    @job_name = N'Job_Respaldo_RecursosUAM',
    @schedule_name = N'Diario_2AM';
GO

EXEC msdb.dbo.sp_add_jobserver @job_name = N'Job_Respaldo_RecursosUAM';
GO


-- ----------------------------------------------------------
-- JOB 2: Mantenimiento (Estadísticas + Índices) Semanal
-- Se ejecuta los domingos a las 3:00 AM
-- ----------------------------------------------------------
IF EXISTS (SELECT job_id FROM msdb.dbo.sysjobs WHERE name = N'Job_Mantenimiento_RecursosUAM')
    EXEC msdb.dbo.sp_delete_job @job_name = N'Job_Mantenimiento_RecursosUAM';
GO

EXEC msdb.dbo.sp_add_job
    @job_name = N'Job_Mantenimiento_RecursosUAM',
    @enabled = 1,
    @description = N'Actualiza estadísticas y reorganiza índices semanalmente.';
GO

EXEC msdb.dbo.sp_add_jobstep
    @job_name = N'Job_Mantenimiento_RecursosUAM',
    @step_name = N'Mantenimiento preventivo',
    @subsystem = N'TSQL',
    @command = N'EXEC sp_updatestats;
                 ALTER INDEX ALL ON Recursos REORGANIZE;
                 ALTER INDEX ALL ON Clases REORGANIZE;
                 ALTER INDEX ALL ON Carreras REORGANIZE;',
    @database_name = N'RecursosAcademicosUAM';
GO

EXEC msdb.dbo.sp_add_schedule
    @schedule_name = N'Domingo_3AM',
    @freq_type = 8,
    @freq_interval = 1,
    @freq_recurrence_factor = 1,
    @active_start_time = 030000;
GO

EXEC msdb.dbo.sp_attach_schedule
    @job_name = N'Job_Mantenimiento_RecursosUAM',
    @schedule_name = N'Domingo_3AM';
GO

EXEC msdb.dbo.sp_add_jobserver @job_name = N'Job_Mantenimiento_RecursosUAM';
GO


/* ============================================================
   4.3 AUTOMATIZACIÓN DE TAREAS ADMINISTRATIVAS
   Trigger que registra automáticamente cambios en Recursos.
   ============================================================ */

USE RecursosAcademicosUAM;
GO

IF OBJECT_ID('trg_Auditoria_Recursos', 'TR') IS NOT NULL
    DROP TRIGGER trg_Auditoria_Recursos;
GO

CREATE TRIGGER trg_Auditoria_Recursos
ON Recursos
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @Accion VARCHAR(100);
    
    IF EXISTS (SELECT * FROM inserted) AND EXISTS (SELECT * FROM deleted)
        SET @Accion = 'UPDATE en Recursos';
    ELSE IF EXISTS (SELECT * FROM inserted)
        SET @Accion = 'INSERT en Recursos';
    ELSE
        SET @Accion = 'DELETE en Recursos';
    
    INSERT INTO AuditoriaAccesos (Usuario, Accion, TablaAfectada)
    VALUES (SUSER_SNAME(), @Accion, 'Recursos');
END;
GO


/* ============================================================
   4.4 MONITOREO PROACTIVO
   Vistas y procedimiento para revisar el estado del servidor.
   ============================================================ */

-- Vista 1: Conexiones activas
IF OBJECT_ID('vw_ConexionesActivas', 'V') IS NOT NULL
    DROP VIEW vw_ConexionesActivas;
GO

CREATE VIEW vw_ConexionesActivas
AS
SELECT 
    session_id AS SesionID,
    login_name AS Usuario,
    host_name AS Host,
    status AS Estado,
    DB_NAME(database_id) AS BaseDeDatos
FROM sys.dm_exec_sessions
WHERE is_user_process = 1;
GO

-- Vista 2: Espacio de la base de datos
IF OBJECT_ID('vw_EspacioBaseDeDatos', 'V') IS NOT NULL
    DROP VIEW vw_EspacioBaseDeDatos;
GO

CREATE VIEW vw_EspacioBaseDeDatos
AS
SELECT 
    name AS NombreArchivo,
    type_desc AS TipoArchivo,
    size * 8 / 1024 AS TamanoMB,
    FILEPROPERTY(name, 'SpaceUsed') * 8 / 1024 AS EspacioUsadoMB
FROM sys.database_files;
GO


-- Procedimiento: Reporte general de salud
IF OBJECT_ID('sp_ReporteSaludServidor', 'P') IS NOT NULL
    DROP PROCEDURE sp_ReporteSaludServidor;
GO

CREATE PROCEDURE sp_ReporteSaludServidor
AS
BEGIN
    SET NOCOUNT ON;
    
    PRINT '=== REPORTE DE SALUD - RecursosAcademicosUAM ===';
    PRINT 'Fecha: ' + CONVERT(VARCHAR, GETDATE(), 120);
    
    PRINT '--- Conexiones activas ---';
    SELECT * FROM vw_ConexionesActivas;
    
    PRINT '--- Espacio de la base de datos ---';
    SELECT * FROM vw_EspacioBaseDeDatos;
    
    PRINT '--- Ultimos registros de auditoria ---';
    SELECT TOP 10 * FROM AuditoriaAccesos ORDER BY FechaAccion DESC;
END;
GO


/* ============================================================
   PRUEBAS FINALES
   ============================================================ */

-- Probar el trigger: insertar un recurso y verificar auditoría
INSERT INTO Recursos (Titulo, Descripcion, Enlace, IdClase, IdProfesor, IdTipoRecurso)
VALUES ('Prueba de trigger', 'Recurso de prueba para validar auditoria.',
        'https://ejemplo.com/prueba', 1, 1, 3);
GO

-- Ver el registro automático generado por el trigger
SELECT TOP 5 * FROM AuditoriaAccesos ORDER BY FechaAccion DESC;
GO

-- Ejecutar el reporte de salud
EXEC sp_ReporteSaludServidor;
GO

-- Verificar jobs creados
SELECT name AS NombreJob, enabled AS Habilitado
FROM msdb.dbo.sysjobs
WHERE name LIKE '%RecursosUAM%';
GO

-- Verificar sesión de Extended Events
SELECT name, startup_state
FROM sys.server_event_sessions
WHERE name = 'Monitoreo_RecursosUAM';
GO