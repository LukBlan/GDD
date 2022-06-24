use bi
go

CREATE SCHEMA [LUSAX2]
GO

create table lusax2.BI_tablaDeHechos (
	auto_id int NOT NULL,
	piloto_id int,
	circuito_codigo int, 
	tiempo_id int,
	escuderia_nombre nvarchar(255),
	neumatico_tipo nvarchar(255),
	sector_tipo nvarchar(255),
	[TELE_AUTO_VELOCIDAD] decimal(18,2)
);

CREATE TABLE lusax2.BI_Automovil (
  AUTO_ID int NOT NULL,
  AUTO_NUMERO int,
  AUTO_MODELO nvarchar(255),
  CONSTRAINT PK_AUTO_ID PRIMARY KEY (AUTO_ID),
);

create table lusax2.BI_tipoNeumatico (
	neumatico_tipo nvarchar(255) NOT NULL,
	CONSTRAINT PK_neumatico_tipo PRIMARY KEY (neumatico_tipo),
);

CREATE TABLE lusax2.BI_Escuderia ( 
	ESCUDERIA_NOMBRE nvarchar (255) NOT NULL,
	ESCUDERIA_NACIONALIDAD NVARCHAR (255),
  CONSTRAINT PK_ESCUDERIA_NOMBRE PRIMARY KEY(ESCUDERIA_NOMBRE),
);

CREATE TABLE lusax2.BI_Piloto (
  PILOTO_ID int NOT NULL,
  PILOTO_NOMBRE nvarchar(50),
  PILOTO_APELLIDO nvarchar(50),
  PILOTO_NACIONALIDAD nvarchar(50),
  PILOTO_FECHA_NACIMIENTO date,
  CONSTRAINT PK_PILOTO_ID PRIMARY KEY(PILOTO_ID),
);

CREATE TABLE lusax2.BI_Circuito (
  CIRCUITO_CODIGO int not null,
  CIRCUITO_NOMBRE nvarchar(255),
  CIRCUITO_PAIS nvarchar(255),
  CONSTRAINT PK_CIRCUITO_CODIGO PRIMARY KEY (CIRCUITO_CODIGO),
);

Create TABLE lusax2.BI_Tiempo (
	tiempo_id int not null identity(1,1),
	anio int,
	cuatrimestre int,
	CONSTRAINT PK_tiempo_id PRIMARY KEY (tiempo_id),
)

create table lusax2.BI_tipoSector (
	sector_tipo nvarchar(255) NOT NULL,
	CONSTRAINT PK_sector_tipo PRIMARY KEY (sector_tipo),
);

alter table lusax2.BI_tablaDeHechos
ADD CONSTRAINT FK_auto_id
FOREIGN KEY (auto_id) REFERENCES lusax2.BI_Automovil(auto_id);

alter table lusax2.BI_tablaDeHechos
ADD CONSTRAINT FK_piloto_id
FOREIGN KEY (piloto_id) REFERENCES lusax2.BI_Piloto(piloto_id);

alter table lusax2.BI_tablaDeHechos
ADD CONSTRAINT FK_circuito_codigo
FOREIGN KEY (circuito_codigo) REFERENCES lusax2.BI_Circuito(circuito_codigo);

alter table lusax2.BI_tablaDeHechos
ADD CONSTRAINT FK_neumatico_tipo
FOREIGN KEY (neumatico_tipo) REFERENCES lusax2.BI_tipoNeumatico(neumatico_tipo);

alter table lusax2.BI_tablaDeHechos
ADD CONSTRAINT FK_tiempo_id
FOREIGN KEY (tiempo_id) REFERENCES lusax2.BI_Tiempo(tiempo_id);

alter table lusax2.BI_tablaDeHechos
ADD CONSTRAINT FK_ESCUDERIA_NOMBRE
FOREIGN KEY (ESCUDERIA_NOMBRE) REFERENCES lusax2.BI_Escuderia(ESCUDERIA_NOMBRE);

alter table lusax2.BI_tablaDeHechos
ADD CONSTRAINT FK_sector_tipo
FOREIGN KEY (sector_tipo) REFERENCES lusax2.BI_tipoSector(sector_tipo);

insert into bi.[LUSAX2].[BI_Automovil] ([AUTO_ID],[AUTO_NUMERO],[AUTO_MODELO])
select distinct [AUTO_ID], [AUTO_NUMERO], [AUTO_MODELO]
from test.[LUSAX2].[Automovil]

insert into bi.[LUSAX2].BI_tipoNeumatico (neumatico_tipo)
select distinct NEUMATICO_TIPO
from test.[LUSAX2].[Neumatico]
group by NEUMATICO_TIPO
having NEUMATICO_TIPO is not null

insert into bi.lusax2.BI_Escuderia ([ESCUDERIA_NOMBRE], [ESCUDERIA_NACIONALIDAD])
select distinct [ESCUDERIA_NOMBRE], [ESCUDERIA_NACIONALIDAD]
from test.[LUSAX2].[Escuderia]

insert into bi.lusax2.BI_Piloto ([PILOTO_ID],[PILOTO_NOMBRE], [PILOTO_APELLIDO], [PILOTO_NACIONALIDAD], [PILOTO_FECHA_NACIMIENTO])
select distinct [PILOTO_ID],[PILOTO_NOMBRE], [PILOTO_APELLIDO], [PILOTO_NACIONALIDAD], [PILOTO_FECHA_NACIMIENTO]
from test.[LUSAX2].[Piloto]

insert into bi.lusax2.BI_Circuito (CIRCUITO_CODIGO, CIRCUITO_NOMBRE, CIRCUITO_PAIS)
select distinct CIRCUITO_CODIGO, CIRCUITO_NOMBRE, CIRCUITO_PAIS
from test.[LUSAX2].[Circuito]

insert into bi.lusax2.BI_tipoSEctor ([sector_tipo])
select distinct [SECTOR_TIPO]
from test.[LUSAX2].[Sector]

insert into bi.lusax2.BI_Tiempo (anio, cuatrimestre)
select distinct year([CARRERA_FECHA]), CASE
    WHEN MONTH(CARRERA_FECHA) >= 1 AND MONTH(CARRERA_FECHA) <= 4 THEN 1
    WHEN MONTH(CARRERA_FECHA) >= 5 AND MONTH(CARRERA_FECHA) <= 8 THEN 2
    WHEN MONTH(CARRERA_FECHA) >= 9 AND MONTH(CARRERA_FECHA) <= 12 THEN 3
    end AS "Cuatrimestre"
from test.[LUSAX2].[Carrera]


/*
insert into lusax2.BI_tablaDeHechos (auto_id, sector_tipo, circuito_codigo, escuderia_nombre, piloto_id, neumatico_tipo, )
select a.auto_id, s.sector_tipo, s.circuito_codigo,a.[ESCUDERIA_NOMBRE], c.carrera_fecha,a.[PILOTO_ID], n.[NEUMATICO_TIPO], max([TELE_AUTO_VELOCIDAD])
from lusax2.automovil as a	join lusax2.telemetria_auto as ta on a.auto_id = ta.auto_id
							join lusax2.telemetria as t on t.tele_auto_id = ta.tele_auto_id 
							join lusax2.sector as s on s.sector_codigo = t.sector_codigo
							join lusax2.carrera as c on c.[CARRERA_CODIGO] = t.[CARRERA_CODIGO]
							join lusax2.neumatico as n on a.auto_id = n.auto_id

group by a.auto_id, s.sector_tipo, s.circuito_codigo,a.[ESCUDERIA_NOMBRE], c.carrera_fecha,a.[PILOTO_ID], n.[NEUMATICO_TIPO]
*/