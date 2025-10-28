/*
Doneu una seqüència d'operacions d'algebra relacional per obtenir els números 
i els noms dels departament situats a MADRID, que tenen algun empleat que guanya més de 200000.

Pel joc de proves que trobareu al fitxer adjunt, la sortida ha de ser:

Num_dpt		Nom_dpt
5		VENDES

*/

A = DEPARTAMENTS{num_dpt -> num_dpt_d, nom_dpt -> nom_dpt_d}
B = A[num_dpt_d = num_dpt]EMPLEATS
C = B(ciutat_dpt = 'MADRID')
D = C(sou > 200000)
R = D[num_dpt, nom_dpt_d]