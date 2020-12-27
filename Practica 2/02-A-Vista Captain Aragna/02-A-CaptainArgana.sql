-- 02 VISTA a CAPTAIN ARGANA 

--SUBVISTAS / SUBQUERYS
CREATE OR REPLACE VIEW T1 AS( -- Obtenemos TODAS las propuestas comentadas POR CADA USUARIO.
SELECT NICK,CLUB,TITLE,DIRECTOR
FROM COMMENTS
GROUP BY NICK, CLUB, TITLE, DIRECTOR
)WITH READ ONLY;

CREATE OR REPLACE VIEW T2 AS( -- Obtenemos las propuestas NO comentadas DE CADA USUARIO.
SELECT MEMBER,CLUB, TITLE, DIRECTOR
FROM PROPOSALS
WHERE (MEMBER,CLUB,TITLE,DIRECTOR) NOT IN(SELECT NICK,CLUB,TITLE,DIRECTOR FROM T1)
)WITH READ ONLY;

CREATE OR REPLACE VIEW T3 AS(
SELECT T2.MEMBER, COUNT(*) AS MEM_COUNT1  -- Numero total de propuestas no comentadas por usuario de las que han sido creadas por el mismo.
FROM T2
GROUP BY MEMBER
)WITH READ ONLY;

CREATE OR REPLACE VIEW T4 AS(-- Propuestas creadas por cada usuario.
SELECT PROPOSALS.MEMBER, COUNT(*) AS MEM_COUNT2   -- Contamos el total de propuestas creadas por cada usuario.
FROM PROPOSALS
GROUP BY MEMBER
)WITH READ ONLY;

CREATE OR REPLACE VIEW T5 AS(
SELECT T3.MEMBER,T3.MEM_COUNT1,T4.MEM_COUNT2   -- Juntamos en una tabla las propuestas no comentadas por el creador y el total de propuestas creadas por el mismo.
FROM T3 INNER JOIN T4 
    ON T3.MEMBER=T4.MEMBER
)WITH READ ONLY;

CREATE OR REPLACE VIEW T6 AS(
SELECT T5.MEMBER,((MEM_COUNT1/MEM_COUNT2)*100)PORCENTAJE_NO_COMENTADOS --Realizamos la division y obtenemos el porcentaje del numero de propuestas creadas por el usuario que no han comentado los propios creadores.
FROM T5
) WITH READ ONLY;

-- VISTA FINAL 
CREATE OR REPLACE VIEW CaptainArgana AS( -- Vista final en la que obtenemos los resultados de T6 y los ponemos de forma ordenada.
SELECT subquery.MEMBER, subquery.PORCENTAJE_NO_COMENTADOS 
FROM (SELECT T6.MEMBER, T6.PORCENTAJE_NO_COMENTADOS 
FROM T6 
ORDER BY PORCENTAJE_NO_COMENTADOS DESC) subquery -- Creamos una subquery como solucion a que no permite usar el ORDER BY dentro de una vista.
)WITH READ ONLY;

