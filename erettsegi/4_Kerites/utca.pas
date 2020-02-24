//Emelt érettségi 2018 október, https://www.informatikatanarok.hu/media/uploads/Informatika_erettsegi/Emelt/e_inf_18okt_fl.pdf
program utca;
uses crt, strutils, sysutils;

const max = 1000;
	  adatok = 'kerites.txt';

Type Haz = record
	Oldal:boolean;
	Szelesseg:integer;
	Szin:char;
END;

var Hazak:array[1..max] of Haz;
	ossz:integer;
	fajl:text;

Procedure Feladat1();
var sor:string;
	darab:array[1..3] of string;
	i:integer;
BEGIN
	Assign(fajl, adatok);
	Reset(fajl);
	
	While NOT EOF(fajl) do BEGIN
		ReadLn(fajl, sor);
		
		for i := 1 to 3 do BEGIN
			darab[i] := ExtractWord(i, sor, [' ']);
		END;
		
		ossz := ossz + 1;
		Hazak[ossz].Oldal := StrToBool(darab[1]);
		Hazak[ossz].Szelesseg := StrToInt(darab[2]);
		Hazak[ossz].Szin := darab[3][1];
	END;
	
	Close(fajl);
END;

Procedure Feladat2(); //<-
BEGIN
	WriteLn('2. feladat:');
	WriteLn('Az eladott telkek száma: ', ossz);
END;

Procedure Feladat3();
var hazszam:integer = 0;
	i:integer;
BEGIN
	WriteLn('3. feladat:');
	if not(Hazak[ossz].Oldal) then BEGIN
		WriteLn('A páros oldalon adták el az utolsó telket.');
		hazszam := 0;
		
		for i := 1 to ossz do BEGIN
			if(Hazak[i].Oldal = false) then BEGIN
				hazszam := hazszam + 2;
			END;
		END;
	END else BEGIN
		WriteLn('A páratlan oldalon adták el az utolsó telket.');
		hazszam := -1;
		
		for i := 1 to ossz do BEGIN
			if(Hazak[i].Oldal = true) then BEGIN
				hazszam := hazszam + 2;
			END;
		END;
	END;
	
	WriteLn('Az utolsó telek házszáma: ', hazszam);
END;

Procedure Feladat4(); //<-
var i:integer;
	haz:integer = 0;
	hazszam:integer = 0;
BEGIN
	WriteLn('4. feladat:');
	
	for i := 2 to ossz do BEGIN
		if((Hazak[i].Szin = '#') OR (Hazak[i].Szin = ':')) then BEGIN
			continue;
		END;
		
		if(Hazak[i].Szin = Hazak[i-1].Szin) then BEGIN
			haz := i;
			break;
		END;
	END;
	
	if not(Hazak[haz].Oldal) then BEGIN
		hazszam := 0;
		
		for i := 1 to haz do BEGIN
			if(Hazak[i].Oldal = false) then BEGIN
				hazszam := hazszam + 2;
			END;
		END;
	END else BEGIN
		hazszam := -1;
		
		for i := 1 to haz do BEGIN
			if(Hazak[i].Oldal = true) then BEGIN
				hazszam := hazszam + 2;
			END;
		END;
	END;
	
	WriteLn('A szomszédossal egyezik a kerítés színe: ', hazszam);
END;

Procedure Feladat5();
var hazszam:integer;
	sorszam:integer = 0;
	i:integer;
	jelenhsz:integer = 0;
BEGIN
	WriteLn('5. feladat:');
	Write('Adjon meg egy házszámot! ');
	ReadLn(hazszam);
	if((hazszam mod 2) = 0) then BEGIN
		jelenhsz := 0;
	END else BEGIN
		jelenhsz := -1;
	END;
	
	for i := 1 to ossz do BEGIN
		if(sorszam = 0) then BEGIN
			jelenhsz := jelenhsz + 2;
			if(jelenhsz = hazszam) then BEGIN
				sorszam := i;
			END;
		END;
	END;
	
	WriteLn('A kerítés színe / állapota: ', Hazak[sorszam].Szin);
	WriteLn('Egy lehetséges festési szín: '); //<-
END;

Procedure Feladat6();
var i:integer;
	k:integer;
	hazszam:integer = -1;
BEGIN
	Assign(fajl, 'utcakep.txt');
	ReWrite(fajl);
	
	for i := 1 to ossz do BEGIN
		if(Hazak[i].Oldal = true) then BEGIN
			for k := 1 to Hazak[i].Szelesseg do BEGIN
				Write(fajl, Hazak[i].Szin);
			END;
		END;
	END;
	
	WriteLn(fajl);
	
	for i := 1 to ossz do BEGIN //<-
		if(Hazak[i].Oldal = true) then BEGIN
			hazszam := hazszam + 2;
			for k := 1 to Hazak[i].Szelesseg do BEGIN
				if(k = 1) then BEGIN
					Write(fajl, hazszam);
				END else BEGIN
					Write(fajl, ' ');
				END;
			END;
		END;
	END;
	
	Close(fajl);
END;

BEGIN
	ClrScr;
	
	Feladat1();
	Feladat2();
	WriteLn;
	Feladat3();
	WriteLn;
	Feladat4();
	WriteLn;
	Feladat5();
	Feladat6();
	
	WriteLn;
	WriteLn;
END.
