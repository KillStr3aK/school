//Emelt érettségi 2014 október, http://dload.oktatas.educatio.hu/erettsegi/feladatok_2014osz_emelt/e_inf_14okt_fl.pdf
program nezoter;
uses crt, strutils, sysutils;

var Sorok:array[1..15] of string[20];
	Arak:array[1..15] of string[20];
	fajl:text;
	
Procedure Beolvasas();
var i:integer;
BEGIN
	Assign(fajl, 'foglaltsag.txt');
	Reset(fajl);
	
	for i := 1 to 15 do BEGIN
		ReadLn(fajl, Sorok[i]);
	END;
	
	Close(fajl);
	
	Assign(fajl, 'kategoria.txt');
	Reset(fajl);
	
	for i := 1 to 15 do BEGIN
		ReadLn(fajl, Arak[i]);
	END;
	
	Close(fajl);
END;

Procedure Feladat2();
var sor:integer;
	szek:integer;
BEGIN
	WriteLn('2. feladat: ');
	
	Write('Adjon meg egy sor számot: ');
	ReadLn(sor);
	Write('Adjon meg egy szék számot: ');
	ReadLn(szek);
	
	if(Sorok[sor][szek] = 'x') then BEGIN
		WriteLn('Ez a szék már foglalt!');
	END else BEGIN
		WriteLn('Ez a szék még szabad!');
	END;
END;

Procedure Feladat3();
var i:integer;
	k:integer;
	db:integer = 0;
BEGIN
	WriteLn('3. feladat: ');
	
	for i := 1 to 15 do BEGIN
		for k := 1 to 20 do BEGIN
			if(Sorok[i][k] = 'x') then BEGIN
				db := db + 1;
			END;
		END;
	END;
	
	WriteLn('Az előadásra eddig ', db, ' jegyet adtak el, ez a nézőtér ', ((100/(15*20))*db):2:0,'%-a.');
END;

Procedure Feladat4();
var i:integer;
	k:integer;
	kategoria:array[1..5] of integer;
	legtobb:integer = 1;
BEGIN
	WriteLn('4. feladat: ');
	
	for i := 1 to 5 do BEGIN
		kategoria[i] := 0;
	END;
	
	for i := 1 to 15 do BEGIN
		for k := 1 to 20 do BEGIN
			if(Sorok[i][k] = 'x') then BEGIN
				kategoria[StrToInt(Arak[i][k])] := kategoria[StrToInt(Arak[i][k])] + 1;
			END;
		END;
	END;
	
	for i := 1 to 5 do BEGIN
		if(kategoria[i] > kategoria[legtobb]) then BEGIN
			legtobb := i;
		END;
	END;
	
	WriteLn('A legtöbb jegyet a(z) ', legtobb, '. árkategóriában értékesítették.');
END;

Function Arkategoria(kategoria:integer): integer;
var ar:integer;
BEGIN
	Case kategoria Of
		1:ar := 5000;
		2:ar := 4000;
		3:ar := 3000;
		4:ar := 2000;
		5:ar := 1500;
	END;
	
	Arkategoria := ar;
END;

Procedure Feladat5();
var i:integer;
	k:integer;
	kategoria:array[1..5] of integer;
	bevetel:int64 = 0;
BEGIN
	WriteLn('5. feladat: ');
	
	for i := 1 to 5 do BEGIN
		kategoria[i] := 0;
	END;
	
	for i := 1 to 15 do BEGIN
		for k := 1 to 20 do BEGIN
			if(Sorok[i][k] = 'x') then BEGIN
				kategoria[StrToInt(Arak[i][k])] := kategoria[StrToInt(Arak[i][k])] + 1;
			END;
		END;
	END;
	
	for i := 1 to 5 do BEGIN
		bevetel := bevetel + (Arkategoria(i)*kategoria[i]);
	END;
	
	WriteLn('A színház pillanatnyi bevétele: ', bevetel, ' Ft');
END;

Procedure Feladat6();
var i:integer;
	k:integer;
	db:integer = 0;
BEGIN
	for i := 1 to 15 do BEGIN
		for k := 1 to 20 do BEGIN
			if((Sorok[i][k] = 'o'){ AND not(Sorok[i][k+1] = 'o')}) then BEGIN //Azért van kikommentelve mert a feladat nem egyértelmű/nincs minta
				if(Sorok[i][k-1] = 'x') then BEGIN
					db := db + 1;
				END;
			END;
		END;
	END;
	
	WriteLn('Összesen ', db, 'db egyedülálló hely van.');
END;

Procedure Feladat7();
var i:integer;
	k:integer;
BEGIN
	Assign(fajl, 'szabad.txt');
	ReWrite(fajl);
	
	for i := 1 to 15 do BEGIN
		for k := 1 to 20 do BEGIN
			if(Sorok[i][k] = 'x') then BEGIN
				Write(fajl, 'x');
			END else BEGIN
				Write(fajl, Arak[i][k]);
			END;
		END;
		
		WriteLn(fajl);
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
	WriteLn;
	Feladat5();
	WriteLn;
	Feladat6();
	WriteLn;
	Feladat7();
	WriteLn;
	
	WriteLn;
	WriteLn;
END.
