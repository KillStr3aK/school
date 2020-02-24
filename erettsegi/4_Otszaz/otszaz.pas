//Emelt érettségi 2016 május, http://dload.oktatas.educatio.hu/erettsegi/feladatok_2016tavasz_emelt/e_inf_16maj_fl.pdf
program otszaz;
uses crt, sysutils, strutils, math;

const max = 1000;http:
	  adatok = 'penztar.txt';
	  
var fajl:text;
	Vasarlo:array[1..max, 1..20] of string[30];
	Targyak:array[1..max] of integer;
	ossz:integer = 1;

Procedure Beolvasas();
var sor:string;
	i:integer;
BEGIN
	Assign(fajl, adatok);
	Reset(fajl);
	
	for i := 1 to max do BEGIN
		Targyak[i] := 0;
	END;
	
	While NOT EOF(fajl) do BEGIN
		ReadLn(fajl, sor);
		if(sor = 'F') then BEGIN
			ossz := ossz + 1;
		END else BEGIN
			Targyak[ossz] := Targyak[ossz] + 1;
			Vasarlo[ossz][Targyak[ossz]] := sor;
		END;
	END;
	
	ossz := ossz - 1; //Azért mert az utolsó fizetés után már nem következik új vásárló.
	Close(fajl);
END;

Procedure Feladat2();
BEGIN
	WriteLn('2. feladat ');
	WriteLn('A fizetések száma: ', ossz);
END;

Procedure Feladat3();
BEGIN
	WriteLn('3. feladat ');
	WriteLn('Az első vásárló ', Targyak[1], ' darab árucikket vásárolt.');
END;

Function ertek(darab:integer): integer;
BEGIN
	if(darab <= 2) then BEGIN
		ertek := (darab*500-(darab-1)*50);
	END else BEGIN
		ertek := (1350+(darab-3)*400);
	END;
END;

Procedure Feladat6(db:integer);
BEGIN
	WriteLn;
	WriteLn('6. feladat ');
	WriteLn(db, ' darab vételekor fizetendő: ', ertek(db));
END;

Function Duplikalt(sorszam:integer; index:integer; targy:string): integer;
var i:integer;
	dup:integer = 0;
BEGIN
	for i := 1 to (index-1) do BEGIN
		if(Vasarlo[sorszam][i] = targy) then BEGIN
			dup := i;
		END;
	END;
	
	Duplikalt := dup;
END;

Procedure Feladat7(sorszam:integer);
var i:integer;
	darab:array[1..20] of integer;
	targy:array[1..20] of string[30];
	dupl:integer = 0;
BEGIN
	WriteLn('7. feladat ');
	WriteLn;
	
	for i := 1 to Targyak[sorszam] do BEGIN
		darab[i] := 1;
		targy[i] := Vasarlo[sorszam][i];
	END;
	
	for i := 1 to Targyak[sorszam] do BEGIN
		dupl := Duplikalt(sorszam, i, Vasarlo[sorszam][i]);
		if(dupl > 0) then BEGIN
			darab[i] := darab[i] + 1;
			targy[dupl] := '';
		END;
	END;
	
	for i := 1 to Targyak[sorszam] do BEGIN
		if not(targy[i] = '') then BEGIN
			WriteLn(darab[i], ' ', targy[i]);
		END;
	END;
END;

Procedure Feladat5(targy:string);
var db:integer = 0;
	van:array[1..max] of boolean;
	i:integer;
	k:integer;
	elso:integer = 0;
	utolso:integer = 0;
BEGIN
	WriteLn;
	WriteLn('5. feladat ');
	
	for i := 1 to max do BEGIN
		van[i] := false;
	END;
	
	for i := 1 to ossz do BEGIN
		for k := 1 to Targyak[i] do BEGIN
			if(Vasarlo[i][k] = targy) then BEGIN
				if(elso = 0) then BEGIN
					elso := i;
				END;
				
				utolso := i;
				van[i] := true;
			END;
		END;
	END;
	
	for i := 1 to max do BEGIN
		if(van[i] = true) then BEGIN
			db := db + 1;
		END;
	END;
	
	WriteLn('Az első vásárlás sorszáma: ', elso);
	WriteLn('Az utolsó vásárlás sorszáma: ', utolso);
	WriteLn(db, ' vásárlás során vettek belőle.');
END;

Procedure Feladat4();
var sorszam:integer;
	targy:string[30];
	db:integer;
BEGIN
	WriteLn('4. feladat ');
	Write('Adja meg egy vásárlás sorszámát! ');
	ReadLn(sorszam);
	Write('Adja meg egy árucikk nevét! ');
	ReadLn(targy);
	Write('Adja meg a vásárolt darabszámot! ');
	ReadLn(db);
	
	Feladat5(targy);
	WriteLn;
	Feladat6(sorszam);
	WriteLn;
	Feladat7(db);
END;

Procedure Feladat8(); //FAIL
var i:integer;
	k:integer = 1;
	fizetendo:integer;
	darab:array[1..20] of integer;
	targy:array[1..20] of string[30];
	dupl:integer = 0;
BEGIN
	Assign(fajl, 'osszeg.txt');
	ReWrite(fajl);
	
	for i := 1 to ossz do BEGIN
		for k := 1 to Targyak[k] do BEGIN
			darab[k] := 0;
			targy[k] := Vasarlo[i][k];
		END;
		
		for k := 1 to Targyak[k] do BEGIN
			dupl := Duplikalt(i, k, Vasarlo[i][k]);
			if(dupl > 0) then BEGIN
				darab[k] := darab[k] + 1;
				targy[dupl] := '';
			END;
		END;
		
		fizetendo := 0;
		
		for k := 1 to Targyak[i] do BEGIN
			if not(targy[k] = '') then BEGIN
				fizetendo := fizetendo + ertek(darab[k]);
			END;
		END;
		
		WriteLn(fajl, i, ': ', fizetendo);
	END;
	
	Close(fajl);
END;

BEGIN
	ClrScr;
	
	Beolvasas();
	Feladat2();
	WriteLn;
	Feladat3();
	WriteLn;
	Feladat4();
	Feladat8();
	
	WriteLn;
	WriteLn;
END.
