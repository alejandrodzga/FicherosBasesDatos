-- 04 DISEÑO EXTERNO A: USUARIO REGISTRADO

-- Creamos el rol de usuario registrado
CREATE ROLE usuarioregistrado;

--Le damos los privilegios necesarios al rol creado de las tablas relativas a preliculas y especificas para su rol
GRANT select on movies to usuarioregistrado;
GRANT SELECT on stars to usuarioregistrado;
GRANT SELECT on casts to usuarioregistrado;
GRANT SELECT on keywords to usuarioregistrado;
GRANT SELECT on genres_movies to usuarioregistrado;
GRANT SELECT on clubs to usuarioregistrado;
GRANT SELECT on proposals to usuarioregistrado;
GRANT SELECT on profiles to usuarioregistrado;

-------------------------------------------- CREACION DE VISTAS------------------------------
-- SUBVISTAS PARA OPENHUB
CREATE OR REPLACE VIEW O1 AS( -- Obtenemos todos los clubs que estan abiertos OPEN      CASILLA DEFINITIVA 1
    SELECT name  FROM CLUBS WHERE OPEN='O' AND END_DATE IS NULL
)WITH READ ONLY;

CREATE OR REPLACE VIEW O2 AS( -- Obtenemos por club su cantidad de miembros    CASILLA DEFINITIVA 2
    SELECT CLUB, COUNT(*) AS NUM_MEMBERS  
    FROM MEMBERSHIP INNER JOIN O1 
    ON CLUB=O1.NAME
    GROUP BY CLUB
)WITH READ ONLY;

CREATE OR REPLACE VIEW O3 AS( -- Obtenemos los meses de actividad de cada club  CASILLA DEFINITIVA 3
    SELECT NAME,NUM_MEMBERS, MONTHS_BETWEEN(SYSDATE, cre_date) as NUM_MONTHS
    FROM CLUBS INNER JOIN O2
    ON NAME=O2.CLUB
)WITH READ ONLY;

CREATE OR REPLACE VIEW O4 AS( -- Obtenemos el total de propuestas por club 
    SELECT CLUB, COUNT(*) AS NUM_PROPUESTAS
    FROM PROPOSALS  
    GROUP BY CLUB
)WITH READ ONLY;

CREATE OR REPLACE VIEW O5 AS( -- Obtenemos PROPUESTAS/MES  CASILLA DEFINITIVA 4
    SELECT O4.CLUB, NUM_MEMBERS,NUM_MONTHS,(O4.NUM_PROPUESTAS/O3.NUM_MONTHS) AS PROPUESTASALMES
    FROM O4 INNER JOIN O3
    ON O4.CLUB = O3.NAME
)WITH READ ONLY;

CREATE OR REPLACE VIEW O6 AS( -- Obtenemos el total de comentarios por club     
    SELECT CLUB, COUNT(*) AS NUM_COMMENTS 
    FROM COMMENTS 
    GROUP BY CLUB
)WITH READ ONLY;

CREATE OR REPLACE VIEW O7 AS( -- Obtenemos el total de comentarios/propuesta   CASILLA DEFINITIVA 5
    SELECT O6.CLUB,NUM_MEMBERS,NUM_MONTHS,PROPUESTASALMES,NUM_COMMENTS
    FROM O6 INNER JOIN O5
    ON O6.CLUB = O5.CLUB
)WITH READ ONLY;

-- NOTA: Se van haciendo inner joins consecutivamente para arrastrar las columnas y que siempre tenga coherencia por el club
-- NOTA: Creamos la vista OpenPub, que estara compuesta de otras vistas para dividir el proceso, el usuario final solo tendra privilegios de consulta sobre la de OpenPub
CREATE OR REPLACE VIEW OpenPub AS( -- FUNCIONANDO PERFECTAMENTE 
SELECT O7.CLUB, O7.NUM_MEMBERS, O7.NUM_MONTHS, O7.PROPUESTASALMES,(O7.NUM_COMMENTS/O4.NUM_PROPUESTAS) AS COMENTARIOSPORPROPUESTA
FROM O7 INNER JOIN O4
ON O7.CLUB=O4.CLUB
)WITH READ ONLY;

-- Le otorgamos al rol los permisos para OpenPub
GRANT SELECT on OpenPub to usuarioregistrado;

----------- VISTA DE ANYONE_GOES--------------------------------------------
CREATE OR REPLACE VIEW A1 AS ( -- VISTA PARA OBTENER LOS RESULTADOS DE TODOS LOS CLUBS QUE ACEPTAN PETICIONES JUNTO AL NUMERO DE PETICIONES QUE ACEPTAN
SELECT CLUB, COUNT(*) AS PETICIONESACEPTADAS
FROM MEMBERSHIP 
WHERE ACC_MSG IS NOT NULL
GROUP BY CLUB
)WITH READ ONLY;

CREATE OR REPLACE VIEW Anyone_goes AS ( -- AQUI OBTENEMOS EL ORDEN
SELECT  CLUB, PETICIONESACEPTADAS
FROM (SELECT * FROM A1 ORDER BY  PETICIONESACEPTADAS DESC)
WHERE ROWNUM<=5
)WITH READ ONLY;

-- le damos al rol los permisos de consulta de anyone_goes
GRANT SELECT ON Anyone_goes TO usuarioregistrado;

--- REPORT DEL USUARIO ACTUAL ---------------------------------------
-- SUBVISTAS PARA HACER EL REPORT
CREATE OR REPLACE VIEW R1 AS(-- COGEMOS INFO DE MEMBERSHIP DE LOS CLUBES A LOS QUE PERTENECE O HA PERTENECIDO EN ALGUN MOMENTO
SELECT CLUB, TYPE, ACC_MSG, INC_DATE, END_DATE
FROM MEMBERSHIP
WHERE NICK=(SELECT USER FROM DUAL)
)WITH READ ONLY; 

CREATE OR REPLACE VIEW R2 AS(-- COGEMOS INFO DE CANDIDATES PARA OBTENER LOS CLUBS A LOS CUALES HA PRESENTADO CANDIDATURA
SELECT CLUB, TYPE, REQ_MSG, REQ_DATE, REJ_DATE
FROM CANDIDATES
WHERE NICK=(SELECT USER FROM DUAL)
)WITH READ ONLY; 

-- VISTA (MEMBERSHIP) REPORT
CREATE OR REPLACE VIEW REPORT AS(-- Unimos la informacion para darle al usuario toda su informacion de clubes a los que pertenece o ha pertenecido asi como sus candidaturas
SELECT CLUB, TYPE, ACC_MSG, INC_DATE, END_DATE FROM R1 
UNION 
SELECT CLUB, TYPE, REQ_MSG, REQ_DATE, REJ_DATE FROM R2
)WITH READ ONLY; 

--Le concedemos los permisos de consulta sobre la vista 
GRANT SELECT ON REPORT TO usuarioregistrado;
