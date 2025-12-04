CREATE TYPE empl AS (
    nom CHAR(30),
    sou INTEGER
);

CREATE OR REPLACE FUNCTION empl_departament(numdept INTEGER)
RETURNS SETOF empl AS
$$
DECLARE
    e empl;
    missatge VARCHAR(50);
BEGIN
    FOR e IN
        SELECT nom_empl, sou
        FROM empleats em
        WHERE em.num_dpt = numdept
          AND em.ciutat_empl = 'SITGES'
    LOOP
        RETURN NEXT e;
    END LOOP;

    IF NOT FOUND THEN
        SELECT texte INTO missatge
        FROM missatgesExcepcions
        WHERE num = 1;

        RAISE EXCEPTION '%', missatge;
    END IF;

    RETURN;

EXCEPTION
    WHEN raise_exception THEN
        RAISE EXCEPTION '%', SQLERRM;

    WHEN others THEN
        SELECT texte INTO missatge
        FROM missatgesExcepcions
        WHERE num = 2;

        RAISE EXCEPTION '%', missatge;
END;
$$ LANGUAGE plpgsql;
