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
