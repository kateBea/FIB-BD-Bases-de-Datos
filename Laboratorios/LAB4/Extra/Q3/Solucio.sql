/*
Doneu una seqüència d'operacions d'algebra relacional per obtenir el número i 
nom dels departaments tals que tots els seus empleats viuen a MADRID. 
El resultat no ha d'incloure aquells departaments que no tenen cap empleat.

Pel joc de proves que trobareu al fitxer adjunt, la sortida seria:

Num_dpt		Nom_dpt
3		MARKETING

*/

A = DEPARTAMENTS{num_dpt -> num_dpt_d, nom_dpt -> nom_dpt_d}
D = EMPLEATS(ciutat_empl != 'MADRID')
E = D[num_dpt = num_dpt_d]A
E = E[num_dpt_d, nom_dpt_d]
F = A - E
G = F[num_dpt_d = num_dpt]EMPLEATS
R = G[num_dpt, nom_dpt_d]