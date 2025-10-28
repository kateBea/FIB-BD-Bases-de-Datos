-- Pràctica corresponen a slides 143-150

-- 0: Crea un nou esquema per als exercicis d'avui, i passa a funcionar 
-- amb el nou esquema

create schema vistes;
set search_path to vistes;


-- 1: Crea les taules següents:

create table estudis
(id integer primary key,
detall char(30));

create table persona
(dni integer primary key,
nom char(30),
id_estudis integer references estudis,
instantnaixement integer,
ciutat_naixement char(30));


-- 2: Insereix files a les taules:

insert into estudis values (5, 'Doctorat');
insert into estudis values (4, 'Master');
insert into estudis values (3, 'Grau');
insert into estudis values (2, 'Batxillerat');
insert into estudis values (1, 'ESO');

insert into persona values (1,'Joan',5,111,'Tremp');
insert into persona values (2,'Pere',3,222,'Vic');
insert into persona values (3,'Anna',4,333,'Olot');
insert into persona values (4,'Enric',2,444,'Tona');
insert into persona values (5,'Maria',5,555,'Seva');


-- 3: Crea les vistes següents:

CREATE VIEW persones4 AS  
				SELECT dni, nom, id_estudis
                FROM persona
                WHERE id_estudis >= 4;

CREATE VIEW persones4_i_estudis AS 
				SELECT dni, nom, estudis.id, estudis.detall
                FROM persones4, estudis
                WHERE estudis.id = persones4.id_estudis;


-- 4-1: Consulta les vistes

select * from persones4;
select * from persones4_i_estudis;


-- 4-2: Busca al navegador de la teva base de dades (finestra de l'esquerra del DBeaver)

-- 4-2-1: Les taules
-- 4-2-2: Les vistes

-- A l'hora de contestar les preguntes suposa que:
-- La creació de taules, inserció de files a taules, i creació de vistes la fa un mateix usuari A
-- L'usuari A dóna privilegis de consulta i actualització de les vistes a l'usuari B
-- Les preguntes que es fan relacionades amb operacions de consulta i actualització sobre vistes
-- les heu de contestar suposant que les executa l'usuari B que ÚNICAMENT té accés a les vistes
-- i, per tant, per ell/a les vistes són com si fossin taules 


-- 5: Respon a les preguntes següents a partir de la informació que hi ha a les transparències

-- Pregunta 5-1: Quines dades s'obtenen amb cadascuna de les vistes definides? Donar una frase que expliqui les dades que s'obtenen amb cadascuna.
-- Pregunta 5-2: Totes les vistes són consultables?
-- Pregunta 5-3: Les vistes estan materialitzades físicament?
-- Pregunta 5-4: Des del punt de vista de qui escriu els selects hi ha ha alguna diferencia d'escriure selects sobre taules i/o vistes?


-- 6: Executa la sentència d'actualització de la vista següent:

select * from persona order by dni;
select * from persones4;
UPDATE persones4 SET nom='Anna Maria' WHERE dni=5;


-- 7: Respon a les preguntes següents, si et fa falta ajudant-te de les transparències:

-- Pregunta 7-1: Com es diu la persona amb dni=5 abans del update?
-- Pregunta 7-2: Ha canviat el nom de la persona amb dni=5?
-- Pregunta 7-3: Què fa el SGBD quan es fa un update de la vista persones4 si la vista en realitat no està materialitzada?


-- 8: Executa la sentència d'actualització de la vista següent:

select * from persona order by dni;
select * from persones4;
UPDATE persones4 SET id_estudis=2 WHERE dni = 5;


-- 9: Respon a les preguntes següents, si et fa falta ajudant-te de les transparències:

-- Pregunta 9-1: Quin id d'estudis té la persona amb dni=5 abans del update?
-- Pregunta 9-2: S'ha pogut executar l'update sense cap excepció?
-- Pregunta 9-3: La fila apareix modificada a la vista? 
-- Pregunta 9-4: La fila apareix modificada a la taula? 
-- Pregunta 9-5: Des del punt de vista de l'usuari que executa el update creus que pot ser confús el què ha passat? 
-- Pregunta 9-6: Què fa el SGBD quan es fa un update de la vista persones4 si la vista en realitat no està materialitzada?

-- 10: Executa la sentència d'inserció a la vista següent:

select * from persona order by dni;
select * from persones4;
INSERT INTO persones4 (dni, nom, id_estudis) VALUES (6,'Pol',1);


-- 11: Respon a les preguntes següents:

-- Pregunta 11-1: S'ha pogut executar l'insert sense cap excepció?
-- Pregunta 11-2: La nova fila apareix a la vista? 
-- Pregunta 11-3: La nova fila apareix a la taula? 
-- Pregunta 11-4: Des del punt de vista de l'usuari que executa el insert creus que pot ser confús el què ha passat?
-- Pregunta 11-5: Què fa el SGBD quan es fa un update de la vista persones4 si la vista en realitat no està materialitzada?

-- 12: Esborrar les vistes

drop view persones4_i_estudis;
drop view persones4;


-- 13: Crear les vistes novament amb la clàusula With Check Option

CREATE VIEW persones4 AS  SELECT dni, nom, id_estudis
                FROM persona
                WHERE id_estudis >= 4
WITH CHECK OPTION;


-- 14: Executa la sentència d'actualització de la vista següent:

select * from persona order by dni;
select * from persones4;
UPDATE persones4 SET nom='Ton' WHERE dni=1;


-- 15: Respon a les preguntes següents:

-- Pregunta 15-1: Com es diu la persona amb dni=1 abans del update?
-- Pregunta 15-2: Ha canviat el nom de la persona amb dni=1?


-- 16: Executa la sentència d'actualització de la vista següent:

select * from persones4;
select * from persona order by dni;
UPDATE persones4 SET id_estudis=2 WHERE dni = 1;


-- 17: Respon a les preguntes següents:

-- Pregunta 17-1: Quin id d'estudis té la persona amb dni=1 abans del update?
-- Pregunta 17-2: Quina excepció ha donat l'execució de l'update? Perquè?


-- 18: Executa la sentència d'inserció a la vista següent:

select * from persones4;
select * from persona order by dni;
INSERT INTO persones4 (dni, nom, id_estudis) VALUES (7,'Silvia',1);


-- 19: Respon a les preguntes següents:

-- Pregunta 19-1: Quina excepció ha donat l'insert? Perquè?


-- 20: Respon a les preguntes següents a partir de les transparències:

-- Pregunta 20-1: Totes les vistes són actualitzables? 
-- Pregunta 20-2: La vista persones4 és actualitzable? Perquè?
-- Pregunta 20-3: La vista persones4_i_estudis és actualitzable? Perquè?


-- 21: Crea la vista següent:

CREATE VIEW quantesPersones(num) AS  
				SELECT count(*) 
                FROM persona
                WHERE id_estudis >= 4;

-- 22: Consulta la vista:

select * from quantesPersones;


-- 23: Respon a les preguntes següents:

-- Pregunta 22-1: Quines dades s'obtenen amb la vista definida? Donar una frase que expliqui les dades que s'obtenen.


-- 24: Executa la sentència de modificació de la vista següent:

update quantesPersones set num = num + 1;


-- 25: Respon a les preguntes següents a partir de les transparències:

-- Pregunta 25-1: Quina excepció dóna quan intentes executar l'update? Perquè?
-- Pregunta 25-2: Recorda que els passos que fa un SGBD quan es demana un update sobre una vista és traduir-ho a operacions sobre les vistes/taules sobre les que aquesta està definida. Com es podria fer aquesta traducció per l'operació update que has volgut executar? 


-- 26: Crear la vista següent:

CREATE VIEW persones5 AS  
				SELECT dni, nom, id_estudis
                FROM persones4
                WHERE id_estudis >= 5;
		
		
-- 27: Executa la sentència d'inserció a la vista següent:

select * from persones5;
select * from persones4;
select * from persona order by dni;
INSERT INTO persones5 (dni, nom, id_estudis) VALUES (8,'Marta',4);				
				
				
-- 28: Respon a les preguntes següents:

-- Pregunta 28-1: S'ha pogut executar l'insert sense cap excepció?
-- Pregunta 28-2: La nova fila apareix a la vista persones5? 
-- Pregunta 28-3: La nova fila apareix a la vista persones4? 
-- Pregunta 28-4: La nova fila apareix a la taula? 
-- Pregunta 28-5: Què fa el SGBD quan es fa un update de la vista persones5 si la vista en realitat no està materialitzada?


-- 29: Executa la sentència d'inserció a la vista següent:

select * from persones5;
select * from persones4;
select * from persona order by dni;
INSERT INTO persones5 (dni, nom, id_estudis) VALUES (9,'Montse',1);	

-- 30: Respon a les preguntes següents:

-- Pregunta 30-1: S'ha pogut executar l'insert sense cap excepció? Perquè?


-- 31: Executa la sentència d'update a la vista següent:

select * from persones5;
select * from persones4;
select * from persona order by dni;
UPDATE persones5 SET nom='XXX';		
				
				
-- 32: Respon a les preguntes següents:

-- Pregunta 32-1: S'ha pogut executar l'update sense cap excepció?
-- Pregunta 32-2: S'ha canviat el nom a totes les persones que apareixien a la vista persones5?
-- Pregunta 32-3: S'ha canviat el nom a totes les persones que apareixien a la vista persones4? 
-- Pregunta 32-4: S'ha canviat el nom a totes les persones que apareixien a la taula persona?
-- Pregunta 32-5: A quines files afecta els canvis que es fan sobre una vista? 


====================================================================================
-- Després d'aquesta pràctica es recomana fer l'exercici 3 del 31-10-2023.
====================================================================================