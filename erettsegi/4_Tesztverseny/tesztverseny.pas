//Emelt érettségi 2017 május, https://www.informatikatanarok.hu/media/uploads/Informatika_erettsegi/Emelt/e_inf_17maj_fl.pdf
program tesztverseny;
uses crt, sysutils, strutils;

const max = 500;
	  adatok = 'valaszok.txt';
	  
Type Sorok = record
	Azonosito:string[5];
	Valasz:string[14];
	Pontszam:integer;
END;

var fajl:text;
	Jovalasz:string[14];
	Lista:array[1..500] of Sorok;
	ossz:integer = 0;

Procedure Beolvasas();
var sor:string;
	darab:array[1..2] of string;
	i:integer;
BEGIN
	WriteLn('1. feladat: Az adatok beolvasása');
	Assign(fajl, adatok);
	Reset(fajl);
	
	ReadLn(fajl, Jovalasz);
	
	While NOT EOF(fajl) do BEGIN
		ReadLn(fajl, sor);
		for i := 1 to 2 do BEGIN
			darab[i] := ExtractWord(i, sor, [' ']);
		END;
		
		ossz := ossz + 1;
		Lista[ossz].Azonosito := darab[1];
		Lista[ossz].Valasz := darab[2];
	END;
	
	Close(fajl);
END;

Procedure Feladat2();
BEGIN
	WriteLn('2. feladat: A vetélkedőn ', ossz, ' versenyző indult. ');
END;

Procedure Feladat5();
var i:integer;
	sorszam:integer;
	db:integer = 0;
BEGIN
	WriteLn;
	Write('5. feladat: A feladat sorszáma = ');
	ReadLn(sorszam);
	
	for i := 1 to ossz do BEGIN
		if(Lista[i].Valasz[sorszam] = Jovalasz[sorszam]) then BEGIN
			db := db + 1;
		END;
	END;
	
	WriteLn('A feladatra ', db, ' fő, a versenyzők ', ((100/ossz)*db):2:2, '%-a adott helyes választ.');
END;

Procedure Feladat4(index:integer);
var i:integer;
BEGIN
	WriteLn;
	WriteLn('4. feladat: ');
	
	WriteLn('BCCCDBBBBCDAAA (a helyes megoldás)');
	for i := 1 to 14 do BEGIN
		if(Lista[index].Valasz[i] = Jovalasz[i]) then BEGIN
			Write('+');
		END else BEGIN
			Write(' ');
		END;
	END;
	
	Write(' (a versenyző helyes válaszai)');
END;

Procedure Feladat3();
var azon:string[5];
	i:integer;
BEGIN
	Write('3. feladat: A versenyző azonosítója = ');
	ReadLn(azon);
	
	for i := 1 to ossz do BEGIN
		if(Lista[i].Azonosito = azon) then BEGIN
			Write(Lista[i].Valasz, ' (a versenyző válasza)');
			WriteLn;
			Feladat4(i);
		END;
	END;
END;

Function Pontok(fel:integer): integer;
var pont:integer;
BEGIN
	Case fel Of
		1..5: pont := 3;
		6..10: pont :=4;
		11..13: pont := 5;
		14: pont := 6
	END;
	
	Pontok := pont;
END;

Procedure Feladat6();
var i:integer;
	k:integer;
	osszpont:integer = 0;
BEGIN
	WriteLn('6. feladat: A versenyzők pontszámának meghatározása');
	Assign(fajl, 'pontok.txt');
	ReWrite(fajl);
	
	for i := 1 to ossz do BEGIN
		osszpont := 0;
		for k := 1 to 14 do BEGIN
			if(Lista[i].Valasz[k] = Jovalasz[k]) then BEGIN
				osszpont := osszpont + Pontok(k);
			END;
		END;
		
		WriteLn(fajl, Lista[i].Azonosito, ' ', osszpont);
		Lista[i].Pontszam := osszpont;
	END;
	
	Close(fajl);
END;

Procedure Feladat7();
var i:integer;
	k:integer;
	dijak:integer = 1;
	temp:Sorok;
BEGIN
	WriteLn('7. feladat: A verseny legjobbjai:');
	
	for k := 1 to ossz do BEGIN
		for i := 1 to ossz-k do BEGIN
			if(Lista[i].Pontszam < Lista[i+1].Pontszam) then BEGIN
				temp := Lista[i];
				Lista[i] := Lista[i+1];
				Lista[i+1] := temp;
			END;
		END;
	END;
	
	WriteLn(dijak, '. díj (', Lista[1].Pontszam, ' pont): ', Lista[1].Azonosito);
	
	for i := 2 to ossz do BEGIN
		if(Lista[i].Pontszam < Lista[i-1].Pontszam) then BEGIN
			dijak := dijak + 1;
		END;
		
		if(dijak <= 3) then BEGIN
			WriteLn(dijak, '. díj (', Lista[i].Pontszam, ' pont): ', Lista[i].Azonosito);
		END;
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
	Feladat5();
	WriteLn;
	Feladat6();
	WriteLn;
	Feladat7;
	
	WriteLn;
	WriteLn;
END.
