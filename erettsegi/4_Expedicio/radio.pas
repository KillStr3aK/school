//Emelt érettségi 2015 május, http://dload.oktatas.educatio.hu/erettsegi/feladatok_2015tavasz_emelt/e_inf_15maj_fl.pdf
program radio;
uses crt, sysutils, strutils;

const adatok = 'veetel.txt';
	  max = 306;

Type Vetel = record
	Nap:integer;
	Amator:integer;
	Uzenet:string;
END;

var fajl:text;
	Lista:array[1..max] of Vetel;
	i:integer;
	k:integer;
	ossz:integer = 0;

Procedure Beolvasas();
var sor:string;
	darab:array[1..3] of string;
BEGIN
	Assign(fajl, adatok);
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
		
		Lista[ossz].Uzenet := sor;
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
BEGIN
	WriteLn('3. feladat:');
	for i := 1 to ossz do BEGIN
		if(AnsiContainsStr(Lista[i].Uzenet, 'farkas')) then BEGIN
			WriteLn(Lista[i].Nap, '. nap ', Lista[i].Amator,'. rádióamatőr');
		END;
	END;
END;

Function HanyAmator(nap:integer): integer;
var osszeg:integer = 0;
BEGIN
	for k := 1 to ossz do BEGIN
		if(Lista[k].Nap = nap) then BEGIN
			osszeg := osszeg + 1;
		END;
	END;
	
	HanyAmator := osszeg;
END;

Procedure Feladat4();
BEGIN
	WriteLn('4. feladat:');
	
	for i := 1 to 11 do BEGIN
		WriteLn(i, '. nap: ', HanyAmator(i), ' rádióamatőr');
	END;
END;

Procedure Feladat5();
var j:integer;
	szoveg:string[90];
BEGIN
	Assign(fajl, 'aadas.txt');
	ReWrite(fajl);
	
	for j := 1 to 11 do BEGIN
		for i := 1 to 90 do BEGIN
			for k := 1 to ossz do BEGIN
				if(Lista[k].Nap = j) then BEGIN
					if not(Lista[k].Uzenet[i] = '#') then BEGIN
						szoveg[i] := Lista[k].Uzenet[i];
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
BEGIN
	valasz := true;
	for i := 1 to length(szo) do BEGIN
		if((szo[i] < '0') or (szo[i] > '9')) then BEGIN
			valasz := false;
		END;
	END;
	
	szame := valasz;
END;

Procedure Feladat7();
var nap:integer;
	amator:integer;
	egyedek:array[1..2] of integer;
	volt:boolean = false;
BEGIN
	WriteLn('7. feladat:');
	Write('Adja meg a nap sorszámát! ');
	ReadLn(nap);
	Write('Adja meg a rádióamatőr sorszámát! ');
	ReadLn(amator);
	
	for k := 1 to ossz do BEGIN
		if((Lista[k].Nap = nap) AND (Lista[k].Amator = amator)) then BEGIN
			if(szame(Lista[k].Uzenet[1]) = true) then BEGIN
				egyedek[1] := StrToInt(Lista[k].Uzenet[1]);
			END;
			
			if(szame(Lista[k].Uzenet[3]) = true) then BEGIN
				egyedek[2] := StrToInt(Lista[k].Uzenet[3]);
			END;
			
			volt := true;
		END;
	END;

	if(volt = false) then BEGIN
		WriteLn('Nincs ilyen feljegyzés');
	END else if((egyedek[1] > 0) or (egyedek[2] > 0)) then BEGIN
		WriteLn('A megfigyelt egyedek száma: ', egyedek[1]+egyedek[2]);
	END else BEGIN
		WriteLn('Nincs információ');
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
	WriteLn;
	Feladat7();
	
	WriteLn;
	WriteLn;
END.

{Function Helyreallitas(nap:integer): string;
var szoveg:string[90];
BEGIN
	for i := 1 to 90 do BEGIN
		for k := 1 to ossz do BEGIN
			if(Lista[k].Nap = nap) then BEGIN
				if not(Lista[k].Uzenet[i] = '#') then BEGIN
					szoveg[i] := Lista[k].Uzenet[i];
				END;
			END;
		END;
	END;
	
	WriteLn(szoveg[1..90]);
	Helyreallitas := szoveg;
END;}
