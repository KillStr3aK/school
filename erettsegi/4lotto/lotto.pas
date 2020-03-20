//Emelt érettségi 2005 május, https://www.informatikatanarok.hu/media/uploads/Informatika_erettsegi/Emelt/e_info_fl.pdf
program lotto;
uses crt;

var fajl:text;
	Szamok:array[1..51, 1..5] of integer;
	Het:array[1..5] of integer;
	
Procedure Beolvasas();
var i:integer;
BEGIN
	Assign(fajl, 'lottosz.dat');
	Reset(fajl);
	
	for i := 1 to 51 do BEGIN
		ReadLn(fajl, Szamok[i][1], Szamok[i][2], Szamok[i][3], Szamok[i][4], Szamok[i][5]);
	END;
	
	Close(fajl);
END;

Procedure Feladat1();
var csere:integer;
	i:integer;
	k:integer;
BEGIN
	WriteLn('1. feladat:');
	for i := 1 to 5 do BEGIN
		Write('Add meg az 52. hét ', i, '. számát: ');
		ReadLn(Het[i]);
	END;
	
	for i := 1 to 5 do BEGIN
		for k := 1 to 5-i do BEGIN
			if(Het[k] > Het[k+1]) then BEGIN
				csere := Het[k+1];
				Het[k+1] := Het[k];
				Het[k] := csere;
			END;
		END;
	END;
	
	WriteLn;
	WriteLn('2. feladat:');
	for i := 1 to 5 do BEGIN
		Write(Het[i], ' ');
	END;
	WriteLn;
END;

Procedure Feladat4(szam:integer);
var	i:integer;
BEGIN
	WriteLn;
	WriteLn('4. feladat:');
	for i := 1 to 5 do BEGIN
		Write(Szamok[szam][i], ' ');
	END;
END;

Procedure Feladat3();
var szam:integer;
BEGIN
	WriteLn('3. feladat:');
	Write('Adj meg egy számot 1-51 között: ');
	ReadLn(szam);
	Feladat4(szam);
END;

Procedure Feladat5();
var i:integer;
	j:integer;
	Huzott:array[1..90] of boolean;
	Van:boolean = false;
BEGIN
	WriteLn;
	WriteLn;
	WriteLn('5. feladat:');
	
	for i := 1 to 90 do BEGIN
		Huzott[i] := false;
	END;
	
	for i := 1 to 51 do BEGIN
		for j := 1 to 5 do BEGIN
			Huzott[Szamok[i][j]] := true;
		END;
	END;
	
	
	for i := 1 to 90 do BEGIN
		if(Huzott[i] = false) then BEGIN
			Van := true;
		END;
	END;
	
	Case Van Of
		true: WriteLn('Van');
		false: WriteLn('Nincs');
	END;
END;

Procedure Feladat6();
var paratlanok:integer = 0;
	i:integer;
	k:integer;
BEGIN
	WriteLn('6. feladat:');
	
	for i := 1 to 51 do BEGIN
		for k := 1 to 5 do BEGIN
			if not((Szamok[i][k] mod 2) = 0) then BEGIN
				paratlanok := paratlanok + 1;
			END;
		END;
	END;
	
	WriteLn(paratlanok, ' alkalommal húztak páratlan számot!');
END;

Procedure Feladat7();
var i:integer;
	k:integer;
BEGIN
	WriteLn('7. feladat:');
	
	Assign(fajl, 'lotto52.ki');
	ReWrite(fajl);
	
	for i := 1 to 51 do BEGIN
		for k := 1 to 5 do BEGIN
			Write(fajl, Szamok[i][k], ' ');
		END;
		
		WriteLn(fajl);
	END;
	
	for i := 1 to 5 do BEGIN
		Write(fajl, Het[i], ' ');
	END;
	
	Close(fajl);
	WriteLn('(lotto52.ki fájl létrehozva)');
END;

Procedure Feladat8();
var Darab:array[1..90] of integer;
	k:integer;
	i:integer;
BEGIN
	WriteLn('8. feladat:');
	
	for i := 1 to 90 do BEGIN
		Darab[i] := 0;
	END;
	
	Assign(fajl, 'lotto52.ki');
	Reset(fajl);
	
	for i := 1 to 51 do BEGIN
		for k := 1 to 5 do BEGIN
			Darab[Szamok[i][k]] := Darab[Szamok[i][k]] + 1;
		END;
	END;
	
	WriteLn;
	for k := 1 to 90 do BEGIN
		Write(Darab[k], ' ');
			
		if((k mod 15) = 0) then BEGIN
			WriteLn;
		END;
	END;
		
	Close(fajl);
END;

Procedure Feladat9();
var i:integer;
	k:integer;
	primek:array[2..90] of boolean;
BEGIN
	WriteLn('9. feladat:');
	
	for i := 2 to 90 do BEGIN
		primek[i] := true;
	END;
	
	for i := 2 to 90 do BEGIN
		if(primek[i] = true) then BEGIN
			for k := 2 to (90 div i) do BEGIN
				primek[i*k] := false;
			END;
		END;
	END;
	
	for i := 2 to 51 do BEGIN
		for k := 1 to 5 do BEGIN
			primek[Szamok[i][k]] := false; //Azokat a prímeket amelyeket kihúztak átállítom hamisra
		END;
	END;
	
	for k := 1 to 5 do BEGIN
		primek[Het[k]] := false; //Azokat a prímeket amelyeket kihúztak az 52. héten átállítom hamisra
	END;
	
	Write('Ezeket a prímszámokat nem húzták ki: ');
	for i := 2 to 90 do BEGIN
		if(primek[i] = true) then BEGIN
			Write(i, ' ');
		END;
	END;
END;

BEGIN
	ClrScr;
	
	Beolvasas();
	Feladat1();
	WriteLn;
	Feladat3();
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
