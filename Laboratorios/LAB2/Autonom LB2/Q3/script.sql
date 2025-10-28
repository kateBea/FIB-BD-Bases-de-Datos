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
	
INSERT INTO  PROJECTES VALUES (3,'PR1123','TELEVISIO',600000);

INSERT INTO  DEPARTAMENTS VALUES (4,'MARKETING',3,'RIOS ROSAS','BARCELONA');

INSERT INTO  EMPLEATS VALUES (3,'ROBERTO',25000,'MATARO',4,3);

DROP TABLE EMPLEATS;
DROP TABLE PROJECTES;
DROP TABLE DEPARTAMENTS;

/*
 * Doneu una sentència SQL per incrementar en 500000 el pressupost 
 * dels projectes que tenen algun empleat que treballa a BARCELONA.
 * Pel joc de proves que trobareu al fitxer adjunt, el pressupost del 
 * projecte que hi ha d'haver després de l'execució de la sentència és 1100000
 * */
UPDATE PROJECTES
SET PRESSUPOST = PRESSUPOST + 500000
WHERE NUM_PROJ IN (
	SELECT p.num_proj
	FROM empleats e, projectes p, departaments d
	WHERE e.num_proj = p.num_proj
		AND d.num_dpt = e.num_dpt
		AND d.ciutat_dpt = 'BARCELONA');

--Tots el projectes
SELECT * FROM PROJECTES;

-- Projectes amb algun empleat que treballa a BCN
SELECT p.nom_proj, p.pressupost, e.nom_empl
FROM empleats e, projectes p, departaments d
WHERE e.num_proj = p.num_proj
AND d.num_dpt = e.num_dpt
AND d.ciutat_dpt = 'BARCELONA';