--CRACREAMOS LA BASE DE DATOS
GO

GO
--Usamos la base de datos
GO
USE SistemasCobroAgua;
GO
--cremos las tablas fuertes
CREATE TABLE rol (
idRol       INTEGER NOT NULL IDENTITY(1,1),
descripcion VARCHAR(40) NOT NULL,
statusRol   BIT NOT NULL DEFAULT 1,
CONSTRAINT pk_rol PRIMARY KEY(IdRol)
);

--Insermos Datos
INSERT INTO rol (descripcion) 
	   VALUES('Adminisrador'),('Usuario');



--Tabla Servicio Contratado
CREATE TABLE servicio (
idServicio  INTEGER IDENTITY(1,1),
descripcion	VARCHAR(100) NOT NULL,
cost        DECIMAL NOT NULL,
statusServicio BIT NOT NULL DEFAULT 1
CONSTRAINT pk_servicio PRIMARY KEY(idServicio)
);

--Insertamos Datos
INSERT INTO servicio (descripcion,cost)
	   VALUES('Agua Potable',1000),('Drenaje',1100);

--TABLA COLONIA 
CREATE TABLE colonia(
	idColonia INTEGER NOT NULL IDENTITY(1,1),
	nombre    VARCHAR(80) NOT NULL,
	CONSTRAINT pk_colonia PRIMARY KEY(idColonia)
);
--INSERTAR DATOS
INSERT INTO colonia(nombre)
                   VALUES('Reforma'),('Niños Hereos'),('Santiago Tula'),('Arcardia'),
				         ('Francisco Villa');
--TABLA CALLE
CREATE TABLE calle(
	idCalle INTEGER NOT NULL IDENTITY(1,1),
	idColonia INTEGER NOT NULL,
	nombre VARCHAR(100) NOT NULL,
	CONSTRAINT pk_calle PRIMARY KEY(idCalle),
	CONSTRAINT fk_colonia FOREIGN KEY (idColonia) REFERENCES colonia (idColonia),
);

--INSERTAR DATOS 
INSERT INTO calle(idColonia,nombre)VALUES
						  (5,'20 de noviembre'),(5,'Alvaro Obregon'),
						  (5,'Lic. Benito Juarez'),(5,'15 de Septiembre'),
						  (3,'Leona Vicario'),(3,'Calle las Flores'),(3,'Las Palmas'),(3,'Calle 40 Oriente');

 ----Tabla Status de Toma
CREATE TABLE statusToma (
idStatusToma INTEGER IDENTITY(1,1),
descripcion VARCHAR(40) NOT NULL,
statusToma BIT NOT NULL DEFAULT 1
CONSTRAINT pk_statusToma PRIMARY KEY(idStatusToma)
);
--INSERTAMOS DATOS
INSERT INTO statusToma (descripcion) 
		VALUES('Pasivo'),('Activo');

--TABLA Tarifa Mensual
CREATE TABLE tarifa (
idTarifa INTEGER NOT NULL IDENTITY(1,1),
descripcion VARCHAR(200) NOT NULL,
costo DECIMAL NOT NULL,
statusTarifa BIT NOT NULL default 1
CONSTRAINT pk_tarifa PRIMARY KEY(idTarifa)
);
--Insertamos Datos
INSERT INTO tarifa (descripcion,costo)
	   VALUES('Domestico',50),('Riego',80);

--Tabla Sanciones
CREATE TABLE tipoSancion (
idTipoSancion INTEGER IDENTITY(1,1),
descripcion	varchar(100) NOT NULL,
costo DECIMAL NOT NULL,
statusSancion bit default 1 NOT NULL
CONSTRAINT pk_tipoSancion PRIMARY KEY(idTipoSancion)
);

--Insertamos Datos
INSERT INTO tipoSancion (descripcion,costo)
	   VALUES('Desperdicio de Agua',500),('Pago Vencido',500);
--TABLA CARGOS
CREATE TABLE cargo(
   idCargo INTEGER NOT NULL IDENTITY(1,1),
   descripcion VARCHAR(80) NOT NULL,
   statusCargos BIT NOT NULL DEFAULT 1,
   CONSTRAINT pk_cargo PRIMARY KEY(idCargo)
);

INSERT INTO cargo(descripcion) VALUES('Presidente de Comite'),('Secretaria'),('Tesorera');

--TABLAS DEPEDIENTES

--Tabla  Usuarios
CREATE TABLE usuarios (
idUser INTEGER IDENTITY(1,1),
idRol INTEGER NOT NULL,
UserName VARCHAR(40) NOT NULL,
Password text NOT NULL,
name VARCHAR(60) NOT NULL,
lastNameP VARCHAR(60) NOT NULL,
lastNameM VARCHAR(60) NOT NULL,
Phone VARCHAR(10) NOT NULL,
statusUsuarios BIT NOT NULL DEFAULT 1,
dateCreacion DATETIME NOT NULL DEFAULT GETDATE(),
CONSTRAINT pk_user PRIMARY KEY(idUser),
CONSTRAINT fk_userRol FOREIGN KEY (idRol) REFERENCES rol (idRol),
);

----Insertamos Datos
INSERT INTO usuarios (idRol,UserName,Password,name,lastNameP,lastNameM,Phone)
	   VALUES(1,'Miguel5673','Manchas123','Mario','Delgado','Martinez','2381813540'),
             (2,'cuevas9985','cuevas123','Armando','Perez','Moteo','2382050491');

CREATE TABLE representante(
idRepresentante INTEGER NOT NULL IDENTITY(1,1),
idCargo INTEGER NOT NULL,
nombre VARCHAR(60) NOT NULL,
lastNameP VARCHAR(60) NOT NULL,
lastNameM VARCHAR(60) NOT NULL,
statusRepresentante BIT NOT NULL DEFAULT 1,
fechaCreacion DATETIME NOT NULL DEFAULT GETDATE(),
CONSTRAINT pk_representate PRIMARY KEY(idRepresentante),
CONSTRAINT fk_cargo FOREIGN KEY (idCargo) REFERENCES cargo(idCargo)
);


INSERT INTO representante(idCargo,nombre,lastNameP,lastNameM)
						  VALUES(1,'Felipe','Rodriguez','Castillo'),
								(2,'Guillermina','Valencia','Hernandez'),
								(3,'Martha','Merino','Pioquinto');

--Tabla Contribuyente
CREATE TABLE contribuyentes (
idContribuyentes INTEGER NOT NULL IDENTITY(1,1),
idCalle INTEGER NOT NULL,
numberExt INTEGER NOT NULL,
numberInt VARCHAR(5) NULL DEFAULT '/',
nombre VARCHAR(60) NOT NULL,
lastNameP VARCHAR(60) NOT NULL,
lastNameM VARCHAR(60) NOT NULL,
genero  CHAR(1) NOT NULL,
phone VARCHAR(10) NOT NULL, 
descripcion VARCHAR(300) NULL DEFAULT '/'
CONSTRAINT pk_Contribuyente PRIMARY KEY(idContribuyentes),
CONSTRAINT fk_contriCalle FOREIGN KEY (idCalle) REFERENCES calle (idCalle)
);

--Insertamos Datos
INSERT INTO contribuyentes (idCalle,numberExt,numberInt,nombre,lastNameP,lastNameM,genero,phone,descripcion)
VALUES (4,231,'','Perla Rocio','Mendez','Mejiaz','F','2375674567','Es un saguna verde'),
	   (2,185,'A','Armando','Mendez','Sanchez','M','2389876543','Frente la tortilleria Ramos'),
	   (2,185,'','Rodrigo','Perez','Martinez','M','2381813540','Es a alado de una balconeria llamado Emmamnuel'),
	   (8,254,'C','Maria Fernanda','Cuevas','Solis','M','2374567544','A lado de un nieveria');

--Tabla Contracto
CREATE TABLE contrato(
idContracto	INTEGER NOT NULL IDENTITY(1,1),
idContribuyentes INTEGER NOT NULL,
idServicio INTEGER NOT NULL,
idUser INTEGER NOT NULL,
idTarifa INTEGER NOT NULL, 
fechaContrato DATETIME NOT NULL DEFAULT GETDATE(),
costoFinalContrato Decimal NOT NULL,
CONSTRAINT pk_contrato PRIMARY KEY(idContracto),
CONSTRAINT pk_contratoContribuyente FOREIGN KEY (idContribuyentes) REFERENCES contribuyentes (idContribuyentes),
CONSTRAINT pk_contratoTipoServicio FOREIGN KEY (idServicio) REFERENCES servicio (idServicio),
CONSTRAINT pk_contratoTarifa FOREIGN KEY (idTarifa) REFERENCES tarifa (idTarifa),
CONSTRAINT pk_contratoUser FOREIGN KEY (idUser) REFERENCES usuarios (IdUser),
);

INSERT INTO contrato (idContribuyentes,idServicio,idUser,idTarifa,costoFinalContrato)
       VALUES(3,2,1,1,1000);

	 

--Tabla Toma
CREATE TABLE toma (
idToma INTEGER IDENTITY(1,1),
idContribuyentes INTEGER NOT NULL,
idUser INTEGER NOT NULL,
idCalle INTEGER NOT NULL,
idTarifa INTEGER NOT NULL,
idStatusToma INTEGER NOT NULL,
fechaToma DATETIME NOT NULL DEFAULT GETDATE(),
fechaUpdateToma DATETIME NOT NULL DEFAULT GETDATE(),
comentario VARCHAR(150) NULL DEFAULT 'S/C',
CONSTRAINT pk_toma PRIMARY KEY(idToma),
CONSTRAINT pk_tomaContribuyente FOREIGN KEY (idContribuyentes) REFERENCES contribuyentes (idContribuyentes),
CONSTRAINT pk_fkContriUser FOREIGN KEY(idUser) REFERENCES usuarios (idUser),
CONSTRAINT pk_fkContriCalle FOREIGN KEY(idCalle) REFERENCES calle(idCalle),
CONSTRAINT pk_contriTarifa FOREIGN KEY (idTarifa) REFERENCES tarifa (idTarifa),
CONSTRAINT pk_tomastatusToma FOREIGN KEY (idStatusToma) REFERENCES statusToma (idStatusToma)
);

select * from toma


--INSERTAR DATOS TABLA TOMA DE AGUA
INSERT INTO toma (idContribuyentes,idUser,idCalle,idTarifa,idStatusToma)
		VALUES (1,2,1,1,1),
			   (2,2,1,2,2),
			   (4,1,7,1,1);

---TABLA MESES
--CREATE CATALOGO MESES
CREATE TABLE meses(
idMes INTEGER NOT NULL IDENTITY(1,1),
nombreMes VARCHAR(15) NOT NULL,
CONSTRAINT pk_meses PRIMARY KEY(idMes)
);
--INSERTAR TABLA MESES
INSERT INTO meses(nombreMes)VALUES('Enero'),('Febrero'),('Marzo'),('Abril'),
										('Mayo'),('Junio'),('Julio'),('Agosto'),
										('Semtiembre'),('Octubre'),('Noviembre'),('Diciembre');
-------TABLA RECIBO
CREATE TABLE Recibo(
idRecibo INTEGER NOT NULL IDENTITY(1,1),
idToma INTEGER NOT NULL,
idUser INTEGER  NOT NULL,
yeard  INTEGER NOT NULL,
montoPagar DECIMAL(9,2) NOT NULL,
fechaGenerado DATETIME NOT NULL DEFAULT GETDATE(),
CONSTRAINT pk_Recibo PRIMARY KEY(idRecibo),
CONSTRAINT fk_reciboTomas FOREIGN KEY (idToma) REFERENCES toma (idToma),
CONSTRAINT fk_reciboUser FOREIGN KEY (idUser) REFERENCES usuarios (idUser)
);
select * from toma;
select * from usuarios;


INSERT INTO Recibo(idToma,idUser,yeard,montoPagar) VALUES(1,1,2018,150.00);
INSERT INTO Recibo(idToma,idUser,yeard,montoPagar) VALUES(1,2,2018,200.00);
INSERT INTO Recibo(idToma,idUser,yeard,montoPagar) VALUES(2,1,2019,200.00);
INSERT INTO Recibo(idToma,idUser,yeard,montoPagar) VALUES(1,2,2019,200.00);
INSERT INTO Recibo(idToma,idUser,yeard,montoPagar) VALUES(3,1,2018,300.00);
INSERT INTO Recibo(idToma,idUser,yeard,montoPagar) VALUES(1,1,2020,500.00);


select * from Recibo

CREATE TABLE detalles_Recibos(
   idRecibo INTEGER NOT NULL,
   idMes INTEGER NOT NULL,
   CONSTRAINT pk_ReciboMeses PRIMARY KEY(idRecibo,idMes),
   CONSTRAINT fk_detalleRecibo FOREIGN KEY (idRecibo) REFERENCES Recibo (idRecibo),
   CONSTRAINT fk_detalleMes FOREIGN KEY (idMes) REFERENCES meses (idMes),
);

Insert INTO detalles_Recibos (idRecibo,idMes)Values (1,1),(1,2),(1,3);
Insert INTO detalles_Recibos (idRecibo,idMes)Values (2,4),(2,5),(2,6),(2,7);
Insert INTO detalles_Recibos (idRecibo,idMes)Values (3,7),(3,8),(3,9),(3,10);
Insert INTO detalles_Recibos (idRecibo,idMes)Values (4,6),(4,7),(4,8),(4,9);
Insert INTO detalles_Recibos (idRecibo,idMes)Values (5,2),(5,3),(5,4),(5,5),(5,6),(5,7);
Insert INTO detalles_Recibos (idRecibo,idMes)Values (6,2),(6,3),(6,4),(6,5),(6,6),(6,7),(6,8),(6,9),(6,10),(6,11);


select * from detalles_Recibos

SELECT r.idRecibo AS [Codigo Recibo],r.idToma AS TOMA,nombreMes AS [Mes],r.yeard AS Año, CONCAT(c.nombre, ' ',c.lastNameP) AS [Nombre Completo] from detalles_Recibos dR INNER JOIN Recibo r ON 
              r.idRecibo=dR.idRecibo INNER JOIN meses m ON
			  dr.idMes=m.idMes INNER JOIN toma t ON
			  r.idToma=t.idToma INNER JOIN contribuyentes c ON
			  c.idContribuyentes=t.idContribuyentes

SELECT m.nombreMes from detalles_Recibos dR INNER JOIN meses m ON 
			  dr.idMes=m.idMes INNER JOIN Recibo r ON 
              r.idRecibo=dR.idRecibo WHERE dr.idRecibo=1;

--quiero los pagos de la toma 1
SELECT m.nombreMes from detalles_Recibos dR INNER JOIN meses m ON 
			  dr.idMes=m.idMes INNER JOIN Recibo r ON 
              r.idRecibo=dR.idRecibo WHERE r.idToma=1;

--BUSCAR LOS RECIBOS DE UNA TOMA ESPECIFICA CON UNA FECHA ESPECIFICA
SELECT r.idRecibo AS [Codigo Recibo],t.idToma,CONCAT(con.nombre, ' ',con.lastNameM) AS Nombre,
r.montoPagar AS [Cantidad Pagada],r.yeard AS Año,
CONVERT(VARCHAR(10), r.fechaGenerado, 23) AS [Fecha Emision]
FROM Recibo r INNER JOIN toma t ON r.idToma=t.idToma INNER JOIN contribuyentes con ON
								   con.idContribuyentes=t.idContribuyentes
									WHERE t.idToma=1 AND r.yeard=2018;

--Los meses que pagos la toma 1 del año 2018
		
SELECT r.idRecibo AS [Codigo Recibo], m.nombreMes AS [Mes], r.yeard AS [Año]
				FROM detalles_Recibos dt INNER JOIN meses m ON dt.idMes=m.idMes
										INNER JOIN Recibo r ON r.idRecibo=dt.idRecibo WHERE r.idToma=1 AND
										r.yeard=2018;

--BUSCAR LOS RECIBOS DE UNA TOMA ESPECIFICA DE UN RANGO DE AÑOS ESPECIFICOS
SELECT r.idRecibo AS [Codigo Recibo],
r.montoPagar AS [Cantidad Pagada],r.yeard AS Año,
CONVERT(VARCHAR(10), r.fechaGenerado, 23) AS [Fecha Emision]
FROM Recibo r INNER JOIN toma t ON r.idToma=t.idToma WHERE t.idToma=2 AND r.yeard BETWEEN 2018 AND 2019

--Especifica detalle recibo de una recibo en particular con los meses pagados en una toma
SELECT dt.idRecibo AS [Codigo Recibo],m.nombreMes AS Mes FROM detalles_Recibos dt INNER JOIN Recibo r ON 
				  dt.idRecibo=r.idRecibo INNER JOIN meses m ON
				   dt.idMes=m.idMes WHERE r.idRecibo=3;

----------------------------------------------------------------------
--TOMAS ADICIONALES
CREATE TABLE adeudos(
idAdeudo INTEGER NOT NULL IDENTITY(1,1),
idToma INTEGER NOT NULL,
idTipoSancion INTEGER NOT NULL,
mesvencido VARCHAR(20) NOT NULL,
yearVencido INTEGER NOT NULL,
fechaGenerado DATE NOT NULL,
statusPagado BIT NOT NULL DEFAULT 0,
CONSTRAINT pk_idAdeudos PRIMARY KEY(idAdeudo),
CONSTRAINT fk_adeudosToma FOREIGN KEY (idToma) REFERENCES toma (idToma),
CONSTRAINT fk_adeudosSancion FOREIGN KEY (idTipoSancion) REFERENCES tipoSancion (idTipoSancion),
);
drop table adeudos

INSERT INTO adeudos(idToma,idTipoSancion,mesvencido,yearVencido,fechaGenerado)VALUES(1,2,'Agosto',2018,'2019-04-18');
INSERT INTO adeudos(idToma,idTipoSancion,mesvencido,yearVencido,fechaGenerado)VALUES(1,2,'Septiembre',2018,'2019-05-18');


SELECT * FROM adeudos

CREATE TABLE reciboAdeudos(
	   idRecibo INTEGER NOT NULL, 
	   idAdeudo INTEGER NOT NULL,
	   CONSTRAINT pk_ReciboAdeudos PRIMARY KEY(idRecibo,idAdeudo),
	   CONSTRAINT fk_Recibodetalles FOREIGN KEY (idRecibo) REFERENCES Recibo (idRecibo),
	   CONSTRAINT fk_detalleAdeudos FOREIGN KEY (idAdeudo) REFERENCES adeudos (idAdeudo),
);

INSERT INTO reciboAdeudos (idRecibo,idAdeudo)



SELECT r.idRecibo AS [Codigo Recibo], m.nombreMes AS [Mes], r.yeard AS [Año]
				FROM detalles_Recibos dt INNER JOIN meses m ON dt.idMes=m.idMes
										INNER JOIN Recibo r ON r.idRecibo=dt.idRecibo WHERE r.idToma=1 AND
										r.yeard=2018;
select * from adeudos
INSERT INTO adeudos(idToma,idTipoSancion,mesvencido,yearVencido,fechaGenerado)VALUES(1,2,'Septiembre',2018,18/04/2024);


SELECT r.idRecibo AS [Codigo Recibo], m.nombreMes AS [Mes], r.yeard AS [Año]
				FROM detalles_Recibos dt INNER JOIN meses m ON dt.idMes=m.idMes
										INNER JOIN Recibo r ON r.idRecibo=dt.idRecibo WHERE r.idToma=1 AND
										r.yeard=2018;

SELECT * FROM adeudos;



SELECT * FROM adeudos
UPDATE adeudos set statusPagado=1 WHERE idAdeudo=1;





				  	

			  
			   

--WHERE c.nombre like '%Perla Rocio%' OR c.lastNameP LIKE '%Mendez%' OR c.lastNameM like '%Mejiaz%';

----BUSCAR LOS RECIBOS DE LA TOMA 1 DEL AÑO 2018
--SELECT r.idRecibo AS [Codigo Recibo],r.fechaGenerado AS [Fecha Emision] from detalles_Recibos dR INNER JOIN Recibo r ON 
--              r.idRecibo=dR.idRecibo INNER JOIN meses m ON
--			  dr.idMes=m.idMes INNER JOIN toma t ON
--			  r.idToma=t.idToma INNER JOIN contribuyentes c ON
--			  c.idContribuyentes=t.idContribuyentes 





































select * from toma;

SELECT c.nombre AS NOMBRE, c.lastNameP AS [APELLIDO PATERNO], s.descripcion as [Status],ta.descripcion as [Tarifa] FROM toma t INNER JOIN contribuyentes c 
                             ON c.idContribuyentes=t.idContribuyentes INNER JOIN tarifa ta
							 ON t.idTarifa=ta.idTarifa INNER JOIN statusToma s
							 ON t.idStatusToma=s.idStatusToma							
-----------------------------------------------------------------------------------------------------------------------

	