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

CREATE TABLE COST_CIUTAT
(CIUTAT_DPT CHAR(20),
COST INTEGER,
PRIMARY KEY (CIUTAT_DPT));

-- Sentències d'esborrat de la base de dades:
DROP TABLE cost_ciutat;
DROP TABLE empleats;
DROP TABLE departaments;
DROP TABLE projectes;

--------------------------
-- Joc de proves Public
--------------------------

-- Sentències d'inicialització:
INSERT INTO PROJECTES VALUES (3,'PR1123','TELEVISIO',600000);

INSERT INTO DEPARTAMENTS VALUES (4,'MARKETING',3,'RIOS ROSAS','BARCELONA');

-- Sentències d'esborrat de la base de dades:
DROP TABLE cost_ciutat;
DROP TABLE empleats;
DROP TABLE departaments;
DROP TABLE projectes;

/*
* Doneu una sentència d'inserció de files a la taula cost_ciutat que l'ompli a partir del contingut de la resta de taules de la base de dades. Tingueu en compte el següent:

Cal inserir una fila a la taula cost_ciutat per cada ciutat on hi ha un o més departaments, però no hi ha cap departament que tingui empleats.

Per tant, només s'han d'inserir les ciutats on cap dels departaments situats a la ciutat tinguin empleats.

El valor de l'atribut cost ha de ser 0.

Pel joc de proves públic del fitxer adjunt, un cop executada la sentència d'inserció, a la taula cost_ciutat hi haurà les tuples següents:

CIUTAT_DPT COST
BARCELONA 0
* */

INSERT INTO COST_CIUTAT (CIUTAT_DPT, COST)
SELECT DISTINCT d.CIUTAT_DPT, 0
FROM DEPARTAMENTS d
WHERE NOT EXISTS (
SELECT 1
FROM EMPLEATS e
INNER JOIN DEPARTAMENTS d2 ON d2.NUM_DPT = e.NUM_DPT
WHERE d2.CIUTAT_DPT = d.CIUTAT_DPT);

-- prova
select ciutat_dpt, cost
from COST_CIUTAT;


-- Sentències de preparació de la base de dades:
CREATE TABLE clients
(dni char(9),
nomClient char(50) UNIQUE NOT NULL,
ciutatResidencia char(15),
PRIMARY KEY (dni));
-- Hi ha una fila per cada client d’una entitat bancària.

CREATE TABLE comptesBancaris
(numCompte char(24),
dniClient char(9) NOT NULL,
saldoDisponible real,
PRIMARY KEY (numCompte),
FOREIGN KEY (dniClient) REFERENCES clients(dni));
-- Hi ha una fila per cada compte bancari d’una entitat. -- El saldoDisponible és el saldo que hi ha en el instant actual en el compte bancari.

CREATE TABLE ingressos
(numCompte char(24),
instantIngres integer NOT NULL,
quantitat integer NOT NULL CHECK (quantitat>0),
PRIMARY KEY (numCompte, instantIngres),
FOREIGN KEY (numCompte) REFERENCES comptesBancaris(numCompte));
-- Hi ha una fila per cada ingrés fet al compte bancari.

CREATE TABLE reintegraments
(numCompte char(24),
instantReintegrament integer NOT NULL,
quantitat integer NOT NULL CHECK (quantitat>0),
PRIMARY KEY (numCompte, instantReintegrament),
FOREIGN KEY (numCompte) REFERENCES comptesBancaris(numCompte));
-- Hi ha una fila per cada reintegrament fet al compte bancari.

--------------------------
-- Joc de proves Public
--------------------------

-- Sentències d'inicialització:
INSERT INTO clients (dni, nomClient, ciutatResidencia)
VALUES ('12345678A', 'Joan Pons', 'Barcelona');

INSERT INTO comptesBancaris (numCompte, dniClient, saldoDisponible)
VALUES ('760236', '12345678A', 2000),
('760888', '12345678A', 3000);

INSERT INTO ingressos (numCompte, instantIngres, quantitat) VALUES
('760236', 520, 1500),
('760236', 600, 2000),
('760236', 710, 2500),
('760236', 800, 1800),
('760236', 920, 3000),
('760236', 990, 1200);

INSERT INTO reintegraments (numCompte, instantReintegrament, quantitat) VALUES
('760236', 750, 3),
('760236', 970, 3),
('760888', 750, 15);


/*
* Doneu un sentència SQL per modificar el saldo dels comptesBancaris pels que xisteix entre els instants 500 i 1000 més de 5 ingressos d'una quantitat més gran o igual a 500 euros cadascun, i pels que tots els reintagraments entre els mateixos instants han sigut d'una quantitat de menys de 10 euros cadascun (en cas que no hi hagi cap reintegrament, aquesta segona condició es considera també certa).

S'ha d'incrementar el saldo d'aquests comptes en 100 euros.

Després de l'execució de la instrucció, en el cas del joc de proves públic, l'estat de la taula comptesBancaris serà el següent

num_compte dniClient saldoDisponible
760236 12345678A 2100
760888 12345678A 3000
* */


UPDATE comptesBancaris cb
SET saldoDisponible = saldoDisponible + 100
WHERE cb.numCompte IN (
SELECT i.numCompte
FROM ingressos i
WHERE i.instantIngres BETWEEN 500 AND 1000
AND i.quantitat >= 500
GROUP BY i.numCompte
HAVING COUNT(*) > 5)
AND NOT EXISTS (
SELECT 1
FROM reintegraments r
WHERE r.numCompte = cb.numCompte
AND r.instantReintegrament BETWEEN 500 AND 1000
AND r.quantitat >= 10);

-- Prova dades
select c.numCompte, b.dniClient, c.saldoDisponible
from comptesBancaris c inner join comptesBancaris b on b.dniClient = c.dniClient;