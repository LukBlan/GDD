use bi
go

CREATE SCHEMA [LUSAX2]
GO

create table lusax2.BI_Carrera (
	fact_Carrera_Vuelta_id int identity(1,1),
	circuito_codigo int,
	piloto_id int,
	tiempo_id int,
	escuderia_nombre nvarchar(255),
	sector_tipo nvarchar(255),
	auto_id int,
	Desgaste_Caja decimal(18,2),
	Desgaste_Neumatico decimal(18,6),
	Desgaste_freno decimal(18,2),
	desgaste_motor decimal(18,6),
	numero_vuelta decimal(18,0),
	consumo_Combustible_promedio decimal(18,2),
	velocidad_Maxima decimal(18,2),
	tiempo_Vuelta decimal(18,10),
	CONSTRAINT PK_fact_Carrera_Vuelta_id PRIMARY KEY (fact_Carrera_Vuelta_id)
); 

create table lusax2.BI_Incidente (
	fact_incidente_id int identity(1,1),
	incidente_id int,
	circuito_codigo int,
	piloto_id int,
	tiempo_id int,
	escuderia_nombre nvarchar(255),
	auto_id int,
	cantidad_Incidentes int,
	CONSTRAINT PK_fact_incidente_id PRIMARY KEY (fact_incidente_id),
); 

create table lusax2.BI_Parada (
	fact_Parada_id int identity(1,1),
	circuito_codigo int,
	piloto_id int,
	tiempo_id int,
	escuderia_nombre nvarchar(255),
	neumatico_tipo nvarchar(255),
	auto_id int,
	tiempo_Promedio_Boxes decimal(18,2),
	cantidad_Paradas int,
	CONSTRAINT PK_fact_Parada_id PRIMARY KEY (fact_Parada_id),
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

create table lusax2.BI_tipo_incidente (
	INCIDENTE_ID  int  NOT NULL,
	INCIDENTE_TIPO nvarchar(255),
    INCIDENTE_BANDERA nvarchar(255),
    INCIDENTE_TIEMPO decimal(18,2),
	CONSTRAINT PK_INCIDENTE_ID PRIMARY KEY (INCIDENTE_ID),
)

alter table lusax2.BI_Parada
ADD CONSTRAINT FKP_auto_id
FOREIGN KEY (auto_id) REFERENCES lusax2.BI_Automovil(auto_id);

alter table lusax2.BI_Parada
ADD CONSTRAINT FKP_piloto_id
FOREIGN KEY (piloto_id) REFERENCES lusax2.BI_Piloto(piloto_id);

alter table lusax2.BI_Parada
ADD CONSTRAINT FKP_circuito_codigo
FOREIGN KEY (circuito_codigo) REFERENCES lusax2.BI_Circuito(circuito_codigo);

alter table lusax2.BI_Parada
ADD CONSTRAINT FK_neumatico_tipo
FOREIGN KEY (neumatico_tipo) REFERENCES lusax2.BI_tipoNeumatico(neumatico_tipo);

alter table lusax2.BI_Parada
ADD CONSTRAINT FKP_tiempo_id
FOREIGN KEY (tiempo_id) REFERENCES lusax2.BI_Tiempo(tiempo_id);

alter table lusax2.BI_Parada
ADD CONSTRAINT FKP_ESCUDERIA_NOMBRE
FOREIGN KEY (ESCUDERIA_NOMBRE) REFERENCES lusax2.BI_Escuderia(ESCUDERIA_NOMBRE);

alter table lusax2.BI_Carrera
ADD CONSTRAINT FKC_auto_id
FOREIGN KEY (auto_id) REFERENCES lusax2.BI_Automovil(auto_id);

alter table lusax2.BI_Carrera
ADD CONSTRAINT FKC_piloto_id
FOREIGN KEY (piloto_id) REFERENCES lusax2.BI_Piloto(piloto_id);

alter table lusax2.BI_Carrera
ADD CONSTRAINT FKC_circuito_codigo
FOREIGN KEY (circuito_codigo) REFERENCES lusax2.BI_Circuito(circuito_codigo);

alter table lusax2.BI_Carrera
ADD CONSTRAINT FKC_tiempo_id
FOREIGN KEY (tiempo_id) REFERENCES lusax2.BI_Tiempo(tiempo_id);

alter table lusax2.BI_Carrera
ADD CONSTRAINT FKC_ESCUDERIA_NOMBRE
FOREIGN KEY (ESCUDERIA_NOMBRE) REFERENCES lusax2.BI_Escuderia(ESCUDERIA_NOMBRE);

alter table lusax2.BI_Carrera
ADD CONSTRAINT FK_sector_tipo
FOREIGN KEY (sector_tipo) REFERENCES lusax2.BI_tipoSector(sector_tipo);

alter table lusax2.BI_Incidente
ADD CONSTRAINT FKI_auto_id
FOREIGN KEY (auto_id) REFERENCES lusax2.BI_Automovil(auto_id);

alter table lusax2.BI_Incidente
ADD CONSTRAINT FK_incidente_id
FOREIGN KEY (incidente_id) REFERENCES lusax2.BI_tipo_incidente(incidente_id);

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

insert into bi.lusax2.BI_tipo_incidente (INCIDENTE_ID, INCIDENTE_TIPO, INCIDENTE_BANDERA, INCIDENTE_TIEMPO)
select INCIDENTE_ID, INCIDENTE_TIPO, INCIDENTE_BANDERA, INCIDENTE_TIEMPO
from test.[LUSAX2].[Incidente]

insert into lusax2.BI_Carrera (auto_id, sector_tipo, circuito_codigo, escuderia_nombre, tiempo_id, piloto_id,numero_vuelta, consumo_combustible_promedio, velocidad_Maxima)
select a.auto_id, s.sector_tipo, s.circuito_codigo, a.[ESCUDERIA_NOMBRE], bt.tiempo_id, a.[PILOTO_ID],ta.[TELE_AUTO_NRO_VUELTA],avg(tele_auto_combustible), max([TELE_AUTO_VELOCIDAD])
from test.lusax2.automovil as a	join test.lusax2.telemetria_auto as ta on a.auto_id = ta.auto_id
							join test.lusax2.telemetria as t on t.tele_auto_id = ta.tele_auto_id 
							join test.lusax2.sector as s on s.sector_codigo = t.sector_codigo
							join test.lusax2.carrera as c on c.[CARRERA_CODIGO] = t.[CARRERA_CODIGO]
							join test.LUSAX2.Parada as PA on c.CARRERA_CODIGO = PA.CARRERA_CODIGO
							join bi.LUSAX2.BI_Tiempo as bt on bt.tiempo_id = (	select tiempo_id
																				from bi.lusax2.BI_Tiempo as bi1
																				where bi1.anio = year(c.carrera_fecha) and
																				bi1.cuatrimestre = CASE
																									WHEN MONTH(c.carrera_fecha) > 8	THEN 3
																									WHEN MONTH(c.carrera_fecha) > 4	THEN 2
																									ELSE 1
																									end)
group by a.auto_id, s.sector_tipo, s.circuito_codigo, a.[ESCUDERIA_NOMBRE], bt.tiempo_id, a.[PILOTO_ID],ta.[TELE_AUTO_NRO_VUELTA]

/*
insert into lusax2.BI_Carrera(circuito_codigo,piloto_id,auto_id,Desgaste_Caja,desgaste_neumatico , Desgaste_freno,desgaste_motor,numero_vuelta)
select CI.circuito_codigo,au.Auto_id,TC.tele_caja_desgaste,(max(tele_neumatico1_profundidad)-min(tele_neumatico1_profundidad)+(max(tele_neumatico2_profundidad)-min(tele_neumatico2_profundidad)+(max (tele_neumatico3_profundidad))-min(tele_neumatico3_profundidad)+max(tele_neumatico4_profundidad)-min(tele_neumatico4_profundidad)/4)),(max(tele_freno1_grosor_pastilla)-min(tele_freno1_grosor_pastilla)+max(tele_freno2_grosor_pastilla)-min(tele_freno2_grosor_pastilla)+max(tele_freno3_grosor_pastilla)-min(tele_freno3_grosor_pastilla)+max(tele_freno4_grosor_pastilla)-min(tele_freno4_grosor_pastilla)/4),(max(TM.tele_motor_potencia)-min(TM.tele_motor_potencia)),TA.TELE_AUTO_NRO_VUELTA
from test.lusax2.Telemetria as TE join test.lusax2.Telemetria_Motor as TM on TE.TELE_MOTOR_ID = TM.TELE_MOTOR_ID
join test.lusax2.Telemetria_CajaDeCambio as TC on TE.TELE_CAJA_CAMBIO_ID = TC.TELE_CAJA_CAMBIO_ID
join test.lusax2.Carrera as CA on CA.CARRERA_CODIGO = TE.CARRERA_CODIGO
join test.lusax2.Circuito as CI on CA.Circuito_Codigo = CI.CIRCUITO_CODIGO
join test.lusax2.Telemetria_Auto as TA on TA.TELE_AUTO_ID = TE.TELE_AUTO_ID
join test.lusax2.Automovil as AU on AU.AUTO_ID = TA.AUTO_ID
join GD1C2022.gd_esquema.Maestra as EM on em.TELE_AUTO_CODIGO = TE.TELE_AUTO_ID and
em.CIRCUITO_CODIGO = CI.CIRCUITO_CODIGO and
EM.TELE_AUTO_NUMERO_VUELTA = TA.TELE_AUTO_NRO_VUELTA and
em.CODIGO_CARRERA = CA.CARRERA_CODIGO
group by AU.AUTO_ID,CI.Circuito_Codigo,TELE_AUTO_NRO_VUELTA,TC.TELE_CAJA_DESGASTE,em.TELE_NEUMATICO1_PROFUNDIDAD,em.TELE_NEUMATICO2_PROFUNDIDAD,em.TELE_NEUMATICO3_PROFUNDIDAD,em.TELE_NEUMATICO4_PROFUNDIDAD,em.TELE_FRENO1_GROSOR_PASTILLA,em.TELE_FRENO2_GROSOR_PASTILLA,em.TELE_FRENO3_GROSOR_PASTILLA,em.TELE_FRENO4_GROSOR_PASTILLA
*/
/*
create table #temp (
	ESCUDERIA_NOMBRE nvarchar (255),
	auto_id int,
	CIRCUITO_CODIGO int,
	piloto_id int,
	sector_tipo nvarchar(255),
	TELE_AUTO_NRO_VUELTA int,
	CARRERA_FECHA date,
	neumatico_tipo nvarchar(255),
	TELE_AUTO_TIEMPO_VUELTA decimal(18,10),
)

insert into #temp (auto_id, sector_tipo, CIRCUITO_CODIGO, ESCUDERIA_NOMBRE, piloto_id,  TELE_AUTO_NRO_VUELTA, CARRERA_FECHA,neumatico_tipo, TELE_AUTO_TIEMPO_VUELTA)
select a.auto_id, s.sector_tipo,s.CIRCUITO_CODIGO,a.ESCUDERIA_NOMBRE,a.piloto_id, ta.TELE_AUTO_NRO_VUELTA, CARRERA_FECHA,n.neumatico_tipo, max(TELE_AUTO_TIEMPO_VUELTA)
from test.LUSAX2.Automovil as a		join test.LUSAX2.Telemetria_Auto as ta on ta.AUTO_ID = a.AUTO_ID
									join test.LUSAX2.Telemetria as t on t.TELE_AUTO_ID = ta.TELE_AUTO_ID
									join test.LUSAX2.Sector as s on s.SECTOR_CODIGO = t.SECTOR_CODIGO
									join test.LUSAX2.Carrera as c on c.Circuito_Codigo = s.CIRCUITO_CODIGO
									join test.LUSAX2.neumatico as n on a.auto_id = n.auto_id 
where ta.TELE_AUTO_TIEMPO_VUELTA != 0 and
neumatico_tipo is not null
group by a.ESCUDERIA_NOMBRE, s.CIRCUITO_CODIGO,a.piloto_id,s.sector_tipo, ta.TELE_AUTO_NRO_VUELTA, CARRERA_FECHA,a.auto_id,n.neumatico_tipo
order by 1,2,3


insert into lusax2.BI_tablaDeHechos (escuderia_nombre, auto_id,circuito_codigo,piloto_id, sector_tipo, tiempo_id,  neumatico_tipo, tiempo_Vuelta)
select ESCUDERIA_NOMBRE, auto_id, CIRCUITO_CODIGO, piloto_id, sector_tipo, tiempo_id,neumatico_tipo , min(TELE_AUTO_TIEMPO_VUELTA)
from bi.#temp join bi.LUSAX2.BI_Tiempo as bt on bt.tiempo_id = (select tiempo_id
																			from bi.lusax2.BI_Tiempo as bi1
																			where bi1.anio = year(carrera_fecha) and
																			bi1.cuatrimestre = CASE
																									WHEN MONTH(carrera_fecha) > 8	THEN 3
																									WHEN MONTH(carrera_fecha) > 4	THEN 2
																									ELSE 1
																								end)
group by ESCUDERIA_NOMBRE, auto_id, CIRCUITO_CODIGO, piloto_id, sector_tipo, tiempo_id, neumatico_tipo
drop table #temp
*/

insert into lusax2.BI_Parada (circuito_codigo, piloto_id, tiempo_id, escuderia_nombre, neumatico_tipo, tiempo_promedio_boxes, cantidad_Paradas)
select ca.Circuito_Codigo, a.piloto_id,bt.tiempo_id,e.escuderia_nombre, NEUMATICO_TIPO, count(distinct PARADA_CODIGO_BOX), AVG(PARADA_BOX_TIEMPO)
from test.lusax2.Parada as p	join test.LUSAX2.Automovil as a on a.AUTO_ID = p.AUTO_ID
								JOIN test.LUSAX2.TELEMETRIA_AUTO AS TA   ON A.AUTO_ID = TA.AUTO_ID
								JOIN test.LUSAX2.TELEMETRIA AS TE ON TA.TELE_AUTO_ID = TE.TELE_AUTO_ID
								join test.LUSAX2.Escuderia as e on A.ESCUDERIA_NOMBRE= e.ESCUDERIA_NOMBRE
								JOIN test.LUSAX2.CARRERA AS CA ON TE.CARRERA_CODIGO = CA.CARRERA_CODIGO
								join test.lusax2.Neumatico as n on n.AUTO_ID = a.AUTO_ID
								join bi.LUSAX2.BI_Tiempo as bt on bt.tiempo_id = (select tiempo_id
																			from bi.lusax2.BI_Tiempo as bi1
																			where bi1.anio = year(carrera_fecha) and
																			bi1.cuatrimestre = CASE
																									WHEN MONTH(carrera_fecha) > 8	THEN 3
																									WHEN MONTH(carrera_fecha) > 4	THEN 2
																									ELSE 1
																								end)
where NEUMATICO_TIPO is not null
group by A.ESCUDERIA_NOMBRE,	a.auto_id, ca.Circuito_Codigo, a.piloto_id,e.ESCUDERIA_NOMBRE, NEUMATICO_TIPO, bt.tiempo_id

-- Falta dividir
/*
insert into lusax2.BI_tablaDeHechos (escuderia_nombre, auto_id, circuito_codigo, piloto_id, sector_tipo, tiempo_id, promedio_incidentes)
select A.ESCUDERIA_NOMBRE,	a.auto_id, c.Circuito_Codigo, a.piloto_id, s.SECTOR_TIPO, bt.tiempo_id, count(distinct i.INCIDENTE_ID)/cast((select count(distinct year(carrera_fecha))
																																			from test.lusax2.carrera) as float)
from test.LUSAX2.AutoxIncidente as ai	join test.LUSAX2.Automovil as a on a.AUTO_ID = ai.AUTO_ID
										join test.LUSAX2.Incidente as i on ai.INCIDENTE_ID	= i.INCIDENTE_ID
										join test.LUSAX2.Carrera as c on c.CARRERA_CODIGO = i.CARRERA_CODIGO
										join test.lusax2.sector as s on s.CIRCUITO_CODIGO = c.Circuito_Codigo
										join bi.LUSAX2.BI_Tiempo as bt on bt.tiempo_id = (select tiempo_id
																			from bi.lusax2.BI_Tiempo as bi1
																			where bi1.anio = year(carrera_fecha) and
																			bi1.cuatrimestre = CASE
																									WHEN MONTH(carrera_fecha) > 8	THEN 3
																									WHEN MONTH(carrera_fecha) > 4	THEN 2
																									ELSE 1
																								end)
group by A.ESCUDERIA_NOMBRE, a.auto_id, c.Circuito_Codigo, a.piloto_id, s.SECTOR_TIPO, bt.tiempo_id

insert into lusax2.BI_tablaDeHechos (auto_id, piloto_id, escuderia_nombre, circuito_codigo, sector_tipo, tiempo_id, cantidad_Incidentes)
select a.auto_id, a.PILOTO_ID, a.ESCUDERIA_NOMBRE, ci.Circuito_Codigo, s.SECTOR_TIPO, tiempo_id , count(distinct i.INCIDENTE_ID)
from test.[LUSAX2].[Incidente] as i join test.[LUSAX2].[carrera] as ca on i.CARRERA_CODIGO = ca.CARRERA_CODIGO
									join test.LUSAX2.Circuito as ci on ci.CIRCUITO_CODIGO = ca.Circuito_Codigo
									join test.[LUSAX2].[AutoxIncidente] as ai on i.INCIDENTE_ID = ai.INCIDENTE_ID
									join test.LUSAX2.Automovil as a on ai.auto_id = a.AUTO_ID
									join test.lusax2.Neumatico as n on n.AUTO_ID = a.AUTO_ID
									join test.LUSAX2.sector as s on s.CIRCUITO_CODIGO = ci.CIRCUITO_CODIGO
									join bi.LUSAX2.BI_Tiempo as bt on bt.tiempo_id = (select tiempo_id
																			from bi.lusax2.BI_Tiempo as bi1
																			where bi1.anio = year(carrera_fecha) and
																			bi1.cuatrimestre = CASE
																									WHEN MONTH(carrera_fecha) > 8	THEN 3
																									WHEN MONTH(carrera_fecha) > 4	THEN 2
																									ELSE 1
																								end)
group by a.auto_id, a.PILOTO_ID, a.ESCUDERIA_NOMBRE, ci.Circuito_Codigo, s.SECTOR_TIPO, bt.tiempo_id 
*/
