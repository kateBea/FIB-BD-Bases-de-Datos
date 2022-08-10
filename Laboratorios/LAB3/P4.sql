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

-- Sentències d'esborrat de la base de dades:
drop table Assignacions;
drop table Despatxos;
drop table Professors;

--------------------------
-- Joc de proves Public
--------------------------

-- Sentències de neteja de les taules:
delete from assignacions;
delete from despatxos;
delete from professors;

--Solució
insert into professors
values (1, 'Jordi', 6, 1000);

insert into despatxos values
('A', 'A', 15),
('A', 'B', 15);

insert into assignacions values
(1, 'A', 'A', 51, 53),
(1, 'A', 'A', 52, 53),
(1, 'A', 'B', 52, 54);
