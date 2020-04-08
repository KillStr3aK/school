{Az adatokbe1.txt fájl neveket és magasságokat tartalmaz egymás alatti sorokban, maximum 50 db-ot. Egy név legfeljebb 25 karakterből állhat.
pl.:
XY
170
ABC
180}
program hazi;
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
	
	WriteLn;
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

//Kérj be a billentyűzetről egy nevet. Döntsd el, hogy a bekért név szerepel-e a sorozatban.
Procedure Eldontes();
var i:integer;
	nev:string[25];
BEGIN
	WriteLn;
	Write('Adj meg egy nevet: ');
	ReadLn(nev);
	
	i := 1;
	While (not(Emberek[i].Nev = nev) AND (i <= darab)) do BEGIN // ..Emberek[i].Nev <> nev.. -> operator not overloaded
		i := i + 1;
	END;
	
	if(Emberek[i].Nev = nev) then BEGIN
		WriteLn('Van ilyen elem');
	END else BEGIN
		WriteLn('Nincs ilyen elem');
	END;
END;

//Válogasd ki a legalább 180 cm magasságúakat. A kiválogatás után írasd ki a képernyőre a nevüket, és a magasságukat.
Procedure Kivalogatas();
var Valogatott:array[1..max] of Adatok;
	Valogatottak:integer = 0;
	i:integer;
BEGIN
	WriteLn;
	for i := 1 to darab do BEGIN
		if(Emberek[i].Magassag >= 150) then BEGIN
			Valogatottak := Valogatottak + 1;
			Valogatott[Valogatottak] := Emberek[i];
		END;
	END;
	
	for i := 1 to Valogatottak do BEGIN
		WriteLn(Valogatott[i].Nev, ' ', Valogatott[i].Magassag);
	END;
END;

BEGIN
	ClrScr;
	
	Beolvasas();
	Kiir();
	Eldontes();
	Kivalogatas();
	
	WriteLn;
	WriteLn;
END.
