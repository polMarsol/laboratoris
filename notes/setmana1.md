# Informe de la Setmana 1

## APUNTS CLASSE - Passar a net.
Quan crees una màquina virtual es crea una adreça cap aquesta i una clau única. Al borrar-la i al crear-ne una de nova pot ser que se li adjudiqui la mateixa adreça a la nova MV. I llavors la clau única ja no ens servirà perquè és independent de cada MV. Llavors s'ha d'accedir a Users/Pol/.ssh/known_hosts i borrar les claus ja conegudes perquè ens en dongui una altra. 1 clau serveix per 1 MV.
MV: A Adreça(A)= 127.0.1 Clau(A)= 1234, si borro A i creo B Adreça(B)= 127.0.1 clau(b) != clau(a), la mateixa clau no serveix.

Per donar-li a una ip un nom es pot fer servir: alias, també es pot fer servir amb el hostname.

Pots crear un proxy que agafi totes les adreces que es vulguin connectar a internet i pots privar que entri.
ipaddr per saber l'adreça de la teva màquina.

Crear nou script per arrancar la mv i connectar-te a ssh: vmrun start C:\Users\Pol Marsol\OneDrive\Documentos\Virtual Machines\Debian 12.x 64-bit

su - Per entrar com admin amb totes les variables d'entorn carregades.

head 10 primeres entrades
wc -l conta les linies
tail les 10 últimes
head -1 pokemon.csv | tr ',' '\n' | wc -l Contarà totes les columnes del fitxer.

## Certificació AWS
He avançat en el primer tema de Amazon Web Services, tot i que al llarg de la setmana següent m'he establert arribar al tema 3.

## Scripts
Ja he fet tots els 5 scripts corresponents a l'activitat avaluativa dels conceptes de Bash i Awk.
