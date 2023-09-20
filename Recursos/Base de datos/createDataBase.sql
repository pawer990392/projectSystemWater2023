--CREAMOS LA BASE DE DATOS
CREATE DATABASE SistemasCobroAgua;

--USAMOS LA BASE DE DATOS
USE SistemasCobroAgua;
					--------------------------------TABLA FUERTE--------------------------------
--TABLA rol
CREATE TABLE rol (
idRol       INTEGER NOT NULL IDENTITY(1,1),
descripcion VARCHAR(40) NOT NULL,
statusRol   BIT NOT NULL DEFAULT 1,
CONSTRAINT pk_rol PRIMARY KEY(IdRol)
);

---ISSERCCION DE DATOS
INSERT INTO rol (descripcion) 
	   VALUES('Adminisrador'),('Usuario');

--TABLA SERVICIO
CREATE TABLE servicio (
idServicio  INTEGER IDENTITY(1,1),
descripcion	VARCHAR(100) NOT NULL,
cost        DECIMAL NOT NULL,
statusServicio BIT NOT NULL DEFAULT 1
CONSTRAINT pk_servicio PRIMARY KEY(idServicio)
);

--INSERTAR TABLA servicio
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

--Tabla tipo de sancion
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

	       --------------------------------TABLA DEPEDIENTES--------------------------------

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

------Insertamos Datos
INSERT INTO usuarios (idRol,UserName,Password,name,lastNameP,lastNameM,Phone)
	   VALUES(2,'Miguel5673','Manchas123','Mario','Delgado','Martinez','2381813540'),
             (2,'cuevas9985','cuevas123','Armando','Perez','Moteo','2382050491'),
			 (2,'mkterisco','messi102023','Luis Miguel','Torres','Garcia','2381239081'),
			 (2,'Mariana1980','rocter123','Mariana','Vidal','Jimenez','2381234567'),
			 (1,'Angeito897','mthyer654','Luis Angel','Carrerra','Mendoza','2381245678');

----TABLA representantes
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

---INSERTAR DATOS
INSERT INTO representante(idCargo,nombre,lastNameP,lastNameM)
						  VALUES(1,'Felipe','Rodriguez','Castillo'),
								(2,'Guillermina','Valencia','Hernandez'),
								(3,'Martha','Merino','Pioquinto');

--TABLA Contribuyente
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
------INSERTAR DATOS
INSERT INTO contribuyentes (idCalle,numberExt,numberInt,nombre,lastNameP,lastNameM,genero,phone,descripcion)
VALUES (4,231,'','Narzo','Rodriguez','Mateo','H','2375674567','Es un saguna verde'),
	   (2,185,'','Misael','Rodriguez','Castillo','H','2389876543','Frente la tortilleria Ramos'),
	   (2,185,'','Samuel','Sanchez','Valencia','H','2381813540','Es a alado de una balconeria llamado Emmamnuel'),
	   (8,254,'','Enrique','Rodriguez','Merino','H','2374567544','A lado de un nieveria'),
	   (5,254,'','Eduardo','Marcos','Contrera','H','2373467865','/'),
	   (6,254,'','Hilda','Cruz','Merino','F','2376549876','/'),
	   (7,254,'','Elias','Lopez','Alvarez','H','2378450987','/'),
	   (3,254,'','Manuela','Luciana','Rivera Martinez','F','2373456721','Sagaun de color azul'),
	   (3,254,'','Miguel','Sanches','Gimenez','F','2381234567','Sagaun de color azul'),
	   (3,254,'','Angela','Sanches','Ortiz','F','2374567890','Sagaun de color azul');

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
---INSERTAR DATOS
INSERT INTO contrato (idContribuyentes,idServicio,idUser,idTarifa,costoFinalContrato)
       VALUES(1,2,1,1,1000),(2,2,4,2,1000),(7,2,5,1,1000),(3,2,2,1,1000),(6,2,1,1,1000);

--TABLA Toma
CREATE TABLE toma (
idToma INTEGER IDENTITY(1,1),
idContribuyentes INTEGER NOT NULL,
idUser INTEGER NOT NULL,
idCalle INTEGER NOT NULL,
idTarifa INTEGER NOT NULL,
idStatusToma INTEGER NOT NULL,
fechaTomaRegistrada DATETIME NOT NULL DEFAULT GETDATE(),
fechaTomaStar DATETIME NOT NULL DEFAULT GETDATE(),
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
		VALUES (1,2,4,1,1),
			   (2,2,2,2,1),
			   (3,3,2,1,2),
			   (4,4,8,2,2),
			   (5,5,5,1,2),
			   (6,2,6,2,2),
			   (7,1,7,1,2);

---TABLA MESES
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

--INSERTAR TABLA RECIBO
INSERT INTO Recibo(idToma,idUser,yeard,montoPagar) VALUES(1,2,2018,150.00);
INSERT INTO Recibo(idToma,idUser,yeard,montoPagar) VALUES(1,4,2018,150.00);
INSERT INTO Recibo(idToma,idUser,yeard,montoPagar) VALUES(1,3,2018,150.00);
INSERT INTO Recibo(idToma,idUser,yeard,montoPagar) VALUES(1,4,2019,600.00);
INSERT INTO Recibo(idToma,idUser,yeard,montoPagar) VALUES(1,5,2018,50.00);
INSERT INTO Recibo(idToma,idUser,yeard,montoPagar) VALUES(2,2,2018,500.00);
INSERT INTO Recibo(idToma,idUser,yeard,montoPagar) VALUES(3,3,2018,500.00);
INSERT INTO Recibo(idToma,idUser,yeard,montoPagar) VALUES(1,2,2019,600.00);

--TABLA detalles_Recibos
CREATE TABLE detalles_Recibos(
   idRecibo INTEGER NOT NULL,
   idMes INTEGER NOT NULL ,
   CONSTRAINT pk_ReciboMeses PRIMARY KEY(idRecibo,idMes),
   CONSTRAINT fk_detalleRecibo FOREIGN KEY (idRecibo) REFERENCES Recibo (idRecibo),
   CONSTRAINT fk_detalleMes FOREIGN KEY (idMes) REFERENCES meses (idMes),
);

--INSERTAR detalles_Recibos
	Insert INTO detalles_Recibos (idRecibo,idMes)Values (1,1),(1,2),(1,3);
	Insert INTO detalles_Recibos (idRecibo,idMes)Values (6,10);
	Insert INTO detalles_Recibos (idRecibo,idMes)Values (2,4),(2,5),(2,6);
	Insert INTO detalles_Recibos (idRecibo,idMes)Values (3,7),(3,8),(3,9);
	Insert INTO detalles_Recibos (idRecibo,idMes)Values (4,1),(4,2),(4,3),(4,4),(4,5),(4,6);
	Insert INTO detalles_Recibos (idRecibo,idMes)Values (5,1),(5,2),(5,3),(5,4),(5,5),(5,6);
	Insert INTO detalles_Recibos (idRecibo,idMes)Values (7,1),(7,2),(7,3),(7,4),(7,5),(7,6),(7,7),(7,8),(7,9),(7,10);
	Insert INTO detalles_Recibos (idRecibo,idMes)Values (8,1),(8,2),(8,3),(8,4),(8,5),(8,6),(8,7),(8,8),(8,9),(8,10);
	Insert INTO detalles_Recibos (idRecibo,idMes)Values (9,7),(9,8);

--TABLA ADEUDOS

CREATE TABLE adeudos(
idAdeudo INTEGER NOT NULL IDENTITY(1,1),
idToma INTEGER NOT NULL,
idTipoSancion INTEGER NOT NULL,
mesvencido VARCHAR(20) NOT NULL,
yearVencido INTEGER NOT NULL,
fechaGenerado DATETIME NOT NULL,
statusPagado BIT NOT NULL DEFAULT 0,
CONSTRAINT pk_idAdeudos PRIMARY KEY(idAdeudo),
CONSTRAINT fk_adeudosToma FOREIGN KEY (idToma) REFERENCES toma (idToma),
CONSTRAINT fk_adeudosSancion FOREIGN KEY (idTipoSancion) REFERENCES tipoSancion (idTipoSancion),
);
--INSERTANDO EJEMPLO adeudos
INSERT INTO adeudos(idToma,idTipoSancion,mesvencido,yearVencido,fechaGenerado)VALUES(1,2,'Novimebre',2018,'2019-05-18');
INSERT INTO adeudos(idToma,idTipoSancion,mesvencido,yearVencido,fechaGenerado)VALUES(1,2,'Diciembre',2018,'2019-06-18');

--TABLA reciboAdeudos
CREATE TABLE reciboAdeudos(
	   idRecibo INTEGER NOT NULL, 
	   idAdeudo INTEGER NOT NULL,
	   CONSTRAINT pk_ReciboAdeudos PRIMARY KEY(idRecibo,idAdeudo),
	   CONSTRAINT fk_Recibodetalles FOREIGN KEY (idRecibo) REFERENCES Recibo (idRecibo),
	   CONSTRAINT fk_detalleAdeudos FOREIGN KEY (idAdeudo) REFERENCES adeudos (idAdeudo),
);
--ISNERTANDO reciboAdeudos
INSERT INTO reciboAdeudos (idRecibo,idAdeudo)VALUES(9,1);

--TABLA TOMA ADICIONAL
CREATE TABLE tomasAdicionales(
idtomaAdicional INTEGER NOT NULL IDENTITY(1,1),
idToma INTEGER NOT NULL,
idUser INTEGER NOT NULL,
idContribuyentes INTEGER NOT NULL,
idTarifa INTEGER NOT NULL,
idStatusToma INTEGER NOT NULL,
comentario VARCHAR(200) NULL DEFAULT 's/c',
fechaCreada DATETIME NOT NULL DEFAULT GETDATE(),
CONSTRAINT pk_tomasAdicionales PRIMARY KEY(idtomaAdicional),
CONSTRAINT fk_tomasAdicionalesToma FOREIGN KEY (idToma) REFERENCES toma (idToma),
CONSTRAINT fk_tomasAdicionalesUser FOREIGN KEY (idUser) REFERENCES usuarios (idUser),
CONSTRAINT fk_tomasAdicionalContribuyente FOREIGN KEY (idContribuyentes) REFERENCES contribuyentes (idContribuyentes),
CONSTRAINT fk_tomasAdicionalesTarifa FOREIGN KEY (idTarifa) REFERENCES tarifa (idTarifa),
CONSTRAINT fk_tomasAdicionalStatusToma FOREIGN KEY (idStatusToma) REFERENCES statusToma (idStatusToma),
);

--INSERTAMOS Tomas Adicionales
INSERT INTO tomasAdicionales(idToma,idUser,idContribuyentes,idTarifa,idStatusToma,comentario)
			VALUES (1,2,9,2,1,''),(1,4,10,2,1,'');

		
-------TABLA RECIBO
CREATE TABLE ReciboAdicionales(
idReciboAdicionales INTEGER NOT NULL IDENTITY(1,1),
idtomaAdicional INTEGER NOT NULL,
idUser INTEGER  NOT NULL,
yeard  INTEGER NOT NULL,
montoPagar DECIMAL(9,2) NOT NULL,
fechaGenerado DATETIME NOT NULL DEFAULT GETDATE(),
CONSTRAINT pk_ReciboAdicionalesPrimary PRIMARY KEY(idReciboAdicionales),
CONSTRAINT fk_ReciboAdicionalesTomas FOREIGN KEY (idtomaAdicional) REFERENCES tomasAdicionales (idtomaAdicional),
CONSTRAINT fk_ReciboAdicionalesUser FOREIGN KEY (idUser) REFERENCES usuarios (idUser)
);

--INSERTAR TABLA RECIBO
INSERT INTO ReciboAdicionales(idtomaAdicional,idUser,yeard,montoPagar) 
							  VALUES(1,3,2018,150.00),(1,3,2018,150.00);

							  select * from ReciboAdicionales

--CREATE TABLE detalles_RecibosAdicionales
CREATE TABLE detalles_RecibosAdicionales(
   idReciboAdicionales INTEGER NOT NULL,
   idMes INTEGER NOT NULL ,
   CONSTRAINT pk_ReciboMesesAdicional PRIMARY KEY(idReciboAdicionales,idMes),
   CONSTRAINT fk_detalleReciboAdicional FOREIGN KEY (idReciboAdicionales) REFERENCES ReciboAdicionales (idReciboAdicionales),
   CONSTRAINT fk_detalleMesAdicional FOREIGN KEY (idMes) REFERENCES meses (idMes),
);

--INSERTAR DATOS detalles_RecibosAdicionales
	Insert INTO detalles_RecibosAdicionales (idReciboAdicionales,idMes)Values (1,1),(1,2),(1,3);
	Insert INTO detalles_RecibosAdicionales (idReciboAdicionales,idMes)Values (2,4),(2,5),(2,6);

