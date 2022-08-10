-- Sent�ncies de preparaci� de la base de dades:
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

--Soluci�
create table comandes (
	numComanda INT,
	instantComanda INT UNIQUE NOT NULL,
	client CHAR(30),
	encarregat INT NOT NULL,
	supervisor INT,
	PRIMARY KEY (numComanda),
	FOREIGN KEY (encarregat) REFERENCES EMPLEATS,
	FOREIGN KEY (supervisor) REFERENCES EMPLEATS
);
	

create table productesComprats(
	numComanda INT,
	producte CHAR(20),
	quantitat INT NOT NULL DEFAULT 1,
	preu INT NOT NULL,
	PRIMARY KEY(numComanda, producte),
	FOREIGN KEY (numComanda) REFERENCES comandes
);