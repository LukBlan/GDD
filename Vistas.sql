--Top 3 de circuitos donde hay mayor cantidad de tiempo en boxes
create view mayor_Tiempo_En_Parada as
select top 3 PA.PARADA_BOX_TIEMPO,CA.CIRCUITO_CODIGO,CA.CARRERA_CODIGO
from test.LUSAX2.PARADA as PA
left join test.LUSAX2.CARRERA as CA on CA.CARRERA_CODIGO = PA.CARRERA_CODIGO
order by 1 desc
--Desgaste De cada componente por vuelta
create view lusax2.desgaste_componentes as
select auto_id,desgaste_caja,desgaste_neumatico,desgaste_freno,desgaste_motor,numero_vuelta,circuito_codigo
from LUSAX2.BI_Componente
group by auto_id,desgaste_caja,desgaste_neumatico,desgaste_freno,desgaste_motor,numero_vuelta,circuito_codigo

--Tiempo promedio de parada en cada cuatrimestre
CREATE view Tiempo_Promedio_Parada_Cuatrimestre as
SELECT ES.ESCUDERIA_NOMBRE,AVG(PARADA_BOX_TIEMPO) as "Promedio",YEAR(CA.CARRERA_FECHA) as "ANIO", CASE  
	WHEN MONTH(CA.CARRERA_FECHA) = 1 or MONTH(CA.CARRERA_FECHA) = 2 or MONTH(CA.CARRERA_FECHA) = 3 or MONTH(CA.CARRERA_FECHA)=4 THEN 1
	WHEN MONTH(CA.CARRERA_FECHA) = 5 or MONTH(CA.CARRERA_FECHA)= 6 or MONTH(CA.CARRERA_FECHA)=7 or MONTH(CA.CARRERA_FECHA)=8 THEN 2
	WHEN MONTH(CA.CARRERA_FECHA) = 9 or MONTH(CA.CARRERA_FECHA)= 10 or MONTH(CA.CARRERA_FECHA) =11 or MONTH(CA.CARRERA_FECHA)=12 THEN 3
	end AS "Cuatrimestre"
	 FROM LUSAX2.PARADA AS PA
LEFT JOIN LUSAX2.AUTOMOVIL AS AU ON PA.AUTO_ID = AU.AUTO_ID
LEFT JOIN LUSAX2.ESCUDERIA AS ES ON AU.ESCUDERIA_NOMBRE = ES.ESCUDERIA_NOMBRE
LEFT JOIN LUSAX2.TELEMETRIA_AUTO AS TA   ON AU.AUTO_ID = TA.AUTO_ID
LEFT JOIN LUSAX2.TELEMETRIA AS TE ON TA.TELE_AUTO_ID = TE.TELE_AUTO_ID
LEFT JOIN LUSAX2.CARRERA AS CA ON TE.CARRERA_CODIGO = CA.CARRERA_CODIGO
GROUP BY ES.ESCUDERIA_NOMBRE,YEAR(CA.CARRERA_FECHA), CASE  
	WHEN MONTH(CA.CARRERA_FECHA) = 1 or MONTH(CARRERA_FECHA) = 2 or MONTH(CARRERA_FECHA) = 3 or MONTH(CARRERA_FECHA)=4 THEN 1
	WHEN MONTH(CA.CARRERA_FECHA) = 5 or MONTH(CARRERA_FECHA)= 6 or MONTH(CARRERA_FECHA)=7 or MONTH(CARRERA_FECHA)=8 THEN 2
	WHEN MONTH(CA.CARRERA_FECHA) = 9 or MONTH(CARRERA_FECHA)= 10 or MONTH(CARRERA_FECHA) =11 or MONTH(CARRERA_FECHA)=12 THEN 3
	end,YEAR(CA.CARRERA_FECHA)

--Max Velocidad en cada sector por un auto
CREATE view lusax2.Max_Velocidad_Auto_Sector as
select auto_id, sector_tipo, circuito_codigo, velocidad_Maxima
from lusax2.BI_tablaDeHechos
group by auto_id, sector_tipo, circuito_codigo, velocidad_Maxima

--Circuitos mas peligrosos
CREATE view Circuitos_mas_peligrosos as
select top 3 CI.CIRCUITO_NOMBRE , CI.CIRCUITO_CODIGO , COUNT(INCIDENTE_ID) as "Id de incidente"
FROM LUSAX2.CIRCUITO AS CI
LEFT JOIN lusax2.CARRERA AS CA ON CA.CIRCUITO_CODIGO = CI.CIRCUITO_CODIGO
LEFT JOIN LUSAX2.INCIDENTE AS IC ON CA.CARRERA_CODIGO = IC.CARRERA_CODIGO
WHERE YEAR(CA.CARRERA_FECHA) = 2022  -- al no especificar el año el tp pusimos que tomara el año actual, no da ninguna respuesta ya que no hay carreras en el 2022, si lo cambiamos por 2020 si da rtas
GROUP BY CI.CIRCUITO_NOMBRE , CI.CIRCUITO_CODIGO


-- Mejor Tiempo de Vuelta de Cada Escuderia por Circuito
/* -- es max max(TELE_AUTO_TIEMPO_VUELTA) por que devuelve el ultimo valor registrado para esa vuelta (que seria el final de la vuelta)
select e.ESCUDERIA_NOMBRE,a.auto_id, s.CIRCUITO_CODIGO, ta.TELE_AUTO_NRO_VUELTA, year(CARRERA_FECHA), max(TELE_AUTO_TIEMPO_VUELTA)
from test.LUSAX2.Escuderia as e		join test.LUSAX2.Automovil as a on e.ESCUDERIA_NOMBRE = a.ESCUDERIA_NOMBRE
									join test.LUSAX2.Telemetria_Auto as ta on ta.AUTO_ID = a.AUTO_ID
									join test.LUSAX2.Telemetria as t on t.TELE_AUTO_ID = ta.TELE_AUTO_ID
									join test.LUSAX2.Sector as s on s.SECTOR_CODIGO = t.SECTOR_CODIGO
									join test.LUSAX2.Carrera as c on c.Circuito_Codigo = s.CIRCUITO_CODIGO
where ta.TELE_AUTO_TIEMPO_VUELTA != 0
group by e.ESCUDERIA_NOMBRE, s.CIRCUITO_CODIGO,ta.TELE_AUTO_NRO_VUELTA, year(CARRERA_FECHA),a.auto_id
order by 1,2,3
*/
