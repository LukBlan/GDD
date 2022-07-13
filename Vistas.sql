--Top 3 de circuitos donde hay mayor cantidad de tiempo en boxes
create view lusax2.Circuitos_Mayor_tiempo_boxes as
select top 3 circuito_codigo, sum(tiempo_Promedio_Boxes)
from bi.LUSAX2.BI_parada
group by circuito_codigo
order by 2 desc
go

--Desgaste De cada componente [x Auto x Vuelta x Circuito]
create view lusax2.desgaste_componentes as
select	auto_id, 
		circuito_codigo,
		numero_vuelta,
		avg(desgaste_caja) as 'DesgasteCaja', 
		avg(desgaste_neumatico) as 'DesgasteNeumaticos', 
		avg(desgaste_freno) as 'DesgasteFreno', 
		avg(desgaste_motor) as 'DesgasteMotor'
from LUSAX2.BI_Mediciones
group by auto_id, circuito_codigo, numero_vuelta
go

--Max Velocidad en cada sector por un auto 
CREATE view lusax2.Max_Velocidad_Auto_Sector as
select auto_id, sector_tipo, circuito_codigo, max(velocidad_Maxima) as 'VelocidadMaxima'
from lusax2.BI_Mediciones
group by auto_id, sector_tipo, circuito_codigo
go

--Mayor consumo de combustible
CREATE view lusax2.circuito_mas_gasto_combustibles as
select circuito_codigo, avg(consumo_Combustible_promedio) * max(numero_vuelta) as 'ConsumoCombustiblePromedio'
from LUSAX2.BI_Mediciones
group by circuito_codigo
order by 2 desc
go

--Tiempo promedio de parada en cada cuatrimestre
CREATE view lusax2.Tiempo_Promedio_Parada_Cuatrimestre as
SELECT ESCUDERIA_NOMBRE, bt.cuatrimestre, AVG(tiempo_Promedio_Boxes) as promedioParada
FROM bi.LUSAX2.bi_parada as tdh	join bi.LUSAX2.BI_Tiempo as bt on tdh.tiempo_id = bt.tiempo_id
group by ESCUDERIA_NOMBRE, bt.cuatrimestre
go

--Vuelta Mas Rapida [x Escuderia x Circuito x Anio]
CREATE view lusax2.VueltaMasRapida as
select [ESCUDERIA_NOMBRE], circuito_codigo, dt.anio,  min(tiempo_Vuelta) as tiempoVueltaMasRapida
from LUSAX2.BI_Mediciones as tdh	join [LUSAX2].[BI_Tiempo] as dt on tdh.tiempo_id = dt.tiempo_id
where tiempo_Vuelta != 0
group by [ESCUDERIA_NOMBRE], circuito_codigo, dt.anio
go

-- Cantidad de Paradas [x Circuito x Escuderia x Anio]
CREATE view lusax2.CantidadDeParadas as
select escuderia_nombre,circuito_codigo, bt.anio, sum(cantidad_Paradas) as cantidadDeParadas
from bi.LUSAX2.bi_parada as tdh		join bi.LUSAX2.BI_Tiempo as bt on tdh.tiempo_id = bt.tiempo_id
group by circuito_codigo, escuderia_nombre, bt.anio
go

-- Promedio de Incidetes [x Escuderia x Sector_Tipo] (Pendiente)
CREATE view lusax2.promedioIncidentes as
select escuderia_nombre ,sector_tipo, sum([promedio_incidentes]) as promedioIncidentesPorAnio
from bi.LUSAX2.BI_Incidente as tdh	join bi.LUSAX2.BI_Tiempo as bt on tdh.tiempo_id = bt.tiempo_id
group by escuderia_nombre,sector_tipo
go

--Circuitos mas peligrosos
alter view lusax2.top3CircuitoMasPeligrosos as with circuitoPeligrosos as
(select bi.circuito_codigo,
		bt.anio,
		sum(bi.cantidad_incidentes) as 'CantidadIncidentes',
		row_number() over (partition by bt.anio order by bt.anio) as cantidadDeFilas
from bi.lusax2.bi_incidente as bi	join bi.lusax2.bi_tiempo as bt on bt.tiempo_id = bi.tiempo_Id
group by bi.circuito_codigo, bt.anio)
select circuito_codigo, cantidadIncidentes, anio
from circuitoPeligrosos
where cantidadDeFilas < 4
go

/*
create procedure top3CircuitosPeligrosos
as
begin
	declare @anio int
	declare topCircuitos cursor for select anio from bi.LUSAX2.BI_Tiempo
	open topCircuitos
	fetch next FROM topCircuitos
	into @anio
	while @@FETCH_STATUS = 0
	begin
	select bi.circuito_codigo,bt.anio, SUM(bi.cantidad_incidentes) 
	from BI.lusax2.bi_incidente as bi  join bi.LUSAX2.BI_Tiempo as bt on bt.tiempo_id = bi.tiempo_id 
	where bt.anio = 2020 
	group by bi.circuito_codigo,bi.cantidad_incidentes,bt.anio 
	order by sum(bi.cantidad_incidentes)
	fetch next FROM topCircuitos 
	into @anio
	end
	CLOSE topCircuitos
DEALLOCATE  topCircuitos
end
*/
