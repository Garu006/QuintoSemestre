USE master;
GO

CREATE DATABASE tienda_db;
GO

USE tienda_db;
GO

-- Creación de tabla clientes
CREATE TABLE clientes (
    id_cliente INT,
    nombres VARCHAR(100) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    correo VARCHAR(150) NOT NULL,
    telefono VARCHAR(20),

    CONSTRAINT pk_clientes PRIMARY KEY (id_cliente),
    CONSTRAINT uq_clientes_correo UNIQUE (correo),
    CONSTRAINT chk_clientes_correo CHECK (
        correo NOT LIKE '% %'
        AND correo LIKE '%@%.%'
    )
);
GO

-- Creación de tabla pedidos
CREATE TABLE pedidos (
    id_pedido INT,
    fecha_pedido DATE NOT NULL,
    monto_total DECIMAL(10,2) NOT NULL,
    id_cliente INT NOT NULL,

    CONSTRAINT pk_pedidos PRIMARY KEY (id_pedido),
    CONSTRAINT fk_pedidos_clientes FOREIGN KEY (id_cliente)
        REFERENCES clientes(id_cliente),
    CONSTRAINT chk_pedidos_monto CHECK (monto_total > 0)
);
GO

-- Creación de tabla auditoría
CREATE TABLE auditoria_pedidos (
    id_auditoria INT IDENTITY(1,1),
    id_pedido INT NOT NULL,
    accion VARCHAR(50) NOT NULL,
    fecha_cambio DATETIME NOT NULL,
    usuario VARCHAR(100) NOT NULL,

    CONSTRAINT pk_auditoria_pedidos PRIMARY KEY (id_auditoria),
    CONSTRAINT fk_auditoria_pedidos FOREIGN KEY (id_pedido)
        REFERENCES pedidos(id_pedido)
);
GO

-- Insertar datos de ejemplo
INSERT INTO clientes (id_cliente, nombres, apellidos, correo, telefono)
VALUES
(1, 'Juan', 'Pérez', 'juan@gmail.com', '999111222'),
(2, 'María', 'Gómez', 'maria@gmail.com', '999333444');
GO

INSERT INTO pedidos (id_pedido, fecha_pedido, monto_total, id_cliente)
VALUES
(101, '2026-04-20', 250.00, 1),
(102, '2026-04-20', 180.00, 2);
GO

-- Registrar manualmente un ejemplo de trazabilidad
INSERT INTO auditoria_pedidos (id_pedido, accion, fecha_cambio, usuario)
VALUES
(101, 'Pedido actualizado', '2026-04-20', 'admin');
GO

-- Consultar relación entre clientes y pedidos
SELECT 
    c.nombres, 
    c.apellidos, 
    p.id_pedido, 
    p.fecha_pedido, 
    p.monto_total
FROM clientes c
INNER JOIN pedidos p
    ON c.id_cliente = p.id_cliente;
GO

-- Crear índice para optimización
CREATE INDEX idx_pedidos_cliente
ON pedidos(id_cliente);
GO

-- Buscar todos los pedidos de un cliente específico
SELECT *
FROM pedidos
WHERE id_cliente = 1;
GO

-- Crear trigger de auditoría
CREATE TRIGGER trg_actualizar_pedido
ON pedidos
AFTER UPDATE
AS
BEGIN
    INSERT INTO auditoria_pedidos (
        id_pedido,
        accion,
        fecha_cambio,
        usuario
    )
    SELECT
        id_pedido,
        'UPDATE',
        GETDATE(),
        SYSTEM_USER
    FROM inserted;
END;
GO

-- Probar el trigger
UPDATE pedidos
SET monto_total = 300.00
WHERE id_pedido = 101;
GO

-- Consultar auditoría
SELECT * FROM auditoria_pedidos;
GO