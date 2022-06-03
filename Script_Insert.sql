USE test
go

-- Sector
INSERT INTO test.LUSAX2.Sector (SECTOR_CODIGO, SECTOR_TIPO, SECTOR_DISTANCIA)
SELECT DISTINCT CODIGO_SECTOR ,SECTO_TIPO, SECTOR_DISTANCIA
FROM GD1C2022.gd_esquema.Maestra
ORDER BY CODIGO_SECTOR

-- CIRCUITO
INSERT INTO test.LUSAX2.Circuito (CIRCUITO_CODIGO, SECTOR_CODIGO, CIRCUITO_NOMBRE, CIRCUITO_PAIS)
SELECT DISTINCT CIRCUITO_CODIGO, em.[CODIGO_SECTOR], CIRCUITO_NOMBRE, CIRCUITO_PAIS
FROM GD1C2022.gd_esquema.Maestra AS em
JOIN test.LUSAX2.Sector AS s ON em.CODIGO_SECTOR = s.SECTOR_CODIGO

-- Carrera
INSERT INTO test.LUSAX2.Carrera (CARRERA_CODIGO, [Circuito_id], CARRERA_CLIMA, CARRERA_CANT_VUELTAS,CARRERA_FECHA)
SELECT DISTINCT CODIGO_CARRERA, s.Circuito_id, CARRERA_CLIMA, CARRERA_CANT_VUELTAS, CARRERA_FECHA
FROM GD1C2022.gd_esquema.Maestra as em join test.LUSAX2.Circuito as s ON em.CODIGO_SECTOR = s.SECTOR_CODIGO 
and em.[CIRCUITO_CODIGO] = s.[CIRCUITO_CODIGO]
ORDER BY CODIGO_CARRERA

-- ESCUDERIA
INSERT INTO test.LUSAX2.Escuderia (ESCUDERIA_NOMBRE, ESCUDERIA_NACIONALIDAD)
SELECT DISTINCT ESCUDERIA_NOMBRE, ESCUDERIA_NACIONALIDAD
FROM GD1C2022.gd_esquema.Maestra

-- PILOTO
INSERT INTO test.LUSAX2.Piloto (PILOTO_NOMBRE, PILOTO_APELLIDO, PILOTO_NACIONALIDAD, PILOTO_FECHA_NACIMIENTO)
SELECT DISTINCT PILOTO_NOMBRE, PILOTO_APELLIDO ,PILOTO_NACIONALIDAD,PILOTO_FECHA_NACIMIENTO
FROM GD1C2022.gd_esquema.Maestra

--NEUMATICO
INSERT INTO test.LUSAX2.Neumatico(NEUMATICO_NRO_SERIE,NEUMATICO_POSICION,NEUMATICO_TIPO)
SELECT DISTINCT NEUMATICO1_NRO_SERIE_NUEVO,NEUMATICO1_POSICION_NUEVO,NEUMATICO1_TIPO_NUEVO
FROM GD1C2022.gd_esquema.Maestra
where NEUMATICO1_NRO_SERIE_NUEVO is not null
UNION
SELECT DISTINCT NEUMATICO1_NRO_SERIE_VIEJO,NEUMATICO1_POSICION_VIEJO,NEUMATICO1_TIPO_VIEJO
FROM GD1C2022.gd_esquema.Maestra
where NEUMATICO1_NRO_SERIE_VIEJO is not null
UNION
SELECT DISTINCT NEUMATICO2_NRO_SERIE_NUEVO,NEUMATICO2_POSICION_NUEVO,NEUMATICO2_TIPO_NUEVO
FROM GD1C2022.gd_esquema.Maestra
where NEUMATICO2_NRO_SERIE_NUEVO is not null
UNION
SELECT DISTINCT NEUMATICO2_NRO_SERIE_VIEJO,NEUMATICO2_POSICION_VIEJO,NEUMATICO2_TIPO_VIEJO
FROM GD1C2022.gd_esquema.Maestra
where NEUMATICO2_NRO_SERIE_VIEJO is not null
UNION
SELECT DISTINCT NEUMATICO3_NRO_SERIE_NUEVO,NEUMATICO3_POSICION_NUEVO,NEUMATICO3_TIPO_NUEVO
FROM GD1C2022.gd_esquema.Maestra
where NEUMATICO3_NRO_SERIE_NUEVO is not null
UNION
SELECT DISTINCT NEUMATICO3_NRO_SERIE_VIEJO,NEUMATICO3_POSICION_VIEJO,NEUMATICO3_TIPO_VIEJO
FROM GD1C2022.gd_esquema.Maestra
where NEUMATICO3_NRO_SERIE_VIEJO is not null
UNION
SELECT DISTINCT NEUMATICO4_NRO_SERIE_NUEVO,NEUMATICO4_POSICION_NUEVO,NEUMATICO4_TIPO_NUEVO
FROM GD1C2022.gd_esquema.Maestra
where NEUMATICO4_NRO_SERIE_NUEVO is not null
UNION
SELECT DISTINCT NEUMATICO4_NRO_SERIE_VIEJO,NEUMATICO4_POSICION_VIEJO,NEUMATICO4_TIPO_VIEJO
FROM GD1C2022.gd_esquema.Maestra
where NEUMATICO4_NRO_SERIE_VIEJO is not null
order by 1

--MOTOR
INSERT INTO test.LUSAX2.Motor(MOTOR_NRO_SERIE, MOTOR_MODELO)
select distinct TELE_MOTOR_NRO_SERIE,TELE_MOTOR_MODELO
from GD1C2022.gd_esquema.Maestra
WHERE TELE_MOTOR_MODELO IS NOT NULL AND TELE_MOTOR_NRO_SERIE IS NOT NULL

--CAJA DE CAMBIO
INSERT INTO test.LUSAX2.CajaDeCambio(CAJA_NRO_SERIE,CAJA_MODELO)
SELECT DISTINCT TELE_CAJA_NRO_SERIE,TELE_MOTOR_MODELO
FROM GD1C2022.gd_esquema.Maestra
where TELE_CAJA_NRO_SERIE IS NOT NULL and TELE_CAJA_MODELO IS NOT NULL

--Telemetria_CajaDeCambio
INSERT INTO test.LUSAX2.Telemetria_CajaDeCambio(CAJA_NRO_SERIE,TELE_CAJA_TEMP_ACEITE,TELE_CAJA_RPM,TELE_CAJA_DESGASTE)
select distinct em.TELE_CAJA_NRO_SERIE,em.TELE_CAJA_TEMP_ACEITE,em.TELE_CAJA_RPM,em.TELE_CAJA_DESGASTE
FROM GD1C2022.gd_esquema.Maestra AS em
JOIN test.LUSAX2.CajaDeCambio AS c ON em.TELE_CAJA_NRO_SERIE = c.CAJA_NRO_SERIE

--FRENO
INSERT INTO test.LUSAX2.Freno(FRENO_NRO_SERIE,FRENO_POSICION)
select distinct TELE_FRENO1_NRO_SERIE,TELE_FRENO1_POSICION
from GD1C2022.gd_esquema.Maestra
where TELE_FRENO1_NRO_SERIE IS NOT NULL
UNION
select distinct TELE_FRENO2_NRO_SERIE,TELE_FRENO2_POSICION
from GD1C2022.gd_esquema.Maestra
where TELE_FRENO2_NRO_SERIE IS NOT NULL
UNION
select distinct TELE_FRENO3_NRO_SERIE,TELE_FRENO3_POSICION
from GD1C2022.gd_esquema.Maestra
where TELE_FRENO3_NRO_SERIE IS NOT NULL
UNION
select distinct TELE_FRENO4_NRO_SERIE,TELE_FRENO4_POSICION
from GD1C2022.gd_esquema.Maestra
where TELE_FRENO4_NRO_SERIE IS NOT NULL

--TELEMETRIA_MOTOR
INSERT INTO test.LUSAX2.Telemetria_Motor(MOTOR_NRO_SERIE,TELE_MOTOR_RPM,TELE_MOTOR_TEMP_ACEITE,TELE_MOTOR_TEMP_AGUA,TELE_MOTOR_POTENCIA)
select distinct TELE_MOTOR_NRO_SERIE,TELE_MOTOR_RPM,TELE_MOTOR_TEMP_ACEITE,TELE_MOTOR_TEMP_AGUA,TELE_MOTOR_POTENCIA
FROM GD1C2022.gd_esquema.Maestra AS em
JOIN test.LUSAX2.Motor AS m ON em.TELE_MOTOR_NRO_SERIE = m.MOTOR_NRO_SERIE

--TELEMETRIA_FRENO
INSERT INTO test.LUSAX2.Telemetria_Freno(FRENO_NRO_SERIE,TELE_TAMANIO_DISCO,TELE_TEMPERATURA)
select distinct TELE_FRENO1_NRO_SERIE,TELE_FRENO1_GROSOR_PASTILLA,TELE_FRENO1_TEMPERATURA
FROM GD1C2022.gd_esquema.Maestra AS em
JOIN test.LUSAX2.Freno AS f ON em.TELE_FRENO1_NRO_SERIE = f.FRENO_NRO_SERIE
UNION
select distinct TELE_FRENO2_NRO_SERIE,TELE_FRENO2_GROSOR_PASTILLA,TELE_FRENO2_TEMPERATURA
FROM GD1C2022.gd_esquema.Maestra AS em
JOIN test.LUSAX2.Freno AS f ON em.TELE_FRENO2_NRO_SERIE = f.FRENO_NRO_SERIE
UNION
select distinct TELE_FRENO3_NRO_SERIE,TELE_FRENO3_GROSOR_PASTILLA,TELE_FRENO3_TEMPERATURA
FROM GD1C2022.gd_esquema.Maestra AS em
JOIN test.LUSAX2.Freno AS f ON em.TELE_FRENO3_NRO_SERIE = f.FRENO_NRO_SERIE
UNION
select distinct TELE_FRENO4_NRO_SERIE,TELE_FRENO4_GROSOR_PASTILLA,TELE_FRENO4_TEMPERATURA
FROM GD1C2022.gd_esquema.Maestra AS em
JOIN test.LUSAX2.Freno AS f ON em.TELE_FRENO4_NRO_SERIE = f.FRENO_NRO_SERIE
--hasta aca copia bien 

--TELEMETRIA_NEUMATICO
INSERT INTO test.LUSAX2.Telemetria_Neumatico(NEUMATICO_NRO_SERIE,TELE_NEUMATICO_PRESION,TELE_NEUMATICO_PROFUNDIDAD,TELE_NEUMATICO_TEMPERATURA)
select distinct TELE_NEUMATICO1_NRO_SERIE,TELE_NEUMATICO1_PRESION,TELE_NEUMATICO1_PROFUNDIDAD,TELE_NEUMATICO1_TEMPERATURA
FROM GD1C2022.gd_esquema.Maestra AS em
JOIN test.LUSAX2.Neumatico AS N ON em.TELE_NEUMATICO1_NRO_SERIE = N.NEUMATICO_NRO_SERIE
UNION
select distinct TELE_NEUMATICO2_NRO_SERIE,TELE_NEUMATICO2_PRESION,TELE_NEUMATICO2_PROFUNDIDAD,TELE_NEUMATICO2_TEMPERATURA
FROM GD1C2022.gd_esquema.Maestra AS em
JOIN test.LUSAX2.Neumatico AS N ON em.TELE_NEUMATICO2_NRO_SERIE = N.NEUMATICO_NRO_SERIE
UNION
select distinct TELE_NEUMATICO3_NRO_SERIE,TELE_NEUMATICO3_PRESION,TELE_NEUMATICO3_PROFUNDIDAD,TELE_NEUMATICO3_TEMPERATURA
FROM GD1C2022.gd_esquema.Maestra AS em
JOIN test.LUSAX2.Neumatico AS N ON em.TELE_NEUMATICO3_NRO_SERIE = N.NEUMATICO_NRO_SERIE
UNION
select distinct TELE_NEUMATICO4_NRO_SERIE,TELE_NEUMATICO4_PRESION,TELE_NEUMATICO4_PROFUNDIDAD,TELE_NEUMATICO4_TEMPERATURA
FROM GD1C2022.gd_esquema.Maestra AS em
JOIN test.LUSAX2.Neumatico AS N ON em.TELE_NEUMATICO4_NRO_SERIE = N.NEUMATICO_NRO_SERIE
ORDER BY 1
--REVISAR DESPUES

--INCIDENTE
/*INSERT INTO test.LUSAX2.INCIDENTE(carrera_id,INCIDENTE_TIPO,INCIDENTE_BANDERA,INCIDENTE_TIEMPO)
select distinct c.carrera_id,em.INCIDENTE_TIPO
FROM GD1C2022.gd_esquema.Maestra AS em join
test.lusax2.carrera on c.carrera_codigo=em.CODIGO_CARRERA
*/
/*
-- AUTO --- FALTA TERMINAR
INSERT INTO LUSAX2.Automovil (AUTO_NUMERO, ESCUDERIA_NOMBRE, PILOTO_ID,NEUMATICO_NRO_SERIE, MOTOR_NRO_SERIE, CAJA_NRO_SERIE, FRENO_NRO_SERIE, AUTO_MODELO)
SELECT DISTINCT M.AUTO_NUMERO,E.ESCUDERIA_NOMBRE,P.PILOTO_ID,N.NEUMATICO_NRO_SERIE,M.MOTOR_NRO_SERIE,C.CAJA_NRO_SERIE,F.FRENO_NRO_SERIE,M.AUTO_MODELO
FROM gd_esquema.Maestra AS M
JOIN LUSAX2.Piloto AS P ON P.PILOTO_ID = 

*/

