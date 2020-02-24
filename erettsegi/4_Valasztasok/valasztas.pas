//Emelt érettségi 2013 május, http://dload.oktatas.educatio.hu/erettsegi/feladatok_2013tavasz_emelt/e_inf_13maj_fl.pdf
program valasztas;
uses crt, sysutils, strutils;

const max = 100;
	  adatok = 'szavazatok.txt';
	  
Type Sorok = record
	Kerulet:integer;
	Szavazatok:integer;
	Vezeteknev:string;
	Keresztnev:string;
	Part:string[5];
END;

var Lista:array[1..max] of Sorok;
	fajl:text;
	ossz:integer = 0;
	
Procedure Feladat1();
var sor:string;
	darab:array[1..5] of string;
	i:integer;
BEGIN
	Assign(fajl, adatok);
	Reset(fajl);
	
	While NOT EOF(fajl) do BEGIN
		ReadLn(fajl, sor);
		for i := 1 to 5 do BEGIN
			darab[i] := ExtractWord(i, sor, [' ']);
		END;
		
		ossz := ossz + 1;
		Lista[ossz].Kerulet := StrToInt(darab[1]);
		Lista[ossz].Szavazatok := StrToInt(darab[2]);
		Lista[ossz].Vezeteknev := darab[3];
		Lista[ossz].Keresztnev := darab[4];
		Lista[ossz].Part := darab[5];
	END;
	
	Close(fajl);
END;

Procedure Feladat2();
BEGIN
	WriteLn('2. feladat:');
	WriteLn('A helyhatósági választáson ', ossz, ' képviselőjelölt indult.');
END;

Procedure Feladat3();
var nev:array[1..2] of string;
	i:integer;
	szemely:integer = 0;
BEGIN
	WriteLn('3. feladat:');
	Write('Adj meg egy vezetéknevet: ');
	ReadLn(nev[1]);
	Write('Adj meg egy keresztnevet: ');
	ReadLn(nev[2]);
	
	for i := 1 to ossz do BEGIN
		if((Lista[i].Vezeteknev = nev[1]) AND (Lista[i].Keresztnev = nev[2])) then BEGIN
			szemely := i;
		END;
	END;
	
	if(szemely = 0) then BEGIN
		WriteLn('Ilyen nevű képviselőjelölt nem szerepel a nyilvántartásban!');
	END else BEGIN
		WriteLn(nev[1], ' ', nev[2], ' ', Lista[szemely].Szavazatok,' szavazatot kapott');
	END;
END;

Procedure Feladat5(szavaz:integer);
var partok:array[1..5] of integer;
	i:integer;
BEGIN
	WriteLn;
	WriteLn('5. feladat:');
	
	for i := 1 to 5 do BEGIN
		partok[i] := 0;
	END;
	
	for i := 1 to ossz do BEGIN
		Case Lista[i].Part Of
			'GYEP':partok[1] := partok[1] + Lista[i].Szavazatok;
			'ZEP':partok[2] := partok[2] + Lista[i].Szavazatok;
			'HEP':partok[3] := partok[3] + Lista[i].Szavazatok;
			'TISZ':partok[4] := partok[4] + Lista[i].Szavazatok;
			'-':partok[5] := partok[5] + Lista[i].Szavazatok;
		END;
	END;
	
	WriteLn('Gyümölcsevők Pártja= ', (100/szavaz)*partok[1]:2:2, '%');
	WriteLn('Zöldségevők Pártja= ', (100/szavaz)*partok[2]:2:2, '%');
	WriteLn('Húsevők Pártja= ', (100/szavaz)*partok[3]:2:2, '%');
	WriteLn('Tejivók Szövetsége= ', (100/szavaz)*partok[4]:2:2, '%');
	WriteLn('Független jelöltek= ', (100/szavaz)*partok[5]:2:2, '%');
END;

Procedure Feladat4();
var i:integer;
	darab:integer = 0;
BEGIN
	WriteLn('4. feladat:');
	for i := 1 to ossz do BEGIN
		darab := darab + Lista[i].Szavazatok;
	END;
	
	WriteLn('A választáson ', darab, ' állampolgár, a jogosultak ', (100/12345)*darab:2:2, '%-a vett részt.');
	Feladat5(darab);
END;

Procedure Feladat6();
var legnagyobb:integer = 0;
	i:integer;
BEGIN
	WriteLn('6. feladat:');
	
	for i := 1 to ossz do BEGIN
		if(Lista[i].Szavazatok > legnagyobb) then BEGIN
			legnagyobb := Lista[i].Szavazatok;
		END;
	END;
	
	WriteLn('Legtöbb szavazattal rendelkező jelöltek: ');
	for i := 1 to ossz do BEGIN
		if(Lista[i].Szavazatok = legnagyobb) then BEGIN
			if not(Lista[i].Part = '-') then BEGIN
				WriteLn(Lista[i].Vezeteknev, ' ', Lista[i].Keresztnev, ' ', Lista[i].Part);
			END else BEGIN
				WriteLn(Lista[i].Vezeteknev, ' ', Lista[i].Keresztnev, ' független');
			END;
		END;
	END;
END;

Procedure Feladat7();
var i:integer;
	k:integer;
	nyertes:array[1..8] of integer;
BEGIN
	for i := 1 to 8 do BEGIN
		nyertes[i] := 0;
	END;
	
	for i := 1 to 8 do BEGIN
		for k := 1 to ossz do BEGIN
			if(Lista[k].Kerulet = i) then BEGIN
				if(Lista[k].Szavazatok > Lista[nyertes[i]].Szavazatok) then BEGIN
					nyertes[i] := k;
				END;
			END;
		END;
	END;
	
	Assign(fajl, 'kepviselok.txt');
	ReWrite(fajl);
	
	for i := 1 to 8 do BEGIN
		if not(Lista[nyertes[i]].Part = '-') then BEGIN
			WriteLn(fajl, i, ' ', Lista[nyertes[i]].Vezeteknev, ' ', Lista[nyertes[i]].Keresztnev, ' ', Lista[nyertes[i]].Part);
		END else BEGIN
			WriteLn(fajl, i, ' ', Lista[nyertes[i]].Vezeteknev, ' ', Lista[nyertes[i]].Keresztnev, ' független');
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
	Feladat6();
	WriteLn;
	Feladat7();
	
	WriteLn;
	WriteLn;
END.
