--Top 3 de circuitos donde hay mayor cantidad de tiempo en boxes
create view mayor_Tiempo_En_Parada as
select top 3 PA.PARADA_BOX_TIEMPO,CA.CIRCUITO_CODIGO,CA_CARRERA_CODIGO
from test.LUSAX2.PARADA as PA
left join test.LUSAX2.CIRCUITO as CA on CA.CARRERA_CODIGO = PA.CARRERA_CODIGO
order by 1 desc

--Tiempo promedio de parada en cada cuatrimestre
CREATE view Tiempo_Promedio_Parada_Cuatrimestre as
SELECT ES.ESCUDERIA_NOMBRE,AVG(PARADA_BOX_TIEMPO) as "Promedio",YEAR(CR.CARRERA_FECHA) as "ANIO", CASE  
	WHEN MONTH(CR.CARRERA_FECHA) = 1 or MONTH(CARRERA_FECHA) = 2 or MONTH(CARRERA_FECHA) = 3 or MONTH(CARRERA_FECHA)=4 THEN 1
	WHEN MONTH(CR.CARRERA_FECHA) = 5 or MONTH(CARRERA_FECHA)= 6 or MONTH(CARRERA_FECHA)=7 or MONTH(CARRERA_FECHA)=8 THEN 2
	WHEN MONTH(CR.CARRERA_FECHA) = 9 or MONTH(CARRERA_FECHA)= 10 or MONTH(CARRERA_FECHA) =11 or MONTH(CARRERA_FECHA)=12 THEN 3
	end AS "Cuatrimestre",
	 FROM LUSAX2.PARADA AS PA
LEFT JOIN LUSAX2.AUTOMOVIL AS AU ON PA.AUTO_ID = AU.AUTO_ID
LEFT JOIN LUSAX2.ESCUDERIA AS ES ON AU.ESCUDERIA_NOMBRE = ES.ESCUDERIA_NOMBRE
LEFT JOIN LUSAX2.TELEMETRIA_AUTO AS TA   ON AU.AUTO_ID = TA.AUTO_ID
LEFT JOIN LUSAX2.TELEMETRIA AS TE ON TA.TELE_AUTO_ID = TE.TELE_AUTO_ID
LEFT JOIN LUSAX2.CARRERA AS CA ON TE.CARRERA_CODIGO = CA.CARRERA_CODIGO
GROUP BY E.ESCUDERIA_NOMBRE,3,YEAR(CR.CARRERA_FECHA)
