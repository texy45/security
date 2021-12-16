#!/bin/bash

if  (( $# != 1 ))
then
	printf "[-] %s <fichier liste d'ip à scanner>\n" $0
	exit
fi

lip=$1
fout="./res.tmp"
fport="./ports.tmp"

for ip in `cat ${lip}`
do
	# identification des ports et services ouverts
	# -sS: scan en mode furtif
	# -PN: on ne ping pas le serveur avant le scan afin de contourner la désactivation du protocole icmp
	nmap -sS -PN -p- ${ip} -o ${fout} >/dev/null;grep -i open ${fout}|cut -f 1 -d />${fport};rm ${fout};

	# mise en forme de la liste des ports ouverts au format: <port1>,<port2>,...
	lp=""
	for p in `sort -u ${fport}`
	do	
		lp=${lp}${p}","
	done

	
	rm ${fport}

	# recherche des vulnerabilités pour chaque service ouvert
	# -sVC: recherche de la version et type de service; on exécute un script d'attaque par défaut sur chaque service trouvé
	nmap -sVC -PN -p ${lp} ${ip};

done


