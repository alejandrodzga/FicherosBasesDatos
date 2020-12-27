-- INSERCION EN LA TABLA REGISTROS 
INSERT INTO registros(Etype,nombre_usuario,fecha,hora) SELECT etype,client,ev_date,ev_hour FROM FSDB.old_events WHERE etype='registration';

-- INSERCION EN LA TABLA EMAILS
INSERT INTO emails(email) SELECT email FROM FSDB.old_users;

--INSERCION EN LA TABLA DIRECTORES
INSERT INTO directores (nombre_director) SELECT DISTINCT fsdb.old_movies.director_name FROM FSDB.old_movies;

--INSERCION EN LA TABLA ACTORES
INSERT INTO actores (nombre_actor) SELECT DISTINCT fsdb.old_movies.actor_1_name FROM fsdb.old_movies WHERE fsdb.old_movies.actor_1_name is not null;

--INSERCION EN LA TABLA COLORES
INSERT INTO colores (tipo_color) SELECT DISTINCT fsdb.old_movies.color FROM FSDB.old_movies WHERE fsdb.old_movies.color is not null;

--INSERCION EN LA TABLA RELACIONES DE ASPECTO 
INSERT INTO relaciones_aspecto (relacion_aspecto) SELECT DISTINCT fsdb.old_movies.aspect_ratio FROM fsdb.old_movies WHERE fsdb.old_movies.aspect_ratio is not null;

--INSERCION EN LA TABLA CLASIFICACION DE EDADES

INSERT INTO clasificacion_edades (edades) SELECT DISTINCT fsdb.old_movies.content_rating FROM FSDB.old_movies WHERE fsdb.old_movies.content_rating is not null;

--INSERCION EN LA TABLA INFOS IMDB
INSERT INTO infos_imdb (link_web) SELECT DISTINCT fsdb.old_movies.movie_imdb_link FROM fsdb.old_movies WHERE fsdb.old_movies.movie_imdb_link is not null;

--INSERCION EN LA TABLA DE GENEROS
INSERT INTO generos (nombre_genero) SELECT DISTINCT fsdb.old_movies.genre1 FROM FSDB.old_movies WHERE fsdb.old_movies.genre1 is not null;

--INSERCION EN LA TABLA DE IDIOMAS 
INSERT INTO idiomas(nombre_idioma) SELECT DISTINCT fsdb.old_movies.language FROM FSDB.old_movies WHERE fsdb.old_movies.language is not null;

--INSERCION EN LA TABLA DE PAISES
INSERT INTO paises(nombre_pais) SELECT DISTINCT fsdb.old_movies.country FROM fsdb.old_movies WHERE fsdb.old_movies.country is not null;

--INSERCION EN LA TABLA DE LOS TIPOS DE CONTRATOS
INSERT INTO tipos_contrato (contrato_tipo) SELECT DISTINCT fsdb.old_users.contract_type FROM FSDB.old_users WHERE fsdb.old_users.contract_type is not null;

--INSERCION EN LA TABLA DE PELICULAS 
INSERT INTO peliculas(titulo,director) SELECT DISTINCT movie_title,director_name FROM fsdb.old_movies;


--  HASTA AQUI LAS INSERCIONES REALIZADAS FUNCIONAN CORRECTAMENTE SOBRE LAS TABLAS CREADAS CON NEWcreation.sql

-- Las tablas que no aparecen en la insercion es debido a posibles fallos que no se han podido verificar:


--INSERT INTO contratos(contrato_id,movil,contrato_tipo,inicio_contrato,fin_contrato,codigo_postal,direccion,ciudad,pais,DNI) SELECT contractID,phoneN,contract_type,startdate,enddate,ZIPcode,adress,town,country,citizenID FROM FSDB.old_users;
--INSERT INTO fundaciones(Etype,nombre_club,fundador,fecha,hora,eslogan,privacidad) SELECT Etype,club,client,ev_date,ev_hour,subject,details1 FROM FSDB.old_events WHERE etype=‘foundation’;
--INSERT INTO clubes(nombre_club,fundador,fecha,hora,eslogan,privacidad) SELECT club,client,ev_date,ev_hour,subject,details1 FROM FSDB.old_events WHERE etype=‘foundation’;
--INSERT INTO clausuras(Etype,nombre_club,fecha,hora) SELECT etype,club,ev_date,ev_hour FROM FSDB.old_events WHERE etype=‘ceasing’;
--INSERT INTO invitaciones(Etype,emisor,nombre_club,fecha,hora,remitente,mensaje) SELECT etype,client,club,ev_date,ev_hour,subject,message FROM FSDB.old_events WHERE etype=‘invitation’;
--INSERT INTO aceptaciones(Etype,aceptador,nombre_club,fecha,hora,solicitante,mensaje) SELECT etype,client,club,ev_date,ev_hour,subject,message FROM FSDB.old_events WHERE etype=‘acceptance’;
--INSERT INTO rechazos(Etype,denegador,nombre_club,fecha,hora,solicitante,mensaje) SELECT etype,client,club,ev_date,ev_hour,subject,message FROM FSDB.old_events WHERE etype=‘rejection’;
--INSERT INTO proposiciones(Etype,usuario_propone,nombre_club,fecha,hora,propuesta,titulo_pelicula,director) SELECT etype,client,club,ev_date,ev_hour,subject,details1,details2 FROM FSDB.old_events WHERE etype=‘proposal’;
--INSERT INTO opiniones(Etype,usuario,nombre_club,fecha,hora,asunto,mensaje,titulo_pelicula,director) SELECT etype,client,club,ev_date,ev_hour,subject,message,details1,details2 FROM FSDB.old_events WHERE etype=‘opinion’;
--INSERT INTO opinionesxx(Etype,usuario,nombre_club,fecha,hora,asunto,mensaje,titulo_pelicula,director) SELECT etype,client,club,ev_date,ev_hour,subject,message,details1,details2 FROM FSDB.old_events WHERE etype=‘opinion:XX’;
--INSERT INTO privacidades(nombre_club,fundador,fecha_fundacion,hora_fundacion,eslogan,privacidad) SELECT club,client,ev_date,ev_hour,subject,details1 FROM FSDB.old_events WHERE etype=‘foundation’;
--INSERT INTO clubes_historicos(nombre_club,fundador,fecha_fundacion,hora_fundacion,eslogan,privacidad) SELECT club,client,ev_date,ev_hour,subject,details1 FROM FSDB.old_events WHERE etype=‘foundation’;
--INSERT INTO solicitudes(Etype,solicitante,nombre_club,fecha,hora,frase,privacidad) SELECT etype,client,club,ev_date,ev_hour,subject,details1 FROM FSDB.old_events WHERE etype=‘application’;

