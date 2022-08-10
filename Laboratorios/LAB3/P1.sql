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
DROP TABLE assignacions;
DROP TABLE despatxos;
DROP TABLE professors;

--------------------------
-- Joc de proves Public
--------------------------

-- Sent�ncies d'inicialitzaci�:
insert into professors values('111','toni','3111',3500);
insert into professors values('222','geralt','3445',1500);
insert into professors values('333','jerry','3445',3500);

insert into despatxos values('omega','120',20);

insert into assignacions values('111','omega','120',345,null);

-- Sent�ncies de neteja de les taules:
DELETE FROM assignacions;
DELETE FROM despatxos;
DELETE FROM professors;

select *
--from professors p, assignacions a, despatxos d;
from professors p natural inner join assignacions a natural inner join despatxos d;
-- Soluci�
select nomprof
from professors p
where (p.telefon is not null and p.sou > 2500) or (p.telefon is null and not exists (select d.superficie
                    from despatxos d, assignacions a
                    where a.dni=p.dni and d.modul=a.modul and d.numero = a.numero and d.superficie<20));