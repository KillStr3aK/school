//Emelt érettségi 2014 május, http://dload.oktatas.educatio.hu/erettsegi/feladatok_2014tavasz_emelt/e_inf_14maj_fl.pdf
program cimek;
uses crt, strutils, sysutils;

const adatok = 'ip.txt';
	  max = 500;
	  
var Ipcimek:array[1..max] of string[40];
	ossz:integer = 0;
	fajl:text;
	
Procedure Feladat1();
BEGIN
	Assign(fajl, adatok);
	Reset(fajl);
	
	While NOT EOF(fajl) do BEGIN
		ossz := ossz + 1;
		ReadLn(fajl, Ipcimek[ossz]);
	END;
	
	Close(fajl);
END;

Procedure Feladat2();
BEGIN
	WriteLn('2. feladat:');
	WriteLn('Az állományban ', ossz, ' darab adatsor van.');
END;

Procedure Feladat3();
BEGIN
	WriteLn('3. feladat:');
	WriteLn('A legalacsonyabb tárolt IP-cím:');
END;

Procedure Feladat4();
var darab:array[1..3] of integer;
	i:integer;
BEGIN
	WriteLn('4. feladat:');
	
	for i := 1 to 3 do BEGIN
		darab[i] := 0;
	END;
	
	for i := 1 to ossz do BEGIN
		if(AnsiContainsStr(Ipcimek[i][1..9], '2001:0db8')) then BEGIN
			darab[1] := darab[1] + 1;
		END else if(AnsiContainsStr(Ipcimek[i][1..7], '2001:0e')) then BEGIN
			darab[2] := darab[2] + 1;
		END else BEGIN
			darab[3] := darab[3] + 1;
		END;
	END;
	
	WriteLn('Dokumentációs cím: ', darab[1], ' darab');
	WriteLn('Globális egyedi cím: ', darab[2], ' darab');
	WriteLn('Helyi egyedi cím: ', darab[3], ' darab');
END;

Function Hanynulla(sor:string): integer;
var darab:integer = 0;
	i:integer;
BEGIN
	for i := 1 to length(sor) do BEGIN
		if(sor[i] = '0') then BEGIN
			darab := darab + 1;
		END;
	END;
	
	Hanynulla := darab;
END;

Procedure Feladat5();
var	i:integer;
BEGIN
	Assign(fajl, 'sok.txt');
	ReWrite(fajl);
	
	for i := 1 to ossz do BEGIN
		if(Hanynulla(Ipcimek[i]) >= 18) then BEGIN
			WriteLn(fajl, i, ' ', Ipcimek[i]);
		END;
	END;
	
	Close(fajl);
END;

Procedure Feladat7(ipcim:string);
BEGIN
	WriteLn;
	WriteLn('7. feladat:');
	if(AnsiContainsStr(ipcim, ':0:0:0:')) then BEGIN
		WriteLn(ReplaceStr(ipcim, ':0:0:0:', '::'));
	END else if(AnsiContainsStr(ipcim, ':0:0:')) then BEGIN
		WriteLn(ReplaceStr(ipcim, ':0:0:', '::'));
	END else BEGIN
		WriteLn('Nem rövidíthető tovább.');
	END;
END;

Procedure Feladat6();
var sorszam:integer;
	ujcim:string[40];
BEGIN
	WriteLn('6. feladat:');
	Write('Kérek egy sorszámot: ');
	ReadLn(sorszam);
	
	WriteLn(Ipcimek[sorszam]);
	ujcim := ReplaceStr(Ipcimek[sorszam], '0000', '0');
	WriteLn(ujcim);
	
	Feladat7(ujcim);
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
