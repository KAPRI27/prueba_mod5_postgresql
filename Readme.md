//PARA ACCEDER A POSTGRESQL
sudo -u postgres psql

REQUERIMIENTOS A RESOLVER

//1).Crea el modelo (revisa bien cuál es el tipo de relación antes de crearlo), respeta las claves primarias, foráneas y tipos de datos.(1 punto)**

//Crear tabla 'peliculas'
CREATE TABLE peliculas (peliculas_id SERIAL PRIMARY KEY, nombre VARCHAR(255), estreno INTEGER);

//Crear tabla 'tags'
CREATE TABLE tags (tags_id SERIAL PRIMARY KEY, tag VARCHAR(50));

//Crear tabla intermedia llamada 'peliculas_tags'
CREATE TABLE peliculas_tags (peliculas_id INTEGER, tags_id INTEGER,
    FOREIGN KEY (peliculas_id) REFERENCES peliculas(peliculas_id),
    FOREIGN KEY (tags_id) REFERENCES tags(tags_id),
    PRIMARY KEY (peliculas_id, tags_id)
);

//2.1) Inserta 5 películas y 5 tags, 


//INSERTA 5 PELICULAS A LA TABLA peliculas

INSERT INTO peliculas (nombre, estreno) VALUES ('Iron Man' , 2008);
INSERT INTO peliculas (nombre, estreno) VALUES ('El increible Hulk', 2008);
INSERT INTO peliculas (nombre, estreno) VALUES ('Iron Man 2', 2010);
INSERT INTO peliculas (nombre, estreno) VALUES ('Thor', 2011);
INSERT INTO peliculas (nombre, estreno) VALUES ('Capitán América: El primer vengador', 2011);


probando_paralaprueba=# SELECT * FROM peliculas;
 peliculas_id |               nombre                | estreno 
--------------+-------------------------------------+---------
            1 | Iron Man                            |    2008
            2 | Iron Man 2                          |    2010
            3 | Thor                                |    2011
            4 | Capitán América: El primer vengador |    2011
            5 | El increible Hulk                   |    2008
(5 rows)


//INSERTA 5 tags EN LA TABLA tags
INSERT INTO tags (tag) VALUES ('Superheroes');
INSERT INTO tags (tag) VALUES ('Universo Marvel');
INSERT INTO tags (tag) VALUES ('Acción y Aventuras');
INSERT INTO tags (tag) VALUES ('Avengers');
INSERT INTO tags (tag) VALUES ('Comedia');

//REVISANDO COMO QUEDO LA TABLA tags
SELECT * FROM tags;
 tags_id |        tag         
---------+--------------------
       1 | Superheroes
       2 | Universo Marvel
       3 | Acción y Aventuras
       4 | Avengers
       5 | Comedia
(5 rows)

/*
//ASIGNAMOS a LOS peliculas_id EL ID DE LOS TAGS USANDO tags_id 
INSERT INTO peliculas_tags (peliculas_id, tags_id) VALUES (1, 1); //Iron Man, Superheroes
INSERT INTO peliculas_tags (peliculas_id, tags_id) VALUES (1, 2); //Iron Man, Universo Marvel
INSERT INTO peliculas_tags (peliculas_id, tags_id) VALUES (1, 3); //Iron Man, Acción y aventuras
INSERT INTO peliculas_tags (peliculas_id, tags_id) VALUES (2, 1); //Iron Man 2, Superheroes
INSERT INTO peliculas_tags (peliculas_id, tags_id) VALUES (2, 2); //Iron Man 2, Universo Marvel
*/

//2.2) la primera película tiene que tener 3 tags asociados, la segunda película debe tener dos tags asociados. (1 punto)

//INSERTAR TAGS A LAS PELICULAS (3 tags en la primera pelicula y 2 tags en la segunda pelicula)
INSERT INTO peliculas_tags (peliculas_id, tags_id) VALUES (1, 1);                        
INSERT INTO peliculas_tags (peliculas_id, tags_id) VALUES (1, 2);
INSERT INTO peliculas_tags (peliculas_id, tags_id) VALUES (1, 3);
INSERT INTO peliculas_tags (peliculas_id, tags_id) VALUES (2, 1);
INSERT INTO peliculas_tags (peliculas_id, tags_id) VALUES (2, 2);

//REVISANDO LA TABLA peliculas_tags
probando_paralaprueba=# SELECT * FROM peliculas_tags;
 peliculas_id | tags_id 
--------------+---------
            1 |       1
            1 |       2
            1 |       3
            2 |       1
            2 |       2
(5 rows)


//3) Cuenta la cantidad de tags que tiene cada película. Si una película no tiene tags debe mostrar 0.


SELECT peliculas.peliculas_id, peliculas.nombre, COUNT(peliculas_tags.tags_id) AS cantidad_tags FROM peliculas LEFT JOIN peliculas_tags ON peliculas.peliculas_id = peliculas_tags.peliculas_id GROUP BY peliculas.peliculas_id, peliculas.nombre;

 peliculas_id |               nombre                | cantidad_tags 
--------------+-------------------------------------+---------------
            3 | Thor                                |             0
            5 | El increible Hulk                   |             0
            4 | Capitán América: El primer vengador |             0
            2 | Iron Man 2                          |             2
            1 | Iron Man                            |             3
(5 rows)

//FIN PRIMERA PARTE 

probando_paralaprueba=# 
//LA RELACIÓN QUE TIENEN LAS TABLAS ENTRE Si

\d
                     List of relations
 Schema |            Name            |   Type   |  Owner   
--------+----------------------------+----------+----------
 public | peliculas                  | table    | postgres
 public | peliculas_peliculas_id_seq | sequence | postgres
 public | peliculas_tags             | table    | postgres
 public | tags                       | table    | postgres
 public | tags_tags_id_seq           | sequence | postgres



//4). Crea las tablas respetando los nombres, tipos, claves primarias y foráneas y tipos de datos. (1 punto)

//CREA LA TABLA preguntas (uno a muchos)
CREATE TABLE preguntas (id SERIAL PRIMARY KEY, pregunta VARCHAR(255) NOT NULL, respuesta_correcta VARCHAR(255) NOT NULL);
 id | pregunta | respuesta_correcta 
----+----------+--------------------
(0 rows)

//CREA LA TABLA usuarios (uno a muchos)
CREATE TABLE usuarios (id SERIAL PRIMARY KEY, nombre VARCHAR(255) NOT NULL, edad INTEGER);
 id | nombre | edad 
----+--------+------
(0 rows)

//TABLA INTERMEDIA NOMBRE 'respuestas'  ENTRE 'preguntas' y 'usuarios'
CREATE TABLE respuestas (id SERIAL PRIMARY KEY, pregunta_id INTEGER REFERENCES preguntas(id), usuario_id INTEGER REFERENCES usuarios(id), respuesta VARCHAR(255) NOT NULL);
 id | pregunta_id | usuario_id | respuesta 
----+-------------+------------+-----------
(0 rows)


probando_paralaprueba=# \d
                     List of relations
 Schema |            Name            |   Type   |  Owner   
--------+----------------------------+----------+----------
 public | preguntas                  | table    | postgres
 public | preguntas_id_seq           | sequence | postgres
 public | respuestas                 | table    | postgres
 public | respuestas_id_seq          | sequence | postgres
 public | usuarios                   | table    | postgres
 public | usuarios_id_seq            | sequence | postgres



//5). Agrega datos, 5 usuarios y 5 preguntas:

//AGREGA 5 USUARIOS A LA TABLA 'usuarios'
INSERT INTO usuarios (nombre, edad) VALUES ('Antonia', 30);
INSERT INTO usuarios (nombre, edad) VALUES ('Iñaki', 35);
INSERT INTO usuarios (nombre, edad) VALUES ('César', 37);
INSERT INTO usuarios (nombre, edad) VALUES ('Daniela', 22);
INSERT INTO usuarios (nombre, edad) VALUES ('Pablo', 24);
SELECT * FROM usuarios;
 id | nombre  | edad 
----+---------+------
  1 | Antonia |   30
  2 | Iñaki   |   35
  3 | César   |   37
  4 | Daniela |   22
  5 | Pablo   |   24
(5 rows)

//AGREGA 5 preguntas Y sus respuestas a la tabla 'preguntas'
INSERT INTO preguntas (pregunta, respuesta_correcta) VALUES ('tijera le gana a ...?', 'papel');
INSERT INTO preguntas (pregunta, respuesta_correcta) VALUES ('papel le gana a ...?', 'piedra');
INSERT INTO preguntas (pregunta, respuesta_correcta) VALUES ('piedra le gana a ...?', 'lagarto');
INSERT INTO preguntas (pregunta, respuesta_correcta) VALUES ('lagarto le gana a ...?', 'spock');
INSERT INTO preguntas (pregunta, respuesta_correcta) VALUES ('spock le gana a ...?', 'tijera');



SELECT * FROM preguntas;
 id |        pregunta        | respuesta_correcta 
----+------------------------+--------------------
  1 | tijera le gana a ...?  | papel
  2 | papel le gana a ...?   | piedra
  3 | piedra le gana a ...?  | lagarto
  4 | lagarto le gana a ...? | spock
  5 | spock le gana a ...?   | tijera
(5 rows)


INSERT INTO respuestas (pregunta_id , usuario_id, respuesta)

INSERT INTO respuestas (pregunta_id , usuario_id, respuesta) VALUES (1, 1, 'papel');
INSERT INTO respuestas (pregunta_id , usuario_id, respuesta) VALUES (1, 2, 'papel');
INSERT INTO respuestas (pregunta_id , usuario_id, respuesta) VALUES (2, 3, 'piedra');
INSERT INTO respuestas (pregunta_id , usuario_id, respuesta) VALUES (4, 1, '¿qué?');
INSERT INTO respuestas (pregunta_id , usuario_id, respuesta) VALUES (5, 2, '¿spock qué?');


SELECT * FROM respuestas;
probando_paralaprueba=# SELECT * FROM respuestas;
 id | pregunta_id | usuario_id |  respuesta  
----+-------------+------------+-------------
  1 |           1 |          1 | papel
  2 |           1 |          2 | papel
  3 |           2 |          3 | piedra
  4 |           4 |          1 | ¿qué?
  5 |           5 |          2 | ¿spock qué?
(5 rows)

    *La pregunta 1 debe estar contestada correctamente dos veces por distintos usuarios
    *La pregunta 2 debe estar contestada correctamente sólo por un usuario, 
    *Las otras 2 respuestas deben estar incorrectas. (1 punto)

Nota: La 'respuesta_correcta' significa que la respuesta indicada en la tabla 'respuestas' es EXACTAMENTE igual al texto indicado en la tabla de 'preguntas'.



//6). Cuenta la cantidad de respuestas correctas totales por usuario (independiente de la pregunta). (1 punto)

SELECT usuarios.id AS usuario_id, usuarios.nombre AS nombre_usuario, 
COUNT(respuestas.id) AS respuestas_correctas_totales FROM usuarios 
LEFT JOIN respuestas ON usuarios.id = respuestas.usuario_id 
LEFT JOIN preguntas ON respuestas.pregunta_id = preguntas.id
WHERE respuestas.respuesta = preguntas.respuesta_correcta
GROUP BY usuarios.id, usuarios.nombre;

 usuario_id | nombre_usuario | respuestas_correctas_totales 
------------+----------------+------------------------------
          1 | Antonia        |                            1
          2 | Iñaki          |                            1
          3 | César          |                            1
(3 rows)



//7). Por cada pregunta, en la tabla preguntas, cuenta cuántos usuarios tuvieron la respuesta correcta. (1 punto)

SELECT preguntas.id AS pregunta_id, preguntas.pregunta,
COUNT(respuestas.usuario_id) AS usuarios_con_respuesta_correcta
FROM preguntas
LEFT JOIN respuestas ON preguntas.id = respuestas.pregunta_id
LEFT JOIN usuarios ON respuestas.usuario_id = usuarios.id
WHERE respuestas.respuesta = preguntas.respuesta_correcta
GROUP BY preguntas.id, preguntas.pregunta;

 pregunta_id |       pregunta        | usuarios_con_respuesta_correcta 
-------------+-----------------------+---------------------------------
           1 | tijera le gana a ...? |                               2
           2 | papel le gana a ...?  |                               1
(2 rows)



//8). Implementa borrado en cascada de las respuestas al borrar un usuario y borrar el primer usuario para probar la implementación. (1 punto)

//cuando borremos una fila de la tabla 'respuestas', se borrarán en cascada las filas correspondientes en la tabla 'respuestas' 
ALTER TABLE respuestas ADD CONSTRAINT fk_usuario_id FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE CASCADE;

//Eliminar respuestas asociadas al usuario con id 1
DELETE FROM respuestas WHERE usuario_id = 1;

//Borramos el usuario con id=1
DELETE FROM usuarios WHERE id = 1;



probando=# ALTER TABLE respuestas ADD CONSTRAINT fk_usuario_id FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE CASCADE;
ALTER TABLE
probando=# DELETE FROM usuarios WHERE id = (SELECT id FROM usuarios ORDER BY id LIMIT 1);
ERROR:  update or delete on table "usuarios" violates foreign key constraint "respuestas_usuario_id_fkey" on table "respuestas"
DETAIL:  Key (id)=(1) is still referenced from table "respuestas".
probando=# DELETE FROM usuarios WHERE id = 1;
ERROR:  update or delete on table "usuarios" violates foreign key constraint "respuestas_usuario_id_fkey" on table "respuestas"
DETAIL:  Key (id)=(1) is still referenced from table "respuestas".
probando=# DELETE FROM respuestas WHERE usuario_id = 1;
DELETE 2
probando=# DELETE FROM usuarios WHERE id = 1;
DELETE 1
probando=# SELECT * FROM usuarios;
 id | nombre  | edad 
----+---------+------
  2 | Iñaki   |   35
  3 | César   |   37
  4 | Daniela |   22
  5 | Pablo   |   24
(4 rows)

probando=# SELECT * FROM respuestas;
 id | pregunta_id | usuario_id |  respuesta  
----+-------------+------------+-------------
  2 |           1 |          2 | papel
  3 |           2 |          3 | piedra
  5 |           5 |          2 | ¿spock qué?





  

//9). AGREGA una restricción que impida insertar usuarios menores de 18 años en la base de datos. (1 punto)
ALTER TABLE usuarios ADD CONSTRAINT edad_mayor_o_igual_a_18 CHECK (edad >= 18);

//10). Altera la tabla existente de usuarios agregando el campo email con la restricción de único. (1 punto)
ALTER TABLE usuarios ADD COLUMN email VARCHAR(255) UNIQUE;

probando_paralaprueba=# SELECT * FROM usuarios;
 id | nombre  | edad | email 
----+---------+------+-------
  1 | Antonia |   30 | 
  2 | Iñaki   |   35 | 
  3 | César   |   37 | 
  4 | Daniela |   22 | 
  5 | Pablo   |   24 | 
(5 rows)

*********************************************
//PARA SABER LA RELACIÓN DE LAS TABLAS 
\d
                     List of relations
 Schema |            Name            |   Type   |  Owner   
--------+----------------------------+----------+----------
 public | preguntas                  | table    | postgres
 public | preguntas_id_seq           | sequence | postgres
 public | respuestas                 | table    | postgres
 public | respuestas_id_seq          | sequence | postgres
 public | usuarios                   | table    | postgres
 public | usuarios_id_seq            | sequence | postgres
(6 rows)


**************************************************

//PARA SABER QUE TIPO DE DATO ACEPTA UNA COLUMNA 'nombre_columna' en la tabla 'nombre_tabla'

SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'usuarios' AND column_name = 'email';

 column_name |     data_type     
-------------+-------------------
 email       | character varying


**PARA SABER QUÉ TIPO DE RESTRICCIONES TIENE LA TABLA**


SELECT constraint_name, constraint_type
FROM information_schema.table_constraints
WHERE table_name = 'usuarios';

     constraint_name     | constraint_type 
-------------------------+-----------------
 usuarios_pkey           | PRIMARY KEY
 edad_mayor_o_igual_a_18 | CHECK
 usuarios_email_key      | UNIQUE
 2200_41125_1_not_null   | CHECK
 2200_41125_2_not_null   | CHECK
(5 rows)


SELECT constraint_name, constraint_type
FROM information_schema.table_constraints
WHERE table_name = 'preguntas';

    constraint_name    | constraint_type 
-----------------------+-----------------
 preguntas_pkey        | PRIMARY KEY
 2200_41116_1_not_null | CHECK
 2200_41116_2_not_null | CHECK
 2200_41116_3_not_null | CHECK
(4 rows)


probando_paralaprueba=# SELECT constraint_name, constraint_type
FROM information_schema.table_constraints
WHERE table_name = 'respuestas';

       constraint_name       | constraint_type 
-----------------------------+-----------------
 respuestas_pkey             | PRIMARY KEY
 respuestas_pregunta_id_fkey | FOREIGN KEY
 respuestas_usuario_id_fkey  | FOREIGN KEY
 fk_pregunta_id              | FOREIGN KEY
 fk_usuario_id               | FOREIGN KEY
 2200_41132_1_not_null       | CHECK
 2200_41132_4_not_null       | CHECK
(7 rows)
