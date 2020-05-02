// Emelt érettségi 2013 október, https://www.informatikatanarok.hu/media/uploads/Informatika_erettsegi/Emelt/e_inf_13okt_fl.pdf
program jaror;
uses crt;

Type Struct = record
	Ora:integer;
	Perc:integer;
	Masodperc:integer;
	Rendszam:string[8];
END;

const max = 1000;

var fajl:text;
	ossz:integer = 0;
	Adatok:array[1..max] of Struct;

Procedure Feladat1();
BEGIN
	Assign(fajl, 'jarmu.txt');
	Reset(fajl);
	
	While NOT EOF(fajl) do BEGIN
		ossz := ossz + 1;
		ReadLn(fajl, Adatok[ossz].Ora, Adatok[ossz].Perc, Adatok[ossz].Masodperc, Adatok[ossz].Rendszam);
	END;
	
	Close(fajl);
END;

Procedure Feladat2();
BEGIN
	WriteLn('2. feladat:');
	WriteLn('A rendőrök ', Adatok[ossz].Ora-Adatok[1].Ora, ' órán át voltak szolgálatban');
END;

Procedure Feladat3();
var i:integer;
	ora:integer = 0;
BEGIN
	WriteLn('3. feladat:');
	for i := Adatok[1].Ora to Adatok[ossz].Ora do BEGIN
		if(Adatok[i].Ora > ora) then BEGIN
			ora := Adatok[i].Ora;
			WriteLn(i, ' óra: ', Adatok[i].Rendszam);
		END;
	END;
END;

Procedure Feladat4();
var i:integer;
	tipus:array[1..4] of integer;
BEGIN
	WriteLn('4. feladat:');
	
	for i := 1 to 4 do BEGIN
		tipus[i] := 0;
	END;
	
	for i := 1 to ossz do BEGIN
		Case Adatok[i].Rendszam[2] Of
			'B': tipus[1] := tipus[1] + 1;
			'K': tipus[2] := tipus[2] + 1;
			'M': tipus[3] := tipus[3] + 1;
		ELSE
			tipus[4] := tipus[4] + 1;
		END;
	END;
	
	WriteLn('Autóbusz: ', tipus[1]);
	WriteLn('Kamion: ', tipus[2]);
	WriteLn('Motor: ', tipus[3]);
	WriteLn('Személygépkocsi: ', tipus[4]);
END;

Procedure Feladat5();
var leghosszabbido:integer = 0;
	leghosszabb:integer = 2;
	temp:integer = 0;
	i:integer;
BEGIN
	WriteLn('5. feladat:');
	
	for i := 2 to ossz do BEGIN
		temp := Adatok[i].Ora-Adatok[i-1].Ora;
		if(temp > leghosszabbido) then BEGIN
			leghosszabbido := temp;
			leghosszabb := i;
		END;
	END;
	
	WriteLn(Adatok[leghosszabb-1].Ora, ':', Adatok[leghosszabb-1].Perc, ':',Adatok[leghosszabb-1].Masodperc, ' - ', Adatok[leghosszabb].Ora, ':', Adatok[leghosszabb].Perc, ':',Adatok[leghosszabb].Masodperc);
END;

Procedure Feladat6();
var bekert:string[7];
	i:integer;
	k:integer;
BEGIN
	WriteLn('6. feladat:');
	Write('Írd be a rendszám részeit: ');
	ReadLn(bekert);
	
	for i := 1 to ossz do BEGIN
		for k := 2 to length(Adatok[i].Rendszam) do BEGIN
			if((bekert[k] = Adatok[i].Rendszam[k]) OR (bekert[k] = '*')) then BEGIN
				WriteLn(Adatok[i].Rendszam);
			END;
		END;
	END;
END;

Procedure Feladat7();
var i:integer;
	
BEGIN
	Assign(fajl, 'vizsgalt.txt');
	ReWrite(fajl);
	
	
	
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
	Feladat5();
	WriteLn;
	Feladat6();
	Feladat7();
	
	WriteLn;
	WriteLn;
END.;
