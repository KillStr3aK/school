program hazi;
uses crt;

const max = 10;

var fajl:text;
	szamok:array[1..max] of integer;

//A szamok.txt fájl tíz darab pozitív egész számot tartalmaz egymás alatti sorokban. Olvassuk be a számokat egy tömbbe és írjuk ki a képernyőre egymás mellé szóközzel elválasztva.
Procedure Feladat1();
var i:integer;
BEGIN
	WriteLn('1. feladat:');
	Assign(fajl, 'szamok.txt');
	Reset(fajl);
	
	for i := 1 to max do BEGIN
		ReadLn(fajl, szamok[i]);
		Write(szamok[i], ' ');
	END;
	
	Close(fajl);
END;

//Számitsuk ki a tömb elemeinek összegét
Procedure Feladat2();
var i:integer;
	osszeg:integer = 0;
BEGIN
	WriteLn;
	WriteLn('2. feladat:');
	
	for i := 1 to max do BEGIN
		osszeg := osszeg + szamok[i];
	END;
	
	WriteLn('A tömb elemeinek összege: ', osszeg);
END;

//Számoljuk meg, hogy hány páros szám van a sorozatban
Procedure Feladat3();
var i:integer;
	paros:integer = 0;
BEGIN
	WriteLn('3. feladat:');
	
	for i := 1 to max do BEGIN
		if((szamok[i] mod 2) = 0) then BEGIN
			paros := paros + 1;
		END;
	END;
	
	WriteLn('A sorozatban ', paros, ' db páros szám van');
END;

//Kérjünk be egy pozitív egész számot és döntsük el, hogy benne van-e a sorozatban
Procedure Feladat4();
var szam:integer;
	benne:boolean = false;
	i:integer;
BEGIN
	WriteLn('4. feladat:');
	Write('Adj meg egy pozitív egész számot: ');
	ReadLn(szam);
	
	for i := 1 to max do BEGIN
		if(szamok[i] = szam) then BEGIN
			benne := true;
		END;
	END;
	
	Case benne Of
		true: WriteLn('A szám benne van a sorozatban');
		false: WriteLn('A szám nincs benne a sorozatban');
	END;
END;

//Válogassuk ki egy külön tömbbe a páratlan számokat és írjuk ki a szamokki.txt fájlba egymás alatti sorokba, a fájl első sora tartalmazza a páratlan számok darabszámát
Procedure Feladat5();
var paratlanok:array[1..max] of integer;
	hanyparatlan:integer = 0;
	i:integer;
BEGIN
	WriteLn('5. feladat:');
	
	for i := 1 to max do BEGIN
		if not((szamok[i] mod 2) = 0) then BEGIN
			hanyparatlan := hanyparatlan + 1;
			paratlanok[hanyparatlan] := szamok[i];
		END;
	END;
	
	Assign(fajl, 'szamokki.txt');
	ReWrite(fajl);
	
	WriteLn(fajl, hanyparatlan);
	for i := 1 to hanyparatlan do BEGIN
		WriteLn(fajl, paratlanok[i]);
	END;
	
	Close(fajl);
	
	Write('(szamokki.txt létrehozva)');
END;

BEGIN
	ClrScr;
	
	Feladat1();
	WriteLn;
	Feladat2();
	WriteLn;
	Feladat3();
	WriteLn;
	Feladat4();
	WriteLn;
	Feladat5();
	
	WriteLn;
	WriteLn;
END.
