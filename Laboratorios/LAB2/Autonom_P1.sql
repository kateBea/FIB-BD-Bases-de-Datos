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


INSERT INTO  DEPARTAMENTS VALUES (3,'MARKETING',2,'PAU CLARIS','BARCELONA');

INSERT INTO  PROJECTES VALUES (1,'IBDTEL','TELEVISIO',1000000);

INSERT INTO  EMPLEATS VALUES (4,'JOAN',30000,'BARCELONA',3,1);
INSERT INTO  EMPLEATS VALUES (5,'PERE',25000,'MATARO',3,1);

select distinct nom_proj p, num_proj p
from projectes p natural inner join empleats e
where p.nom_proj = 'V' and e.num_proj = p.num_proj;

-->The statement below doesnt not work
-->Because num_proj in select is ambiguous
select distinct nom_proj p, num_proj p
from projectes p, empleats e
where p.nom_proj = 'V' and e.num_proj = p.num_proj;

select count(distinct num_proj) 
from projectes;

-->solution (doesnt work)
select distinct p.num_proj, p.nom_proj
from projectes p natural inner join empleats e
where e.num_proj = p.num_proj
group by p.num_proj
order by p.num_proj desc;

-->solution (work)
SELECT num_proj, nom_proj
FROM projectes
WHERE 1 < (SELECT COUNT(*) FROM empleats e WHERE projectes.num_proj = e.num_proj)
ORDER BY num_proj DESC;

select p.num_proj, p.nom_proj
from projectes p natural inner join empleats e;