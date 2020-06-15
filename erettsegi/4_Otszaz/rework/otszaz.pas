program otszaz;
uses crt;

const max = 1000;

var Darabszam:array[1..max] of integer;
	Kosar:array[1..max, 1..20] of string[30];
	fajl:text;
	ossz:integer = 1;

Procedure Feladat1();
var sor:string;
	i:integer;
BEGIN
	for i := 1 to max do BEGIN
		Darabszam[i] := 0;
	END;
	
	Assign(fajl, 'penztar.txt');
	Reset(fajl);
	
	While not EOF(fajl) do BEGIN
		ReadLn(fajl, sor);
		if(sor = 'F') then BEGIN
			ossz := ossz + 1;
		END else BEGIN
			Darabszam[ossz] := Darabszam[ossz] + 1;
			Kosar[ossz][Darabszam[ossz]] := sor;
		END;
	END;
	
	ossz := ossz - 1;
	Close(fajl);
END;

Procedure Feladat2();
BEGIN
	WriteLn('2. feladat:');
	WriteLn('A fizetések száma: ', ossz);
END;

Procedure Feladat3();
BEGIN
	WriteLn('3. feladat:');
	WriteLn('Az első vásárló ', Darabszam[1],' darab árucikket vásárolt.');
END;

Procedure Feladat5(nev:string; sorszam:integer; dsz:integer) Forward;
Procedure Feladat6(darabszam:integer) Forward;
Procedure Feladat7(sorszam:integer) Forward;

Procedure Feladat4();
var arunev:string;
	sorszam:integer;
	darabszam:integer;
BEGIN
	WriteLn('4. feladat:');
	
	Write('Adja meg egy vásárlás sorszámát! ');
	ReadLn(sorszam);
	Write('Adja meg egy árucikk nevét! ');
	ReadLn(arunev);
	Write('Adja meg a vásárolt darabszámot! ');
	ReadLn(darabszam);
	WriteLn;
	Feladat5(arunev, sorszam, darabszam);
END;

Procedure Feladat5(nev:string; sorszam:integer; dsz:integer);
var i:integer;
	k:integer;
	elso:integer = -1;
	utolso:integer;
	vettek:array[1..max] of boolean;
	db:integer = 0;
BEGIN
	WriteLn('5. feladat:');
	
	for i := 1 to max do BEGIN
		vettek[i] := false;
	END;
	
	for i := 1 to ossz do BEGIN
		for k := 1 to Darabszam[i] do BEGIN
			if(Kosar[i][k] = nev) then BEGIN
				if(elso = -1) then BEGIN
					elso := i;
				END;
				
				utolso := i;
				vettek[i] := true;
			END;
		END;
	END;
	
	for i := 1 to ossz do BEGIN
		if(vettek[i]) then BEGIN
			db := db + 1;
		END;
	END;
	
	WriteLn('Az első vásárlás sorszáma: ', elso);
	WriteLn('Az utolsó vásárlás sorszáma: ', utolso);
	WriteLn(db, ' vásárlás során vettek belőle.');
	
	WriteLn;
	Feladat6(dsz);
	WriteLn;
	Feladat7(sorszam);
END;

Function ertek(db:integer): integer;
BEGIN
	if(db <= 2) then BEGIN
		ertek := (db*500-(db-1)*50);
	END else BEGIN
		ertek := (1350+(db-3)*400);
	END;
END;

Procedure Feladat6(darabszam:integer);
BEGIN
	WriteLn('6. feladat:');
	WriteLn(darabszam, ' darab vételekor fizetendő: ', ertek(darabszam));
END;

Function Duplikalt(sorszam:integer; index:integer; targy:string): integer;
var i:integer;
	dupl:integer = 0;
BEGIN
	for i := 1 to (index-1) do BEGIN
		if(Kosar[sorszam][i] = targy) then BEGIN
			dupl := i;
		END;
	END;
	
	Duplikalt := dupl;
END;

Procedure Feladat7(sorszam:integer);
var i:integer;
	db:array[1..20] of integer;
	aru:array[1..20] of string;
	dupl:integer = 0;
BEGIN
	WriteLn('7. feladat:');
	
	for i := 1 to 20 do BEGIN
		db[i] := 1;
		aru[i] := Kosar[sorszam][i];
	END;
	
	for i := 1 to 20 do BEGIN
		dupl := Duplikalt(sorszam, i, Kosar[sorszam][i]);
		if(dupl > 0) then BEGIN
			db[i] := db[i] + 1;
			aru[dupl] := '';
		END;
	END;
	
	for i := 1 to 20 do BEGIN
		if (aru[i] <> '') then BEGIN
			WriteLn(db[i], ' ', aru[i]);
		END;
	END;
END;

Procedure Feladat8();
var i:integer;
	k:integer;
	osszeg:integer = 0;
	db:array[1..max, 1..20] of integer;
	aru:array[1..max, 1..20] of string;
	dupl:integer = 0;
BEGIN
	Assign(fajl, 'osszeg.txt');
	ReWrite(fajl);
	
	for k := 1 to ossz do BEGIN
		for i := 1 to 20 do BEGIN
			db[k][i] := 1;
			aru[k][i] := Kosar[k][i];
		END;
	END;
	
	for k := 1 to ossz do BEGIN
		for i := 1 to 20 do BEGIN
			dupl := Duplikalt(k, i, Kosar[k][i]);
			if(dupl > 0) then BEGIN
				db[k][i] := db[k][i] + 1;
				aru[k][dupl] := '';
			END;
		END;
	END;
	
	for i := 1 to ossz do BEGIN
		osszeg := 0;
		for k := 1 to Darabszam[i] do BEGIN
			if(aru[i][k] <> '') then BEGIN
				osszeg := osszeg + ertek(db[i][k]);
			END;
		END;
		
		WriteLn(fajl, i, ': ', osszeg);
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
	Feladat8();
	
	WriteLn;
	WriteLn;
END.
