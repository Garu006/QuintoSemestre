exec sp_addlinkedserver
	@server = 'MYSQLSERVER01',
	@srvproduct = '',
	@provider = 'SQLNCLI',
	@datasrc = 'CHOCOMONKEY\MSSQLSERVER01'

exec sp_addlinkedsrvlogin
	@rmtsrvname = 'MYSQLSERVER01',
	@useself = 'false'

select * from MYSQLSERVER01.InventarioDB.dbo.Inventario