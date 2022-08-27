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
select * from empleats;
--Solució:

CREATE OR REPLACE FUNCTION delete_check() 
RETURNS TRIGGER AS $$
DECLARE 
	missatge varchar(100);

BEGIN
	IF (TG_OP = 'DELETE') THEN
	--Si es fa un delete s'esborra si no es l'empleat 123
		IF (OLD.nempl = 123) THEN
		SELECT texte INTO missatge FROM missatgesExcepcions WHERE num = 1;
		RAISE EXCEPTION '%', missatge;
		ELSE RETURN OLD;
		END IF;
	ELSEIF (TG_OP = 'UPDATE') THEN
	--Si es fa un pdate es retorna valor modificat si no es l'empleat 123
		IF (OLD.nempl = 123) THEN
		SELECT texte INTO missatge FROM missatgesExcepcions WHERE num = 1;
		RAISE EXCEPTION '%', missatge;
		ELSE RETURN NEW;
		END IF;
	END IF;

	EXCEPTION
		WHEN raise_exception THEN
			RAISE EXCEPTION '%', SQLERRM;
		WHEN OTHERS THEN
			RAISE EXCEPTION 'Error intern';
	
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER delete_123 BEFORE DELETE OR UPDATE OF nempl ON empleats 
FOR EACH ROW EXECUTE PROCEDURE delete_check();

DROP FUNCTION delete_check () CASCADE;


















