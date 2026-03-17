create database Universidad
on
(
	name = universidad,
	filename = 'c:\base_datos\Universidad_data.mdf'
	size = 10mb
	maxsize = 100mb,
	filegrowth = 5mb
)
log on
(
	name = Universidad_log,
	filename = 'c:\base_datos\Universidad_log.ldf'
	size = 5mb,
	maxsize = 50mb,
	filegrowth = 5mb
)