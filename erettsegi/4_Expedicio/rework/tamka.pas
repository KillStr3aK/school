program radio;
uses crt, strutils, sysutils;

Type Adatok = record
	Nap:integer;
	Amator:integer;
	Feljegyzes:string[90];
END;

var Lista:array[1..306] of Adatok;
	ossz:integer = 0;
	fajl:text;

Procedure Beolvasas();
var sor:string;
	darab:array[1..2] of string;
	i:integer;
BEGIN
	Assign(fajl, 'veetel.txt');
	Reset(fajl);
	
	While NOT EOF(fajl) do BEGIN
		ossz := ossz + 1;
		ReadLn(fajl, sor);
		for i := 1 to 2 do BEGIN
			darab[i] := ExtractWord(i, sor, [' ']);
		END;
		
		Lista[ossz].Nap := StrToInt(darab[1]);
		Lista[ossz].Amator := StrToInt(darab[2]);
		
		ReadLn(fajl, sor);
		Lista[ossz].Feljegyzes := sor;
	END;
	
	Close(fajl);
END;

Procedure Feladat2();
BEGIN
	WriteLn('2. feladat:');
	WriteLn('Az első üzenet rögzítője: ', Lista[1].Amator);
	WriteLn('Az utolsó üzenet rögzítője: ', Lista[ossz].Amator);
END;

Procedure Feladat3();
var i:integer;
BEGIN
	WriteLn('3. feladat:');
	for i := 1 to ossz do BEGIN
		if(Pos('farkas', Lista[i].Feljegyzes) > 0) then BEGIN
			WriteLn(Lista[i].Nap, '. nap ', Lista[i].Amator,'. rádióamatőr');
		END;
	END;
END;

Function HanyAmator(nap:integer): integer;
var osszeg:integer = 0;
	k:integer;
BEGIN
	for k := 1 to ossz do BEGIN
		if(Lista[k].Nap = nap) then BEGIN
			osszeg := osszeg + 1;
		END;
	END;
	
	HanyAmator := osszeg;
END;

Procedure Feladat4();
var i:integer;
BEGIN
	WriteLn('4. feladat:');
	
	for i := 1 to 11 do BEGIN
		WriteLn(i, '. nap: ', HanyAmator(i),' rádióamatőr');
	END;
END;

Procedure Feladat5();
var i:integer;
	k:integer;
	g:integer;
	szoveg:string[90];
BEGIN
	Assign(fajl, 'adaas.txt');
	ReWrite(fajl);
	
	for i := 1 to 11 do BEGIN
		for k := 1 to 90 do BEGIN
			for g := 1 to ossz do BEGIN
				if(Lista[g].Nap = i) then BEGIN
					if not(Lista[g].Feljegyzes[k] = '#') then BEGIN
						szoveg[k] := Lista[g].Feljegyzes[k];
					END;
				END;
			END;
		END;
		
		WriteLn(fajl, szoveg[1..90]);
	END;
	
	Close(fajl);
END;

Function szame(szo:string): boolean;
var valasz:boolean;
	i:integer;
BEGIN
	valasz := true;
	for i := 1 to length(szo) do BEGIN
		if((szo[i] < '0') OR (szo[i] > '9')) then BEGIN
			valasz := false;
		END;
	END;
	
	szame := valasz;
END;

Procedure Feladat7();
var i:integer;
	sorszam:integer;
	amator:integer;
	egyed:array[1..2] of integer;
	volt:boolean = false;
BEGIN
	WriteLn('7. feladat:');
	Write('Adja meg a nap sorszámát! ');
	ReadLn(sorszam);
	Write('Adja meg a rádióamatőr sorszámát! ');
	ReadLn(amator);
	
	for i := 1 to 2 do BEGIN
		egyed[i] := 0;
	END;
	
	for i := 1 to ossz do BEGIN
		if((Lista[i].Nap = sorszam) AND (Lista[i].Amator = amator)) then BEGIN
			if(szame(Lista[i].Feljegyzes[1])) then BEGIN
				egyed[1] := StrToInt(Lista[i].Feljegyzes[1]);
			END;
			
			if(szame(Lista[i].Feljegyzes[3])) then BEGIN
				egyed[2] := StrToInt(Lista[i].Feljegyzes[3]);
			END;
		END;
	END;
	
	volt := boolean(egyed[1]+egyed[2]);
	
	if(volt) then BEGIN
		if((egyed[1] > 0) OR (egyed[2] > 0)) then BEGIN
			WriteLn('A megfigyelt egyedek száma: ', egyed[1]+egyed[2]);
		END else BEGIN
			WriteLn('Nincs információ');
		END;
	END else BEGIN
		WriteLn('Nincs ilyen feljegyzés');
	END;
END;

BEGIN
	ClrScr;
	
	Beolvasas();
	Feladat2();
	WriteLn;
	Feladat3();
	WriteLn;
	Feladat4();
	WriteLn;
	Feladat5();
	Feladat7();
	
	WriteLn;
	WriteLn;
END.
