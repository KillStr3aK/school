//Emelt érettségi 2012 május, https://www.oktatas.hu/pub_bin/dload/kozoktatas/erettsegi/feladatok2012tavasz/emelt/e_inf_12maj_fl.pdf
program futar;
uses crt, strutils, sysutils;

const adatok = 'tavok.txt';
	  max = 61;

Type Jegyzet = record
	Nap:integer;
	Fuvar:integer;
	Km:integer;
END;

var Lista:array[1..max] of Jegyzet;
	fajl:text;
	i:integer;
	k:integer;
	g:integer;
	ossz:integer;

Procedure Beolvasas();
var sor:string;
	darab:array[1..3] of string;
BEGIN
	Assign(fajl, adatok);
	Reset(fajl);
	
	While NOT EOF(fajl) do BEGIN
		ReadLn(fajl, sor);
		for i := 1 to 3 do BEGIN
			darab[i] := ExtractWord(i, sor, [' ']);
		END;
		
		ossz := ossz + 1;
		Lista[ossz].Nap := StrToInt(darab[1]);
		Lista[ossz].Fuvar := StrToInt(darab[2]);
		Lista[ossz].Km := StrToInt(darab[3]);
	END;
	
	Close(fajl);
END;

Procedure Feladat2();
var index:integer = 1;
	lnap:integer = 8;
	osszesen:integer;
BEGIN
	WriteLn('2. feladat:');
	
	for i := 1 to ossz do BEGIN
		if(Lista[i].Nap < lnap) then BEGIN
			lnap := Lista[i].Nap;
		END;
	END;
	
	osszesen := ossz;
	While NOT(osszesen = 0) do BEGIN
		if(Lista[osszesen].Nap = lnap) then BEGIN
			if(Lista[osszesen].Fuvar < Lista[index].Fuvar) then BEGIN
				index := osszesen;
			END;
		END;
		
		osszesen := osszesen - 1;
	END;
	
	WriteLn('A hét legelső útja ', Lista[index].Km, ' km volt!');
END;

Procedure Feladat3();
var index:integer = 1;
	lnap:integer = 0;
	osszesen:integer;
BEGIN
	WriteLn('3. feladat:');
	
	for i := 1 to ossz do BEGIN
		if(Lista[i].Nap > lnap) then BEGIN
			lnap := Lista[i].Nap;
		END;
	END;
	
	osszesen := ossz;
	While NOT(osszesen = 0) do BEGIN
		if(Lista[osszesen].Nap = lnap) then BEGIN
			if(Lista[osszesen].Fuvar > Lista[index].Fuvar) then BEGIN
				index := osszesen;
			END;
		END;
		
		osszesen := osszesen - 1;
	END;
	
	WriteLn('A hét utolsó útja ', Lista[index].Km, ' km volt!');
END;

Procedure Feladat4();
var dolgozott:array[1..7] of boolean;
BEGIN
	for i := 1 to 7 do BEGIN
		dolgozott[i] := false;
	END;
	
	for i := 1 to ossz do BEGIN
		dolgozott[Lista[i].Nap] := true;
	END;
	
	Write('A futár ezeken a napokon nem dolgozott: ');
	for i := 1 to 7 do BEGIN
		if(dolgozott[i] = false) then BEGIN
			Write(i, ' ');
		END;
	END;
END;

Procedure Feladat5();
var fuvarok:array[1..7] of integer;
	nap:integer = 1;
BEGIN
	WriteLn('5. feladat: ');
	
	for i := 1 to 7 do BEGIN
		fuvarok[i] := 0;
	END;
	
	for i := 1 to ossz do BEGIN
		fuvarok[Lista[i].Nap] := fuvarok[Lista[i].Nap] + 1;
	END;
	
	for i := 1 to 7 do BEGIN
		if(fuvarok[i] > fuvarok[nap]) then BEGIN
			nap := i;
		END;
	END;
	
	WriteLn('A(z) ', nap, '. napon volt a legtöbb fuvar.');
END;

Procedure Feladat6();
var ut:array[1..7] of integer;
BEGIN
	WriteLn('6. feladat: ');
	
	for i := 1 to 7 do BEGIN
		ut[i] := 0;
	END;
	
	for i := 1 to ossz do BEGIN
		ut[Lista[i].Nap] := ut[Lista[i].Nap]+Lista[i].Km;
	END;
	
	for i := 1 to 7 do BEGIN
		WriteLn(i, '. nap: ', ut[i],' km ');
	END;
END;

Function Fuvardij(km:integer): integer;
var dij:integer;
BEGIN
	Case km Of
		1..2:dij := 500;
		3..5:dij := 700;
		6..10:dij := 900;
		11..20:dij := 1400;
		21..30:dij := 2000;
	END;
	
	Fuvardij := dij;
END;

Procedure Feladat7();
var km:integer;
BEGIN
	WriteLn('7. feladat: ');
	Write('Adj meg egy tetszőleges távolságot: ');
	ReadLn(km);
		
	WriteLn('Díjazás: ', Fuvardij(km));
END;

Function HanyFuvar(nap:integer): integer;
var j:integer;
	db:integer = 0;
BEGIN
	for j := 1 to ossz do BEGIN
		if(Lista[j].Nap = nap) then BEGIN
			db := db + 1;
		END;
	END;
	
	HanyFuvar := db;
END;

Procedure Feladat8();
BEGIN
	Assign(fajl, 'dijazas.txt');
	ReWrite(fajl);
	
	for k := 1 to 7 do BEGIN
		for g := 1 to HanyFuvar(k) do BEGIN
			for i := 1 to ossz do BEGIN
				if((Lista[i].Nap = k) AND (Lista[i].Fuvar = g)) then BEGIN
					WriteLn(fajl, Lista[i].Nap, '. nap ', g, '. út: ', Fuvardij(Lista[i].Km), ' Ft');
				END;
			END;
		END;
	END;
	
	Close(fajl);
END;

Procedure Feladat9();
var fizetes:int64 = 0;
BEGIN
	WriteLn('9. feladat: ');
	
	for k := 1 to 7 do BEGIN
		for g := 1 to HanyFuvar(k) do BEGIN
			for i := 1 to ossz do BEGIN
				if((Lista[i].Nap = k) AND (Lista[i].Fuvar = g)) then BEGIN
					fizetes := fizetes + Fuvardij(Lista[i].Km);
				END;
			END;
		END;
	END;
	
	WriteLn('A futár ', fizetes, ' Ft fizetést kap a heti munkájáért!');
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
	WriteLn;
	Feladat5();
	WriteLn;
	Feladat6();
	WriteLn;
	Feladat7();
	WriteLn;
	Feladat8();
	WriteLn;
	Feladat9();
	
	WriteLn;
	WriteLn;
END.
