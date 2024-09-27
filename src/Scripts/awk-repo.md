# Repositori d'exercicis

Aquesta secció conté els exercicis realitzats pels estudiants de l'assignatura d'Administració i Manteniment de Sistemes i Aplicacions (AMSA).

## Exercicis

- Comanda que permeti imprimir totes les línies que comencin per un "M" majúscula. Mostra només el nom del pokémon (columna 2).

    ```bash
    awk -F, '{ if ($2 ~ /^M/) print $2 }' pokemon.csv
    ```

    Aquesta solució utilitza una estructura if dins de l'script awk per verificar si una línia compleix la condició que volem. En aquest cas, la condició és que el nom del Pokémon (que es troba a la segona columna del CSV) comenci amb la lletra "M" majúscula.

- Imprimiu tots els pokemons que siguin del tipus herba i fosc. Imprimiu el nom, tipus 1 i tipus 2. Podeu fer servir l'operador && per crear l'expressió regular.

    ```bash
    awk -F, '{ if ($3 == "Grass" && $4 == "Dark") print $2, $3, $4 }' pokemon.csv
    ```

    Aquesta alternativa utilitza el bloc BEGIN dins de awk. Aquest bloc s'executa abans que el programa comenci a processar les línies del fitxer. L'ús principal és configurar coses que volem que estiguin preparades abans de començar, com ara definir el delimitador de camps (en aquest cas, una coma perquè és un CSV).

- Substituir totes les aparicions d'una paraula en un fitxer `.csv` fer una versió amb `sed` i una altra amb `awk`.

  - **Versió amb `awk`**:

    ```bash
    awk -F, '{gsub(/paraula_antiga/, "paraula_nova"); print}' pokemon.csv
    ```

    **Explicació:**

    - `gsub(/paraula_antiga/, "paraula_nova")` és una funció d'AWK que reemplaça totes les aparicions de "paraula_antiga" per "paraula_nova" en cada línia.
    - AWK processa el fitxer línia per línia i realitza la substitució globalment (similar al comportament de `sed` amb l'opció `g`).
    - Després de fer la substitució, imprimeix la línia modificada.

  - **Versió amb `sed`**:

    ```bash
    sed 's/paraula_antiga/paraula_nova/g' pokemon.csv
    ```

- Comanda per simular `head -n 5 pokemon.csv` amb `awk`.

    ```bash
    awk 'NR <= 5' pokemon.csv
    ```

    Aquesta solució utilitza la variable NR d'AWK, que representa el número de registre (línia) actual. La condició `NR <= 5` assegura que només s'imprimeixin les primeres 5 línies del fitxer.

- Comanda per simular `tail -n 5 pokemon.csv` amb `awk`.

    ```bash
    awk '{line[NR] = $0} END {for (i = NR-4; i <= NR; i++) print line[i]}' pokemon.csv
    ```

    **Explicació**:
      - AWK no té una funció nativa com `tail` per accedir directament a les últimes línies, per la qual cosa aquí utilitzem un array.
      - `line[NR] = $0` emmagatzema cada línia del fitxer en l'array `line`, utilitzant el número de línia (`NR`) com a índex.
      - Al bloc `END`, quan AWK ha acabat de processar totes les línies, imprimim les últimes 5 línies. L'expressió `for (i = NR-4; i <= NR; i++)` recorre les últimes 5 línies de l'array (de `NR-4` a `NR`).

- Cerca el Pokémon més fort i mes feble de tipus Planta.

    ```bash
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

- Transformar noms de Pokémon a majúscules.

    ```bash
    awk -F, 'BEGIN {OFS=","} 
    { 
        $2 = toupper($2); 
        print 
    }' pokemon.csv
    ```

- Comanda que permeti comptar tots els pokemons que tenim a la pokedex i que tingui la sortida següent:

    ```bash
    awk 'BEGIN { print "Counting pokemons..." } NR > 1 { } END { print "There are", NR-1, "pokemons." }' pokemon.csv
    ```

- Implementeu un script que permeti comptar el nombre de pokemons de tipus aigua i roca. La sortida ha de ser semblant a:

    ```bash
    Water: 64
    Rock: 50
    Others: 689
    ```

    ```bash
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
    ```

- Implementeu un script que mostri la pokedex en ordre invers. Però mantenint la primera línia com a capçalera.

    ```bash
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
    ```

- Implementeu un filtre que mostri els pokemons de tipus foc. Mostra nom, tipus 1 i tipus 2.

    ```bash
    awk -F, '
    $3 == "Fire" || $4 == "Fire" || $3 == "Fighting" || $4 == "Fighting" {
        print $2, $3, $4
    }' pokemon.csv
    ```

- Implementeu un script que mostri el nom dels pokemons que tinguin una "b" o "B" seguida de "ut". Mostra només el nom del pokémon.

    ```bash
    awk -F, '/[bB]ut/ {print $2}' pokemon.csv
    ```

- Implementeu un script que mostri els pokemons que comencin per "K" majúscula. Mostra només el nom del pokémon.

    ```bash
    awk -F, '$2 ~ /^K/ {print $2}' pokemon.csv
    ```

- Mostra els pokemons que siguin del tipus foc o lluita. Imprimeix nom, tipus 1 i tipus 2.

    ```bash
    awk -F, '/Fire|Fighting/ {print $2, $3, $4}' pokemon.csv
    ```

- Imprimir el nom dels pokemons de la primera generació que siguin llegendaris.

    ```bash
    awk -F, '$12 == 1 && $13 == "True" {print $2}' pokemon.csv
    ```

- Coomptar les línies del fitxer pokemon.csv sense utilitzar una variable explícita.

    ```bash
    awk 'END{ print NR }' pokemon.csv
    ```

- Comprouvar que la suma dels atributs coincideix amb el total (Filtrar només Pokémons de tipus 'Foc').

    ```bash
    awk -F, '$3 == "Fire" { print $2"->Total="$5"=="($6+$7+$8+$9+$10+$11)}' pokemon.csv
    ```

- Traduïm la capçalera al català i ometre les línies incorrectes.

    ```bash
    awk 'NR==1 { $1="#"; $2="Nom"; $3="Tipus 1"; $4="Tipus 2"; $5="Total"; $6="HP"; $7="Atac"; $8="Defensa"; $9="Atac Especial"; $10="Defensa Especial"; $11="Velocitat"; $12="Generació"; $13="Llegendari"; print $0 } NF == 13 {print}' pokemon.csv
    ```

- Comptar Pokémons de tipus Foc de la primera generació (sense Mega).

    ```bash
    awk -F, '$3 == "Fire" && $12 == 1 && $2 !~ /Mega/ { n++ } END{ print "There are", n, "fire type pokemons in the first generation without Mega evolutions." }' pokemon.csv
    ```

- Imprimir el nom del Pokémon i si és llegendari o no, filtrant per tipus 'Drac'.

    ```bash
    awk -F, '$3 == "Dragon" { print $2, "és", ($13 == "True" ? "un pokémon llegendari" : "un pokémon comú") }' pokemon.csv
    ```
