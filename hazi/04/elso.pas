{Az adatokbe1.txt fájl neveket és magasságokat tartalmaz egymás alatti sorokban, maximum 50 db-ot. Egy név legfeljebb 25 karakterből állhat.
A fájl első sora tartalmazza, a fájlban tárolt nevek (és magasságok) darabszámát: 
pl.: 
2
XY
170
ABC
180}
program elso;
uses crt;

Type Adatok = record
	Nev:string[25];
	Magassag:integer;
END;

const max = 50;
var fajl:text;
	Emberek:array[1..max] of Adatok;

//Írasd ki a képernyőre egymás mellé, hogy ki, milyen magas
Procedure Kiir(darabszam:integer);
var i:integer;
BEGIN
	for i := 1 to darabszam do BEGIN
		Write(Emberek[i].Nev, ' ', Emberek[i].Magassag, ' ');
	END;
END;

//Olvasd be az adatokat egy megfelelő adatszerkezetbe (tömb és rekord)!
Procedure Beolvasas();
var darab:integer;
	i:integer;
BEGIN
	Assign(fajl, 'adatokbe1.txt');
	Reset(fajl);
	
	ReadLn(fajl, darab);
	for i := 1 to darab do BEGIN
		ReadLn(fajl, Emberek[i].Nev);
		ReadLn(fajl, Emberek[i].Magassag);
	END;
	
	Close(fajl);
	Kiir(darab);
END;

BEGIN
	ClrScr;
	
	Beolvasas();
	
	WriteLn;
	WriteLn;
END.
