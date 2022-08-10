-- Sentències d'esborrat de la base de dades:
drop table empleats;
drop table departaments;
drop table projectes;

-- Sentències de preparació de la base de dades:
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

--------------------------
-- Joc de proves Públic
--------------------------

-- Sentències d'inicialització:
INSERT INTO  DEPARTAMENTS VALUES (1,'DIRECCIO',10,'PAU CLARIS','BARCELONA');

INSERT INTO  PROJECTES VALUES (1,'IBDTEL','TELEVISIO',1000000);

INSERT INTO  EMPLEATS VALUES (1,'CARME',400000,'MATARO',1,1);

--Solució:

SELECT d.num_dpt, d.nom_dpt, ciutat_dpt
FROM DEPARTAMENTS d NATURAL INNER JOIN EMPLEATS e
WHERE d.num_dpt = e.num_dpt AND NOT EXISTS (SELECT * 
											FROM EMPLEATS e1
											WHERE e.num_dpt = e1.num_dpt
											AND e.num_proj <> e1.num_proj);


