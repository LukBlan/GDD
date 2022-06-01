-- Sector
INSERT INTO LUSAX2.Sector (SECTOR_CODIGO,SECTOR_TIPO,SECTOR_DISTANCIA)
SELECT DISTINCT CODIGO_SECTOR,SECTOR_DISTANCIA,SECTO_TIPO
FROM gd_esquema.Maestra
ORDER BY CODIGO_SECTOR

-- ESCUDERIA
INSERT INTO LUSAX2.Escuderia (ESCUDERIA_NOMBRE,ESCUDERIA_NACIONAL)
SELECT DISTINCT ESCUDERIA_NOMBRE,ESCUDERIA_NACIONALIDAD
FROM gd_esquema.Maestra

-- CIRCUITO
INSERT INTO LUSAX2.Circuito (CIRCUITO_CODIGO,SECTOR_CODIGO,CIRCUITO_NOMBRE,CIRCUITO_PAIS)
SELECT DISTINCT CIRCUITO_CODIGO,s.SECTOR_CODIGO,CIRCUITO_NOMBRE,CIRCUITO_PAIS
FROM gd_esquema.Maestra AS em
JOIN LUSAX2.Sector AS s ON m.SECTOR_CODIGO = s.CODIGO_SECTOR

-- PILOTO
INSERT INTO LUSAX2.Piloto (PILOTO_NOMBRE, PILOTO_APELLIDO,PILOTO_NACIONALIDAD,PILOTO_FECHA_NACIMIENTO)
SELECT DISTINCT PILOTO_NOMBRE, PILOTO_APELLIDO ,PILOTO_NACIONALIDAD,PILOTO_FECHA_NACIMIENTO
FROM gd_esquema.Maestra

--CARRERA
INSERT INTO LUSAX2.Carrera(CARRERA_CODIGO,CIRCUITO_CODIGO,CARRERA_CLIMA,CARRERA_CANT_VUELTAS,CARRERA_FECHA)
SELECT DISTINCT CODIGO_CARRERA,CIRCUITO_CODIGO,CARRERA_CLIMA,CARRERA_CANT_VUELTAS,CARRERA_FECHE
FROM gd_esquema.Maestra
ORDER BY CODIGO_CARRERA

-- AUTO --- FALTA TERMINAR
INSERT INTO LUSAX2.Automovil(AUTO_NUMERO,ESCUDERIA_NOMBRE,PILOTO_ID,NEUMATICO_NRO_SERIE,MOTOR_NRO_SERIE,CAJA_NRO_SERIE,FRENO_NRO_SERIE,AUTO_MODELO)
SELECT DISTINCT M.AUTO_NUMERO,E.ESCUDERIA_NOMBRE,P.PILOTO_ID,N.NEUMATICO_NRO_SERIE,M.MOTOR_NRO_SERIE,C.CAJA_NRO_SERIE,F.FRENO_NRO_SERIE,M.AUTO_MODELO
FROM gd_esquema.Maestra AS M
JOIN LUSAX2.Piloto AS P ON P.PILOTO_ID = 







