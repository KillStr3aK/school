//Emelt érettségi 2018 május, http://dload.oktatas.educatio.hu/erettsegi/feladatok_2018tavasz_emelt/e_inf_18maj_fl.pdf
program tarsalgo;
uses crt, strutils, sysutils;

const max = 1000;
	  adatok = 'ajto.txt';

Type Sorok = record
	Ora:integer;
	Perc:integer;
	Szemely:integer;
	Irany:boolean;
END;

var	fajl:text;
	Lista:array[1..max] of Sorok;
	ossz:integer = 0;

Procedure Beolvasas();
var sor:string;
	darab:array[1..4] of string;
	i:integer;
BEGIN
	Assign(fajl, adatok);
	Reset(fajl);

	While NOT EOF(fajl) do BEGIN
		ReadLn(fajl, sor);
		for i := 1 to 4 do BEGIN
			darab[i] := ExtractWord(i, sor, [' ']);
		END;

		ossz := ossz + 1;
		Lista[ossz].Ora := StrToInt(darab[1]);
		Lista[ossz].Perc := StrToInt(darab[2]);
		Lista[ossz].Szemely := StrToInt(darab[3]);
		if(darab[4] = 'be') then BEGIN
			Lista[ossz].Irany := true;
		END else BEGIN
			Lista[ossz].Irany := false;
		END;
	END;

	Close(fajl);
END;

Procedure Feladat2();
var osszesen:integer;
BEGIN
	WriteLn('2. feladat');

	osszesen := ossz;
	WriteLn('Az első belépő: ', Lista[1].Szemely);

	While NOT(osszesen = 0) do BEGIN
		if(Lista[osszesen].Irany = false) then BEGIN
			WriteLn('Az utolsó kilépő: ', Lista[osszesen].Szemely);
			break;
		END;

		osszesen := osszesen - 1;
	END;
END;

Procedure Feladat3();
var i:integer;
	k:integer;
	szemelyek:integer = 0;
	haladas:array[1..max] of integer;
BEGIN
	for i := 1 to max do BEGIN
		haladas[i] := 0;
	END;

	for i := 1 to ossz do BEGIN
		if(Lista[i].Szemely > szemelyek) then BEGIN
			szemelyek := Lista[i].Szemely;
		END;
	END;

	for i := 1 to szemelyek do BEGIN
		for k := 1 to ossz do BEGIN
			if(Lista[k].Szemely = i) then BEGIN
				haladas[i] := haladas[i] + 1;
			END;
		END;
	END;

	Assign(fajl, 'athaladas.txt');
	ReWrite(fajl);

	for i := 1 to szemelyek do BEGIN
		if(haladas[i] > 0) then BEGIN
			WriteLn(fajl, i, ' ', haladas[i]);
		END;
	END;

	Close(fajl);
END;

Procedure Feladat4();
var hol:array[1..max] of boolean;
	i:integer;
	k:integer;
	szemelyek:integer = 0;
BEGIN
	WriteLn('4. feladat');

	for i := 1 to ossz do BEGIN
		if(Lista[i].Szemely > szemelyek) then BEGIN
			szemelyek := Lista[i].Szemely;
		END;
	END;

	for i := 1 to szemelyek do BEGIN
		hol[i] := false;
	END;

	for i := 1 to szemelyek do BEGIN
		for k := 1 to ossz do BEGIN
			if(Lista[k].Szemely = i) then BEGIN
				hol[i] := Lista[k].Irany;
			END;
		END;
	END;

	WriteLn('A végén a társalgóban voltak: ');
	for i := 1 to szemelyek do BEGIN
		if(hol[i] = true) then BEGIN
			Write(i, ' ');
		END;
	END;
END;

Procedure Feladat5();
var i:integer;
	letszam:integer = 0;
	mikor:integer = 0;
	maxletszam:integer = 0;
BEGIN
	WriteLn('5. feladat:');

	for i := 1 to ossz do BEGIN
		if(Lista[i].Irany = true) then BEGIN
			letszam := letszam + 1;
		END else BEGIN
			letszam := letszam - 1;
		END;

		if(letszam > maxletszam) then BEGIN
			mikor := i;
		END;
	END;

	WriteLn('Például ', Lista[mikor].Ora, ':', Lista[mikor].Perc, '-kor voltak a legtöbben a társalgóban.');
END;

BEGIN
	ClrScr;

	Beolvasas();
	Feladat2();
	Feladat3();
	Feladat4();
	Feladat5();
	
	WriteLn;
	WriteLn;
END.
