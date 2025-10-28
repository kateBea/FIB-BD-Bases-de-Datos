/*
Doneu una seqüència d'operacions de l'àlgebra relacional per obtenir el número i 
nom dels departaments que tenen dos o més empleats que viuen a ciutats diferents.

Pel joc de proves que trobareu al fitxer adjunt, la sortida seria:

Num_dpt		Nom_dpt
3		MARKETING

*/

A = EMPLEATS{ciutat_empl -> ciutat_empl1, num_dpt -> num_dpt1, num_empl -> num_empl1}
B = A[ciutat_empl1 <> ciutat_empl, num_dpt1 = num_dpt, num_empl1 <> num_empl]EMPLEATS
C=B[num_dpt1 = num_dpt] DEPARTAMENTS
R= C[num_dpt1, nom_dpt]