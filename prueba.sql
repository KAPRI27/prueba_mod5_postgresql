PRUEBA MODULO 5

//PARA ACCEDER A POSTGRESQL
sudo -u postgres psql

CREATE DATABASE prueba_mod5_pmaureira725;

\c prueba_mod5_pmaureira725;



1. Crea el modelo (revisa bien cuál es el tipo de relación antes de crearlo), respeta las claves primarias, foráneas y tipos de datos.(1 punto)
CREATE TABLE peliculas (peliculas_id SERIAL PRIMARY KEY, nombre VARCHAR(255), estreno INTEGER);
CREATE TABLE tags (tags_id SERIAL PRIMARY KEY, tag VARCHAR(50));
CREATE TABLE peliculas_tags (peliculas_id INTEGER, tags_id INTEGER,
    FOREIGN KEY (peliculas_id) REFERENCES peliculas(peliculas_id),
    FOREIGN KEY (tags_id) REFERENCES tags(tags_id),
    PRIMARY KEY (peliculas_id, tags_id)
);

2.1 Inserta 5 películas y 5 tags, 

INSERT INTO peliculas (nombre, estreno) VALUES ('Iron Man' , 2008);
INSERT INTO peliculas (nombre, estreno) VALUES ('El increible Hulk', 2008);
INSERT INTO peliculas (nombre, estreno) VALUES ('Iron Man 2', 2010);
INSERT INTO peliculas (nombre, estreno) VALUES ('Thor', 2011);
INSERT INTO peliculas (nombre, estreno) VALUES ('Capitán América: El primer vengador', 2011);
INSERT INTO tags (tag) VALUES ('Superheroes');
INSERT INTO tags (tag) VALUES ('Universo Marvel');
INSERT INTO tags (tag) VALUES ('Acción y Aventuras');
INSERT INTO tags (tag) VALUES ('Avengers');
INSERT INTO tags (tag) VALUES ('Comedia');

2.1 la primera película tiene que tener 3 tags asociados, la segunda película debe tener dos tags asociados.(1 punto)
INSERT INTO peliculas_tags (peliculas_id, tags_id) VALUES (1, 1);                        
INSERT INTO peliculas_tags (peliculas_id, tags_id) VALUES (1, 2);
INSERT INTO peliculas_tags (peliculas_id, tags_id) VALUES (1, 3);
INSERT INTO peliculas_tags (peliculas_id, tags_id) VALUES (2, 1);
INSERT INTO peliculas_tags (peliculas_id, tags_id) VALUES (2, 2);


3. Cuenta la cantidad de tags que tiene cada película. Si una película no tiene tags debe mostrar 0.(1 punto)

SELECT peliculas.peliculas_id, peliculas.nombre, 
COUNT(peliculas_tags.tags_id) AS cantidad_tags 
FROM peliculas LEFT JOIN peliculas_tags ON peliculas.peliculas_id = peliculas_tags.peliculas_id 
GROUP BY peliculas.peliculas_id, peliculas.nombre;

//FIN PRIMERA PARTE 


4). Crea las tablas respetando los nombres, tipos, claves primarias y foráneas y tipos de datos. (1 punto)

CREATE TABLE preguntas (id SERIAL PRIMARY KEY, pregunta VARCHAR(255) NOT NULL, respuesta_correcta VARCHAR(255) NOT NULL);
CREATE TABLE usuarios (id SERIAL PRIMARY KEY, nombre VARCHAR(255) NOT NULL, edad INTEGER);
CREATE TABLE respuestas (id SERIAL PRIMARY KEY, pregunta_id INTEGER REFERENCES preguntas(id), usuario_id INTEGER REFERENCES usuarios(id), respuesta VARCHAR(255) NOT NULL);

5). Agrega 5 usuarios y 5 preguntas: 
    la 1ra pregunta debe estar contestada correctamente 2 veces por distintos usuarios
    la 2da pregunta debe estar contestada correctamente SOLO por 1 usuario
    las otras 2 respuestas deben ser incorrectas.


INSERT INTO usuarios (nombre, edad) VALUES ('Antonia', 30);
INSERT INTO usuarios (nombre, edad) VALUES ('Iñaki', 35);
INSERT INTO usuarios (nombre, edad) VALUES ('César', 37);
INSERT INTO usuarios (nombre, edad) VALUES ('Daniela', 22);
INSERT INTO usuarios (nombre, edad) VALUES ('Pablo', 24);
INSERT INTO preguntas (pregunta, respuesta_correcta) VALUES ('tijera le gana a ...?', 'papel');
INSERT INTO preguntas (pregunta, respuesta_correcta) VALUES ('papel le gana a ...?', 'piedra');
INSERT INTO preguntas (pregunta, respuesta_correcta) VALUES ('piedra le gana a ...?', 'lagarto');
INSERT INTO preguntas (pregunta, respuesta_correcta) VALUES ('lagarto le gana a ...?', 'spock');
INSERT INTO preguntas (pregunta, respuesta_correcta) VALUES ('spock le gana a ...?', 'tijera');
INSERT INTO respuestas (pregunta_id , usuario_id, respuesta) VALUES (1, 1, 'papel');
INSERT INTO respuestas (pregunta_id , usuario_id, respuesta) VALUES (1, 2, 'papel');
INSERT INTO respuestas (pregunta_id , usuario_id, respuesta) VALUES (2, 3, 'piedra');
INSERT INTO respuestas (pregunta_id , usuario_id, respuesta) VALUES (4, 1, '¿qué?');
INSERT INTO respuestas (pregunta_id , usuario_id, respuesta) VALUES (5, 2, '¿spock qué?');


6). Cuenta la cantidad de respuestas correctas totales por usuario (independiente de la pregunta). (1 punto)

SELECT usuarios.id AS usuario_id, usuarios.nombre AS nombre_usuario, 
COUNT(respuestas.id) AS respuestas_correctas_totales FROM usuarios 
LEFT JOIN respuestas ON usuarios.id = respuestas.usuario_id 
LEFT JOIN preguntas ON respuestas.pregunta_id = preguntas.id
WHERE respuestas.respuesta = preguntas.respuesta_correcta
GROUP BY usuarios.id, usuarios.nombre;

7). Por cada pregunta, en la tabla preguntas, cuenta cuántos usuarios tuvieron la respuesta correcta. (1 punto)

SELECT preguntas.id AS pregunta_id, preguntas.pregunta,
COUNT(respuestas.usuario_id) AS usuarios_con_respuesta_correcta
FROM preguntas
LEFT JOIN respuestas ON preguntas.id = respuestas.pregunta_id
LEFT JOIN usuarios ON respuestas.usuario_id = usuarios.id
WHERE respuestas.respuesta = preguntas.respuesta_correcta
GROUP BY preguntas.id, preguntas.pregunta;

8). Implementa borrado en cascada de las respuestas al borrar un usuario y borrar el primer usuario para probar la implementación. (1 punto)

//AGREGAMOS DELETE ON CASCADE a la tabla 'respuestas' para que cuando borremos una fila de la tabla 'respuestas', se borrarán en cascada las filas correspondientes que coincidan con el id del usuario
ALTER TABLE respuestas ADD CONSTRAINT fk_usuario_id FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE CASCADE;

//Eliminar respuestas asociadas al usuario con id 1
DELETE FROM respuestas WHERE usuario_id = 1;

//Borramos el usuario con id=1
DELETE FROM usuarios WHERE id = 1;

9).  AGREGA una restricción que impida insertar usuarios menores de 18 años en la base de datos. (1 punto)
ALTER TABLE usuarios ADD CONSTRAINT edad_mayor_o_igual_a_18 CHECK (edad >= 18);

10). Altera la tabla existente de usuarios agregando el campo email con la restricción de único. (1 punto)
ALTER TABLE usuarios ADD COLUMN email VARCHAR(255) UNIQUE;
