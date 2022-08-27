CREATE TABLE empleats(
  nempl integer PRIMARY KEY,
  salari integer);

CREATE TABLE dia(
dia char(10));

CREATE TABLE missatgesExcepcions(
	num integer, 
	texte varchar(50)
	);

DROP TABLE empleats;
DROP TABLE dia;
DROP TABLE missatgesExcepcions;

insert into empleats values(1,1000);
insert into empleats values(2,2000);
insert into empleats values(123,3000);

insert into dia values('dijous');

insert into missatgesExcepcions values(1,'No es poden esborrar empleats el dijous');

--Solució:

