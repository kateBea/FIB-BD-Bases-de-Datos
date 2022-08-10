create table empleats1 (nemp1 integer primary key, nom1 char(25), ciutat1 char(10) not null);

create table empleats2 (nemp2 integer primary key, nom2 char(25), ciutat2 char(10) not null);

insert into empleats2 values(1,'joan','bcn');
insert into empleats2 values(2,'pere','mad');
insert into empleats2 values(3,'enric','bcn');
insert into empleats1 values(1,'joan','bcn');
insert into empleats1 values(2,'maria','mad');

SELECT * FROM empleats2;
SELECT * FROM empleats1;
--Solució:
CREATE OR REPLACE FUNCTION regla()
RETURNS TRIGGER AS $$
BEGIN
	IF (NOT EXISTS (SELECT * FROM empleats2 WHERE old.ciutat2 = ciutat2)) THEN
	DELETE FROM empleats1 WHERE old.ciutat2 = empleats1.ciutat1;
	END IF;
	RETURN NULL;
END
$$LANGUAGE plpgsql;

CREATE TRIGGER ciutat_delete AFTER DELETE ON empleats2
FOR EACH ROW EXECUTE PROCEDURE regla();

CREATE TRIGGER ciutat_update AFTER UPDATE OF ciutat2 ON empleats2
FOR EACH ROW EXECUTE PROCEDURE regla();


--Joc de proves públic
DELETE FROM empleats2 WHERE nemp2=1;