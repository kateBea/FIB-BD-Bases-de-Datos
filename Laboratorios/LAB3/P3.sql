-- Sent�ncies de preparaci� de la base de dades:
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

-- Sent�ncies d'esborrat de la base de dades:
drop table Assignacions;
drop table Despatxos;
drop table Professors;

--Soluci�
insert into professors values ('1', 'victor', null, 1000000);

insert into despatxos values ('A', 'A', 13);

insert into assignacions values ('1', 'A', 'B', 1, 1);