#!/bin/bash

# -h kapcsoló
if [ $# -ne 4 ] && [[ $1 != "-n" ]]; then
	echo "Ez a script kiszamitja maganszemelyek adojat."
	echo "Hasznalat: "$0 "<havi brutto jovedelem> <egyeb brutto jovedelem> <osztondij> <szoctam>"
	echo "Minden argumentum tipusa egy egesz szam!"
	exit 1
fi

RE='^[0-9]+$'	# Szam formatum
MVJ=0.015		# Munkavallaloi jarulek
MNYP=0.08		# Magannyugdijpenztar
NYJ=0.015		# Nyugdij jarulek
EUJ=0.02		# Egeszsegugyi jarulek
EBJ=0.04		# Egeszsegbiztositasi jarulek
LIMIT=1700000

echo ""

# -n kapcsoló
if [[ $1 == "-n" ]]; then
	if ! [[ $2 =~ $RE ]]; then
		echo "Hiba: Hianyzik egy argumentum, vagy ervenytelen tipus"
		exit 1
	fi

	haviJovedelem=$(echo "$2 / 0.65" | bc)
	echo "Havi jovedelem: $haviJovedelem Ft"

	evesJovedelem=$(($haviJovedelem * 12))
	echo "Eves jovedelem: $evesJovedelem Ft"

	if [[ $evesJovedelem -gt $LIMIT ]]; then
		felsoResz=$(($evesJovedelem - $LIMIT))
		seged=$(echo "$felsoResz * 0.36" | bc)

		seged2=$(echo "$LIMIT * 0.18" | bc)
		szja=$(echo "$seged + $seged2" | bc)
		szja=$(echo "$szja / 12" | bc)
	else
		szja=$(echo "$evesJovedelem * 0.18" | bc)
	fi

	echo "Szemelyi jovedelem ado: $szja Ft"
	echo "Munkavallaloi jarulek: "$(echo "$haviJovedelem * $MVJ" | bc)" Ft"
	echo "Magannyugdijpenztar: "$(echo "$haviJovedelem * $MNYP" | bc)" Ft"
	echo "Egeszsegugyi jarulek: "$(echo "$haviJovedelem * $EUJ" | bc)" Ft"
	echo "Egeszsegbiztositasi jarulek: "$(echo "$haviJovedelem * $EBJ" | bc)" Ft"
	echo "Nyugdij jarulek: "$(echo "$haviJovedelem * $NYJ" | bc)" Ft"
	exit
fi

# Argumentumok ellenőrzése
for i in $@; do
	if ! [[ $i =~ $RE ]]; then
		echo "Hiba: $i ervenytelen tipusu argumentum"
		exit 1
	fi
done

haviJovedelem=$(($1 + $2 + $3 + $4))
evesBrutto=$(($haviJovedelem * 12))

if [[ $evesBrutto -gt $LIMIT ]]; then
	felsoResz=$(echo "$evesBrutto - $(($3 * 12)) - $(($4 * 12))" | bc)
	felsoResz=$(echo "$substract2 - $LIMIT" | bc)

	seged=$(echo "$LIMIT * 0.18" | bc)
	seged2=$(echo "$felsoResz * 0.36" | bc)

	szja=$(echo "$seged + $seged2" | bc)
	szja=$(echo "$szja / 12" | bc)
else
	szja=$(echo "$(($1 + $2)) * 0.18" | bc)
fi

haviBruttoJovedelem=$(($1 + $2))
munkaVallaloiJarulek=$(echo "$haviBruttoJovedelem * 1.5 / 100" | bc)
maganNyugdijPenztar=$(echo "$haviBruttoJovedelem * $MNYP" | bc)
egeszsegUgyiJarulek=$(echo "$haviBruttoJovedelem * $EUJ" | bc)
egeszsegBiztositasiJarulek=$(echo "$haviBruttoJovedelem * $EBJ" | bc)
nyugdijJarulek=$(echo "$haviBruttoJovedelem * 1.5 / 100" | bc)
nettoJovedelem=$(echo "($haviBruttoJovedelem - $szja - $munkaVallaloiJarulek - $maganNyugdijPenztar - $egeszsegUgyiJarulek - $egeszsegBiztositasiJarulek - $nyugdijJarulek) + $3 + $4" | bc)

echo "Havi jovedelem: $haviJovedelem Ft"
echo "Eves brutto jovedelem: $evesBrutto Ft"
echo "Szemelyi jovedelem ado: $szja Ft"
echo ""

echo "Munkavallaloi jarulek: $munkaVallaloiJarulek Ft"
echo "Magannyugdij penztar: $maganNyugdijPenztar Ft"
echo "Egeszsegugyi jarulek:: $egeszsegUgyiJarulek Ft"
echo "Egeszsegbiztositasi jarulek: $egeszsegBiztositasiJarulek Ft"
echo "Nyugdij jarulek: $nyugdijJarulek Ft"
echo "Netto jovedelem: $nettoJovedelem Ft"
echo ""

function adoJovairasOsszege {
	unset adoJovaIras
	while [ -z "$adoJovaIras" ]; do
		read -p 'Add meg a havi adojovairas osszeget: ' adoJovaIras
	done

	if [[ $adoJovaIras -lt 0 ]] || [[ $adoJovaIras -gt 9000 ]]; then
		echo "Hiba: Az adojovairas osszege 0-9000 kozott van!"
		adoJovairasOsszege
	fi

	if ! [[ $adoJovaIras =~ $RE ]]; then
		echo "Hiba: Ervenytelen formatun!"
		adoJovairasOsszege
	fi
}

if ! [[ $evesBrutto -gt 1400000 ]]; then
	adoJovairasOsszege
	uj_netto=$(echo "$nettoJovedelem + $adoJovaIras" | bc )
	uj_szja=$(echo "$szja - $adoJovaIras" | bc)

	echo ""
	echo "Adojovairas utan:"
	echo "Szemelyi jovedelem ado : $uj_szja Ft"
	echo "Netto jovedelem: $uj_netto Ft"
fi