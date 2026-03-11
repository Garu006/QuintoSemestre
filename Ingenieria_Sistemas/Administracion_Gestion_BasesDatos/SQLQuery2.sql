USE PruebaDB;

INSERT INTO ciudades(nameCiudad) VALUES
	('Managua'),
	('Chinandega'),
	('Masaya'),
	('Rio San Juan')

SELECT * FROM ciudades ORDER BY nameCiudad ASC;
SELECT * FROM ciudades ORDER BY nameCiudad DESC;