-- Sentencies de preparacia de la base de dades:
CREATE TABLE DEPARTAMENTS
         (	NUM_DPT INTEGER,
	NOM_DPT CHAR(20),
	PLANTA INTEGER,
	EDIFICI CHAR(30),
	CIUTAT_DPT CHAR(20),
	PRIMARY KEY (NUM_DPT));

CREATE TABLE PROJECTES
         (	NUM_PROJ INTEGER,
	NOM_PROJ CHAR(10),
	PRODUCTE CHAR(20),
	PRESSUPOST INTEGER,
	PRIMARY KEY (NUM_PROJ));

CREATE TABLE EMPLEATS
         (	NUM_EMPL INTEGER,
	NOM_EMPL CHAR(30),
	SOU INTEGER,
	CIUTAT_EMPL CHAR(20),
	NUM_DPT INTEGER,
	NUM_PROJ INTEGER,
	PRIMARY KEY (NUM_EMPL),
	FOREIGN KEY (NUM_DPT) REFERENCES DEPARTAMENTS (NUM_DPT),
	FOREIGN KEY (NUM_PROJ) REFERENCES PROJECTES (NUM_PROJ));

-- Sentencies d'esborrat de la base de dades:
DROP TABLE empleats;
DROP TABLE departaments;
DROP TABLE projectes;

--------------------------
-- Joc de proves Public
--------------------------

-- Sent?ncies d'inicialitzaci?:
INSERT INTO  DEPARTAMENTS VALUES (3,'MARKETING',3,'RIOS ROSAS','MADRID');

INSERT INTO  PROJECTES VALUES (1,'IBDTEL','TELEVISIO',1000000);

-- Sent?ncies de neteja de les taules:
DELETE FROM empleats;
DELETE FROM departaments;
DELETE FROM projectes;

select d.num_dpt, d.nom_dpt
from departaments d, empleats e
where not exists (select * from departaments d1, empleats e1 where e1.ciutat_empl = 'MADRID' and e1.num_dpt = d1.num_dpt)
and d.num_dpt = e.num_dpt;

-->busca primero los de madrid y excluyelos
select num_dpt, nom_dpt from departaments d where not exists (select * from empleats e
where e.num_dpt = d.num_dpt and e.ciutat_empl = 'MADRID');
