# Repositori d'exercicis

Aquesta secció conté els exercicis realitzats pels estudiants de l'assignatura d'Administració i Manteniment de Sistemes i Aplicacions (AMSA).

## Exercicis

### Bàsics

### 1. Pokémon amb lletra repetida tres vegades consecutives

```awk
awk -F, '$2 ~ /(.)\1\1/ {print $2}' pokemon.csv
```

Aquest script fa el següent:
- Utilitza ',' com a separador de camps (`-F,`).
- Busca en el segon camp (`$2`, que és el nom del Pokémon) un patró on qualsevol caràcter (`.`) es repeteix exactament tres vegades consecutives (`\1\1`).
- Imprimeix el nom del Pokémon si compleix aquesta condició.

### 2. Pokémon amb nom palindròmic

```awk
awk -F, 'function reverse(str) {
    res = ""
    for (i = length(str); i > 0; i--)
        res = res substr(str, i, 1)
    return res
}
$2 == reverse($2) {print $2}' pokemon.csv
```

Aquest script:
- Defineix una funció `reverse` que inverteix una cadena de text.
- Compara el nom del Pokémon (`$2`) amb la seva versió invertida.
- Imprimeix el nom si són iguals, indicant que és un palíndrom.

### 3. Pokémon amb tipus primari que comença i acaba amb la mateixa lletra

```awk
awk -F, 'substr($3, 1, 1) == substr($3, length($3), 1) {print $2, $3}' pokemon.csv
```

Aquest script:
- Compara la primera lletra del tercer camp (`$3`, tipus primari) amb l'última.
- Si són iguals, imprimeix el nom del Pokémon (`$2`) i el seu tipus primari (`$3`).


### Intermedis

### 1. Mitjana d'atac per tipus primari

```awk
awk -F, 'NR>1 {sum[$3] += $7; count[$3]++} 
END {
    for (type in sum) 
        printf "%-10s: %.2f\n", type, sum[type]/count[type]
}' pokemon.csv | sort -k2 -rn
```

Aquest script:
- Suma l'atac (`$7`) per a cada tipus primari (`$3`) i compta quants Pokémon hi ha de cada tipus.
- Al final, calcula i imprimeix la mitjana d'atac per a cada tipus.
- Ordena els resultats de major a menor mitjana d'atac.

### 2. Combinacions més rares de tipus primari i secundari

```awk
awk -F, 'NR>1 {combo[$3 "-" $4]++} 
END {
    for (c in combo)
        if (combo[c] == 1) print c
}' pokemon.csv
```

Aquest script:
- Crea una clau única per cada combinació de tipus primari (`$3`) i secundari (`$4`).
- Compta quantes vegades apareix cada combinació.
- Imprimeix només les combinacions que apareixen una sola vegada.

### 3. Histograma ASCII de distribució de velocitats

```awk
awk -F, 'NR>1 {speed[int($11/10)]++} 
END {
    for (i=0; i<=20; i++) {
        printf "%3d-%3d: ", i*10, (i+1)*10-1
        for (j=0; j<speed[i]; j+=5) printf "*"
        print ""
    }
}' pokemon.csv
```

Aquest script:
- Agrupa les velocitats (`$11`) en rangs de 10.
- Crea un histograma ASCII on cada '*' representa 5 Pokémon en aquell rang de velocitat.



### Avançats

1. Crear un sistema de recomanació simple que suggereixi Pokémon similars basats en estadístiques:

### 1. Sistema de recomanació simple

```awk
awk -F, '
function dist(a,b,c,d,e,f, x,y,z,w,v,u) {
    return sqrt((a-x)^2 + (b-y)^2 + (c-z)^2 + (d-w)^2 + (e-v)^2 + (f-u)^2)
}
NR==1 {print "Nom del Pokémon de referència:"; getline ref < "/dev/tty"}
$2 == ref {p=$2; a=$6; b=$7; c=$8; d=$9; e=$10; f=$11}
NR>1 && $2 != ref {
    similarity = dist(a,b,c,d,e,f, $6,$7,$8,$9,$10,$11)
    printf "%s %.2f\n", $2, similarity
}' pokemon.csv | sort -k2 -n | head -5
```

Aquest script:
- Demana a l'usuari un Pokémon de referència.
- Calcula la "distància" entre les estadístiques del Pokémon de referència i tots els altres.
- Mostra els 5 Pokémon més similars basats en aquesta distància.

### 2. Generador de noms de Pokémon

```awk
BEGIN {srand()}
NR>1 {
    split($2, chars, "")
    for (i in chars) {
        prefix[length(prefix)+1] = substr($2, 1, i)
        suffix[length(suffix)+1] = substr($2, i+1)
    }
}
END {
    for (i=1; i<=10; i++) {
        p = prefix[int(rand() * length(prefix)) + 1]
        s = suffix[int(rand() * length(suffix)) + 1]
        print p s
    }
}' pokemon.csv
```

Aquest script:
- Divideix cada nom de Pokémon en tots els possibles prefixos i sufixos.
- Genera 10 nous noms combinant aleatòriament aquests prefixos i sufixos.

### 3. Sistema de puntuació d'equilibri

```awk
awk -F, '
function stdev(sum, sumsq, n) {
    return sqrt(sumsq/n - (sum/n)^2)
}
NR>1 {
    sum = $6 + $7 + $8 + $9 + $10 + $11
    sumsq = $6^2 + $7^2 + $8^2 + $9^2 + $10^2 + $11^2
    score = sum / stdev(sum, sumsq, 6)
    printf "%s: %.2f\n", $2, score
}' pokemon.csv | sort -k2 -rn | head -10
```

Aquest script:
- Calcula una puntuació d'equilibri per a cada Pokémon basada en la suma de les seves estadístiques dividida per la desviació estàndard d'aquestes.
- Una puntuació alta indica un Pokémon amb estadístiques altes i equilibrades.
- Mostra els 10 Pokémon més equilibrats segons aquesta mètrica.
