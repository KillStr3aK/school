{Az adatokbe1.txt fájl neveket és magasságokat tartalmaz egymás alatti sorokban, maximum 50 db-ot. Egy név legfeljebb 25 karakterből állhat.
pl.: 
2
XY
170
ABC
180}
program masodik;
uses crt;

Type Adatok = record
	Nev:string[25];
	Magassag:integer;
END;

const max = 50;
var fajl:text;
	Emberek:array[1..max] of Adatok;
	darab:integer = 0;

//Írasd ki a képernyőre egymás mellé, hogy ki, milyen magas
Procedure Kiir();
var i:integer;
BEGIN
	for i := 1 to darab do BEGIN
		Write(Emberek[i].Nev, ' ', Emberek[i].Magassag, ' ');
	END;
END;

//Olvasd be az adatokat egy megfelelő adatszerkezetbe (tömb és rekord)!
Procedure Beolvasas();
BEGIN
	Assign(fajl, 'adatokbe2.txt');
	Reset(fajl);
	
	While NOT EOF(fajl) do BEGIN
		darab := darab + 1;
		ReadLn(fajl, Emberek[darab].Nev);
		ReadLn(fajl, Emberek[darab].Magassag);
	END;
	
	Close(fajl);
END;

BEGIN
	ClrScr;
	
	Beolvasas();
	Kiir();
	
	WriteLn;
	WriteLn;
END.
