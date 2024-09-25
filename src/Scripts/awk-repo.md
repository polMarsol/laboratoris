# Repositori d'exercicis

Aquesta secció conté els exercicis realitzats pels estudiants de l'assignatura d'Administració i Manteniment de Sistemes i Aplicacions (AMSA).

## Exercicis

### Bàsics

# 1. Filtrar pokémons de tipus foc i mostrar nom, tipus 1 i tipus 2

    ```awk
    awk -F, '
    $3 == "Fire" || $4 == "Fire" {  # Comprovem si el tipus 1 o tipus 2 és "Fire"
        print $2, $3, $4  # Imprimim el nom, tipus 1 i tipus 2
    }' pokemon.csv
    ```
    
    **Explicació**: El patró `Fire` busca les línies que contenen aquesta paraula, i amb `cut` o amb AWK s’imprimeixen les columnes 2, 3 i 4 (nom i tipus del pokémon).

2. **Imprimir els pokémons que tinguin una "b" o "B" seguida de "ut" i mostrar només el nom del pokémon**

    Aquest exercici cerca pokémons que contenen "but" o "But" en el seu nom i imprimeix només el nom (columna 2):

    *En AWK*:

    ```bash
    awk -F, '/[bB]ut/ {print $2}' pokemon.csv
    ```

    **Explicació**: L'expressió regular `[bB]ut` cerca qualsevol coincidència de "b" o "B" seguida de "ut" a la columna 2.

3. **Imprimir pokémons que comencin per "K" majúscula i mostrar només el nom**

    Aquest exercici imprimeix els pokémons el nom dels quals comença per "K":

    *En AWK*:

    ```bash
    awk -F, '$2 ~ /^K/ {print $2}' pokemon.csv
    ```

    **Explicació**: El símbol `^` dins de l'expressió regular indica que el patró ha de coincidir amb l'inici de la línia (nom del pokémon).

4. **Mostrar els pokémons que siguin del tipus foc o lluita, imprimint nom, tipus 1 i tipus 2**

    Aquest exercici cerca pokémons que siguin del tipus "Fire" o "Fighting" i imprimeix el nom i els seus tipus:

    *En AWK*:

    ```bash
    awk -F, '/Fire|Fighting/ {print $2,$3,$4}' pokemon.csv
    ```

    **Explicació**: S'utilitza l'operador `|` per combinar dos patrons ("Fire" o "Fighting").

5. **Imprimir el nom dels pokémons de la primera generació que són llegendaris**

    Aquest exercici filtra els pokémons que pertanyen a la primera generació (columna 12) i són llegendaris (columna 13):

    *En AWK*:

    ```bash
    awk -F, '$12 == 1 && $13 == "True" {print $2}' pokemon.csv
    ```

    **Explicació**: Utilitzem la condició `$12 == 1` per verificar que el pokémon és de la primera generació i `$13 == "True"` per comprovar si és llegendari.

### Intermedis

### Exemple 1: Comptar línies sense utilitzar una variable explícita
# Aquest script compta el nombre total de línies del fitxer pokemon.csv
# Utilitza la variable interna NR que compta les línies processades automàticament.
awk 'END{ print NR }' pokemon.csv


### Exemple 2: Comprovar que la suma dels atributs coincideix amb el total (Filtrar només Pokémons de tipus 'Foc')
# Aquest script filtra només els Pokémons de tipus 'Foc' i comprova si la columna "Total" és igual a la suma de les columnes 6 a 11.
awk -F, '$3 == "Fire" { print $2"->Total="$5"=="($6+$7+$8+$9+$10+$11)}' pokemon.csv


### Exemple 3: Traduir la capçalera al català i ometre les línies incorrectes
# Traduïm la capçalera al català i descartem les línies amb menys de 13 columnes
awk 'NR==1 { $1="#"; $2="Nom"; $3="Tipus 1"; $4="Tipus 2"; $5="Total"; $6="HP"; $7="Atac"; $8="Defensa"; $9="Atac Especial"; $10="Defensa Especial"; $11="Velocitat"; $12="Generació"; $13="Llegendari"; print $0 } NF == 13 {print}' pokemon.csv


### Exemple 4: Comptar Pokémons de tipus Foc de la primera generació (sense Mega)
# Aquest script compta els Pokémons de tipus 'Foc' de la primera generació, excloent els que tenen 'Mega' al nom.
awk -F, '$3 == "Fire" && $12 == 1 && $2 !~ /Mega/ { n++ } END{ print "There are", n, "fire type pokemons in the first generation without Mega evolutions." }' pokemon.csv


### Exemple 5: Imprimir el nom del Pokémon i si és llegendari o no, filtrant per tipus 'Drac'
# Aquest script filtra només els Pokémons de tipus 'Drac' i imprimeix si són llegendaris o comuns.
awk -F, '$3 == "Dragon" { print $2, "és", ($13 == "True" ? "un pokémon llegendari" : "un pokémon comú") }' pokemon.csv


### Avançats

# Exemple 1: Mostrar la pokedex en ordre invers, mantenint la capçalera
awk -F, '
NR==1 {header=$0; next}  # Guardem la capçalera
{data[NR]=$0}  # Guardem les dades en un array
END {
    print header  # Imprimim la capçalera
    for (i=NR; i>1; i--) 
        print data[i]  # Imprimim les dades en ordre invers
}' pokemon.csv

# Exemple 2: Ordenar pel camp Total de forma numèrica
awk -F, '
{
    total[$1] = $0  # Guardem cada registre amb el nom com a clau
    totals[NR] = $5  # Guardem el total per ordenar
}
END {
    asort(totals, sorted)  # Ordenem l'array de totals
    for (i=1; i<=length(sorted); i++)
        print total[sorted[i]]  # Imprimim els registres ordenats
}' pokemon.csv

# Exemple 3: Taula resum amb els pokemons de cada tipus a cada generació
awk -F, '
BEGIN {
    print "| Tipus      | Gen 1 | Gen 2 | Gen 3 | Gen 4 | Gen 5 | Gen 6 |"
    print "|------------|-------|-------|-------|-------|-------|-------|"
}
{
    types[$3][$12]++  # Comptem els tipus per generació
    types[$4][$12]++  # Comptem el segon tipus també
}
END {
    for (type in types) {
        printf "| %-10s |", type  # Formategem la sortida
        for (gen=1; gen<=6; gen++) {
            printf " %-5d |", types[type][gen]
        }
        print ""
    }
}' pokemon.csv

# Exemple 4: Transformar pokemon.csv a pokemon.json
awk -F, '
BEGIN {
    print "["
}
{
    printf "  {\n    \"Name\": \"%s\",\n    \"Type 1\": \"%s\",\n    \"Type 2\": \"%s\",\n", $1, $3, $4
    printf "    \"Total\": %s,\n    \"HP\": %s,\n    \"Attack\": %s,\n    \"Defense\": %s,\n", $5, $6, $7, $8
    printf "    \"Sp. Atk\": %s,\n    \"Sp. Def\": %s,\n    \"Speed\": %s,\n    \"Generation\": %s,\n", $9, $10, $11, $12
    printf "    \"Legendary\": %s\n  }%s\n", ($13=="True"?"true":"false"), (NR==END?"":" ,")
}
END {
    print "]"
}' pokemon.csv > pokemon.json

# Exemple 5: Simular un combat entre dos pokémons
#!/bin/bash
pokemon1=$1
pokemon2=$2

awk -F, -v p1="$pokemon1" -v p2="$pokemon2" '
{
    if ($1 == p1) {hp1=$6; atk1=$7; def1=$8; spd1=$9}
    if ($1 == p2) {hp2=$6; atk2=$7; def2=$8; spd2=$9}
}
END {
    while (hp1 > 0 && hp2 > 0) {
        if (spd1 >= spd2) {
            dmg = (atk1 - def2) * rand()
            hp2 -= dmg
            print p1 " ataca " p2 " amb " dmg " danys! " p2 " té " hp2 " HP restant."
        } else {
            dmg = (atk2 - def1) * rand()
            hp1 -= dmg
            print p2 " ataca " p1 " amb " dmg " danys! " p1 " té " hp1 " HP restant."
        }
    }
}' pokemon.csv
