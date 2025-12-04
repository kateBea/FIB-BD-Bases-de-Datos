-- Aquesta sentència de PL/pgSQL serveix per mostrar un valor 
-- d'una variable durant l'execució d'un procediment emmagatzemat.

-- Mostrar el valor d'una variable:
    RAISE NOTICE '%',variable;

-- Mostrar el valor de més d'una variable
    RAISE NOTICE '%, %', var1, var2;

-- Mostrar un 'xivato'
    RAISE NOTICE '%','xivato';
    
-- Premeu  Ctrl+Shif+O des de Dbeaver per veure els Notice