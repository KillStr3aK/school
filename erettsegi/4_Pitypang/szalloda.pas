// Emelt 2011 október, https://www.informatikatanarok.hu/media/uploads/Informatika_erettsegi/Emelt/e_inf_11okt_fl.pdf
program szalloda;
uses crt;

Procedure Honapok(); Forward;

const max = 1000;
Type struct = record
	ID:integer;
	Szoba:integer;
	Erkezes:integer;
	Tavozas:integer;
	Vendegek:integer;
	Reggeli:integer;
	Azonosito:string[25];
END;

Type hostruct = record
	Ho:string[20];
	Napok:integer;
	Osszesnap:integer;
END;

var fajl:text;
	ossz:integer = 0;
	Adatok:array[1..max] of struct;
	Honap:array[1..12] of hostruct;

Procedure Feladat1();
var i:integer;
BEGIN
	Assign(fajl, 'pitypang.txt');
	Reset(fajl);
	
	ReadLn(fajl, ossz);
	for i := 1 to ossz do BEGIN
		ReadLn(fajl, Adatok[i].ID, Adatok[i].Szoba, Adatok[i].Erkezes, Adatok[i].Tavozas, Adatok[i].Vendegek, Adatok[i].Reggeli, Adatok[i].Azonosito);
	END;
	
	Close(fajl);
	Honapok();
END;

Procedure Honapok();
var i:integer;
	hofajl:text;
BEGIN
	Assign(hofajl, 'honapok.txt');
	Reset(hofajl);
	
	for i := 1 to 12 do BEGIN
		ReadLn(hofajl, Honap[i].Ho);
		ReadLn(hofajl, Honap[i].Napok);
		ReadLn(hofajl, Honap[i].Osszesnap);
	END;
	
	Close(hofajl);
END;

Procedure Feladat2();
var i:integer;
	legtobb:integer = 0;
BEGIN
	WriteLn('2. feladat:');
	for i := 1 to ossz do BEGIN
		if((Adatok[i].Tavozas-Adatok[i].Erkezes) > (Adatok[legtobb].Tavozas-Adatok[legtobb].Erkezes)) then BEGIN
			legtobb := i;
		END;
	END;
	
	WriteLn(Adatok[legtobb].Azonosito, ' (', Adatok[legtobb].Erkezes, ') – ', Adatok[legtobb].Tavozas-Adatok[legtobb].Erkezes);
END;

Function Fizetendo(foglalas:integer): int64;
var result:int64 = 0;
	napok:integer;
BEGIN
	napok := Adatok[foglalas].Tavozas-Adatok[foglalas].Erkezes;
	if(Adatok[foglalas].Tavozas > 120) then BEGIN
		result := result + (napok*10000);
	END else if(Adatok[foglalas].Tavozas > 243) then BEGIN
		result := result + (napok*8000);
	END else BEGIN
		result := result + (napok*9000);
	END;
	
	if(Adatok[foglalas].Vendegek > 2) then BEGIN
		result := result + ((Adatok[foglalas].Vendegek-2)*2000);
	END;
	
	if(Adatok[foglalas].Reggeli = 1) then BEGIN
		result := result + (napok*Adatok[foglalas].Vendegek*1100);
	END;
	
	Fizetendo := result;
END;

Procedure Feladat3();
var i:integer;
	evi:int64 = 0;
BEGIN
	WriteLn('3. feladat:');
	Assign(fajl, 'bevetel.txt');
	ReWrite(fajl);
	
	for i := 1 to ossz do BEGIN
		evi := evi + Fizetendo(i);
		WriteLn(fajl, Adatok[i].ID, ':', Fizetendo(i));
	END;
	
	WriteLn('A szálloda éves bevétele: ', evi);
	Close(fajl);
END;

Procedure Feladat4(); //???????????????
var i:integer;
	k:integer;
	ej:integer = 0;
BEGIN
	WriteLn('4. feladat:');
	for i := 1 to 12 do BEGIN
		ej := 0;
		for k := 1 to ossz do BEGIN
			if(k = i) then BEGIN //gatya
				ej := ej + (Adatok[i].Tavozas-Adatok[i].Erkezes);
			END;
		END;
		
		WriteLn(i, ': ', ej, ' vendégéj');
	END;
END;

Procedure Feladat5(); //Nemtudom jó-e
var i:integer = 0;
	sorszam:integer = 0;
	szobak:integer = 27;
	ejszakak:integer;
BEGIN
	WriteLn('5. feladat:');
	Write('Adj meg egy nap sorszámot: ');
	ReadLn(sorszam);
	Write('Add meg az éjszakák számát: ');
	ReadLn(ejszakak);
	
	for i := 1 to ossz do BEGIN
		if((Adatok[i].Tavozas >= sorszam) AND (Adatok[i].Tavozas < (sorszam+ejszakak))) then BEGIN
			szobak := szobak - 1;
		END;
	END;
	
	WriteLn('A megadott időszak alatt ', szobak, ' szabad szoba van.');
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
	
	WriteLn;
	WriteLn;
END.
