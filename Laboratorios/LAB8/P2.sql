create table socis ( nsoci char(10) primary key, sexe char(1) not null);

create table clubs ( nclub char(10) primary key);

create table socisclubs (nsoci char(10) not null references socis, 
  nclub char(10) not null references clubs, 
  primary key(nsoci, nclub));

create table clubs_amb_mes_de_5_socis (nclub char(10) primary key references clubs);

create table missatgesExcepcions(
	num integer, 
	texte varchar(50)
	);

	
	
insert into missatgesExcepcions values(1, 'Club amb mes de 10 socis');
insert into missatgesExcepcions values(2, 'Club amb mes homes que dones');
insert into missatgesExcepcions values(3, 'Soci ja assignat a aquest club');
insert into missatgesExcepcions values(4, 'O el soci o el club no existeixen');
insert into missatgesExcepcions values(5, 'Error intern');

insert into clubs values ('escacs');
insert into clubs values ('petanca');

insert into socis values ('anna','F');

insert into socis values ('joanna','F');
insert into socis values ('josefa','F');
insert into socis values ('pere','M');

insert into socisclubs values('joanna','petanca');
insert into socisclubs values('josefa','petanca');
insert into socisclubs values('pere','petanca');

--Solució:
create or replace function assignar_individual(nomSoci char(10), nomClub char(10)) 
returns void as $$
declare missatge varchar(100);
begin
	
	if (not exists (select * from socis where nsoci = nomSoci) or not exists (select * from clubs where nclub = nomClub)) then
		SELECT texte INTO missatge FROM missatgesExcepcions WHERE num=4;
		RAISE EXCEPTION '%',missatge;
	
	elsif ((select count(*) from socisclubs where nclub = nomClub) >= 10) then
		SELECT texte INTO missatge FROM missatgesExcepcions WHERE num=1;
		RAISE EXCEPTION '%',missatge;
	
	elsif (exists (select * from socisclubs where nsoci = nomSoci and nclub = nomClub)) then
		SELECT texte INTO missatge FROM missatgesExcepcions WHERE num=3;
		RAISE EXCEPTION '%',missatge;
	end if;
		
	insert into socisclubs values (nomSoci, nomClub);

	if ((select count(*) from socis natural inner join socisclubs where sexe = 'M') > (select count(*) from socis natural inner join socisclubs where sexe = 'F')) then
		SELECT texte INTO missatge FROM missatgesExcepcions WHERE num=2;
		RAISE EXCEPTION '%',missatge;
		delete from socisclubs where nsoci = nomSoci and nclub = nomClub;
	end if;
	
	exception
		when raise_exception then
			raise exception '%', SQLERRM;
		when others then
			raise exception 'Error intern';

end
$$language plpgsql;
