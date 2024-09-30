# Repositori d'exercicis

Aquesta secció conté els exercicis realitzats pels estudiants de l'assignatura d'Administració i Manteniment de Sistemes i Aplicacions (AMSA).

## Exercicis
### 1. Get a battling challenge

```awk
awk -F, 'BEGIN{srand()}
NR>1 {pokemons[NR-1]=$2; tipos[NR-1]=$3}
END {
    random_poke = pokemons[int(rand() * (NR-2))];
    random_type = tipos[int(rand() * (NR-2))];
    print "Desafío Pokémon: ¡Gana una batalla usando solo Pokémon de tipo " random_type " contra " random_poke "!";
}' pokemon.csv
```
Aquest script fa el següent:
- Utilitza ',' com a separador de camps (`-F,`).
- Selecciona un Pokémon i un tipus a l'atzar (`int(rand() * (NR-2))`).
- Imprimeix un desafiament on s'ha de guanyar una batalla utilitzant només Pokémon del tipus seleccionat contra el Pokémon aleatori.


### 2. Expedition inform

```awk
awk -F, -v gen=1 '
NR>1 && $12 == gen {
    pokemons[$2] = $0;
    if ($11 > max_speed) { max_speed = $11; fastest = $2 }
    if ($7 > max_attack) { max_attack = $7; strongest = $2 }
}
END {
    print "Pokémon más rápido de la generación " gen ": " fastest;
    print "Pokémon más fuerte de la generación " gen ": " strongest;
}' pokemon.csv
```
Aquest script fa el següent:
- Utilitza ',' com a separador de camps (`-F,`).
- Filtra amb una expressió regular el pokemon amb la generació especificada per usuari i evita la capçalera.
- Es guarda el pokemon amb la velocitat i el pokemon l'atac més alt de la generació (`if ($7 > max_attack) { max_attack = $7; strongest = $2 }`) amb una estructura d'`if`.

### 3. Get your pokemon personality

```awk
awk -F, -v personalidad="agresivo" '
NR>1 {
    if ($7 > 80) {tipo_personalidad="agresivo"}
    else if ($8 > 80) {tipo_personalidad="defensivo"}
    else {tipo_personalidad="equilibrado"}
    
    if (tipo_personalidad == personalidad) {
        print $2 " tiene una personalidad similar a la tuya!";
    }
}' pokemon.csv
```
Aquest script fa el següent:
- Analitza les estadístiques d'atac i defensa dels Pokémon:
    atac > 80 -> agresivo
    defensa > 80 -> defensivo
    atac && defensa < 80 -> equilibrat
- Imprimeix els Pokémon que comparteixen la mateixa personalitat que la introduïda per l'usuari.

### 4. Personalized Mega Evolution
#### Ús de paràmetres d'entrada -v
```awk
awk -F, -v poke="Charizard" -v aumento=1.2 '
NR==1 {print $0; next} 
tolower($2) == tolower(poke) {
    $6 = int($6 * aumento);
    $7 = int($7 * aumento);
    $8 = int($8 * aumento);
    $9 = int($9 * aumento);
    $10 = int($10 * aumento);
    $11 = int($11 * aumento);
    print "Mega evolución de " $2 ": " $0;
}' pokemon.csv
```
Aquest script fa el següent:
- Aplica un increment/decrement introduit per l'usuari a totes les estadístiques del Pokémon especificat, simulant una "Mega Evolució".
- Mostra les noves estadístiques després de l'evolució.


### 5. Comprovar espai del disc
#### Ús de bash i awk
```bash
#!/bin/bash
THRESHOLD=90

 USAGE=$(df / | grep / | awk '{ print $5 }' | sed 's/%//g')

  if [ $USAGE -gt $THRESHOLD ]; then
    echo "Advertencia: L'ús del disc està per sobre del $THRESHOLD% (Actualment: $USAGE%)"
  else
    echo "L'ús del disc és del $USAGE%, tot està bé."
  fi
```
Aquest script fa el següent:
- Comprova l'ús del disc al sistema per evitar greus escenaris per falta d'espai.
- Mostra un avís si l'ús del disc supera el 90% o el desitjat, preferiblement 90%.
- Si l'ús és inferior, indica que l'estat del disc és correcte.
