-- CONSULTA a TRAGICOMIC 

WITH T1 AS(  -- Aqui obtenemos las peliculas cque pertenecen al genero comedia 
SELECT * FROM genres_movies
WHERE genre='Comedy'
),
 T2 AS(  -- Aqui obtenemos las peliculas cque pertenecen al genero drama
SELECT * 
FROM genres_movies
WHERE genre='Drama'
),  
T3 AS(-- Resultado de las peliculas que pertenecen a los generos de comedia y drama 
SELECT T1.TITLE,T1.DIRECTOR
FROM T1 INNER JOIN T2
    ON T1.title = T2.title AND T1.director = T2.director
),
T4 AS( --Aqui obtenemos los actores que pertenecen a las peliculas obtenidas en las consultas anteriores, no se especifica en ningun campo la distinccion de protagonista por lo que sacamos los actores
SELECT *
FROM CASTS INNER JOIN T3 
    ON casts.title = T3.title AND casts.director = T3.director
)
SELECT DISTINCT ACTOR FROM T4; -- Sacamos solamente el campo de los nombres de los actores que cumplen con la condicion


--obtiene un total de 1.400 filas *** realizar pruebas seleccionando diferentes actores


