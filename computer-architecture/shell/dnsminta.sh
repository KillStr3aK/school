#!/bin/sh

# Pontosan 2 bemeneti érték kell, a $# visszaadja azt, hogy hány inputot kapott a script
# a -ne azt jelenti, hogy not equal azaz, hogy nem egyenlő
# ha nincs pontosan 2 bemeneti érték akkor szólunk hogy halo és leáll a script
# a shellben a $0, $1, $2, $n mindig a bemeneti értékeket adja vissza sorszám szerint ugye
if [ $# -ne 2 ] ; then
    echo $#
    echo "Ez a script megmondja, ket stringrol hogy hany karakterbol all a leghosszabb egyforma szakasz kozottuk."
    echo "Hasznalat: "$0 " EGYSTRINGKETTO KETSTRINGHAROM" # itt a $0 a 0. bemeneti értéket adja vissza, azaz magát a parancsot (fájl nevet mert a shell scriptek úgy indulnak)
    exit 1
fi

# ha itt tart a kód akkor már fixen van 2 bemeneti értékünk, ezeket elmentjük 1-1 változóba
elso=$1
masodik=$2

for (( i = ${#masodik}; i > 0; i-- )); do
    for (( j = 0; j <= ${#masodik} - i; j++ )); do
        # itt a =~ egy Regex operátor
        if [[ $elso =~ ${masodik:j:i} ]]; then
            szakasz=${masodik:j:i}
            echo "Leghosszabb egyforma szakasz: "$szakasz", hossza: "${#szakasz}" karakter."
            exit 0
        fi
    done
done