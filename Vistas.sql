--Top 3 de circuitos donde hay mayor cantidad de tiempo en boxes
create view lusax2.Circuitos_Mayor_tiempo_boxes as
select top 3 circuito_codigo,tiempo_Promedio_Boxes
from LUSAX2.BI_tablaDeHechos
group by circuito_codigo,tiempo_Promedio_Boxes
order by tiempo_Promedio_Boxes desc
go

--Desgaste De cada componente por vuelta
create view lusax2.desgaste_componentes as
select auto_id,desgaste_caja,desgaste_neumatico,desgaste_freno,desgaste_motor,numero_vuelta,circuito_codigo
from LUSAX2.BI_Componente
group by auto_id,desgaste_caja,desgaste_neumatico,desgaste_freno,desgaste_motor,numero_vuelta,circuito_codigo
go

--Max Velocidad en cada sector por un auto
CREATE view lusax2.Max_Velocidad_Auto_Sector as
select auto_id, sector_tipo, circuito_codigo, velocidad_Maxima
from lusax2.BI_tablaDeHechos
where velocidad_Maxima is not null
group by auto_id, sector_tipo, circuito_codigo, velocidad_Maxima
go

--Mayor consumo de combustible
CREATE view lusax2.circuito_mas_gasto_combustibles as
select top 3 circuito_codigo,consumo_Combustible_promedio
from LUSAX2.BI_tablaDeHechos
group by circuito_codigo,consumo_Combustible_promedio
order by consumo_Combustible_promedio desc
go

--Tiempo promedio de parada en cada cuatrimestre
CREATE view lusax2.Tiempo_Promedio_Parada_Cuatrimestre as
SELECT ESCUDERIA_NOMBRE, bt.cuatrimestre, AVG(tiempo_Promedio_Boxes) as promedioParada
FROM bi.LUSAX2.BI_tablaDeHechos as tdh	join bi.LUSAX2.BI_Tiempo as bt on tdh.tiempo_id = bt.tiempo_id
where tiempo_Promedio_Boxes is not null
group by ESCUDERIA_NOMBRE, bt.cuatrimestre
go

--Max Velocidad en cada sector por un auto
CREATE view lusax2.VueltaMasRapida as
select [ESCUDERIA_NOMBRE], circuito_codigo, dt.anio,  min(tiempo_Vuelta) as tiempoVueltaMasRapida
from lusax2.BI_tablaDeHechos as tdh	join [LUSAX2].[BI_Tiempo] as dt on tdh.tiempo_id = dt.tiempo_id
where tiempo_Vuelta is not null
group by [ESCUDERIA_NOMBRE], circuito_codigo, dt.anio
go

-- Cantidad de Paradas x Circuito x Escuderia x Anio
CREATE view lusax2.CantidadDeParadas as
select escuderia_nombre,circuito_codigo, bt.anio, sum(distinct cantidad_Paradas) as cantidadDeParadas
from bi.LUSAX2.BI_tablaDeHechos as tdh	join bi.LUSAX2.BI_Tiempo as bt on tdh.tiempo_id = bt.tiempo_id
where cantidad_Paradas is not null
group by circuito_codigo, escuderia_nombre,bt.anio
go

CREATE view lusax2.promedioIncidentes as
select escuderia_nombre ,sector_tipo, sum([promedio_incidentes]) as promedioIncidentesPorAnio
from bi.LUSAX2.BI_tablaDeHechos as tdh join bi.LUSAX2.BI_Tiempo as bt on tdh.tiempo_id = bt.tiempo_id
where [promedio_incidentes] is not null
group by escuderia_nombre,sector_tipo
go

CREATE view Circuitos_mas_peligrosos as
select circuito_codigo, anio, sum(distinct cantidad_incidentes) as cantidadIncidentes
from bi.LUSAX2.BI_tablaDeHechos as tdh join bi.LUSAX2.BI_Tiempo as bt on tdh.tiempo_id = bt.tiempo_id 
where cantidad_Incidentes is not null
group by circuito_codigo, anio
go