-- Sentències de preparació de la base de dades:
create table empleats(
                 nempl integer primary key,
                 salari integer);

create table missatgesExcepcions(
	num integer, 
	texte varchar(100));

insert into missatgesExcepcions values(1,'No es pot esborrar l''empleat 123 ni modificar el seu número d''empleat');

-- Sentències d'esborrat de la base de dades:
drop table empleats;
drop table missatgesExcepcions;

--------------------------
-- Joc de proves Public
--------------------------

-- Sentències d'inicialització:
insert into empleats values(1,1000);
insert into empleats values(2,2000);
insert into empleats values(123,3000);

-- Dades d'entrada o sentències d'execució:
delete from empleats where nempl=123;

















