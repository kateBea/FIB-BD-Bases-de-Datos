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





/**
Tenint en compte l'esquema de la BD que s'adjunta, proposeu una sentència de creació de les taules següents:
comandes(numComanda, instantComanda, client, encarregat, supervisor)
productesComprats(numComanda, producte, quantitat, preu)

La taula comandes conté les comandes fetes.
La taula productesComprats conté la informació dels productes comprats a les comandes de la taula comandes.

En la creació de les taules cal que tingueu en compte que:
- No hi poden haver dues comandes amb un mateix número de comanda.
- Un client no pot fer dues comandes en una mateix instant.
- L'encarregat és un empleat que ha d'existir necessariament a la base de dades, i que té sempre tota comanda.
- El supervisor és també un empleat de la base de dades i que s'assigna a algunes comandes en certes circumstàncies.
- No hi pot haver dues vegades un mateix producte en una mateixa comanda. Ja que en cas de el client compri més d'una unitat 
    d'un producte en una mateixa comanda s'indica en l'atribut quantitat.
- Un producte sempre s'ha comprat en una comanda que ha d'existir necessariament a la base de dades.
- La quantitat de producte comprat en una comanda no pot ser nul, i té com a valor per defecte 1.
- Els atributs numComanda, instantComanda, quantitat i preu són de tipus integer.
- Els atributs client, producte són char(30), i char(20) respectivament.
- L'atribut instantComanda no pot tenir valors nuls.
Respecteu els noms i l'ordre en què apareixen les columnes (fins i tot dins la clau o claus que calgui definir). Tots els noms 
s'han de posar en majúscules/minúscules com surt a l'enunciat.
*/

create table comandes(
	numComanda integer,
	instantComanda integer not null,
	client char(30),
	encarregat integer not null,
	supervisor integer,
	
	primary key (numComanda),
	unique (instantComanda, client),
	foreign key (encarregat) references empleats (num_empl),
	foreign key (supervisor) references empleats (num_empl)
);
	

create table productesComprats(
	numComanda integer,
	producte char(20),
	quantitat integer not null default 1,
	preu integer,
	
	primary key (numComanda, producte),
	foreign key (numComanda) references comandes (numComanda)
);
















