USE test
go

-- CIRCUITO
INSERT INTO test.LUSAX2.Circuito (CIRCUITO_CODIGO, CIRCUITO_NOMBRE, CIRCUITO_PAIS)
SELECT DISTINCT CIRCUITO_CODIGO, CIRCUITO_NOMBRE, CIRCUITO_PAIS
FROM GD1C2022.gd_esquema.Maestra
ORDER BY CIRCUITO_CODIGO

-- Sector
INSERT INTO test.LUSAX2.Sector (SECTOR_CODIGO, CIRCUITO_CODIGO, SECTOR_TIPO, SECTOR_DISTANCIA)
SELECT DISTINCT CODIGO_SECTOR ,[CIRCUITO_CODIGO], SECTO_TIPO, SECTOR_DISTANCIA
FROM GD1C2022.gd_esquema.Maestra
ORDER BY CODIGO_SECTOR

-- Carrera
INSERT INTO test.LUSAX2.Carrera ([CARRERA_CODIGO], [Circuito_Codigo], CARRERA_CLIMA, CARRERA_CANT_VUELTAS, CARRERA_FECHA, CARRERA_TOTAL_CARRERA)
SELECT DISTINCT CODIGO_CARRERA, [CIRCUITO_CODIGO], CARRERA_CLIMA, CARRERA_CANT_VUELTAS, CARRERA_FECHA,CARRERA_TOTAL_CARRERA
FROM GD1C2022.gd_esquema.Maestra
ORDER BY CODIGO_CARRERA

-- INCIDENTE
INSERT INTO test.LUSAX2.INCIDENTE ([CARRERA_CODIGO], INCIDENTE_TIPO, INCIDENTE_BANDERA, INCIDENTE_TIEMPO)
select distinct [CODIGO_CARRERA], [INCIDENTE_TIPO], [INCIDENTE_BANDERA], [INCIDENTE_TIEMPO]
FROM GD1C2022.gd_esquema.Maestra
where INCIDENTE_TIPO is not null
ORDER BY CODIGO_CARRERA, INCIDENTE_TIPO

-- ESCUDERIA
INSERT INTO test.LUSAX2.Escuderia (ESCUDERIA_NOMBRE, ESCUDERIA_NACIONALIDAD)
SELECT DISTINCT ESCUDERIA_NOMBRE, ESCUDERIA_NACIONALIDAD
FROM GD1C2022.gd_esquema.Maestra
ORDER BY ESCUDERIA_NACIONALIDAD

-- PILOTO
INSERT INTO test.LUSAX2.Piloto (PILOTO_NOMBRE, PILOTO_APELLIDO, PILOTO_NACIONALIDAD, PILOTO_FECHA_NACIMIENTO)
SELECT DISTINCT PILOTO_NOMBRE, PILOTO_APELLIDO ,PILOTO_NACIONALIDAD,PILOTO_FECHA_NACIMIENTO
FROM GD1C2022.gd_esquema.Maestra

-- AUTO 
INSERT INTO test.LUSAX2.Automovil (AUTO_NUMERO, AUTO_MODELO, ESCUDERIA_NOMBRE, PILOTO_ID)
SELECT DISTINCT M.AUTO_NUMERO,M.AUTO_MODELO,M.ESCUDERIA_NOMBRE,P.PILOTO_ID
FROM GD1C2022.gd_esquema.Maestra AS M 
join test.lusax2.escuderia as e on e.escuderia_nombre=M.escuderia_nombre
JOIN test.LUSAX2.Piloto AS P ON P.PILOTO_NOMBRE+P.PILOTO_APELLIDO =M.PILOTO_NOMBRE+P.PILOTO_APELLIDO
order by AUTO_NUMERO,AUTO_MODELO

--TIPONEUMATICO
INSERT INTO test.LUSAX2.TipoNeumatico(NEUMATICO_TIPO,NEUMATICO_NRO_SERIE)
SELECT DISTINCT NEUMATICO1_TIPO_NUEVO,NEUMATICO1_NRO_SERIE_NUEVO
FROM GD1C2022.gd_esquema.Maestra
where NEUMATICO1_NRO_SERIE_NUEVO is not null
UNION
SELECT DISTINCT NEUMATICO1_TIPO_VIEJO,NEUMATICO1_NRO_SERIE_VIEJO
FROM GD1C2022.gd_esquema.Maestra
where NEUMATICO1_NRO_SERIE_VIEJO is not null
UNION
SELECT DISTINCT NEUMATICO2_TIPO_NUEVO,NEUMATICO2_NRO_SERIE_NUEVO
FROM GD1C2022.gd_esquema.Maestra
where NEUMATICO2_NRO_SERIE_NUEVO is not null
UNION
SELECT DISTINCT NEUMATICO2_TIPO_VIEJO,NEUMATICO2_NRO_SERIE_VIEJO
FROM GD1C2022.gd_esquema.Maestra
where NEUMATICO2_NRO_SERIE_VIEJO is not null
UNION
SELECT DISTINCT NEUMATICO3_TIPO_NUEVO,NEUMATICO3_NRO_SERIE_NUEVO
FROM GD1C2022.gd_esquema.Maestra
where NEUMATICO3_NRO_SERIE_NUEVO is not null
UNION
SELECT DISTINCT NEUMATICO3_TIPO_VIEJO,NEUMATICO3_NRO_SERIE_VIEJO
FROM GD1C2022.gd_esquema.Maestra
where NEUMATICO3_NRO_SERIE_VIEJO is not null
UNION
SELECT DISTINCT NEUMATICO4_TIPO_NUEVO,NEUMATICO4_NRO_SERIE_NUEVO
FROM GD1C2022.gd_esquema.Maestra
where NEUMATICO4_NRO_SERIE_NUEVO is not null
UNION
SELECT DISTINCT NEUMATICO4_TIPO_VIEJO,NEUMATICO4_NRO_SERIE_VIEJO
FROM GD1C2022.gd_esquema.Maestra
where NEUMATICO4_NRO_SERIE_VIEJO is not null
order by 1


--NEUMATICO
INSERT INTO test.LUSAX2.Neumatico(NEUMATICO_NRO_SERIE,NEUMATICO_POSICION,NEUMATICO_TIPO,AUTO_ID)
SELECT DISTINCT NEUMATICO1_NRO_SERIE_NUEVO,NEUMATICO1_POSICION_NUEVO,NEUMATICO1_TIPO_NUEVO,A.AUTO_ID
FROM GD1C2022.gd_esquema.Maestra M JOIN LUSAX2.Automovil A ON A.AUTO_NUMERO=M.AUTO_NUMERO AND A.AUTO_MODELO=M.AUTO_MODELO
where NEUMATICO1_NRO_SERIE_NUEVO is not null
UNION
SELECT DISTINCT NEUMATICO1_NRO_SERIE_VIEJO,NEUMATICO1_POSICION_VIEJO,NEUMATICO1_TIPO_VIEJO,A.AUTO_ID
FROM GD1C2022.gd_esquema.Maestra M JOIN LUSAX2.Automovil A ON A.AUTO_NUMERO=M.AUTO_NUMERO AND A.AUTO_MODELO=M.AUTO_MODELO
where NEUMATICO1_NRO_SERIE_VIEJO is not null
UNION
SELECT DISTINCT NEUMATICO2_NRO_SERIE_NUEVO,NEUMATICO2_POSICION_NUEVO,NEUMATICO2_TIPO_NUEVO,A.AUTO_ID
FROM GD1C2022.gd_esquema.Maestra M JOIN LUSAX2.Automovil A ON A.AUTO_NUMERO=M.AUTO_NUMERO AND A.AUTO_MODELO=M.AUTO_MODELO
where NEUMATICO2_NRO_SERIE_NUEVO is not null
UNION
SELECT DISTINCT NEUMATICO2_NRO_SERIE_VIEJO,NEUMATICO2_POSICION_VIEJO,NEUMATICO2_TIPO_VIEJO,A.AUTO_ID
FROM GD1C2022.gd_esquema.Maestra M JOIN LUSAX2.Automovil A ON A.AUTO_NUMERO=M.AUTO_NUMERO AND A.AUTO_MODELO=M.AUTO_MODELO
where NEUMATICO2_NRO_SERIE_VIEJO is not null
UNION
SELECT DISTINCT NEUMATICO3_NRO_SERIE_NUEVO,NEUMATICO3_POSICION_NUEVO,NEUMATICO3_TIPO_NUEVO,A.AUTO_ID
FROM GD1C2022.gd_esquema.Maestra M JOIN LUSAX2.Automovil A ON A.AUTO_NUMERO=M.AUTO_NUMERO AND A.AUTO_MODELO=M.AUTO_MODELO
where NEUMATICO3_NRO_SERIE_NUEVO is not null
UNION
SELECT DISTINCT NEUMATICO3_NRO_SERIE_VIEJO,NEUMATICO3_POSICION_VIEJO,NEUMATICO3_TIPO_VIEJO,A.AUTO_ID
FROM GD1C2022.gd_esquema.Maestra M JOIN LUSAX2.Automovil A ON A.AUTO_NUMERO=M.AUTO_NUMERO AND A.AUTO_MODELO=M.AUTO_MODELO
where NEUMATICO3_NRO_SERIE_VIEJO is not null
UNION
SELECT DISTINCT NEUMATICO4_NRO_SERIE_NUEVO,NEUMATICO4_POSICION_NUEVO,NEUMATICO4_TIPO_NUEVO,A.AUTO_ID
FROM GD1C2022.gd_esquema.Maestra M JOIN LUSAX2.Automovil A ON A.AUTO_NUMERO=M.AUTO_NUMERO AND A.AUTO_MODELO=M.AUTO_MODELO
where NEUMATICO4_NRO_SERIE_NUEVO is not null
UNION
SELECT DISTINCT NEUMATICO4_NRO_SERIE_VIEJO,NEUMATICO4_POSICION_VIEJO,NEUMATICO4_TIPO_VIEJO,A.AUTO_ID
FROM GD1C2022.gd_esquema.Maestra M JOIN LUSAX2.Automovil A ON A.AUTO_NUMERO=M.AUTO_NUMERO AND A.AUTO_MODELO=M.AUTO_MODELO
where NEUMATICO4_NRO_SERIE_VIEJO is not null
union
--LAS TELEMETRIAS NO TIENEN TIPO POR LO QUE SI EL NRO DE SERIE DEL NEUMATICO NO ESTA EN LA TABLA TIPONEUMATICO 
--SE AGREGA A ESTA TABLA CON NEUMATICO_TIPO NULL
select distinct TELE_NEUMATICO1_NRO_SERIE,TELE_NEUMATICO1_POSICION,[NEUMATICO1_TIPO_VIEJO],A.AUTO_ID
FROM GD1C2022.gd_esquema.Maestra M JOIN LUSAX2.Automovil A ON A.AUTO_NUMERO=M.AUTO_NUMERO AND A.AUTO_MODELO=M.AUTO_MODELO
where TELE_NEUMATICO1_NRO_SERIE is not null AND TELE_NEUMATICO1_NRO_SERIE NOT IN (SELECT t.NEUMATICO_NRO_SERIE
																					FROM LUSAX2.TipoNeumatico t )
UNION
select distinct TELE_NEUMATICO2_NRO_SERIE,TELE_NEUMATICO2_POSICION,[NEUMATICO2_TIPO_VIEJO],A.AUTO_ID
FROM GD1C2022.gd_esquema.Maestra M JOIN LUSAX2.Automovil A ON A.AUTO_NUMERO=M.AUTO_NUMERO AND A.AUTO_MODELO=M.AUTO_MODELO
where TELE_NEUMATICO2_NRO_SERIE is not null AND TELE_NEUMATICO2_NRO_SERIE NOT IN (SELECT t.NEUMATICO_NRO_SERIE
																					FROM LUSAX2.TipoNeumatico t )
UNION
select distinct TELE_NEUMATICO3_NRO_SERIE,TELE_NEUMATICO3_POSICION,NEUMATICO3_TIPO_VIEJO,A.AUTO_ID
FROM GD1C2022.gd_esquema.Maestra M JOIN LUSAX2.Automovil A ON A.AUTO_NUMERO=M.AUTO_NUMERO AND A.AUTO_MODELO=M.AUTO_MODELO
where TELE_NEUMATICO3_NRO_SERIE is not null AND TELE_NEUMATICO3_NRO_SERIE NOT IN (SELECT t.NEUMATICO_NRO_SERIE
																					FROM LUSAX2.TipoNeumatico t )
UNION
select distinct TELE_NEUMATICO4_NRO_SERIE,TELE_NEUMATICO4_POSICION,[NEUMATICO4_TIPO_VIEJO],A.AUTO_ID
FROM GD1C2022.gd_esquema.Maestra M JOIN LUSAX2.Automovil A ON A.AUTO_NUMERO=M.AUTO_NUMERO AND A.AUTO_MODELO=M.AUTO_MODELO
where TELE_NEUMATICO4_NRO_SERIE is not null AND TELE_NEUMATICO4_NRO_SERIE NOT IN (SELECT t.NEUMATICO_NRO_SERIE
																					FROM LUSAX2.TipoNeumatico t )
order by 1

--MOTOR
INSERT INTO test.LUSAX2.Motor(MOTOR_NRO_SERIE, MOTOR_MODELO,AUTO_ID)
select distinct TELE_MOTOR_NRO_SERIE,TELE_MOTOR_MODELO,A.AUTO_ID
from GD1C2022.gd_esquema.Maestra M JOIN LUSAX2.Automovil A ON A.AUTO_NUMERO=M.AUTO_NUMERO AND A.AUTO_MODELO=M.AUTO_MODELO
WHERE TELE_MOTOR_MODELO IS NOT NULL AND TELE_MOTOR_NRO_SERIE IS NOT NULL

--CAJA DE CAMBIO
INSERT INTO test.LUSAX2.CajaDeCambio(CAJA_NRO_SERIE,CAJA_MODELO,AUTO_ID)
SELECT DISTINCT TELE_CAJA_NRO_SERIE,TELE_MOTOR_MODELO,A.AUTO_ID
FROM GD1C2022.gd_esquema.Maestra M JOIN LUSAX2.Automovil A ON A.AUTO_NUMERO=M.AUTO_NUMERO AND A.AUTO_MODELO=M.AUTO_MODELO
where TELE_CAJA_NRO_SERIE IS NOT NULL and TELE_CAJA_MODELO IS NOT NULL

--Telemetria_CajaDeCambio
INSERT INTO test.LUSAX2.Telemetria_CajaDeCambio(CAJA_NRO_SERIE,TELE_CAJA_TEMP_ACEITE,TELE_CAJA_RPM,TELE_CAJA_DESGASTE)
select em.TELE_CAJA_NRO_SERIE,em.TELE_CAJA_TEMP_ACEITE,em.TELE_CAJA_RPM,em.TELE_CAJA_DESGASTE
FROM GD1C2022.gd_esquema.Maestra AS em
JOIN test.LUSAX2.CajaDeCambio AS c ON em.TELE_CAJA_NRO_SERIE = c.CAJA_NRO_SERIE

--FRENO
INSERT INTO test.LUSAX2.Freno(FRENO_NRO_SERIE,FRENO_POSICION,AUTO_ID)
select distinct TELE_FRENO1_NRO_SERIE,TELE_FRENO1_POSICION,A.AUTO_ID
from GD1C2022.gd_esquema.Maestra M JOIN LUSAX2.Automovil A ON A.AUTO_NUMERO=M.AUTO_NUMERO AND A.AUTO_MODELO=M.AUTO_MODELO
where TELE_FRENO1_NRO_SERIE IS NOT NULL
UNION
select distinct TELE_FRENO2_NRO_SERIE,TELE_FRENO2_POSICION,A.AUTO_ID
from GD1C2022.gd_esquema.Maestra M JOIN LUSAX2.Automovil A ON A.AUTO_NUMERO=M.AUTO_NUMERO AND A.AUTO_MODELO=M.AUTO_MODELO
where TELE_FRENO2_NRO_SERIE IS NOT NULL
UNION
select distinct TELE_FRENO3_NRO_SERIE,TELE_FRENO3_POSICION,A.AUTO_ID
from GD1C2022.gd_esquema.Maestra M JOIN LUSAX2.Automovil A ON A.AUTO_NUMERO=M.AUTO_NUMERO AND A.AUTO_MODELO=M.AUTO_MODELO
where TELE_FRENO3_NRO_SERIE IS NOT NULL
UNION
select distinct TELE_FRENO4_NRO_SERIE,TELE_FRENO4_POSICION,A.AUTO_ID
from GD1C2022.gd_esquema.Maestra M JOIN LUSAX2.Automovil A ON A.AUTO_NUMERO=M.AUTO_NUMERO AND A.AUTO_MODELO=M.AUTO_MODELO
where TELE_FRENO4_NRO_SERIE IS NOT NULL

--TELEMETRIA_MOTOR
INSERT INTO test.LUSAX2.Telemetria_Motor (MOTOR_NRO_SERIE,TELE_MOTOR_RPM,TELE_MOTOR_TEMP_ACEITE,TELE_MOTOR_TEMP_AGUA,TELE_MOTOR_POTENCIA)
select TELE_MOTOR_NRO_SERIE, TELE_MOTOR_RPM, TELE_MOTOR_TEMP_ACEITE, TELE_MOTOR_TEMP_AGUA, TELE_MOTOR_POTENCIA
FROM GD1C2022.gd_esquema.Maestra AS em
JOIN test.LUSAX2.Motor AS m ON em.TELE_MOTOR_NRO_SERIE = m.MOTOR_NRO_SERIE

--AUTOXINCIDENTE
INSERT INTO test.LUSAX2.AutoxIncidente(AUTO_ID, incidente_id, INCIDENTE_NUMERO_VUELTA)
SELECT DISTINCT A.AUTO_ID, i.incidente_id, M.INCIDENTE_NUMERO_VUELTA
FROM GD1C2022.gd_esquema.Maestra AS M 
JOIN LUSAX2.Automovil A ON A.AUTO_NUMERO = M.AUTO_NUMERO 
AND A.AUTO_MODELO = M.AUTO_MODELO
JOIN LUSAX2.INCIDENTE as i on i.incidente_id = (select distinct INCIDENTE_ID 
                                                from lusax2.incidente 
												where M.INCIDENTE_TIEMPO = lusax2.incidente.INCIDENTE_TIEMPO
												and M.INCIDENTE_TIPO = lusax2.incidente.INCIDENTE_TIPO
												and M.CODIGO_CARRERA = lusax2.incidente.CARRERA_CODIGO)
WHERE INCIDENTE_NUMERO_VUELTA IS NOT NULL
ORDER BY AUTO_ID

--TELEMETRIA_AUTO
INSERT INTO test.LUSAX2.Telemetria_Auto(TELE_AUTO_ID, AUTO_ID, TELE_AUTO_COMBUSTIBLE, TELE_AUTO_DISTANCIA_CARRERA, TELE_AUTO_DISTANCIA_VUELTA,
									TELE_AUTO_NRO_VUELTA, TELE_AUTO_POSICION, TELE_AUTO_TIEMPO_VUELTA, TELE_AUTO_VELOCIDAD)
SELECT DISTINCT m.TELE_AUTO_CODIGO, A.AUTO_ID, M.TELE_AUTO_COMBUSTIBLE, M.TELE_AUTO_DISTANCIA_CARRERA, M.TELE_AUTO_DISTANCIA_VUELTA,
				M.TELE_AUTO_NUMERO_VUELTA, M.TELE_AUTO_POSICION, TELE_AUTO_TIEMPO_VUELTA, TELE_AUTO_VELOCIDAD
FROM GD1C2022.gd_esquema.Maestra AS M 
JOIN LUSAX2.Automovil A ON A.AUTO_NUMERO = M.AUTO_NUMERO AND A.AUTO_MODELO = M.AUTO_MODELO
WHERE TELE_AUTO_COMBUSTIBLE IS NOT NULL
order by AUTO_ID, TELE_AUTO_POSICION, TELE_AUTO_NUMERO_VUELTA

--Parada 
INSERT INTO test.LUSAX2.Parada ([CARRERA_CODIGO], auto_id, [PARADA_BOX_VUELTA], [PARADA_BOX_TIEMPO])
select distinct [CODIGO_CARRERA], a.auto_id,[PARADA_BOX_VUELTA], [PARADA_BOX_TIEMPO]
FROM GD1C2022.gd_esquema.Maestra AS em
join LUSAX2.automovil as a on a.auto_id = (select distinct auto_id
                                           from [LUSAX2].[Automovil]
										   where LUSAX2.automovil.auto_numero = em.[AUTO_NUMERO]
										   and LUSAX2.automovil.AUTO_MODELO = em.auto_Modelo)
where PARADA_BOX_TIEMPO is not null
order by AUTO_ID

--CAMBIO NEUMATICOS
INSERT INTO test.LUSAX2.Cambio_Neumatico(NEUMATICO_NRO_SERIE_VIEJO,NEUMATICO_NRO_SERIE_NUEVO,PARADA_CODIGO_BOX)
select distinct em.NEUMATICO1_NRO_SERIE_VIEJO,em.NEUMATICO1_NRO_SERIE_NUEVO,p.PARADA_CODIGO_BOX
FROM GD1C2022.gd_esquema.Maestra AS em
join LUSAX2.Parada p ON p.PARADA_BOX_TIEMPO+p.PARADA_BOX_VUELTA=em.PARADA_BOX_TIEMPO+em.PARADA_BOX_VUELTA
where NEUMATICO1_NRO_SERIE_NUEVO is not null
union
select distinct em.NEUMATICO2_NRO_SERIE_VIEJO,em.NEUMATICO2_NRO_SERIE_NUEVO,p.PARADA_CODIGO_BOX
FROM GD1C2022.gd_esquema.Maestra AS em
join LUSAX2.Parada p ON p.PARADA_BOX_TIEMPO+p.PARADA_BOX_VUELTA=em.PARADA_BOX_TIEMPO+em.PARADA_BOX_VUELTA
where NEUMATICO2_NRO_SERIE_NUEVO is not null
union
select distinct em.NEUMATICO3_NRO_SERIE_VIEJO,em.NEUMATICO3_NRO_SERIE_NUEVO,p.PARADA_CODIGO_BOX
FROM GD1C2022.gd_esquema.Maestra AS em
join LUSAX2.Parada p ON p.PARADA_BOX_TIEMPO+p.PARADA_BOX_VUELTA=em.PARADA_BOX_TIEMPO+em.PARADA_BOX_VUELTA
where NEUMATICO3_NRO_SERIE_NUEVO is not null
union
select distinct em.NEUMATICO4_NRO_SERIE_VIEJO,em.NEUMATICO4_NRO_SERIE_NUEVO,p.PARADA_CODIGO_BOX
FROM GD1C2022.gd_esquema.Maestra AS em
join LUSAX2.Parada p ON p.PARADA_BOX_TIEMPO+p.PARADA_BOX_VUELTA=em.PARADA_BOX_TIEMPO+em.PARADA_BOX_VUELTA
where NEUMATICO4_NRO_SERIE_NUEVO is not null

--TELEMETRIA
insert into test.lusax2.Telemetria (TELE_AUTO_ID, CARRERA_CODIGO, sector_codigo, TELE_CAJA_CAMBIO_ID, TELE_MOTOR_ID)
select DISTINCT TELE_AUTO_CODIGO, em.[CODIGO_CARRERA], em.[CODIGO_SECTOR], tc.TELE_CAJA_CAMBIO_ID, tm.TELE_MOTOR_ID
from GD1C2022.gd_esquema.Maestra as em
JOIN LUSAX2.Telemetria_CajaDeCambio As tc on tc.TELE_CAJA_CAMBIO_ID = (select top 1 TELE_CAJA_CAMBIO_ID
                                                                           from LUSAX2.Telemetria_CajaDeCambio
																		   where LUSAX2.Telemetria_CajaDeCambio.CAJA_NRO_SERIE = em.TELE_CAJA_NRO_SERIE
																		   and lusax2.Telemetria_CajaDeCambio.tele_caja_temp_aceite = em.TELE_CAJA_TEMP_ACEITE
																		   and lusax2.Telemetria_CajaDeCambio.TELE_CAJA_RPM = em.TELE_CAJA_RPM
																		   and lusax2.Telemetria_CajaDeCambio.tele_caja_desgaste = em.TELE_CAJA_DESGASTE)
JOIN LUSAX2.Telemetria_Motor As tm on tm.TELE_MOTOR_ID = (select top 1 TELE_MOTOR_ID
                                                                           from LUSAX2.Telemetria_Motor
																		   where LUSAX2.Telemetria_Motor.MOTOR_NRO_SERIE = em.TELE_MOTOR_NRO_SERIE
																		   and LUSAX2.Telemetria_Motor.TELE_MOTOR_RPM = em.TELE_MOTOR_RPM
																		   and LUSAX2.Telemetria_Motor.TELE_MOTOR_TEMP_ACEITE = em.TELE_MOTOR_TEMP_ACEITE
																		   and LUSAX2.Telemetria_Motor.TELE_MOTOR_TEMP_AGUA = em.TELE_MOTOR_TEMP_AGUA
																		   and LUSAX2.Telemetria_Motor.TELE_MOTOR_POTENCIA = em.TELE_MOTOR_POTENCIA)

--TELEMETRIA_NEUMATICO
INSERT INTO test.LUSAX2.Telemetria_Neumatico (telemetria_id, NEUMATICO_NRO_SERIE,TELE_NEUMATICO_PRESION,TELE_NEUMATICO_PROFUNDIDAD,TELE_NEUMATICO_TEMPERATURA)
select distinct t.telemetria_id, TELE_NEUMATICO1_NRO_SERIE,TELE_NEUMATICO1_PRESION,TELE_NEUMATICO1_PROFUNDIDAD,TELE_NEUMATICO1_TEMPERATURA
FROM GD1C2022.gd_esquema.Maestra AS em
JOIN test.LUSAX2.Neumatico AS N ON em.TELE_NEUMATICO1_NRO_SERIE = N.NEUMATICO_NRO_SERIE
join test.LUSAX2.telemetria as t on t.telemetria_id = ( select telemetria_id
														from lusax2.telemetria
														where lusax2.telemetria.tele_auto_id = em.[TELE_AUTO_CODIGO])
UNION

select distinct t.telemetria_id, TELE_NEUMATICO2_NRO_SERIE,TELE_NEUMATICO2_PRESION,TELE_NEUMATICO2_PROFUNDIDAD,TELE_NEUMATICO2_TEMPERATURA
FROM GD1C2022.gd_esquema.Maestra AS em
JOIN test.LUSAX2.Neumatico AS N ON em.TELE_NEUMATICO2_NRO_SERIE = N.NEUMATICO_NRO_SERIE
join test.LUSAX2.telemetria as t on t.telemetria_id = ( select telemetria_id
														from lusax2.telemetria
														where lusax2.telemetria.tele_auto_id = em.[TELE_AUTO_CODIGO])
UNION

select distinct t.telemetria_id, TELE_NEUMATICO3_NRO_SERIE,TELE_NEUMATICO3_PRESION,TELE_NEUMATICO3_PROFUNDIDAD,TELE_NEUMATICO3_TEMPERATURA
FROM GD1C2022.gd_esquema.Maestra AS em
JOIN test.LUSAX2.Neumatico AS N ON em.TELE_NEUMATICO3_NRO_SERIE = N.NEUMATICO_NRO_SERIE
join test.LUSAX2.telemetria as t on t.telemetria_id = ( select telemetria_id
														from lusax2.telemetria
														where lusax2.telemetria.tele_auto_id = em.[TELE_AUTO_CODIGO])
UNION

select distinct t.telemetria_id,TELE_NEUMATICO4_NRO_SERIE,TELE_NEUMATICO4_PRESION,TELE_NEUMATICO4_PROFUNDIDAD,TELE_NEUMATICO4_TEMPERATURA
FROM GD1C2022.gd_esquema.Maestra AS em
JOIN test.LUSAX2.Neumatico AS N ON em.TELE_NEUMATICO4_NRO_SERIE = N.NEUMATICO_NRO_SERIE
join test.LUSAX2.telemetria as t on t.telemetria_id = ( select telemetria_id
														from lusax2.telemetria
														where lusax2.telemetria.tele_auto_id = em.[TELE_AUTO_CODIGO])
ORDER BY 1,2

--TELEMETRIA_FRENO
INSERT INTO test.LUSAX2.Telemetria_Freno (telemetria_id, FRENO_NRO_SERIE, TELE_FRENO_GROSOR_PASTILLA, TELE_TAMANIO_DISCO, TELE_TEMPERATURA)
select distinct t.telemetria_id, TELE_FRENO1_NRO_SERIE, TELE_FRENO1_GROSOR_PASTILLA, TELE_FRENO1_TAMANIO_DISCO, TELE_FRENO1_TEMPERATURA
FROM GD1C2022.gd_esquema.Maestra AS em
JOIN test.LUSAX2.Freno AS f ON em.TELE_FRENO1_NRO_SERIE = f.FRENO_NRO_SERIE
join test.LUSAX2.telemetria as t on t.telemetria_id = ( select telemetria_id
														from lusax2.telemetria
														where lusax2.telemetria.tele_auto_id = em.[TELE_AUTO_CODIGO])
UNION

select distinct t.telemetria_id, TELE_FRENO2_NRO_SERIE, TELE_FRENO2_GROSOR_PASTILLA, TELE_FRENO2_TAMANIO_DISCO, TELE_FRENO2_TEMPERATURA
FROM GD1C2022.gd_esquema.Maestra AS em
JOIN test.LUSAX2.Freno AS f ON em.TELE_FRENO2_NRO_SERIE = f.FRENO_NRO_SERIE
join test.LUSAX2.telemetria as t on t.telemetria_id = ( select telemetria_id
														from lusax2.telemetria
														where lusax2.telemetria.tele_auto_id = em.[TELE_AUTO_CODIGO])
UNION

select distinct t.telemetria_id, TELE_FRENO3_NRO_SERIE, TELE_FRENO3_GROSOR_PASTILLA, TELE_FRENO3_TAMANIO_DISCO, TELE_FRENO3_TEMPERATURA
FROM GD1C2022.gd_esquema.Maestra AS em
JOIN test.LUSAX2.Freno AS f ON em.TELE_FRENO3_NRO_SERIE = f.FRENO_NRO_SERIE
join test.LUSAX2.telemetria as t on t.telemetria_id = ( select telemetria_id
														from lusax2.telemetria
														where lusax2.telemetria.tele_auto_id = em.[TELE_AUTO_CODIGO])
UNION

select distinct t.telemetria_id, TELE_FRENO4_NRO_SERIE, TELE_FRENO4_GROSOR_PASTILLA, TELE_FRENO4_TAMANIO_DISCO, TELE_FRENO4_TEMPERATURA
FROM GD1C2022.gd_esquema.Maestra AS em
JOIN test.LUSAX2.Freno AS f ON em.TELE_FRENO4_NRO_SERIE = f.FRENO_NRO_SERIE
join test.LUSAX2.telemetria as t on t.telemetria_id = ( select telemetria_id
														from lusax2.telemetria
														where lusax2.telemetria.tele_auto_id = em.[TELE_AUTO_CODIGO])


