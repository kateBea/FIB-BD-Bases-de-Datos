CREATE TABLE DEPARTAMENTS
         (	NUM_DPT INTEGER PRIMARY KEY,
	NOM_DPT CHAR(20),
	PLANTA INTEGER,
	EDIFICI CHAR(30),
	CIUTAT_DPT CHAR(20));

CREATE TABLE PROJECTES(
    NUM_PROJ INTEGER PRIMARY KEY,
    NOM_PROJ CHAR(10),
    PRODUCTE CHAR(20),
    PRESSUPOST INTEGER
);

CREATE TABLE EMPLEATS
         (	NUM_EMPL INTEGER PRIMARY KEY,
	NOM_EMPL CHAR(30),
	SOU INTEGER,
	CIUTAT_EMPL CHAR(20),
	NUM_DPT INTEGER REFERENCES DEPARTAMENTS,
	NUM_PROJ INTEGER REFERENCES PROJECTES);

INSERT INTO  DEPARTAMENTS VALUES (3,'MARKETING',3,'RIOS ROSAS','BARCELONA');

INSERT INTO PROJECTES VALUES (2,'IBDVID','VIDEO',500000);

INSERT INTO  EMPLEATS VALUES (2,'ROBERTO',25000,'BARCELONA',3,2);

select d.nom_dpt, p.nom_proj 
from departaments d, projectes p, empleats e 
where e.num_empl = 2 and e.num_proj = p.num_proj and e.num_dpt = d.num_dpt;