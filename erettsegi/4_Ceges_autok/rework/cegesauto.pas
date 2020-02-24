//Emelt érettségi 2019 május, http://informatika.fazekas.hu/wp-content/uploads/2015/10/Céges-autók.pdf
program cegesuato;
uses crt, strutils, sysutils;

type Autok = record
	Nap:integer;
	Azonosito:integer;
	Kora:int64;
	
	Rendszam:string;
	Idopont:string;
	
	Parkol:boolean;
END;

const max = 500;
	  adatok = 'autok.txt';

var sorok:array[1..max] of Autok;
	i:integer;
	k:integer;
	ossz:integer = 0;
	fajl:text;
	
Procedure Beolvasas(); //4pont
var jelenleg:string;
	darab:array[1..6] of string;
BEGIN
	Assign(fajl, adatok);
	Reset(fajl);
	
	While NOT EOF(fajl) do BEGIN
		ossz := ossz+1;
		ReadLn(fajl, jelenleg);
		for i := 1 to 6 do BEGIN
			darab[i] := ExtractWord(i, jelenleg, [' ']);
		END;
		
		sorok[ossz].Nap := StrToInt(darab[1]);
		sorok[ossz].Idopont := darab[2];
		sorok[ossz].Rendszam := darab[3];
		sorok[ossz].Azonosito := StrToInt(darab[4]);
		sorok[ossz].Kora := StrToInt(darab[5]);
		sorok[ossz].Parkol := StrToBool(darab[6]);
	END;
	
	Close(fajl);
END;

Procedure Feladat2(); //3pont
var osszesen:integer;
BEGIN
	WriteLn('2. feladat');
	
	osszesen := ossz;
	While NOT(osszesen = 0) do BEGIN
		if(sorok[osszesen].Parkol = false) then BEGIN
			WriteLn(sorok[osszesen].Nap, '. nap rendszám: ', sorok[osszesen].Rendszam);
			break;
		END;
		
		osszesen := osszesen-1;
	END;
END;

Procedure Feladat3(); //6pont
var melyik:integer;
BEGIN
	WriteLn('3. feladat');
	
	Write('Nap: ');
	ReadLn(melyik);
	
	WriteLn('Forgalom a(z) ', melyik, '. napon: ');
	
	for i := 1 to ossz do BEGIN
		if(sorok[i].Nap = melyik) then BEGIN
			if(sorok[i].Parkol = true) then BEGIN
				WriteLn(sorok[i].Idopont, ' ', sorok[i].Rendszam, ' ', sorok[i].Azonosito, ' be');
			END else BEGIN
				WriteLn(sorok[i].Idopont, ' ', sorok[i].Rendszam, ' ', sorok[i].Azonosito, ' ki');
			END;
		END;
	END;
END;

Procedure Feladat4(); //5pont
var hany:integer = 0;
	allapot:array[0..9] of boolean;
BEGIN
	WriteLn('4. feladat');
	
	for i := 0 to 9 do BEGIN
		allapot[i] := true;
	END;
	
	for k := 0 to 9 do BEGIN
		for i := 1 to ossz do BEGIN
			if(k = StrToInt(Copy(sorok[i].Rendszam, 6, 6))) then BEGIN
				allapot[k] := sorok[i].Parkol;
			END;
		END;
	END;
	
	for i := 0 to 9 do BEGIN
		if(allapot[i] = false) then BEGIN
			hany := hany + 1;
		END;
	END;
	
	WriteLn('A hónap végén ', hany,' autót nem hoztak vissza.');
END;

Procedure Feladat5(); // 7/7 pont
var bentiora:array[0..9] of int64;
	kintiora:array[0..9] of int64;
BEGIN
	WriteLn('5. feladat');
	
	for k := 0 to 9 do BEGIN
		kintiora[k] := 0;
	END;
	
	for k := 0 to 9 do BEGIN
		for i := 1 to ossz do BEGIN
			if(k = StrToInt(Copy(sorok[i].Rendszam, 6, 6))) then BEGIN
				if not(sorok[i].Parkol) AND (kintiora[k] = 0) then BEGIN
					kintiora[k] := sorok[i].Kora;
				END;
				
				if(sorok[i].Parkol) then BEGIN
					bentiora[k] := sorok[i].Kora
				END;
			END;
		END;
	END;
	
	for k := 0 to 9 do BEGIN
		WriteLn('CEG30', k, ' ', (bentiora[k] - kintiora[k]), ' km');
	END;
END;

Procedure Feladat6(); // 8/6 pont
var leghosszabb:int64 = 0;
	szemely:integer;
	elozo:integer = 1;
	km:array[0..9] of integer;
BEGIN
	WriteLn('6. feladat');
	
	for i := 0 to 9 do BEGIN
		km[i] := 0;
	END;
	
	for k := 0 to 9 do BEGIN
		for i := 1 to ossz do BEGIN
			if(k = StrToInt(Copy(sorok[i].Rendszam, 6, 6))) then BEGIN
				if(sorok[i].Parkol = true) then BEGIN
					if(km[k] < sorok[i].Kora-sorok[elozo].Kora) then BEGIN
						km[k] := sorok[i].Kora-sorok[elozo].Kora;
						szemely := sorok[i].Azonosito;
						elozo := i;
					END;
				END;
			END;
		END;
	END;
	
	for k := 0 to 9 do BEGIN
		if(km[k] > leghosszabb) then BEGIN
			leghosszabb := km[k];
		END;
	END;
	
	WriteLn('Leghosszabb út: ', leghosszabb, ' km, személy: ', szemely);
END;

Procedure Feladat7(); // 9/9 pont
var rendszam:string;
	level:text;
BEGIN
	WriteLn('7. feladat');
	
	Write('Rendszám: ');
	ReadLn(rendszam);
	k := StrToInt(Copy(rendszam, 6, 6));
	
	Insert('_menetlevel.txt', rendszam, (length(rendszam)+1));
	Assign(level, rendszam);
	ReWrite(level);
	
	for i := 1 to ossz do BEGIN
		if(k = StrToInt(Copy(sorok[i].Rendszam, 6, 6))) then BEGIN
			if(sorok[i].Parkol = false) then BEGIN
				Write(level, sorok[i].Azonosito, #9, sorok[i].Nap,'.', #9, sorok[i].Idopont, #9, sorok[i].Kora, ' km', #9);
			END else BEGIN
				WriteLn(level, sorok[i].Nap,'.', #9, sorok[i].Idopont, #9, sorok[i].Kora, ' km', #9);
			END;
		END;
	END;
	
	WriteLn('Menetlevél kész.');
	Close(level);
END;

BEGIN
	ClrScr;
	
	Beolvasas();
	Feladat2();
	Feladat3();
	Feladat4();
	Feladat5();
	Feladat6();
	Feladat7();
	//Feladat2o();
	
	WriteLn;
	WriteLn;
END.

{Procedure Feladat2o();
var Utolso:integer = 0;
BEGIN
	WriteLn('2. feladat');
	
	for i := 1 to ossz do BEGIN
		if(sorok[i].Nap > Utolso) then BEGIN
			Utolso := sorok[i].Nap;
		END;
	END;
END;}
