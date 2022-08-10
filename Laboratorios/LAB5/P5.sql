----------------
-- Neteja
----------------
DROP TABLE PROFESSORS;
DROP TABLE DESPATXOS;
DROP TABLE ASSIGNACIONS;

------------------------
-- Inicialitzacio
------------------------

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

--Solució:
CREATE TABLE presentacioTFG (
	idEstudiant CHAR(100), 
	titolTFG CHAR(100) NOT NULL,
	dniDirector CHAR (50),
	dniPresident CHAR(50),
	dniVocal CHAR(50),
	instantPresentació INT NOT NULL,
	nota INT DEFAULT NULL,
	FOREIGN KEY (dniDirector) REFERENCES professors(dni),
	FOREIGN KEY (dniPresident) REFERENCES professors(dni),
	FOREIGN KEY (dniVocal) REFERENCES professors(dni),
	PRIMARY KEY (idEstudiant),
	UNIQUE (titolTFG, dniDirector),
	CONSTRAINT notSame CHECK (dniDirector<>dniPresident AND dniDirector<>dniVocal),
	CONSTRAINT notSame2 CHECK (dniPresident<>dniVocal),
	CONSTRAINT notaValida CHECK (nota BETWEEN 1 AND 10)
);
