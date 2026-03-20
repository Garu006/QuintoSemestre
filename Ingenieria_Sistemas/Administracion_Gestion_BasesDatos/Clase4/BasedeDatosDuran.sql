select * from clientes

select * from clientes where TipoCliente like '%G% %3%'

INSERT INTO clientes(ClienteID, NombreCliente, TipoCliente, Ciudad, Pais)
VALUES
('24010225', 'Noel Gavarrete', 'Grupo FIA', 'Puerto Píritu', 'Venezuela')
('24010226', 'Gabriel Rojas', 'Grupo 3', 'Chinandega', 'Nicaragua')

ALTER TABLE dbo.ChocoMonkey
ADD ChocoDescription VARCHAR(7000);

/*Create table ChocoMonkey (
	ChocoId INT primary key,
	ChocoNombre VARCHAR(50),
	Precio DECIMAL(10, 2),
	Cantidad int,
)*/


Insert Into ChocoMonkey(ChocoId, ChocoNombre, Precio, Cantidad, ChocoDescription)
Values
('1', 'Chocolate oscuro', '25.50', '10', 'yico'),
('2', 'chocolatito gonzales','tapas', '0.0', '1', 'tapas')

Select * from ChocoMonkey
