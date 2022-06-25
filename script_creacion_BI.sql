use bi
go

CREATE SCHEMA [LUSAX2]
GO

create table lusax2.BI_tablaDeHechos (
	fact_id int identity(1,1),
	auto_id int,
	piloto_id int,
	circuito_codigo int, 
	tiempo_id int,
	escuderia_nombre nvarchar(255),
	neumatico_tipo nvarchar(255),
	sector_tipo nvarchar(255),
	incidente_id int,
	consumo_Combustible_promedio decimal(18,2),
	velocidad_Maxima decimal(18,2),
	tiempo_Promedio_Boxes decimal(18,2),
	cantidad_Paradas int,
	tiempo_Vuelta decimal(18,10),
	cantidad_incidentes int,
	CONSTRAINT PK_fact_id PRIMARY KEY (fact_id),
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

create table lusax2.BI_Componente (
	fact_componente_id int not null identity(1,1),
	AUTO_ID int,
	CIRCUITO_CODIGO int,
	Desgaste_Caja decimal(18,2),
	Desgaste_Neumatico decimal(18,6),
	Desgaste_freno decimal(18,2),
	desgaste_motor decimal(18,6),
	numero_vuelta decimal(18,0)
	constraint PK_fact_componente_id primary key (fact_componente_id)
)

alter table lusax2.BI_Componente
add constraint PKC_AUTO_ID
FOREIGN KEY (AUTO_ID) REFERENCES lusax2.BI_Automovil(AUTO_ID)

alter table lusax2.BI_Componente
add constraint PKC_CIRCUITO_CODIGO
FOREIGN KEY (CIRCUITO_CODIGO) REFERENCES lusax2.BI_Circuito(CIRCUITO_CODIGO)

alter table lusax2.BI_tablaDeHechos
ADD CONSTRAINT FK_auto_id
FOREIGN KEY (auto_id) REFERENCES lusax2.BI_Automovil(auto_id);

alter table lusax2.BI_tablaDeHechos
ADD CONSTRAINT FK_incidente_id
FOREIGN KEY (incidente_id) REFERENCES lusax2.BI_tipo_incidente(incidente_id);

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
									        WHEN MONTH(CARRERA_FECHA) > 8	THEN 3
										    WHEN MONTH(CARRERA_FECHA) > 4	THEN 2
										    ELSE 1 
									   end AS "Cuatrimestre"
from test.[LUSAX2].[Carrera]

insert into bi.lusax2.BI_tipo_incidente (INCIDENTE_ID, INCIDENTE_TIPO, INCIDENTE_BANDERA, INCIDENTE_TIEMPO)
select INCIDENTE_ID, INCIDENTE_TIPO, INCIDENTE_BANDERA, INCIDENTE_TIEMPO
from test.[LUSAX2].[Incidente]

insert into lusax2.BI_tablaDeHechos (auto_id, sector_tipo, circuito_codigo, escuderia_nombre, tiempo_id, piloto_id, neumatico_tipo, consumo_combustible_promedio,velocidad_Maxima,tiempo_Promedio_Boxes)
select a.auto_id, s.sector_tipo, s.circuito_codigo, a.[ESCUDERIA_NOMBRE], bt.tiempo_id, a.[PILOTO_ID], n.[NEUMATICO_TIPO],avg(tele_auto_combustible), max([TELE_AUTO_VELOCIDAD]),avg(PA.parada_box_tiempo)
from test.lusax2.automovil as a	join test.lusax2.telemetria_auto as ta on a.auto_id = ta.auto_id
							join test.lusax2.telemetria as t on t.tele_auto_id = ta.tele_auto_id 
							join test.lusax2.sector as s on s.sector_codigo = t.sector_codigo
							join test.lusax2.carrera as c on c.[CARRERA_CODIGO] = t.[CARRERA_CODIGO]
							join test.lusax2.neumatico as n on a.auto_id = n.auto_id
							join test.LUSAX2.Parada as PA on c.CARRERA_CODIGO = PA.CARRERA_CODIGO
							join bi.LUSAX2.BI_Tiempo as bt on bt.tiempo_id = (	select tiempo_id
																			from bi.lusax2.BI_Tiempo as bi1
																			where bi1.anio = year(c.carrera_fecha) and
																			bi1.cuatrimestre = CASE
																									WHEN MONTH(c.carrera_fecha) > 8	THEN 3
																									WHEN MONTH(c.carrera_fecha) > 4	THEN 2
																									ELSE 1
																								end)
where neumatico_tipo is not null
group by a.auto_id, s.sector_tipo, s.circuito_codigo, a.[ESCUDERIA_NOMBRE], bt.tiempo_id, a.[PILOTO_ID], n.[NEUMATICO_TIPO]

insert into lusax2.BI_Componente(auto_id,CIRCUITO_CODIGO,Desgaste_Caja,desgaste_neumatico , Desgaste_freno,desgaste_motor,numero_vuelta)
select au.Auto_id,CI.circuito_codigo,TC.tele_caja_desgaste,(max(tele_neumatico1_profundidad)-min(tele_neumatico1_profundidad)+(max(tele_neumatico2_profundidad)-min(tele_neumatico2_profundidad)+(max (tele_neumatico3_profundidad))-min(tele_neumatico3_profundidad)+max(tele_neumatico4_profundidad)-min(tele_neumatico4_profundidad)/4)),(max(tele_freno1_grosor_pastilla)-min(tele_freno1_grosor_pastilla)+max(tele_freno2_grosor_pastilla)-min(tele_freno2_grosor_pastilla)+max(tele_freno3_grosor_pastilla)-min(tele_freno3_grosor_pastilla)+max(tele_freno4_grosor_pastilla)-min(tele_freno4_grosor_pastilla)/4),(max(TM.tele_motor_potencia)-min(TM.tele_motor_potencia)),TA.TELE_AUTO_NRO_VUELTA
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
select a.auto_id, s.sector_tipo,s.CIRCUITO_CODIGO,e.ESCUDERIA_NOMBRE,a.piloto_id, ta.TELE_AUTO_NRO_VUELTA, CARRERA_FECHA,n.neumatico_tipo, max(TELE_AUTO_TIEMPO_VUELTA)
from test.LUSAX2.Escuderia as e		join test.LUSAX2.Automovil as a on e.ESCUDERIA_NOMBRE = a.ESCUDERIA_NOMBRE
									join test.LUSAX2.Telemetria_Auto as ta on ta.AUTO_ID = a.AUTO_ID
									join test.LUSAX2.Telemetria as t on t.TELE_AUTO_ID = ta.TELE_AUTO_ID
									join test.LUSAX2.Sector as s on s.SECTOR_CODIGO = t.SECTOR_CODIGO
									join test.LUSAX2.Carrera as c on c.Circuito_Codigo = s.CIRCUITO_CODIGO
									join test.LUSAX2.neumatico as n on a.auto_id = n.auto_id 
where ta.TELE_AUTO_TIEMPO_VUELTA != 0 and
neumatico_tipo is not null
group by e.ESCUDERIA_NOMBRE, s.CIRCUITO_CODIGO,a.piloto_id,s.sector_tipo, ta.TELE_AUTO_NRO_VUELTA, CARRERA_FECHA,a.auto_id,n.neumatico_tipo
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

insert into lusax2.BI_tablaDeHechos (escuderia_nombre, auto_id, circuito_codigo, piloto_id, sector_tipo, neumatico_tipo, tiempo_id, tiempo_Promedio_Boxes)
SELECT ES.ESCUDERIA_NOMBRE,	au.auto_id, ca.Circuito_Codigo, au.piloto_id, SECTOR_TIPO, NEUMATICO_TIPO, bt.tiempo_id, AVG(PARADA_BOX_TIEMPO)
FROM test.LUSAX2.PARADA AS PA	JOIN test.LUSAX2.AUTOMOVIL AS AU ON PA.AUTO_ID = AU.AUTO_ID
								JOIN test.LUSAX2.ESCUDERIA AS ES ON AU.ESCUDERIA_NOMBRE = ES.ESCUDERIA_NOMBRE
								JOIN test.LUSAX2.TELEMETRIA_AUTO AS TA   ON AU.AUTO_ID = TA.AUTO_ID
								JOIN test.LUSAX2.TELEMETRIA AS TE ON TA.TELE_AUTO_ID = TE.TELE_AUTO_ID
								JOIN test.LUSAX2.CARRERA AS CA ON TE.CARRERA_CODIGO = CA.CARRERA_CODIGO
								join test.LUSAX2.sector as s on s.CIRCUITO_CODIGO = ca.Circuito_Codigo
								join test.LUSAX2.Neumatico as n on n.AUTO_ID = au.AUTO_ID
								join bi.LUSAX2.BI_Tiempo as bt on bt.tiempo_id = (select tiempo_id
																			from bi.lusax2.BI_Tiempo as bi1
																			where bi1.anio = year(carrera_fecha) and
																			bi1.cuatrimestre = CASE
																									WHEN MONTH(carrera_fecha) > 8	THEN 3
																									WHEN MONTH(carrera_fecha) > 4	THEN 2
																									ELSE 1
																								end)
where NEUMATICO_TIPO is not null
GROUP BY ES.ESCUDERIA_NOMBRE, au.auto_id, ca.Circuito_Codigo,piloto_id, SECTOR_TIPO, bt.tiempo_id, NEUMATICO_TIPO

/*
select ci.Circuito_Codigo, yeaR(CARRERA_FECHA), count(distinct i.INCIDENTE_ID)
from test.[LUSAX2].[Incidente] as i join test.[LUSAX2].[carrera] as ca on i.CARRERA_CODIGO = ca.CARRERA_CODIGO
									join test.LUSAX2.Circuito as ci on ci.CIRCUITO_CODIGO = ca.Circuito_Codigo
									join test.[LUSAX2].[AutoxIncidente] as ai on i.INCIDENTE_ID = ai.INCIDENTE_ID
									join test.LUSAX2.Automovil as a on ai.auto_id = a.AUTO_ID
group by ci.Circuito_Codigo, yeaR(CARRERA_FECHA)
order by 2, 3 desc
*/






