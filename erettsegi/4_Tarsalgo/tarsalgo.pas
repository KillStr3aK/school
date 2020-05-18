program tarsalgo;
uses crt;

const max = 1000;
Type Adatok = record
	Ora:integer;
	Perc:integer;
	Azon:integer;
	Irany:string;
END;

var fajl:text;
	Lista:array[1..max] of Adatok;
	ossz:integer = 0;
	bentvan:array[1..100] of boolean;
	
Procedure Feladat1();
BEGIN
	Assign(fajl, 'ajto.txt');
	Reset(fajl);
	
	While NOT EOF(fajl) do BEGIN
		ossz := ossz + 1;
		ReadLn(fajl, Lista[ossz].Ora, Lista[ossz].Perc, Lista[ossz].Azon, Lista[ossz].Irany);
	END;
	
	Close(fajl);
END;

Procedure Feladat2();
var i:integer;
	utolso:integer = 0;
BEGIN
	WriteLn('2. feladat:');
	WriteLn('Az első belépő: ', Lista[1].Azon);
	
	for i := 1 to ossz do BEGIN
		if(Lista[i].Irany = ' ki') then BEGIN
			utolso := i;
		END;
	END;
	
	WriteLn('Az utolsó kilépő: ', Lista[utolso].Azon);
END;

Procedure Feladat3();
var i:integer;
	k:integer;
	athaladas:array[1..100] of integer;
BEGIN
	for i := 1 to 100 do BEGIN
		athaladas[i] := 0;
	END;
	
	for i := 1 to 100 do BEGIN
		for k := 1 to ossz do BEGIN
			if(Lista[k].Azon = i) then BEGIN
				athaladas[i] := athaladas[i] + 1;
			END;
		END;
	END;
	
	Assign(fajl, 'athaladas.txt');
	ReWrite(fajl);

	for i := 1 to 100 do BEGIN
		if(athaladas[i] > 0) then BEGIN
			WriteLn(fajl, i, ' ', athaladas[i]);
		END;
	END;
	
	Close(fajl);
END;

Procedure Feladat4();
var i:integer;
	k:integer;
BEGIN
	WriteLn('4. feladat:');
	Write('A végén a társalgóban voltak: '); //1 11 22 24 29 30 35 37
	
	for i := 1 to 100 do BEGIN
		for k := 1 to ossz do BEGIN
			if(Lista[k].Azon = i) then BEGIN
				Case Lista[k].Irany Of
					' be':bentvan[i] := true;
					' ki':bentvan[i] := false;
				END;
			END;
		END;
	END;
	
	for i := 1 to 100 do BEGIN
		if(bentvan[i]) then BEGIN
			Write(i, ' ');
		END;
	END;
	
	WriteLn;
END;

Procedure Feladat5();
var i:integer;
	letszam:integer = 0;
	ora:integer = 0;
	perc:integer = 0;
	max:integer = 0;
BEGIN
	WriteLn('5. feladat:');
	
	for i := 1 to ossz do BEGIN
		Case Lista[i].Irany Of
			' be':letszam := letszam + 1;
			' ki':letszam := letszam - 1;
		END;
		
		if(letszam > max) then BEGIN
			max := letszam;
			ora := Lista[i].Ora;
			perc := Lista[i].Perc;
		END;
	END;
	
	WriteLn('Például ', ora, ':', perc, '-kor voltak a legtöbben a társalgóban.');
END;

Procedure Feladat7(azonosito:integer) Forward;
Procedure Feladat8(azonosito:integer) Forward;

Procedure Feladat6();
var azonosito:integer;
BEGIN
	WriteLn('6. feladat:');
	Write('Adja meg a személy azonosítóját! ');
	ReadLn(azonosito);
	
	Feladat7(azonosito);
END;

Procedure Feladat7(azonosito:integer);
var i:integer;
BEGIN
	WriteLn;
	WriteLn('7. feladat:');
	for i := 1 to ossz do BEGIN
		if(Lista[i].Azon = azonosito) then BEGIN
			if(Lista[i].Irany = ' be') then BEGIN
				Write(Lista[i].Ora, ':', Lista[i].Perc, '-');
			END else BEGIN
				Write(Lista[i].Ora, ':', Lista[i].Perc);
				WriteLn;
			END;
		END;
	END;
	
	WriteLn;
	Feladat8(azonosito);
END;

Procedure Feladat8(azonosito:integer);
var i:integer;
	osszperc:integer = 0;
	perc:integer;
BEGIN
	WriteLn;
	WriteLn('8. feladat:');
	
	for i := 1 to ossz do BEGIN
		if(Lista[i].Azon = azonosito) then BEGIN
			if(Lista[i].Irany = ' be') then BEGIN
				perc := Lista[i].Perc;
			END else BEGIN
				osszperc := osszperc + (Lista[i].Perc - perc);
			END;
			
			WriteLn(osszperc);
		END;
	END;
	
	Write('A(z) ', azonosito, '. személy összesen ', osszperc, ' percet volt bent,');
	Case bentvan[azonosito] Of
		true: Write(' a megfigyelés végén a társalgóban volt.');
		false: Write(' a megfigyelés végén nem volt a társalgóban.');
	END;
END;

BEGIN
	ClrScr;
	
	Feladat1();
	Feladat2();
	WriteLn;
	Feladat3();
	Feladat4();
	WriteLn;
	Feladat5();
	WriteLn;
	Feladat6();
	
	WriteLn;
	WriteLn;
END.
