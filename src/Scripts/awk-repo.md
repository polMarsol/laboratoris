# Repositori d'exercicis

Aquesta secció conté els exercicis realitzats pels estudiants de l'assignatura d'Administració i Manteniment de Sistemes i Aplicacions (AMSA).

## Exercicis

### Bàsics

**1- Una comanda que permeti imprimir totes les línies que comencin per un "M" majúscula. Mostra només el nom del pokémon (columna 2)**.

awk -F, '{ if ($2 ~ /^M/) print $2 }' pokemon.csv

Aquesta solució utilitza una estructura if dins de l'script awk per verificar si una línia compleix la condició que volem. En aquest cas, la condició és que el nom del Pokémon (que es troba a la segona columna del CSV) comenci amb la lletra "M" majúscula.

**2- Imprimiu tots els pokemons que siguin del tipus herba i fosc. Imprimiu el nom, tipus 1 i tipus 2. Podeu fer servir l'operador && per crear l'expressió regular**.

awk 'BEGIN { FS = "," } $3 == "Grass" && $4 == "Dark" { print $2, $3, $4 }' pokemon.csv

Aquesta alternativa utilitza el bloc BEGIN dins de awk. Aquest bloc s'executa abans que el programa comenci a processar les línies del fitxer. L'ús principal és configurar coses que volem que estiguin preparades abans de començar, com ara definir el delimitador de camps (en aquest cas, una coma perquè és un CSV).

### Intermedis

**3- Implementeu un script que compti tots els pokemons que tenim a la pokedex i que tingui la sortida següent:
Counting pokemons...
There are 800 pokemons.
Recordeu que la primera línia és la capçalera i no la volem comptar.**

awk 'BEGIN { print "Counting pokemons..." } NR > 1 { } END { print "There are", NR-1, "pokemons." }' pokemon.csv


En aquesta versió del codi fem servir la variable integrada NR, que en awk vol dir número de registre, o sigui, el número de línia que estem llegint en cada moment. La idea és que, com que la primera línia del fitxer és la capçalera (els noms de les columnes), no la volem comptar. Així que utilitzem NR per saltar-nos-la.

**4- Implementeu un script que permeti comptar el nombre de pokemons de tipus aigua i roca. La sortida ha de ser semblant a:
Water:64
Rock:50
Others:689**

awk -F, 'BEGIN{ water=0; rock=0; others=0 } 
{
    if ($3 == "Water" || $4 == "Water") {
        water++
    } else if ($3 == "Rock" || $4 == "Rock") {
        rock++
    } else {
        others++
    }
} 
END{ print "Water:" water "\nRock:" rock "\nOthers:" others }' pokemon.csv

### Avançats

**5- Implementeu un script que mostri la pokedex en ordre invers. Però mantenint la primera línia com a capçalera.**

#Aquest es un codi alternatiu utilitzant un bucle for per la sortida de manera que mostri l'ordre invers del fitxer csv
awk -F, '
NR == 1 { 
    header = $0  # Guardem la capçalera
    next        # Saltem a la següent línia
} 
{
    count[NR] = $0  # Guardem cada línia a un array indexat per NR
}
END {
    # Imprimim la capçalera
    print header   
    # Imprimim les línies en ordre invers
    for (i = NR; i > 1; i--) {
        print count[i]  
    }
}' pokemon.csv





