/*
Doneu una seqüència d'operacions d'algebra relacional per obtenir el nom del departament 
on treballa i el nom del projecte on està assignat l'empleat número 2.

Pel joc de proves que trobareu al fitxer adjunt, la sortida seria:

Nom_dpt		Nom_proj
MARKETING		IBDVID

*/

A = EMPLEATS{num_proj -> num_proj_e, num_dpt -> num_dpt_e}
B = PROJECTES{num_proj -> num_proj_p}
C = A[num_proj_e = num_proj_p]B
D = C[num_dpt_e = num_dpt]DEPARTAMENTS
E= D(num_empl = 2)
R=E[nom_dpt, nom_proj]