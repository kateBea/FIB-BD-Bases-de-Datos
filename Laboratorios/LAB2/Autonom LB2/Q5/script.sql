-- Sentències de preparació de la base de dades:
CREATE TABLE vols (
codi_vol VARCHAR(10) PRIMARY KEY,
origen VARCHAR(50),
desti VARCHAR(50),
data_sortida DATE NOT NULL,
hora_sortida_prevista TIME WITH TIME ZONE NOT NULL,
moment_enlairament TIMESTAMP WITH TIME ZONE );

--------------------------
-- Joc de proves Public
--------------------------

-- Sentències d'inicialització:
INSERT INTO vols VALUES
('V002', 'Madrid', 'Roma', '2025-02-20', '14:15+01', '2025-02-20 16:00:00+01'),
('V003', 'Londres', 'Berlín', '2025-06-05', '09:00+00', '2025-06-05 12:30:00+00'),
('V008', 'Atenes', 'Munic', '2025-08-09', '10:50+03', '2025-08-10 11:20:00+03');

drop table vols;

/*
 * 
 * Doneu una sentència SQL per obtenir els vols problemàtics 
 * de la base de dades donada.

Es vol obtenir el codi, la data de sortida, l'any del vol,
 el mes del vol i el retard que s'ha produit. Tingueu en compte el següent:

Els vols problemàtics són els vols de la taula vols que la 
seva data de sortida sigui a partir del juny i que hagin tingut 
un retard de més d'un dia (24 hores). Per obtenir un TIMESTAMP 
a partir de una DATE i un TIME es pot fer sumant aquests dos últims valors.
El resultat ha d'estar ordenat per codi de vol i data de sortida.
Pel joc de proves públic del fitxer adjunt el resultat de la 
sentència de consulta serà el següent:

CODI_VOL		DATA_SORTIDA		ANY_VOL		MES_VOL		RETARD
V008		    2025-08-09		    2025		8		    1day 00:30:00
*/

SELECT 
    codi_vol,
    data_sortida,
    EXTRACT(YEAR FROM data_sortida) AS ANY_VOL,
    EXTRACT(MONTH FROM data_sortida) AS MES_VOL,
    moment_enlairament - (data_sortida + hora_sortida_prevista) AS RETARD
FROM vols
WHERE EXTRACT(MONTH FROM data_sortida) >= 6
  AND moment_enlairament - (data_sortida + hora_sortida_prevista) > INTERVAL '1 day'
ORDER BY codi_vol, data_sortida;








