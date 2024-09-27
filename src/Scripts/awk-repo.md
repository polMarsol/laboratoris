# Repositori d'exercicis

Aquesta secció conté els exercicis realitzats pels estudiants de l'assignatura d'Administració i Manteniment de Sistemes i Aplicacions (AMSA).

## Exercicis

### Bàsics

### 1. Exemple amb `sed`

Substituir totes les aparicions d'una paraula en un fitxer `.csv` .

#### Versió en Bash (sed):
```bash
sed 's/paraula_antiga/paraula_nova/g' pokemon.csv
```
**Explicació:**
- La comanda `sed` cerca i reemplaça totes les aparicions de la paraula "paraula_antiga" per "paraula_nova" en el `pokemon.csv`.
- La `s` indica una substitució.
- La `g` al final significa que es realitza de forma global, és a dir, en totes les ocurrències de la línia, no només en la primera coincidència.

#### Versió en AWK:
```awk
awk -F, '{gsub(/paraula_antiga/, "paraula_nova"); print}' pokemon.csv
```
**Explicació:**
- `gsub(/paraula_antiga/, "paraula_nova")` és una funció d'AWK que reemplaça totes les aparicions de "paraula_antiga" per "paraula_nova" en cada línia.
- AWK processa el fitxer línia per línia i realitza la substitució globalment (similar al comportament de `sed` amb l'opció `g`).
- Després de fer la substitució, imprimeix la línia modificada.

### 2. Exemple amb head

Mostrar les primeres 5 línies d'un fitxer `.csv`.

#### Versió en Bash (head):
```bash
head -n 5 pokemon.csv 
```
**Explicació:**
- La comanda `head` mostra les primeres 5 línies del `pokemon.csv`.
- L'opció `-n 5` indica que volem veure específicament les primeres 5 línies del fitxer `pokemon.csv`.

#### Versió en AWK:
```awk
awk 'NR <= 5 {print}' pokemon.csv
```
**Explicació:**
- En AWK, `NR` és una variable interna que representa el número de línia (Número de Registre).
- La condició `NR <= 5` assegura que només s'imprimeixin les primeres 5 línies del fitxer.
- Per a cada línia que compleix aquesta condició, la comanda `{print}` la imprimeix.

### Intermedis

### 3. Exemple amb tail

Mostrar les últimes 5 línies d'un fitxer `.csv`.

#### Versió en Bash (tail):
```bash
tail -n 5 pokemon.csv 
```
**Explicació:**
- La comanda `tail` mostra les últimes 5 línies del fitxer `pokemon.csv`.
- L'opció `-n 5` indica que volem veure específicament les últimes 5 línies del fitxer.

#### Versió en AWK:
```awk
awk '{line[NR] = $0} END {for (i = NR-4; i <= NR; i++) print line[i]}' pokemon.csv
```
**Explicació:**
- AWK no té una funció nativa com `tail` per accedir directament a les últimes línies, per la qual cosa aquí utilitzem un array.
- `line[NR] = $0` emmagatzema cada línia del fitxer en l'array `line`, utilitzant el número de línia (`NR`) com a índex.
- Al bloc `END`, quan AWK ha acabat de processar totes les línies, imprimim les últimes 5 línies. L'expressió `for (i = NR-4; i <= NR; i++)` recorre les últimes 5 línies de l'array (de `NR-4` a `NR`).

### 4. Trobar el Pokémon més fort i més feble de tipus Planta

Aquest script troba el Pokémon més fort i més feble de tipus Planta basant-se en el valor de la columna "Attack" (columna 7).

#### Versió en Bash:
```bash
#!/bin/bash
max=0
min=100
while IFS=, read -r col1 col2 col3 col4 col5 col6 col7 col8 col9 col10 col11 col12 col13; do
    if [[ "$col3" == "Grass" ]]; then
        if [[ "$col7" -gt "$max" ]]; then
            max=$col7
            strongest=$col2
        fi
        if [[ "$col7" -lt "$min" ]]; then
            min=$col7
            weakest=$col2
        fi
    fi
done < pokemon.csv
echo "Weakest: $weakest"
echo "Strongest: $strongest"
```
**Explicació:**
- En un bucle `while`, es llegeixen els valors de les columnes. Si el Pokémon és de tipus Planta, es comparen els valors d'atac amb els màxims i mínims actuals, actualitzant `max` i `min` en conseqüència.

#### Versió en AWK:
```awk
awk -F, 'BEGIN { max=0; min=100 } 
{ 
    if ($3 == "Grass") { 
        if ($7 > max) { 
            max=$7; 
            strongest=$2 
        } 
        if ($7 < min) { 
            min=$7; 
            weakest=$2 
        } 
    } 
} 
END { 
    print "Weakest:", weakest; 
    print "Strongest:", strongest 
}' pokemon.csv
```
**Explicació:**
- Es filtren els Pokémon de tipus Planta amb `if ($3 == "Grass")` i es compara el valor d'atac (columna 7) per determinar quins són els més forts i els més febles. Les variables `max` i `min` s'actualitzen segons correspongui.

### Avançats

### 5: Transformar noms de Pokémon a majúscules

Aquest script transforma tots els noms dels Pokémon a majúscules.

#### Versió en AWK:
```awk
awk -F, 'BEGIN {OFS=","} 
{ 
    $2 = toupper($2); 
    print 
}' pokemon.csv
```

**Explicació:**
- Utilitzem la funció `toupper()` per convertir els noms de Pokémon (columna 2) a majúscules. S'imprimeix la línia modificada.
  
#### Versió en Bash:
```bash
#!/bin/bash
while IFS=, read -r col1 col2 col3 col4 col5 col6 col7 col8 col9 col10 col11 col12 col13; do
    col2=$(echo "$col2" | tr '[:lower:]' '[:upper:]')
    echo "$col1,$col2,$col3,$col4,$col5,$col6,$col7,$col8,$col9,$col10,$col11,$col12,$col13"
done < pokemon.csv
```

**Explicació:**
- S'utilitza la comanda `tr` per transformar a majúscules cada nom mentre es llegeixen les línies.

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
