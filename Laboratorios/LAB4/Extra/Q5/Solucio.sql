/*
Donar una seqüència d'operacions d'àlgebra relacional per obtenir informació sobre els 
despatxos que només han estat ocupats per professors amb sou igual a 100000. Es vol 
obtenir el modul i el numero d'aquests despatxos.

Pel joc de proves que trobareu al fitxer adjunt, la sortida ha de ser:

Modul	Numero
Omega	128

*/

A = assignacions * professors
B = A (sou = 100000)
C = B [modul, numero]
D = A (sou <> 100000)
E = D [modul, numero]
F = C - E
M = F [modul, numero]