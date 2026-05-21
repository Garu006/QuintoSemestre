--1. primero creamos la base de datos que vamos a usar para la practica
create database practicaJobs;
go

use practicaJobs;
go

--2. despues creamos la tabla donde vamos a registrar las ejecuciones del job 
create table LogEjecuciones(
	IdLog int identity(1,1) primary key,
	fechaEjecución datetime not null
);
go

--3. cambiar a msdb, porque ahi se administran los jobs
use msdb;
go
--4. creamos el job
exec sp_add_job
	@job_name = N'RegistroDiario',
	@enabled = 1,
	@description = N'Job que registra la fecha y hora actual diariamente a las 6:00 AM';
go

--5. crear el paso del job
exec sp_add_jobstep
	@job_name = N'RegistroDiario',
	@step_name = N'Paso1_InsertarFecha',
	@subsystem = N'TSQL',
	@command = N'
		insert into practicaJobs.dbo.LogEjecuciones (fechaEjecucion)
		values (getdate());
	',
	@database_name = N'practicaJobs',
	@on_success_action = 1,
	@on_fail_action = 2;
go

--6. crear el horario diario a las 6:00AM
exec sp_add_schedule
	@schedule_name = N'HorarioDiario_6AM',
	@freq_type = 4,
	@freq_interval = 1,
	@active_start_time = 60000;
go

--7. Asociar el horario al job
exec sp_attach_schedule
	@job_name = N'RegistroDiario',
	@schedule_name = N'HorarioDiario_6AM';
go

--8. Asignar el job al servidor actual
exec sp_add_jobserver
	@job_name = N'RegistroDiario',
	@server_name = N'(LOCAL)';
go

--9. ejecutar el job manualmente para probarlo
exec msdb.dbo.sp_start_job
	@job_name = N'RegistroDiario';
go

--10. verificar si se inserto el registro
use practicaJobs;
go

--por si acaso pue, borramos los schedules porque me dio un error todo tonto que sin querer ya habia creado un schedule y lo volvi a ejecutar el script y se creo otro con el mismo nombre jeje
use msdb
go

exec sp_delete_schedule
    @schedule_name = N'HorarioDiario_6AM',
    @force_delete = 1;
go

select * from LogEjecuciones;
go