-- =====================================
-- BASE DE DATOS OLAP: VENTAS Y COMPRAS
-- =====================================

CREATE DATABASE BD_SG_FOOD;
GO

USE BD_SG_FOOD;
GO

-- =========================
-- DIMENSIONES
-- =========================

CREATE TABLE DimProducto (
    id_producto VARCHAR(20) PRIMARY KEY,
    nombre_producto VARCHAR(100),
    marca VARCHAR(50),
    categoria VARCHAR(50)
);

CREATE TABLE DimSucursal (
    id_sucursal VARCHAR(20) PRIMARY KEY,
    nombre_sucursal VARCHAR(100),
    region VARCHAR(50),
    departamento VARCHAR(50)
);

CREATE TABLE DimProveedor (
    id_proveedor VARCHAR(20) PRIMARY KEY,
    nombre_proveedor VARCHAR(100)
);

CREATE TABLE DimCliente (
    id_cliente VARCHAR(20) PRIMARY KEY,
    nombre_cliente VARCHAR(100),
    tipo_cliente VARCHAR(30)
);

CREATE TABLE DimVendedor (
    id_vendedor VARCHAR(20) PRIMARY KEY,
    nombre_vendedor VARCHAR(100)
);

CREATE TABLE DimFecha (
    fecha DATE PRIMARY KEY,
    anio INT,
    trimestre INT,
    mes INT,
    dia INT
);

-- =========================
-- TABLA DE HECHOS: COMPRAS
-- =========================

CREATE TABLE HechosCompras (
    id_compra INT IDENTITY(1,1) PRIMARY KEY,
    fecha DATE,
    id_producto VARCHAR(20),
    id_proveedor VARCHAR(20),
    id_sucursal VARCHAR(20),
    unidades INT,
    costo_unitario DECIMAL(18,2),
    total_costo AS (unidades * costo_unitario) PERSISTED,

    FOREIGN KEY (fecha) REFERENCES DimFecha(fecha),
    FOREIGN KEY (id_producto) REFERENCES DimProducto(id_producto),
    FOREIGN KEY (id_proveedor) REFERENCES DimProveedor(id_proveedor),
    FOREIGN KEY (id_sucursal) REFERENCES DimSucursal(id_sucursal)
);

-- =========================
-- TABLA DE HECHOS: VENTAS
-- =========================

CREATE TABLE HechosVentas (
    id_venta INT IDENTITY(1,1) PRIMARY KEY,
    fecha DATE,
    id_producto VARCHAR(20),
    id_cliente VARCHAR(20),
    id_vendedor VARCHAR(20),
    id_sucursal VARCHAR(20),
    unidades INT,
    precio_unitario DECIMAL(18,2),
    total_precio AS (unidades * precio_unitario) PERSISTED,

    FOREIGN KEY (fecha) REFERENCES DimFecha(fecha),
    FOREIGN KEY (id_producto) REFERENCES DimProducto(id_producto),
    FOREIGN KEY (id_cliente) REFERENCES DimCliente(id_cliente),
    FOREIGN KEY (id_vendedor) REFERENCES DimVendedor(id_vendedor),
    FOREIGN KEY (id_sucursal) REFERENCES DimSucursal(id_sucursal)
);
