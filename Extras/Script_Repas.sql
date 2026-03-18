-- CREACIÓ DE DADES

create table professors
(dni char(50),
nomProf char(50) unique,
telefon char(15) unique,
sou integer,
primary key (dni));

create table despatxos
(modul char(5),
numero char(5),
superficie integer not null check(superficie>12 and superficie <25),
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

-- CÁRREGA DE DADES

insert into professors values('111','ruth','3111',1000);
insert into professors values('222','ona','3222',1200);
insert into professors values('333','anna','3333',1100);
insert into professors values('444','mieria','3444',1300);

insert into despatxos values('omega','118',16);
insert into despatxos values('omega','128',20);
insert into despatxos values('c6','109',14);
insert into despatxos values('c6','120',14);
insert into despatxos values('u','125',13);

insert into assignacions values('111','u','125',0,108);
insert into assignacions values('111','c6','120',109,344);
insert into assignacions values('111','omega','128',345,365);
insert into assignacions values('333','omega','128',366,500);
insert into assignacions values('222','c6','109',109,344);
insert into assignacions values('222','omega','118',345,null);
insert into assignacions values('444','omega','118',345,380);

INSERT INTO DEPARTAMENTS VALUES (10, 'INFORMATICA', 2, 'EDIFICI A', 'BARCELONA');
INSERT INTO DEPARTAMENTS VALUES (20, 'RECURSOS HUMANS', 1, 'EDIFICI B', 'MADRID');
INSERT INTO DEPARTAMENTS VALUES (30, 'FINANCES', 3, 'EDIFICI C', 'VALENCIA');
INSERT INTO DEPARTAMENTS VALUES (40, 'MARKETING', 4, 'EDIFICI A', 'BARCELONA');

INSERT INTO PROJECTES VALUES (100, 'PROJ-A', 'SOFTWARE', 500000);
INSERT INTO PROJECTES VALUES (200, 'PROJ-B', 'HARDWARE', 300000);
INSERT INTO PROJECTES VALUES (300, 'PROJ-C', 'CONSULTORIA', 150000);
INSERT INTO PROJECTES VALUES (400, 'PROJ-D', 'IA', 800000);

INSERT INTO EMPLEATS VALUES (1, 'JORDI PUIG', 32000, 'BARCELONA', 10, 100);
INSERT INTO EMPLEATS VALUES (2, 'MARIA GARCIA', 28000, 'MADRID', 20, 200);
INSERT INTO EMPLEATS VALUES (3, 'PERE SOLER', 35000, 'VALENCIA', 30, 300);
INSERT INTO EMPLEATS VALUES (4, 'ANNA MARTINEZ', 40000, 'BARCELONA', 10, 400);
INSERT INTO EMPLEATS VALUES (5, 'LAURA VIDAL', 27000, 'BARCELONA', 40, 100);
INSERT INTO EMPLEATS VALUES (6, 'DAVID ROCA', 30000, 'MADRID', 20, 300);



-- NATEJA
drop table assignacions;
drop table despatxos;
drop table professors;
drop table departaments;
drop table projectes;
drop table empleats;


-- EXERCICIS

-- 1. Retorna empleats del departamanet X que viuen a SItges
create type empl as (nom char(30), sou int);

create or replace function empleat_sitge(nom_dpt varchar(250)) 
returns setof empl as $$
declare 
	missatge varchar(250);

begin
	
	
end;
$$language plpgsql;

drop type empl;
drop procedure empleat_sitge;


