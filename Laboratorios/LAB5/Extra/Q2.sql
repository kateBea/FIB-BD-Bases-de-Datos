-- Sentències de preparació de la base de dades:
create table professors
(dni char(50),
nomProf char(50) unique,
telefon char(15),
sou integer not null check(sou>0),
primary key (dni));

create table despatxos
(modul char(5),
numero char(5),
superficie integer not null check(superficie>12),
primary key (modul,numero));

create table assignacions
(dni char(50),
modul char(5),
numero char(5),
instantInici integer,
instantFi integer,
primary key (dni, modul, numero, instantInici),
foreign key (dni) references professors,
foreign key (modul,numero) references despatxos);
-- instantFi te valor null quan una assignacio es encara vigent.

--------------------------
-- Joc de proves Public
--------------------------

-- Sentències d'inicialització:
insert into professors values('111','toni','3111',3500);
insert into professors values('222','joan','3111',2200);

insert into despatxos values('omega','120',30);

insert into assignacions values('111','omega','120',345,null);

select * from assignacions a ;

drop table assignacions;
drop table despatxos;
drop table professors;

/*
Doneu una seqüència d'operacions en àlgebra relacional per obtenir el nom dels professors que compleixen una de les condicions següents:
cobren igual o menys de 2000 i no tenen cap assignació a un despatx amb superfície inferior a 20
cobren més de 3000.
Pel joc de proves que trobareu al fitxer adjunt, la sortida seria:

NomProf
toni*/

#A = PROFESSORS(SOU > 3000)
B = PROFESSORS(SOU <= 2000)
C = DESPATXOS(SUPERFICIE < 20)
D = ASSIGNACIONS * C
E = D[DNI]
F = B[DNI]
G = F - E
H = G * PROFESSORS
P = H[DNI]
L = P{ DNI -> DNI_REF }
I = PROFESSORS[DNI = DNI_REF]L
J = I[NOMPROF]
K = A[NOMPROF]
R = J _u_ K






-- Sentències d'esborrat de la base de dades:
drop table empleats;
drop table departaments;
drop table projectes;

-- Sentències de preparació de la base de dades:
CREATE TABLE DEPARTAMENTS
( NUM_DPT INTEGER,
NOM_DPT CHAR(20),
PLANTA INTEGER,
EDIFICI CHAR(30),
CIUTAT_DPT CHAR(20),
PRIMARY KEY (NUM_DPT));

CREATE TABLE PROJECTES
( NUM_PROJ INTEGER,
NOM_PROJ CHAR(10),
PRODUCTE CHAR(20),
PRESSUPOST INTEGER,
PRIMARY KEY (NUM_PROJ));

CREATE TABLE EMPLEATS
( NUM_EMPL INTEGER,
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
INSERT INTO DEPARTAMENTS VALUES (1,'DIRECCIO',10,'PAU CLARIS','BARCELONA');

INSERT INTO PROJECTES VALUES (1,'IBDTEL','TELEVISIO',1000000);

INSERT INTO EMPLEATS VALUES (1,'CARME',400000,'MATARO',1,1);

INSERT INTO EMPLEATS VALUES (2,'PEDRO',400000,'MATARO',1,1);

/*
* Doneu una sentència SQL per obtenir els departaments tals que tots els empleats del departament estan assignats a un mateix projecte.
No es vol que surtin a la consulta els departaments que no tenen cap empleet.
Es vol el número, nom i ciutat de cada departament.

Cal resoldre l'exercici sense fer servir funcions d'agregació.

Pel joc de proves que trobareu al fitxer adjunt, la sortida seria:

Num_dpt Nom_dpt Ciutat_dpt
1 DIRECCIO BARCELONA

* */
select d.num_dpt, d.nom_dpt, d.ciutat_dpt
from departaments d
where (select count(distinct e.num_proj)
from empleats e
where e.num_dpt = d.num_dpt) = 1;