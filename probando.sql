CREATE TABLE preguntas (id SERIAL PRIMARY KEY, pregunta VARCHAR(255) NOT NULL, respuesta_correcta VARCHAR(255) NOT NULL);
CREATE TABLE usuarios (id SERIAL PRIMARY KEY, nombre VARCHAR(255) NOT NULL, edad INTEGER);
CREATE TABLE respuestas (id SERIAL PRIMARY KEY, pregunta_id INTEGER REFERENCES preguntas(id), usuario_id INTEGER REFERENCES usuarios(id), respuesta VARCHAR(255) NOT NULL);


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
