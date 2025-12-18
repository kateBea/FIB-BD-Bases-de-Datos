### Quin ha estat l'efecte de l'execució del programa sobre la taula Professors? Perquè?
Cap perquè el codi fa un rollback abans de tancar la sessió amb lo qual es desfan tots els canvis.


### Quin ha estat l'efecte de l'execució del programa sobre la taula Professors? Perquè?
A la taula tenim una nova professora nina amb dni=555 perquè el codi fa un commit abans de tancar la sessió amb lo qual guardem tots el canvis de la transacció.


### Quina excepció es produeix?
El getSQLState es: 23505

El getMessage es: ERROR: duplicate key value violates unique constraint "professors_pkey"
  Detail: Key (dni)=(555                                               ) already exists.


### Quin ha estat l'efecte de l'execució del programa sobre la taula Professors? Perquè?
L'intent d'insert genera una excepció perque intentem registrar un professor amb un dni (PK) que ja existeix.


### Com podrieu fer (sense afegir accessos a la base de dades des del programa) que quan es dongui aquesta excepció en lloc del missatge obtingut surti "El professor ja existeix"?

al block del catch afegim una condició:

```java
if (se.getSQLState().equals("23505")) {
	System.out.println ("El professor ja existeix");
}
```

### Indiqueu quin és el resultat del select

```bash
[ dni: 111  | nom: ruth ]
[ dni: 222  | nom: ona  ]
[ dni: 333  | nom: anna ]
```

### Doneu el codi dela part del programa des del bloc IMPLEMENTAR fins al final.
```java
// IMPLEMENTAR
// printar el dni i el nom dels professors que tenen els telf amb num inferior al que indicat en la variable buscaTelf
// en cas que no hi hagi cap professor amb aquest telf printar "NO TROBAT"
String buscaTelf = "3334";
PreparedStatement stFilter = c.prepareStatement("SELECT dni, nomprof FROM Professors WHERE telefon < ?;");

stFilter.setString(1, buscaTelf);

ResultSet set = stFilter.executeQuery();

boolean hasContents = false;
while (set.next()) {
    hasContents = true;
    System.out.printf("[ dni: %s | nom: %s ]%n", set.getString("dni"), set.getString("nomprof"));
}

if (!hasContents) {
    System.out.println ("NO TROBAT");
}
```