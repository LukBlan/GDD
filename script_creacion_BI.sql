use bi
go

CREATE SCHEMA [LUSAX2]
GO

create table lusax2.BI_Mediciones (
	circuito_codigo int,
	piloto_id int,
	tiempo_id int,
	escuderia_nombre nvarchar(255),
	sector_tipo nvarchar(255),
	auto_id int,
	neumatico_tipo nvarchar(255),
	numero_vuelta int,
	Desgaste_Caja decimal(18,2),
	Desgaste_Neumatico decimal(18,6),
	Desgaste_freno decimal(18,2),
	desgaste_motor decimal(18,6),
	consumo_Combustible_promedio decimal(18,2),
	velocidad_Maxima decimal(18,2),
	tiempo_Vuelta decimal(18,10),
	CONSTRAINT PK_fact_Mediciones PRIMARY KEY (circuito_codigo, piloto_id, tiempo_id, escuderia_nombre, sector_tipo, auto_id,neumatico_tipo, numero_vuelta)
); 

create table lusax2.BI_Incidente (
	INCIDENTE_TIPO nvarchar(255),
	circuito_codigo int,
	piloto_id int,
	tiempo_id int,
	escuderia_nombre nvarchar(255),
	auto_id int,
	cantidad_Incidentes int,
	promedio_incidentes decimal(18,2),
	sector_tipo nvarchar(255), 
	CONSTRAINT PK_fact_INCIDENTE PRIMARY KEY (INCIDENTE_TIPO, circuito_codigo, piloto_id, tiempo_id, escuderia_nombre,	auto_id, sector_tipo),
); 

create table lusax2.BI_Parada (
	circuito_codigo int,
	tiempo_id int,
	escuderia_nombre nvarchar(255),
	tiempo_Promedio_Boxes decimal(18,2),
	cantidad_Paradas int,
	CONSTRAINT PK_fact_Parada PRIMARY KEY (circuito_codigo, tiempo_id, escuderia_nombre),
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

create table lusax2.Bi_vuelta (
	numero_vuelta int
	CONSTRAINT PK_numero_vuelta PRIMARY KEY(numero_vuelta),
)

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

create table lusax2.BI_tipo_incidente (
	INCIDENTE_TIPO nvarchar(255),
	CONSTRAINT PK_INCIDENTE_TIPO PRIMARY KEY (INCIDENTE_TIPO),
)

alter table lusax2.BI_Parada
ADD CONSTRAINT FKP_circuito_codigo
FOREIGN KEY (circuito_codigo) REFERENCES lusax2.BI_Circuito(circuito_codigo);

alter table lusax2.BI_Parada
ADD CONSTRAINT FKP_tiempo_id
FOREIGN KEY (tiempo_id) REFERENCES lusax2.BI_Tiempo(tiempo_id);

alter table lusax2.BI_Parada
ADD CONSTRAINT FKP_ESCUDERIA_NOMBRE
FOREIGN KEY (ESCUDERIA_NOMBRE) REFERENCES lusax2.BI_Escuderia(ESCUDERIA_NOMBRE);

alter table lusax2.BI_Mediciones
ADD CONSTRAINT FKC_auto_id
FOREIGN KEY (auto_id) REFERENCES lusax2.BI_Automovil(auto_id);

alter table lusax2.BI_Mediciones
ADD CONSTRAINT FKC_piloto_id
FOREIGN KEY (piloto_id) REFERENCES lusax2.BI_Piloto(piloto_id);

alter table lusax2.BI_Mediciones
ADD CONSTRAINT FKC_circuito_codigo
FOREIGN KEY (circuito_codigo) REFERENCES lusax2.BI_Circuito(circuito_codigo);

alter table lusax2.BI_Mediciones
ADD CONSTRAINT FKC_tiempo_id
FOREIGN KEY (tiempo_id) REFERENCES lusax2.BI_Tiempo(tiempo_id);

alter table lusax2.BI_Mediciones
ADD CONSTRAINT FKC_ESCUDERIA_NOMBRE
FOREIGN KEY (ESCUDERIA_NOMBRE) REFERENCES lusax2.BI_Escuderia(ESCUDERIA_NOMBRE);

alter table lusax2.BI_Mediciones
ADD CONSTRAINT FK_sector_tipo
FOREIGN KEY (sector_tipo) REFERENCES lusax2.BI_tipoSector(sector_tipo);

alter table lusax2.BI_Mediciones
ADD CONSTRAINT FK_neumatico_tipo
FOREIGN KEY (neumatico_tipo) REFERENCES lusax2.BI_tipoNeumatico(neumatico_tipo)

alter table lusax2.BI_Mediciones
ADD CONSTRAINT FK_numero_vuelta
FOREIGN KEY (numero_vuelta) REFERENCES lusax2.BI_vuelta(numero_vuelta)


alter table lusax2.BI_Incidente
ADD CONSTRAINT FKI_auto_id
FOREIGN KEY (auto_id) REFERENCES lusax2.BI_Automovil(auto_id);

alter table lusax2.BI_Incidente
ADD CONSTRAINT FK_incidente_tipo
FOREIGN KEY (INCIDENTE_TIPO) REFERENCES lusax2.BI_tipo_incidente(INCIDENTE_TIPO);

alter table lusax2.BI_Incidente
ADD CONSTRAINT FKI_piloto_id
FOREIGN KEY (piloto_id) REFERENCES lusax2.BI_Piloto(piloto_id);

alter table lusax2.BI_Incidente
ADD CONSTRAINT FKI_circuito_codigo
FOREIGN KEY (circuito_codigo) REFERENCES lusax2.BI_Circuito(circuito_codigo);

alter table lusax2.BI_Incidente
ADD CONSTRAINT FKI_tiempo_id
FOREIGN KEY (tiempo_id) REFERENCES lusax2.BI_Tiempo(tiempo_id);

alter table lusax2.BI_Incidente
ADD CONSTRAINT FKI_ESCUDERIA_NOMBRE
FOREIGN KEY (ESCUDERIA_NOMBRE) REFERENCES lusax2.BI_Escuderia(ESCUDERIA_NOMBRE);

alter table lusax2.BI_Incidente
ADD CONSTRAINT FKI_sector_tipo
FOREIGN KEY (sector_tipo) REFERENCES lusax2.BI_tipoSector(sector_tipo);

insert into bi.LUSAX2.Bi_vuelta (numero_vuelta)
select distinct [TELE_AUTO_NRO_VUELTA]
from test.[LUSAX2].[Telemetria_Auto]

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
									        WHEN MONTH(CARRERA_FECHA) > 8	THEN 3
										    WHEN MONTH(CARRERA_FECHA) > 4	THEN 2
										    ELSE 1 
									   end AS "Cuatrimestre"
from test.[LUSAX2].[Carrera]

insert into bi.lusax2.BI_tipo_incidente (INCIDENTE_TIPO)
select distinct INCIDENTE_TIPO
from test.[LUSAX2].[Incidente]
group by INCIDENTE_TIPO

-- Se crea tabla temporal intermedia Para luego migrar a la tabla de Hechos Mediciones
create table lusax2.tempNeumatico (
	NEUMATICO_NRO_SERIE nvarchar(255),
	FRENO_NRO_SERIE nvarchar(255),
	circuito_codigo int,
	piloto_id int,
	tiempo_id int,
	escuderia_nombre nvarchar(255),
	sector_tipo nvarchar(255),
	auto_id int,
	neumatico_tipo nvarchar(255),
	numero_vuelta int,
	Desgaste_Caja decimal(18,2),
	Desgaste_Neumatico decimal(18,6),
	Desgaste_freno decimal(18,2),
	desgaste_motor decimal(18,6),
	consumo_Combustible_promedio decimal(18,2),
	velocidad_Maxima decimal(18,2),
	tiempo_Vuelta decimal(18,10),
)

insert into LUSAX2.tempNeumatico (NEUMATICO_NRO_SERIE, FRENO_NRO_SERIE, sector_tipo, neumatico_tipo, auto_id, circuito_codigo, escuderia_nombre, piloto_id, numero_vuelta,tiempo_id,consumo_Combustible_promedio, velocidad_Maxima, desgaste_motor,Desgaste_Caja,Desgaste_Neumatico, Desgaste_freno, tiempo_Vuelta)
select n.NEUMATICO_NRO_SERIE, 
		tf.FRENO_NRO_SERIE,
		SECTOR_TIPO, 
		NEUMATICO_TIPO, 
		a.AUTO_ID, 
		s.CIRCUITO_CODIGO, 
		a.ESCUDERIA_NOMBRE, 
		PILOTO_ID, 
		TELE_AUTO_NRO_VUELTA, 
		tiempo_id,  
		(max(ta.tele_auto_combustible)- min(ta.TELE_AUTO_COMBUSTIBLE)), 
		max(ta.[TELE_AUTO_VELOCIDAD]),
		(max(TM.tele_motor_potencia) - min(TM.tele_motor_potencia)), 
		(max(TC.tele_caja_desgaste) - min(TC.tele_caja_desgaste)),
		(MAX(tn.TELE_NEUMATICO_PROFUNDIDAD) - MIN(tn.TELE_NEUMATICO_PROFUNDIDAD)),
		MAX(tf.TELE_FRENO_GROSOR_PASTILLA) - MIN(tf.TELE_FRENO_GROSOR_PASTILLA),
		max(ta.[TELE_AUTO_TIEMPO_VUELTA])
from test.lusax2.neumatico	n	join test.[LUSAX2].[Telemetria_Neumatico] tn on n.NEUMATICO_NRO_SERIE = tn.NEUMATICO_NRO_SERIE
								join test.LUSAX2.Automovil as a on a.AUTO_ID = n.AUTO_ID
                                JOIN test.LUSAX2.TELEMETRIA_AUTO AS TA   ON a.auto_id = ta.auto_id
								join test.lusax2.telemetria t on t.tele_auto_id = ta.tele_auto_id and tn.TELEMETRIA_ID = t.TELEMETRIA_ID
								join test.LUSAX2.Telemetria_CajaDeCambio tc on tc.TELE_CAJA_CAMBIO_ID = t.TELE_CAJA_CAMBIO_ID
								join test.lusax2.Telemetria_Motor as TM on T.TELE_MOTOR_ID = TM.TELE_MOTOR_ID
								join test.lusax2.sector as s on s.sector_codigo = t.sector_codigo
								join test.lusax2.carrera as c on c.[CARRERA_CODIGO] = t.[CARRERA_CODIGO]
								join test.LUSAX2.Telemetria_Freno as tf on t.TELEMETRIA_ID = tf.TELEMETRIA_ID
								join bi.LUSAX2.BI_Tiempo as bt on bt.tiempo_id = (select tiempo_id
																			from bi.lusax2.BI_Tiempo as bi1
																			where bi1.anio = year(c.carrera_fecha) and
																			bi1.cuatrimestre = CASE
																									WHEN MONTH(c.carrera_fecha) > 8	THEN 3
																									WHEN MONTH(c.carrera_fecha) > 4	THEN 2
																									ELSE 1
																								end)
group by n.NEUMATICO_NRO_SERIE, tf.FRENO_NRO_SERIE,NEUMATICO_TIPO, a.AUTO_ID, SECTOR_TIPO, s.CIRCUITO_CODIGO , a.ESCUDERIA_NOMBRE, PILOTO_ID,TELE_AUTO_NRO_VUELTA,tiempo_id


insert into bi.lusax2.bi_mediciones (neumatico_tipo, auto_id, sector_tipo, circuito_codigo, escuderia_nombre, tiempo_id, piloto_id, numero_vuelta, consumo_combustible_promedio, velocidad_Maxima, desgaste_motor, Desgaste_Caja, Desgaste_Neumatico, Desgaste_freno, tiempo_Vuelta)
select distinct neumatico_tipo, auto_id, sector_tipo, circuito_codigo, escuderia_nombre, tiempo_id,piloto_id , numero_vuelta,  max(consumo_Combustible_promedio), max(velocidad_Maxima), max(desgaste_motor), max(Desgaste_Caja), avg(Desgaste_Neumatico), avg(Desgaste_freno), min(tiempo_Vuelta)
from LUSAX2.tempNeumatico
group by neumatico_tipo, auto_id, sector_tipo, circuito_codigo, escuderia_nombre, tiempo_id, piloto_id, numero_vuelta
order by auto_id, sector_tipo, circuito_codigo, [ESCUDERIA_NOMBRE], tiempo_id, [PILOTO_ID], numero_vuelta

drop table LUSAX2.tempNeumatico

-- Insert en tabla de hechos paradas
insert into lusax2.BI_Parada (circuito_codigo, tiempo_id, escuderia_nombre, cantidad_Paradas, tiempo_promedio_boxes)
select ca.circuito_codigo, bt.tiempo_id, a.[ESCUDERIA_NOMBRE], count(distinct PARADA_CODIGO_BOX), sum(PARADA_BOX_TIEMPO)
from test.lusax2.circuito ci	join test.lusax2.carrera ca on ca.circuito_codigo = ci.circuito_codigo
								join test.lusax2.parada p on P.carrera_codigo = CA.carrera_codigo
								join test.lusax2.automovil a on P.auto_id = A.auto_id
								join bi.LUSAX2.BI_Tiempo as bt on bt.tiempo_id = (select tiempo_id
																									from bi.lusax2.BI_Tiempo as bi1
																									where bi1.anio = year(carrera_fecha) and
																									bi1.cuatrimestre = CASE
																															WHEN MONTH(carrera_fecha) > 8    THEN 3
																															WHEN MONTH(carrera_fecha) > 4    THEN 2
																															ELSE 1
																														end)
group by ca.circuito_codigo, a.[ESCUDERIA_NOMBRE],bt.tiempo_id

insert into lusax2.BI_Incidente(INCIDENTE_TIPO, circuito_codigo, piloto_id, tiempo_id, escuderia_nombre, auto_id,sector_tipo, cantidad_Incidentes, promedio_incidentes)
select i.INCIDENTE_TIPO, ci.Circuito_Codigo, a.PILOTO_ID, tiempo_id, a.ESCUDERIA_NOMBRE, a.AUTO_ID, s.sector_tipo , count(distinct i.INCIDENTE_ID), count(distinct i.INCIDENTE_ID)/cast((select count(distinct year(carrera_fecha)) from test.lusax2.carrera) as float)
from test.[LUSAX2].[Incidente] as i join test.[LUSAX2].[carrera] as ca on i.CARRERA_CODIGO = ca.CARRERA_CODIGO
									join test.LUSAX2.Circuito as ci on ci.CIRCUITO_CODIGO = ca.Circuito_Codigo
									join test.[LUSAX2].[AutoxIncidente] as ai on i.INCIDENTE_ID = ai.INCIDENTE_ID
									join test.LUSAX2.Automovil as a on ai.auto_id = a.AUTO_ID
									join test.lusax2.sector as s on s.circuito_codigo = ci.circuito_codigo
									join bi.LUSAX2.BI_Tiempo as bt on bt.tiempo_id = (select tiempo_id
																			from bi.lusax2.BI_Tiempo as bi1
																			where bi1.anio = year(carrera_fecha) and
																			bi1.cuatrimestre = CASE
																									WHEN MONTH(carrera_fecha) > 8	THEN 3
																									WHEN MONTH(carrera_fecha) > 4	THEN 2
																									ELSE 1
																								end)
group by i.INCIDENTE_TIPO, ci.Circuito_Codigo, a.PILOTO_ID, tiempo_id, a.ESCUDERIA_NOMBRE, a.AUTO_ID, s.sector_tipo
