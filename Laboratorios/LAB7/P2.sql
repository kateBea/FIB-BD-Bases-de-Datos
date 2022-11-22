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

CREATE OR REPLACE FUNCTION delete_check() 
RETURNS TRIGGER AS $$
DECLARE
	dia_actual dia.dia%type;
	missatge missatgesExcepcions.texte%type;

BEGIN
	SELECT dia INTO dia_actual FROM dia;
	IF (dia_actual = 'dijous') THEN
		SELECT texte INTO missatge FROM missatgesExcepcions WHERE num = 1;
		RAISE EXCEPTION '%', missatge;
	ELSE RETURN OLD;
	END IF;

	EXCEPTION
	WHEN raise_exception THEN 
		RAISE EXCEPTION '%', SQLERRM;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger BEFORE DELETE ON empleats FOR EACH STATEMENT
EXECUTE PROCEDURE delete_check();

