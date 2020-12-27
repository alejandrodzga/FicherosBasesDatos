DROP TABLE registros CASCADE CONSTRAINT;
DROP TABLE emails CASCADE CONSTRAINT;
DROP TABLE directores CASCADE CONSTRAINT;
DROP TABLE actores CASCADE CONSTRAINT;
DROP TABLE colores CASCADE CONSTRAINT;
DROP TABLE relaciones_aspecto CASCADE CONSTRAINT;
DROP TABLE clasificacion_edades CASCADE CONSTRAINT;
DROP TABLE infos_imdb CASCADE CONSTRAINT;
DROP TABLE generos CASCADE CONSTRAINT;
DROP TABLE idiomas CASCADE CONSTRAINT;
DROP TABLE paises CASCADE CONSTRAINT;
DROP TABLE tipos_contrato CASCADE CONSTRAINT;
DROP TABLE peliculas CASCADE CONSTRAINT;
DROP TABLE numeros_telefono CASCADE CONSTRAINT;
DROP TABLE contratos CASCADE CONSTRAINT;
DROP TABLE perfiles CASCADE CONSTRAINT;
DROP TABLE fundaciones CASCADE CONSTRAINT;
DROP TABLE clubes CASCADE CONSTRAINT;
DROP TABLE usuarios CASCADE CONSTRAINT;
DROP TABLE clausuras CASCADE CONSTRAINT;
DROP TABLE invitaciones CASCADE CONSTRAINT;
DROP TABLE aceptaciones CASCADE CONSTRAINT;
DROP TABLE rechazos CASCADE CONSTRAINT;
DROP TABLE visualizaciones CASCADE CONSTRAINT;
DROP TABLE proposiciones CASCADE CONSTRAINT;
DROP TABLE opiniones CASCADE CONSTRAINT;
DROP TABLE opinionesxx CASCADE CONSTRAINT;
DROP TABLE privacidades CASCADE CONSTRAINT;
DROP TABLE clubes_historicos CASCADE CONSTRAINT;
DROP TABLE solicitudes CASCADE CONSTRAINT;


CREATE TABLE registros(
    Etype VARCHAR(12) NOT NULL,
    Nombre_Usuario VARCHAR(100),
    fecha VARCHAR(10) NOT NULL,
    hora VARCHAR(5) NOT NULL,
    CONSTRAINT PK_registros PRIMARY KEY(Nombre_Usuario)
);

CREATE TABLE emails(    -- creamos emails unicos 
    email VARCHAR2(100),
    CONSTRAINT PK_emails PRIMARY KEY (email)
);

CREATE TABLE directores(
    nombre_director VARCHAR2(100),
    facebook_likes VARCHAR2(100),
    CONSTRAINT PK_directores PRIMARY KEY(nombre_director)
);

CREATE TABLE actores(
    nombre_actor VARCHAR2(100),
    facebook_likes_protagonistas VARCHAR2(100),
    CONSTRAINT PK_actores PRIMARY KEY(nombre_actor)
);

CREATE TABLE colores(
    tipo_color VARCHAR2(100),
    CONSTRAINT PK_colores PRIMARY KEY(tipo_color)
);

CREATE TABLE relaciones_aspecto(
    relacion_aspecto VARCHAR2(100),
    CONSTRAINT PK_relaciones_aspecto PRIMARY KEY(relacion_aspecto)
);

CREATE TABLE clasificacion_edades(
    edades VARCHAR2(100),
    CONSTRAINT PK_clasificacion_edades PRIMARY KEY(edades)
);

CREATE TABLE infos_imdb(
    link_web VARCHAR2(100),
    puntuacion VARCHAR2(100),
    cantidad_criticos VARCHAR(100),
    CONSTRAINT PK_infos_imdb PRIMARY KEY(link_web)
);

CREATE TABLE generos(
    nombre_genero VARCHAR2(30),
    CONSTRAINT PK_generos PRIMARY KEY(nombre_genero)
);

CREATE TABLE idiomas(
    nombre_idioma VARCHAR2(100),
    CONSTRAINT PK_idiomas PRIMARY KEY(nombre_idioma)
);

CREATE TABLE paises(
    nombre_pais VARCHAR2(100),
    CONSTRAINT PK_paises PRIMARY KEY(nombre_pais)
);

CREATE TABLE tipos_contrato(
    contrato_tipo VARCHAR2(50),
    CONSTRAINT PK_tipos_contrato PRIMARY KEY(contrato_tipo)
);

CREATE TABLE peliculas(
    titulo VARCHAR2(100),
    director VARCHAR2(100),  
    actor1_nombre VARCHAR2(100),
    actor2_nombre VARCHAR2(100),
    actor3_nombre VARCHAR2(100),
    duracion VARCHAR2(100),  
    color VARCHAR2(100),
    relacion_aspecto VARCHAR2(100),
    ano_estreno VARCHAR2(100),
    clasificacion_edad VARCHAR2(100),
    pais_produccion VARCHAR2(100),
    idioma_vo VARCHAR2(100),
    presupuesto VARCHAR2(100),
    ingresos VARCHAR2(100),
    link_web_imdb VARCHAR2(100),
    numero_rostros_poster VARCHAR2(100),
    facebook_likes_reparto VARCHAR2(100),
    facebook_likes_pelicula VARCHAR2(100),
    keyword1 VARCHAR2(50),
    keyword2 VARCHAR2(50),
    keyword3 VARCHAR2(50),
    keyword4 VARCHAR2(50),
    keyword5 VARCHAR2(50),
    genero1 VARCHAR2(30),
    genero2 VARCHAR2(30),
    genero3 VARCHAR2(30),
    genero4 VARCHAR2(30),
    genero5 VARCHAR2(30),
    CONSTRAINT PK_peliculas PRIMARY KEY(titulo,director),
    CONSTRAINT FK_peliculas1 FOREIGN KEY(director) REFERENCES directores ON DELETE CASCADE,-- ON UPDATE CASCADE,
    CONSTRAINT FK_peliculas10 FOREIGN KEY(actor1_nombre) REFERENCES actores ON DELETE SET NULL, --ON UPDATE CASCADE,
    CONSTRAINT FK_peliculas11 FOREIGN KEY(actor2_nombre) REFERENCES actores ON DELETE SET NULL, --ON UPDATE CASCADE,
    CONSTRAINT FK_peliculas12 FOREIGN KEY(actor3_nombre) REFERENCES actores ON DELETE SET NULL, --ON UPDATE CASCADE,
    CONSTRAINT FK_peliculas3 FOREIGN KEY(color) REFERENCES colores ON DELETE SET NULL, --ON UPDATE CASCADE,
    CONSTRAINT FK_peliculas4 FOREIGN KEY(relacion_aspecto) REFERENCES relaciones_aspecto ON DELETE SET NULL, --ON UPDATE CASCADE 
    CONSTRAINT FK_peliculas5 FOREIGN KEY(clasificacion_edad) REFERENCES clasificacion_edades ON DELETE SET NULL, --ON UPDATE CASCADE,
    CONSTRAINT FK_peliculas6 FOREIGN KEY(pais_produccion) REFERENCES paises ON DELETE SET NULL, --ON UPDATE CASCADE,
    CONSTRAINT FK_peliculas7 FOREIGN KEY(idioma_vo) REFERENCES idiomas ON DELETE SET NULL, --ON UPDATE CASCADE,
    CONSTRAINT FK_peliculas8 FOREIGN KEY(link_web_imdb) REFERENCES infos_imdb ON DELETE SET NULL, --ON UPDATE CASCADE,
    CONSTRAINT FK_peliculas9 FOREIGN KEY(genero1) REFERENCES generos ON DELETE SET NULL,--ON UPDATE CASCADE 
    CONSTRAINT FK_peliculas13 FOREIGN KEY(genero2) REFERENCES generos ON DELETE SET NULL, --ON UPDATE CASCADE 
    CONSTRAINT FK_peliculas14 FOREIGN KEY(genero3) REFERENCES generos ON DELETE SET NULL, --ON UPDATE CASCADE 
    CONSTRAINT FK_peliculas15 FOREIGN KEY(genero4) REFERENCES generos ON DELETE SET NULL, --ON UPDATE CASCADE 
    CONSTRAINT FK_peliculas16 FOREIGN KEY(genero5) REFERENCES generos ON DELETE SET NULL --ON UPDATE CASCADE 
);  

CREATE TABLE numeros_telefono(
    numero_telefono VARCHAR2(14),
    CONSTRAINT PK_numeros_telefono PRIMARY KEY(numero_telefono)
);

CREATE TABLE perfiles(
    DNI VARCHAR2(9), -- citizenID en la tabla antigua 
    nombre_pila VARCHAR2(100),
    telefono VARCHAR2(14),   -- SI ES CONTRATO DE PAGO ES OBLIGATORIO!!!
    apellido1 VARCHAR2(100),
    apellido2 VARCHAR2(100),
    edad NUMBER(3),
    fecha_nacimiento VARCHAR2(10),
    CONSTRAINT PK_perfiles PRIMARY KEY(DNI),
    CONSTRAINT FK_perfiles1 FOREIGN KEY(telefono) REFERENCES numeros_telefono ON DELETE SET NULL --ON UPDATE CASCADE 
);

CREATE TABLE contratos(
    contrato_id VARCHAR2(16),
    movil VARCHAR2(14) NOT NULL,
    contrato_tipo VARCHAR2(50),
    inicio_contrato VARCHAR2(10) NOT NULL,
    fin_contrato VARCHAR2(10),
    codigo_postal VARCHAR2(10),
    direccion VARCHAR2(100),
    ciudad VARCHAR2(100),
    pais VARCHAR2(100),
    DNI VARCHAR2(9),
    CONSTRAINT PK_contratos PRIMARY KEY(contrato_id),
    CONSTRAINT FK_contratos1 FOREIGN KEY(movil) REFERENCES numeros_telefono ON DELETE CASCADE, --ON UPDATE CASCADE, 
    CONSTRAINT FK_contratos2 FOREIGN KEY(contrato_tipo) REFERENCES tipos_contrato ON DELETE SET NULL,-- ON UPDATE CASCADE,
    CONSTRAINT FK_contratos3 FOREIGN KEY(pais) REFERENCES paises ON DELETE SET NULL, --ON UPDATE CASCADE,
    CONSTRAINT FK_contratos4 FOREIGN KEY(DNI) REFERENCES perfiles ON DELETE CASCADE --ON UPDATE RESTRICT 
);


CREATE TABLE fundaciones(
    Etype VARCHAR2(12),
    nombre_club VARCHAR2(60),
    fundador VARCHAR2(100),
    fecha VARCHAR2(10) NOT NULL,
    hora VARCHAR2(5) NOT NULL,
    eslogan VARCHAR2(100),
    privacidad VARCHAR2(99),
    CONSTRAINT PK_fundaciones PRIMARY KEY(fundador,nombre_club,fecha,hora,eslogan,privacidad),
    CONSTRAINT FK_fundaciones1 FOREIGN KEY(fundador) REFERENCES registros ON DELETE CASCADE --ON UPDATE RESTRICT 
);

CREATE TABLE clubes(
    nombre_club VARCHAR2(60),
    fundador VARCHAR2(100),
    fecha VARCHAR2(10) NOT NULL,
    hora VARCHAR2(5) NOT NULL,
    eslogan VARCHAR2(100),
    privacidad VARCHAR2(99),
    CONSTRAINT PK_clubes PRIMARY KEY(nombre_club),
    CONSTRAINT FK_clubes1 FOREIGN KEY(nombre_club,fundador,fecha,hora,eslogan,privacidad) REFERENCES fundaciones (nombre_club,fundador,fecha,hora,eslogan,privacidad)-- ON UPDATE CASCADE
   
);

CREATE TABLE usuarios(
    nombre_usuario VARCHAR2(100), 
    password VARCHAR2(100) NOT NULL,               -- restringir con minimo 8 caracteres 
    nombre_club VARCHAR2(60),
    email VARCHAR2(100) NOT NULL,              -- se conecta con la tabla emails
    DNI VARCHAR2(9), -- OJO ESTO ES OPCIONAL PORQUE PUEDE QUE NO TENGA UN PERFIL CREADO EL USUARIO
    CONSTRAINT PK_usuarios PRIMARY KEY(nombre_usuario),
    CONSTRAINT FK_usuarios1 FOREIGN KEY(nombre_club) REFERENCES clubes ON DELETE SET NULL,-- ON UPDATE CASCADE, 
    CONSTRAINT FK_usuarios2 FOREIGN KEY(email) REFERENCES emails ON DELETE SET NULL, --ON UPDATE CASCADE 
    CONSTRAINT FK_usuarios3 FOREIGN KEY(DNI) REFERENCES perfiles ON DELETE CASCADE, --ON UPDATE CASCADE 
    CONSTRAINT pass_valida CHECK (password>8) -- para restringir usamos check 
);

CREATE TABLE clausuras(
    Etype VARCHAR2(12),
    nombre_club VARCHAR2(60),
    fecha VARCHAR2(10) NOT NULL,
    hora VARCHAR2(5) NOT NULL,
    CONSTRAINT PK_clausuras PRIMARY KEY(Etype,nombre_club,fecha,hora),
    CONSTRAINT FK_clausuras FOREIGN KEY(nombre_club) REFERENCES clubes ON DELETE CASCADE --ON UPDATE CASCADE 
);



CREATE TABLE invitaciones(
    Etype VARCHAR2(12),
    emisor VARCHAR2(100),
    nombre_club VARCHAR2(60),
    fecha VARCHAR2(10) NOT NULL,
    hora VARCHAR2(5) NOT NULL,
    remitente VARCHAR2(100),
    mensaje VARCHAR2(1500),
    CONSTRAINT PK_invitaciones PRIMARY KEY(Etype,nombre_club,fecha,hora),
    CONSTRAINT FK_invitaciones1 FOREIGN KEY(nombre_club) REFERENCES clubes ON DELETE CASCADE, --ON UPDATE CASCADE,
    CONSTRAINT FK_invitaciones2 FOREIGN KEY(emisor) REFERENCES usuarios ON DELETE CASCADE, --ON UPDATE RESTRICT 
    CONSTRAINT FK_invitaciones3 FOREIGN KEY(remitente) REFERENCES usuarios ON DELETE CASCADE --ON UPDATE RESTRICT 
);



CREATE TABLE aceptaciones(
    Etype VARCHAR2(12),
    aceptador VARCHAR2(100),
    nombre_club VARCHAR2(60),
    fecha VARCHAR2(10) NOT NULL,
    hora VARCHAR2(5) NOT NULL,
    solicitante VARCHAR2(100),
    mensaje VARCHAR2(1500),
    CONSTRAINT PK_aceptaciones PRIMARY KEY(Etype,nombre_club,fecha,hora),
    CONSTRAINT FK_aceptaciones1 FOREIGN KEY(nombre_club) REFERENCES clubes ON DELETE CASCADE, --ON UPDATE CASCADE,
    CONSTRAINT FK_aceptaciones2 FOREIGN KEY(aceptador) REFERENCES usuarios ON DELETE CASCADE, --ON UPDATE RESTRICT 
    CONSTRAINT FK_aceptaciones3 FOREIGN KEY(solicitante) REFERENCES usuarios ON DELETE CASCADE --ON UPDATE RESTRICT 
);



CREATE TABLE rechazos(
    Etype VARCHAR2(12),
    denegador VARCHAR2(100),
    nombre_club VARCHAR2(60),
    fecha VARCHAR2(10) NOT NULL,
    hora VARCHAR2(5) NOT NULL,
    solicitante VARCHAR2(100),
    mensaje VARCHAR2(1500),
    CONSTRAINT PK_rechazos PRIMARY KEY(Etype,nombre_club,fecha,hora),
    CONSTRAINT FK_rechazos1 FOREIGN KEY(nombre_club) REFERENCES clubes ON DELETE CASCADE, --ON UPDATE CASCADE,
    CONSTRAINT FK_rechazos2 FOREIGN KEY(denegador) REFERENCES usuarios ON DELETE CASCADE, --ON UPDATE RESTRICT 
    CONSTRAINT FK_rechazos3 FOREIGN KEY(solicitante) REFERENCES usuarios ON DELETE CASCADE --ON UPDATE RESTRICT 
);



CREATE TABLE visualizaciones(
    Etype VARCHAR2(12),
    usuario_propone VARCHAR2(100),
    nombre_club VARCHAR2(60),
    fecha VARCHAR2(10) NOT NULL,
    hora VARCHAR2(5) NOT NULL,
    titulo_pelicula VARCHAR2(100),
    director VARCHAR2(100),
    contrato_id VARCHAR2(16),
    CONSTRAINT PK_visualizaciones PRIMARY KEY(Etype,nombre_club,fecha,hora),
    CONSTRAINT FK_visualizaciones1 FOREIGN KEY(nombre_club) REFERENCES clubes ON DELETE CASCADE, --ON UPDATE CASCADE 
    CONSTRAINT FK_visualizaciones2 FOREIGN KEY(usuario_propone) REFERENCES usuarios ON DELETE CASCADE, --ON UPDATE RESTRICT,
    CONSTRAINT FK_visualizaciones3 FOREIGN KEY(titulo_pelicula,director) REFERENCES peliculas(titulo,director), --ON DELETE RESTRICT --ON UPDATE RESTRICT
    CONSTRAINT FK_visualizaciones4 FOREIGN KEY (contrato_id) REFERENCES contratos (contrato_id) ,
    CONSTRAINT correcto_contrato CHECK (contrato_id IS NOT NULL) -- para verificar que las visualizaciones se realizan con contrato 
);

--FUNCIONANDO SI SE COMENTA EL RESTRICT 

CREATE TABLE proposiciones(
    Etype VARCHAR2(12),
    usuario_propone VARCHAR2(100),
    nombre_club VARCHAR2(60),
    fecha VARCHAR2(10) NOT NULL,
    hora VARCHAR2(5) NOT NULL,
    propuesta VARCHAR2(100),
    mensaje VARCHAR2(1500),
    titulo_pelicula VARCHAR2(100),
    director VARCHAR2(100),
    CONSTRAINT PK_proposiciones PRIMARY KEY(Etype,nombre_club,fecha,hora),
    CONSTRAINT FK_proposiciones1 FOREIGN KEY(nombre_club) REFERENCES clubes ON DELETE CASCADE, --ON UPDATE CASCADE,
    CONSTRAINT FK_proposiciones2 FOREIGN KEY(usuario_propone) REFERENCES usuarios ON DELETE CASCADE, --ON UPDATE RESTRICT,
    CONSTRAINT FK_proposiciones3 FOREIGN KEY(titulo_pelicula,director) REFERENCES peliculas(titulo,director)  --ON UPDATE RESTRICT 
);

--FUNCIONANDO SI SE COMENTA EL RESTRICT 


CREATE TABLE opiniones(
    Etype VARCHAR2(12),
    usuario VARCHAR2(100),
    nombre_club VARCHAR2(60),
    fecha VARCHAR2(10) NOT NULL,
    hora VARCHAR2(5) NOT NULL,
    asunto VARCHAR2(100),
    mensaje VARCHAR2(1500),
    titulo_pelicula VARCHAR2(100),
    director VARCHAR2(100),
    CONSTRAINT PK_opiniones PRIMARY KEY(Etype,nombre_club,fecha,hora),
    CONSTRAINT FK_opiniones1 FOREIGN KEY(nombre_club) REFERENCES clubes ON DELETE CASCADE, --ON UPDATE CASCADE 
    CONSTRAINT FK_opiniones2 FOREIGN KEY(usuario) REFERENCES usuarios ON DELETE CASCADE, --ON UPDATE RESTRICT,
    CONSTRAINT FK_opiniones3 FOREIGN KEY(titulo_pelicula,director) REFERENCES peliculas(titulo,director)  --ON UPDATE RESTRICT 
);

CREATE TABLE opinionesxx(
    Etype VARCHAR2(12),
    usuario VARCHAR2(100),
    nombre_club VARCHAR2(60),
    fecha VARCHAR2(10) NOT NULL,
    hora VARCHAR2(5) NOT NULL,
    asunto VARCHAR2(100),
    mensaje VARCHAR2(1500),
    titulo_pelicula VARCHAR2(100),
    director VARCHAR2(100),
    CONSTRAINT PK_opinionesxx PRIMARY KEY(Etype,nombre_club,fecha,hora),
    CONSTRAINT FK_opiniones1xx FOREIGN KEY(nombre_club) REFERENCES clubes ON DELETE CASCADE, --ON UPDATE CASCADE,
    CONSTRAINT FK_opiniones2xx FOREIGN KEY(usuario) REFERENCES usuarios ON DELETE CASCADE,-- ON UPDATE RESTRICT,
    CONSTRAINT FK_opiniones3xx FOREIGN KEY(titulo_pelicula,director) REFERENCES peliculas(titulo,director) --ON UPDATE RESTRICT 
);

-- FUNCIONANDO HASTA AQUI COMENTANDO LOS RESTRICT 

CREATE TABLE privacidades(
    nombre_club VARCHAR2(60),
    fundador VARCHAR2(100),
    fecha_fundacion VARCHAR2(10)NOT NULL,
    hora_fundacion VARCHAR2(5) NOT NULL, 
    eslogan VARCHAR2(100),
    privacidad VARCHAR2(99),
    CONSTRAINT PK_privacidades PRIMARY KEY(nombre_club,privacidad),
    CONSTRAINT FK_privacidades1 FOREIGN KEY(nombre_club,fundador,fecha_fundacion,hora_fundacion,eslogan,privacidad) REFERENCES fundaciones (nombre_club,fundador,fecha,hora,eslogan,privacidad),-- ON DELETE NO ACTION, -- ON UPDATE CASCADE 
    -- CHECK PRIVACIDAD='ABIERTA' EN ESTA TABLA SOLO ESTAN LOS CLUBES CON LA PRIVACIDAD ABIERTA
    CONSTRAINT privacidad_abierta CHECK(privacidad='Open')
);

-- FUNCIONANDO

CREATE TABLE clubes_historicos(
    nombre_club VARCHAR2(60),
    fundador VARCHAR2(100),
    fecha_fundacion VARCHAR2(10)NOT NULL,
    hora_fundacion VARCHAR2(5) NOT NULL, 
    eslogan VARCHAR2(100),
    privacidad VARCHAR2(99),
    CONSTRAINT PK_clubes_historicos PRIMARY KEY(nombre_club),                                                                                                                                           
    CONSTRAINT FK_clubes_historicos1 FOREIGN KEY(nombre_club,fundador,fecha_fundacion,hora_fundacion,eslogan,privacidad) REFERENCES fundaciones (nombre_club,fundador,fecha,hora,eslogan,privacidad) -- por defecto oracle usa el no action... ON DELETE NO ACTION --ON UPDATE CASCADE 
);

CREATE TABLE solicitudes(
    Etype VARCHAR2(12),
    solicitante VARCHAR2(100),
    nombre_club VARCHAR2(60),
    fecha VARCHAR2(10),
    hora VARCHAR2(5),
    frase VARCHAR2(100),
    privacidad VARCHAR2(99),
    CONSTRAINT PK_solicitudes PRIMARY KEY(solicitante,nombre_club,fecha,hora),
    CONSTRAINT FK_solicitudes1 FOREIGN KEY(solicitante) REFERENCES usuarios(nombre_usuario) ON DELETE CASCADE,--ON UPDATE RESTRICT,
    CONSTRAINT FK_solicitudes2 FOREIGN KEY(nombre_club,privacidad) REFERENCES privacidades ON DELETE CASCADE -- ON UPDATE CASCADE 
);

-- HASTA AQUI YA SE CREAN TODAS LAS TABLAS 

-- TODO COLOCAR LAS RESTRICCIONES NECESARIAS A LAS FK Y LOS POSIBLES CHECKS

--TODO REVISAR LA COHERENCIA DEL MODELO CON LAS TABLAS QUE ESTAN CREADAS Y VER POSIBLES FALLAS CON EL ENUNCIADO 




--CONSTRAINT FK_peliculas1 FOREIGN KEY(director) REFERENCES directores,-- ON DELETE CASCADE,-- ON UPDATE CASCADE,


--ALTER TABLE peliculas 
  --ADD CONSTRAINT fk_peliculas1 
  --FOREIGN KEY (director) 
  --REFERENCES directores (nombre_director) 
  --ON DELETE CASCADE ON UPDATE CASCADE;