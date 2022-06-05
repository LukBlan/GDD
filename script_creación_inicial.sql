/*
ALTER TABLE ----------
ADD CONSTRAINT FK---------
FOREIGN KEY (--------) REFERENCES ---------(---------);
*/

USE [test]
GO

CREATE SCHEMA [LUSAX2]
GO

CREATE TABLE [LUSAX2].[Telemetria] (
  TELEMETRIA_ID int NOT NULL,
  TELE_AUTO_ID int,
  Carrera_id int,
  SECTOR_CODIGO int,
  TELE_CAJA_CAMBIO_ID int,
  TELE_FRENO_ID int,
  TELE_NEUMATICO_ID int,
  TELE_MOTOR_ID int,
  PRIMARY KEY (TELEMETRIA_ID),
);

CREATE TABLE [LUSAX2].[Telemetria_Auto] (
  TELE_AUTO_ID int NOT NULL,
  AUTO_ID int,
  TELE_AUTO_POSICION decimal(18,0),
  TELE_AUTO_NRO_VUELTA decimal(18,0),  
  TELE_AUTO_DISTANCIA_CARRERA decimal(18,6),
  TELE_AUTO_TIEMPO_VUELTA decimal(18,10),
  TELE_AUTO_VELOCIDAD decimal(18,2),
  TELE_AUTO_COMBUSTIBLE decimal(18,2),
  TELE_AUTO_DISTANCIA_VUELTA decimal(18,2),
  CONSTRAINT PK_TELE_AUTO_ID PRIMARY KEY (TELE_AUTO_ID),
);

CREATE TABLE [LUSAX2].[Automovil] (
  AUTO_ID INT NOT NULL IDENTITY(1,1),
  AUTO_NUMERO int NOT NULL,
  ESCUDERIA_NOMBRE nvarchar(255),
  PILOTO_ID int,
 /* NEUMATICO_NRO_SERIE nvarchar(255),
  MOTOR_NRO_SERIE nvarchar(255),
  CAJA_NRO_SERIE nvarchar(255),
  FRENO_NRO_SERIE nvarchar(255),*/
  AUTO_MODELO nvarchar(255),
  CONSTRAINT PK_AUTO_ID PRIMARY KEY (AUTO_ID),
);

CREATE TABLE [LUSAX2].[Carrera] (
  Carrera_id int NOT NULL IDENTITY(1,1),
  CARRERA_CODIGO int ,
  Circuito_id int,
  CARRERA_CLIMA  nvarchar(100),
  CARRERA_CANT_VUELTAS int,
  CARRERA_FECHA date,
  CONSTRAINT PK_Carrera_id PRIMARY KEY (Carrera_id),
);

CREATE TABLE [LUSAX2].[Circuito] (
  Circuito_id int NOT NULL IDENTITY(1,1),
  CIRCUITO_CODIGO int,
  CIRCUITO_NOMBRE nvarchar(255),
  CIRCUITO_PAIS nvarchar(255),
  SECTOR_CODIGO int,
  CONSTRAINT PK_Circuito_id PRIMARY KEY (Circuito_id),
);

CREATE TABLE [LUSAX2].[Sector] (
  SECTOR_CODIGO int NOT NULL,
  SECTOR_TIPO nvarchar(255),
  SECTOR_DISTANCIA decimal(18, 2),
  CONSTRAINT PK_SECTOR_CODIGO PRIMARY KEY (SECTOR_CODIGO),
);

CREATE TABLE [LUSAX2].[Telemetria_CajaDeCambio] (
  TELE_CAJA_CAMBIO_ID int NOT NULL identity(1,1),
  CAJA_NRO_SERIE nvarchar(255),
  TELE_CAJA_TEMP_ACEITE decimal (18,2),
  TELE_CAJA_RPM decimal (18,2),
  TELE_CAJA_DESGASTE decimal (18,2),
  CONSTRAINT PK_TELE_CAJA_CAMBIO_ID PRIMARY KEY (TELE_CAJA_CAMBIO_ID),
);

CREATE TABLE [LUSAX2].[CajaDeCambio] (
  --CAJA_ID INT IDENTITY(1,1),
  CAJA_NRO_SERIE nvarchar(255),
  CAJA_MODELO nvarchar (50),
  AUTO_ID INT,
  CONSTRAINT PK_CAJA_NRO_SERIE PRIMARY KEY (CAJA_NRO_SERIE),
);

CREATE TABLE [LUSAX2].[Telemetria_Freno] (
  TELE_FRENO_ID int NOT NULL identity(1,1),
  FRENO_NRO_SERIE nvarchar(255),
  TELE_FRENO_GROSOR_PASTILLA decimal (18,2),
  TELE_TEMPERATURA decimal (18,2),
  TELE_TAMANIO_DISCO decimal (18,2),
  CONSTRAINT PK_TELE_FRENO_ID PRIMARY KEY (TELE_FRENO_ID),
);

CREATE TABLE [LUSAX2].[Freno] (
  --FRENO_ID INT IDENTITY(1,1),
  FRENO_NRO_SERIE nvarchar(255),
  FRENO_POSICION nvarchar(255),
  AUTO_ID INT,
  CONSTRAINT PK_FRENO_NRO_SERIE PRIMARY KEY (FRENO_NRO_SERIE),
);

CREATE TABLE [LUSAX2].[Telemetria_Neumatico] (
  TELE_NEUMATICO_ID int NOT NULL identity(1,1),
  NEUMATICO_NRO_SERIE nvarchar(255),
  TELE_NEUMATICO_PRESION decimal(18,6),
  TELE_NEUMATICO_PROFUNDIDAD decimal(18,6),
  TELE_NEUMATICO_TEMPERATURA decimal(18,6),
  CONSTRAINT PK_TELE_NEUMATICO_ID PRIMARY KEY(TELE_NEUMATICO_ID),
);

CREATE TABLE [LUSAX2].[Escuderia] ( 
  ESCUDERIA_NACIONALIDAD NVARCHAR (255),
  ESCUDERIA_NOMBRE nvarchar (255) NOT NULL,
 
  CONSTRAINT PK_ESCUDERIA_NOMBRE PRIMARY KEY(ESCUDERIA_NOMBRE),
);

CREATE TABLE [LUSAX2].[Piloto] (
  PILOTO_ID int NOT NULL IDENTITY (1,1),
  PILOTO_NOMBRE nvarchar(50),
  PILOTO_APELLIDO nvarchar(50),
  PILOTO_NACIONALIDAD nvarchar(50),
  PILOTO_FECHA_NACIMIENTO date,
  CONSTRAINT PK_PILOTO_ID PRIMARY KEY(PILOTO_ID),
);

CREATE TABLE [LUSAX2].[Telemetria_Motor] (
  TELE_MOTOR_ID int IDENTITY(1,1),
  MOTOR_NRO_SERIE nvarchar(255),
  TELE_MOTOR_RPM decimal(18, 6),
  TELE_MOTOR_TEMP_ACEITE decimal(18, 6),
  TELE_MOTOR_TEMP_AGUA  decimal(18, 6),
  TELE_MOTOR_POTENCIA decimal(18, 6),
  CONSTRAINT PK_TELE_MOTOR_ID PRIMARY KEY(TELE_MOTOR_ID),
);

CREATE TABLE [LUSAX2].[Motor] (
  --MOTOR_ID INT IDENTITY(1,1),
  MOTOR_NRO_SERIE nvarchar(255),
  MOTOR_MODELO nvarchar(255),
  AUTO_ID INT,
  CONSTRAINT PK_MOTOR_NRO_SERIE PRIMARY KEY(MOTOR_NRO_SERIE),
);

CREATE TABLE [LUSAX2].[Incidente] (
  INCIDENTE_ID  int  NOT NULL identity(1,1),
  CARRERA_id int,
  INCIDENTE_TIPO nvarchar(255),
  INCIDENTE_BANDERA nvarchar(255),
  INCIDENTE_TIEMPO decimal(18,2),
  CONSTRAINT PK_INCIDENTE_ID PRIMARY KEY(INCIDENTE_ID),
);

CREATE TABLE [LUSAX2].[AutoxIncidente] (
  INCIDENTE_ID int NOT NULL IDENTITY(1,1),
  AUTO_ID int NOT NULL,
  INCIDENTE_NUMERO_VUELTA decimal(18,0),
  CONSTRAINT PK_AutoXIncidente_ID PRIMARY KEY(AUTO_ID,INCIDENTE_ID),
);

CREATE TABLE [LUSAX2].[Parada] (
  PARADA_CODIGO_BOX int NOT NULL identity(1,1),
  AUTO_ID int,
  Carrera_id int,
  PARADA_BOX_VUELTA decimal(18, 0),
  PARADA_BOX_TIEMPO decimal(18, 2),
  CONSTRAINT PK_PARADA_CODIGO_BOX PRIMARY KEY(PARADA_CODIGO_BOX),
);

CREATE TABLE [LUSAX2].[Neumatico] (
  --NEUMATICO_ID INT IDENTITY(1,1),
  NEUMATICO_NRO_SERIE nvarchar(255),
  NEUMATICO_POSICION nvarchar(255),
  NEUMATICO_TIPO nvarchar(255),
  AUTO_ID INT,
  CONSTRAINT PK_NEUMATICO_NRO_SERIE PRIMARY KEY(NEUMATICO_NRO_SERIE),
);

CREATE TABLE [LUSAX2].[Cambio_Neumatico] (
  ID_CAMBIO_NEUMATICOS int NOT NULL identity(1,1),
  NEUMATICO_NRO_SERIE_VIEJO nvarchar(255),
  NEUMATICO_NRO_SERIE_NUEVO nvarchar(255),
  PARADA_CODIGO_BOX int,
  CONSTRAINT PK_ID_CAMBIO_NEUMATICOS PRIMARY KEY(ID_CAMBIO_NEUMATICOS),
);

ALTER TABLE [LUSAX2].[Parada]
ADD CONSTRAINT FKP_Carrera_id
FOREIGN KEY (Carrera_id) REFERENCES [LUSAX2].[Carrera](Carrera_id);

ALTER TABLE [LUSAX2].[Parada]
ADD CONSTRAINT FKP_AUTO_ID
FOREIGN KEY (AUTO_ID) REFERENCES [LUSAX2].[automovil](AUTO_ID);

ALTER TABLE [LUSAX2].[Cambio_Neumatico]
ADD CONSTRAINT FKC_NEUMATICO_NRO_SERIE_NUEVO
FOREIGN KEY (NEUMATICO_NRO_SERIE_NUEVO) REFERENCES [LUSAX2].[Neumatico](NEUMATICO_NRO_SERIE);

ALTER TABLE [LUSAX2].[Cambio_Neumatico]
ADD CONSTRAINT FKC_NEUMATICO_NRO_SERIE_VIEJO
FOREIGN KEY (NEUMATICO_NRO_SERIE_VIEJO) REFERENCES [LUSAX2].[Neumatico](NEUMATICO_NRO_SERIE);

ALTER TABLE [LUSAX2].[Cambio_Neumatico]
ADD CONSTRAINT FKC_PARADA_CODIGO_BOX
FOREIGN KEY (PARADA_CODIGO_BOX) REFERENCES [LUSAX2].[Parada](PARADA_CODIGO_BOX);

ALTER TABLE [LUSAX2].[AutoxIncidente]
ADD CONSTRAINT FKI_AUTO_ID
FOREIGN KEY (AUTO_ID) REFERENCES [LUSAX2].[Automovil](AUTO_ID);

ALTER TABLE [LUSAX2].[AutoxIncidente]
ADD CONSTRAINT FK_INCIDENTE_ID
FOREIGN KEY ( INCIDENTE_ID) REFERENCES [LUSAX2].[Incidente](INCIDENTE_ID);

ALTER TABLE [LUSAX2].[Incidente]
ADD CONSTRAINT FKI_Carrera_id
FOREIGN KEY (Carrera_id) REFERENCES [LUSAX2].[Carrera](Carrera_id);

ALTER TABLE [LUSAX2].[Telemetria]
ADD CONSTRAINT FK_TELE_AUTO_ID
FOREIGN KEY (TELE_AUTO_ID) REFERENCES [LUSAX2].[Telemetria_Auto](TELE_AUTO_ID);

ALTER TABLE [LUSAX2].[Telemetria]
ADD CONSTRAINT FK_Carrera_id
FOREIGN KEY (Carrera_id) REFERENCES [LUSAX2].[Carrera](Carrera_id);

ALTER TABLE [LUSAX2].[Telemetria]
ADD CONSTRAINT FK_SECTOR_CODIGO
FOREIGN KEY (SECTOR_CODIGO) REFERENCES [LUSAX2].[Sector](SECTOR_CODIGO);

ALTER TABLE [LUSAX2].[Telemetria]
ADD CONSTRAINT FK_TELE_CAJA_CAMBIO_ID
FOREIGN KEY (TELE_CAJA_CAMBIO_ID) REFERENCES [LUSAX2].[Telemetria_CajaDeCambio](TELE_CAJA_CAMBIO_ID);

ALTER TABLE [LUSAX2].[Telemetria]
ADD CONSTRAINT FK_TELE_FRENO_ID
FOREIGN KEY (TELE_FRENO_ID) REFERENCES [LUSAX2].[Telemetria_Freno](TELE_FRENO_ID);

ALTER TABLE [LUSAX2].[Telemetria]
ADD CONSTRAINT FK_TELE_NEUMATICO_ID
FOREIGN KEY (TELE_NEUMATICO_ID) REFERENCES [LUSAX2].[Telemetria_Neumatico](TELE_NEUMATICO_ID);

ALTER TABLE [LUSAX2].[Telemetria]
ADD CONSTRAINT FK_TELE_MOTOR_ID
FOREIGN KEY (TELE_MOTOR_ID) REFERENCES [LUSAX2].[Telemetria_Motor](TELE_MOTOR_ID);

ALTER TABLE [LUSAX2].[Telemetria_Neumatico]
ADD CONSTRAINT FKN_NEUMATICO_NRO_SERIE
FOREIGN KEY (NEUMATICO_NRO_SERIE) REFERENCES [LUSAX2].[Neumatico](NEUMATICO_NRO_SERIE);


ALTER TABLE [LUSAX2].[Telemetria_Auto]
ADD CONSTRAINT FK_AUTO_ID
FOREIGN KEY (AUTO_ID) REFERENCES [LUSAX2].[Automovil](AUTO_ID);

ALTER TABLE [LUSAX2].[Automovil]
ADD CONSTRAINT FK_ESCUDERIA_NOMBRE
FOREIGN KEY (ESCUDERIA_NOMBRE) REFERENCES [LUSAX2].[Escuderia](ESCUDERIA_NOMBRE);

ALTER TABLE [LUSAX2].[Automovil]
ADD CONSTRAINT FK_PILOTO_ID
FOREIGN KEY (PILOTO_ID) REFERENCES [LUSAX2].[Piloto](PILOTO_ID);

ALTER TABLE [LUSAX2].[NEUMATICO]
ADD CONSTRAINT FKn_AUTO_ID
FOREIGN KEY (AUTO_ID) REFERENCES [LUSAX2].[AUTOMOVIL](AUTO_ID);

ALTER TABLE [LUSAX2].[CAJADECAMBIO]
ADD CONSTRAINT FKc_AUTO_ID
FOREIGN KEY (AUTO_ID) REFERENCES [LUSAX2].[AUTOMOVIL](AUTO_ID);

ALTER TABLE [LUSAX2].[FRENO]
ADD CONSTRAINT FKf_AUTO_ID
FOREIGN KEY (AUTO_ID) REFERENCES [LUSAX2].[AUTOMOVIL](AUTO_ID);

ALTER TABLE [LUSAX2].[MOTOR]
ADD CONSTRAINT FKm_AUTO_ID
FOREIGN KEY (AUTO_ID) REFERENCES [LUSAX2].[AUTOMOVIL](AUTO_ID);

ALTER TABLE [LUSAX2].[Telemetria_Freno]
ADD CONSTRAINT FKT_FRENO_NRO_SERIE
FOREIGN KEY (FRENO_NRO_SERIE) REFERENCES [LUSAX2].[Freno](FRENO_NRO_SERIE);

ALTER TABLE [LUSAX2].[Carrera]
ADD CONSTRAINT FK_Circuito_id
FOREIGN KEY (Circuito_id) REFERENCES [LUSAX2].[Circuito](Circuito_id);

ALTER TABLE [LUSAX2].[Circuito]
ADD CONSTRAINT FKC_SECTOR_CODIGO
FOREIGN KEY (SECTOR_CODIGO) REFERENCES [LUSAX2].[Sector](SECTOR_CODIGO);

ALTER TABLE [LUSAX2].[Telemetria_CajaDeCambio]
ADD CONSTRAINT FKT_CAJA_NRO_SERIE
FOREIGN KEY (CAJA_NRO_SERIE) REFERENCES [LUSAX2].[CajaDeCambio](CAJA_NRO_SERIE);

ALTER TABLE [LUSAX2].[Telemetria_Motor]
ADD CONSTRAINT FKT_MOTOR_NRO_SERIE
FOREIGN KEY (MOTOR_NRO_SERIE) REFERENCES [LUSAX2].[Motor](MOTOR_NRO_SERIE);
