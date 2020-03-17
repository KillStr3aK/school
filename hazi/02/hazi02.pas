//Az adatokbe.txt fájl neveket és magasságokat tartalmaz egymás alatti sorokban, maximum 50 db-ot. Egy
//név legfeljebb 25 karakterből állhat. A fájl első sora tartalmazza, a fájlban tárolt nevek (és magasságok) darabszámát.
program hazi;
uses crt;

Type Adatok = record
	Nev:string[25];
	Magassag:integer;
END;

const max = 50;
var fajl:text;
	Lista:array[1..max] of Adatok;
	ossz:integer = 0;

//Olvasd be az adatokat egy megfelelő adatszerkezetbe (tömb és rekord)! Írasd ki a képernyőre egymás mellé, hogy ki, milyen magas.
Procedure Beolvasas();
var i:integer;
BEGIN
	Assign(fajl, 'adatokbe.txt');
	Reset(fajl);
	
	ReadLn(fajl, ossz);
	for i := 1 to ossz do BEGIN
		ReadLn(fajl, Lista[i].Nev);
		ReadLn(fajl, Lista[i].Magassag);
		
		Write(Lista[i].Nev, ' ', Lista[i].Magassag, 'cm ');
	END;
	
	Close(fajl);
END;

//Számítsd ki az átlagmagasságot!
Procedure Feladat2();
var atlag:real;
	osszeg:integer = 0;
	i:integer;
BEGIN
	WriteLn;
	WriteLn('2. feladat:');
	
	for i := 1 to ossz do BEGIN
		osszeg := osszeg + Lista[i].Magassag;
	END;
	
	atlag := osszeg/ossz;
	WriteLn('Az átlagmagasság: ', atlag:0:0, 'cm');
END;

//Ki a legmagasabb?
Procedure Feladat3();
var i:integer;
	legmagasabb:integer = 1;
BEGIN
	WriteLn('3. feladat:');
	
	for i := 1 to ossz do BEGIN
		if(Lista[i].Magassag > Lista[legmagasabb].Magassag) then BEGIN
			legmagasabb := i;
		END;
	END;
	
	WriteLn(Lista[legmagasabb].Nev, ' a legmagasabb');
END;

//Ki a legalacsonyabb?
Procedure Feladat4();
var i:integer;
	legalacsonyabb:integer = 1;
BEGIN
	WriteLn('4. feladat:');
	
	for i := 1 to ossz do BEGIN
		if(Lista[i].Magassag < Lista[legalacsonyabb].Magassag) then BEGIN
			legalacsonyabb := i;
		END;
	END;
	
	WriteLn(Lista[legalacsonyabb].Nev, ' a legalacsonyabb');
END;

//Hányan vannak 170 cm felett?
Procedure Feladat5();
var i:integer;
	hanyan:integer = 0;
BEGIN
	WriteLn('5. feladat:');
	
	for i := 1 to ossz do BEGIN
		if(Lista[i].Magassag > 170) then BEGIN
			hanyan := hanyan + 1;
		END;
	END;
	
	WriteLn(hanyan, 'db személy van 170cm fölött');
END;

//Kik azok, akik pont 170 cm magasak?
Procedure Feladat6();
var i:integer;
BEGIN

	WriteLn('6. feladat:');
	
	for i := 1 to ossz do BEGIN
		if(Lista[i].Magassag = 170) then BEGIN
			Write(Lista[i].Nev, ' ');
		END;
	END;
	
	Write('pontosan 170cm magasak');
END;

//Kérj be egy nevet a billentyűzetről! Döntsd el, hogy az illető benne van-e a fájlban!
Procedure Feladat7();
var nev:string[25];
	i:integer;
	benne:boolean = false;
BEGIN
	WriteLn;
	WriteLn('7. feladat:');
	Write('Adj meg egy nevet: ');
	ReadLn(nev);
	
	for i := 1 to ossz do BEGIN
		if(Lista[i].Nev = nev) then BEGIN
			benne := true;
		END;
	END;
	
	Case benne Of
		true: WriteLn('A megadott név benne van a fájlban!');
		false: WriteLn('A megadott név nincs benne a fájlban!');
	END;
END;

//Rendezd sorba a résztvevőket magasságuk szerint csökkenően!
Procedure Feladat8();
var i:integer;
	k:integer;
	Csere:Adatok;
BEGIN
	WriteLn('8. feladat:');
	WriteLn;
	for i := 1 to ossz do BEGIN
		for k := 1 to ossz-i do BEGIN
			if(Lista[k].Magassag < Lista[k+1].Magassag) then BEGIN
				Csere := Lista[k];
				Lista[k] := Lista[k+1];
				Lista[k+1] := Csere;
			END;
		END;
	END;
	
	for i := 1 to ossz do BEGIN
		WriteLn(Lista[i].Nev, ' ', Lista[i].Magassag, 'cm');
	END;
END;

BEGIN
	ClrScr;
	
	Beolvasas();
	WriteLn;
	Feladat2();
	WriteLn;
	Feladat3();
	WriteLn;
	Feladat4();
	WriteLn;
	Feladat5();
	WriteLn;
	Feladat6();
	WriteLn;
	Feladat7();
	WriteLn;
	Feladat8();
	
	WriteLn;
	WriteLn;
END.
