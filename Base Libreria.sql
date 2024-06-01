
CREATE DATABASE LIBRERIA
GO

USE LIBRERIA
GO

CREATE SCHEMA Catalogo
GO
CREATE SCHEMA Ventas
GO

CREATE TABLE Catalogo.autores
(
	Autor_ID INT IDENTITY (1,1) PRIMARY KEY,
	Nombre VARCHAR (100),
	Apellido VARCHAR (100)
)
GO

SELECT *FROM catalogo.autores

EXEC sp_rename 'catalogo.autores.Apellido', 'Last_name', 'COLUMN';

ALTER TABLE Catalogo.autores
ADD Fecha_nacimiento DATE DEFAULT GETDATE()

INSERT INTO CATALOGO.AUTORES (Nombre,Last_name)
VALUES 
('Charles','Dickens'),
('Ken','Follet'),
('Federico','García'),
('Marcel','Proust'),
('William','Shakespeare'),
('Edgar','Allan'),
('Jane','Austen'),
('Miguel','Cervantes'),
('Agatha','Chistie'),
('Paulo','Coelho')

CREATE TABLE Catalogo.categorias
(
	Categoria_ID INT IDENTITY (1,1) PRIMARY KEY,
	Nombre VARCHAR (100)UNIQUE
)
GO

EXEC sp_rename 'Catalogo.categorias.Nombre', 'Name', 'COLUMN';

INSERT INTO CATALOGO.CATEGORIAS (Name)
VALUES 
('Accion'),
('Novelas'),
('Comedia'),
('Romance'),
('Aventura'),
('Historico'),
('Biografico'),
('Academico'),
('Infantil'),
('Cocina')

SELECT * from catalogo.categorias

CREATE TABLE Catalogo.libros
(
	Libro_ID INT IDENTITY (1,1) PRIMARY KEY,
	Titulo VARCHAR (100),
	Autor_ID INT,
	Categoria_ID INT,
	Precio MONEY
)


ALTER TABLE Catalogo.libros
ADD CONSTRAINT FK_Autor_ID_autores_con_Autor_ID_libros FOREIGN KEY (Autor_ID) REFERENCES catalogo.autores (Autor_ID)

ALTER TABLE Catalogo.libros
ADD CONSTRAINT FK_Categoria_ID_categorias_con_Categoria_ID_libros FOREIGN KEY (Categoria_ID) REFERENCES catalogo.categorias (Categoria_ID)

INSERT INTO CATALOGO.LIBROS (Titulo,Precio,Autor_ID,Categoria_ID)
VALUES 
('Don Quijote de la Mancha',95000,5,5),
('Harry Potter',84750,2,1),
('Historia de dos ciudades',45600,2,6),
('El Señor de los Anillos',21845,1,1),
('El principito',62000,5,9),
('Las aventuras de Alicia en el país de las maravillas',54000,6,9),
('Las Crónicas de Narnia',95000,3,2),
('Diez negritos',84000,5,6),
('El código Da Vinci',40000,4,1),
('El Alquimista',85000,7,2)

SELECT *FROM catalogo.libros

CREATE TABLE Ventas.clientes
(
	Cliente_ID INT IDENTITY (1,1) PRIMARY KEY,
	Nombre VARCHAR (100),
	Apellido VARCHAR (100),
	Correo NVARCHAR (200) UNIQUE
)
GO


EXEC sp_rename 'Ventas.clientes.Correo', 'Email', 'COLUMN';

ALTER TABLE Ventas.clientes
ADD Fecha_nacimiento DATE 

SELECT *FROM Ventas.clientes

INSERT INTO Ventas.clientes (Nombre,Apellido,Email)
VALUES
('Juan','Cuestas','juan@correo.com'),
('Alejandro', 'Corrales','alejo@correo.com'),
('Mateo','Lozano','mateo@correo.com'),
('Julieth','Preciado','julieth@correo.com'),
('Daniel','Herrera','dani@correo.com'),
('Victor','Martinez','victor@correo.com'),
('Carolina','Olaya','caro@correo.com'),
('Laura','Prado','lau@correo.com'),
('Betty','Ariza','betty@correo.com'),
('Juliana','Moreno','juli@correo.com')


CREATE TABLE Ventas.ventas
(
	Venta_ID INT IDENTITY (1,1) PRIMARY KEY,
	Cliente_ID INT,
	Fecha_venta DATETIME
)
GO

INSERT INTO Ventas.ventas (Cliente_ID,Fecha_venta)
VALUES
(3,'2024-01-02'),
(4,'2024-02-04'),
(5,'2024-02-25'),
(6,'2023-11-23'),
(7,'2023-12-31'),
(8,'2024-04-23'),
(9,'2024-01-14'),
(10,'2023-10-18'),
(11,'2023-06-29'),
(12,'2024-01-29')


ALTER TABLE ventas.ventas
ADD CONSTRAINT FK_Cliente_ID_clientes_con_Cliente_ID_ventas FOREIGN KEY (Cliente_ID) REFERENCES ventas.clientes (Cliente_ID)

SELECT * FROM ventas.ventas

CREATE TABLE Ventas.detalle_ventas
(
	Detalle_ID INT IDENTITY (1,1) PRIMARY KEY,
	Venta_ID INT,
	Libro_ID INT,
	Cantidad INT,
	Precio_venta MONEY
)
GO

ALTER TABLE Ventas.detalle_ventas
ADD CONSTRAINT FK_Venta_ID_ventas_con_Venta_ID_detalle_ventas FOREIGN KEY (Venta_ID) REFERENCES Ventas.ventas (Venta_ID)

ALTER TABLE Ventas.detalle_ventas
ADD CONSTRAINT FK_Libro_ID_libros_con_Libro_ID_detalle_ventas FOREIGN KEY (Libro_ID) REFERENCES Catalogo.libros (Libro_ID)

INSERT INTO Ventas.detalle_ventas (Venta_ID,Libro_ID,Cantidad,Precio_venta)
VALUES
(3,5,1,25000),
(5,8,4,30000),
(8,12,2,20000),
(4,4,6,50000),
(7,5,2,45000),
(9,7,1,25000),
(5,5,3,49000),
(8,9,7,80000),
(9,6,3,60000)

SELECT *FROM ventas.detalle_ventas