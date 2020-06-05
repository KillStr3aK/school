program metjelentes;
uses crt, sysutils, strutils;

const max = 500;
Type Adatok = record
	Telepules:string[2];
	Ido:string;
	Szelirany:string;
	Homerseklet:integer;
END;

var fajl:text;
	Lista:array[1..max] of Adatok;
	ossz:integer = 0;
	Telepulesek:array[1..9] of string[2];

Procedure Feladat1();
var sor:string;
	darab:array[1..4] of string;
	i:integer;
BEGIN
	Assign(fajl, 'tavirathu13.txt');
	Reset(fajl);
	
	While NOT EOF(fajl) do BEGIN
		ReadLn(fajl, sor);
		for i := 1 to 4 do BEGIN
			darab[i] := ExtractWord(i, sor, [' ']);
		END;
		
		ossz := ossz + 1;
		Lista[ossz].Telepules := darab[1];
		Lista[ossz].Ido := darab[2];
		Lista[ossz].Szelirany := darab[3];
		Lista[ossz].Homerseklet := StrToInt(darab[4]);
	END;
	
	Close(fajl);
	
	Telepulesek[1] := 'BP';
	Telepulesek[2] := 'DC';
	Telepulesek[3] := 'SM';
	Telepulesek[4] := 'PA';
	Telepulesek[5] := 'SN';
	Telepulesek[6] := 'PR';
	Telepulesek[7] := 'BC';
	Telepulesek[8] := 'PP';
	Telepulesek[9] := 'KE';
END;

Procedure Feladat2();
var kod:string[2];
	i:integer;
	ido:string;
BEGIN
	WriteLn('2. feladat:');
	Write('Adja meg egy település kódját! Település: ');
	ReadLn(kod);
	
	for i := ossz DownTo 1 do BEGIN
		if(Lista[i].Telepules = kod) then BEGIN
			ido := Lista[i].Ido;
			Insert(':', ido, 3);
			WriteLn('Az utolsó mérési adat a megadott településről ', ido,'-kor érkezett.');
			break;
		END;
	END;
END;

Procedure Feladat3();
var i:integer;
	legalacsonyabb:integer = 1;
	legmagasabb:integer = 1;
	ido:string;
BEGIN
	WriteLn('3. feladat:');
	for i := 1 to ossz do BEGIN
		if(Lista[i].Homerseklet > Lista[legmagasabb].Homerseklet) then BEGIN
			legmagasabb := i;
		END;
		
		if(Lista[i].Homerseklet < Lista[legalacsonyabb].Homerseklet) then BEGIN
			legalacsonyabb := i;
		END;
	END;
	
	ido := Lista[legalacsonyabb].Ido;
	Insert(':', ido, 3);
	WriteLn('A legalacsonyabb hőmérséklet: ', Lista[legalacsonyabb].Telepules,' ', ido,' ', Lista[legalacsonyabb].Homerseklet,' fok.');
	ido := Lista[legmagasabb].Ido;
	Insert(':', ido, 3);
	WriteLn('A legmagasabb hőmérséklet: ', Lista[legmagasabb].Telepules,' ', ido,' ', Lista[legmagasabb].Homerseklet,' fok.');
END;

Procedure Feladat4();
var i:integer;
	db:integer = 0;
	ido:string;
BEGIN
	WriteLn('4. feladat:');
	
	for i := 1 to ossz do BEGIN
		if(Lista[i].Szelirany = '00000') then BEGIN
			db := db + 1;
			ido := Lista[i].Ido;
			Insert(':', ido, 3);
			WriteLn(Lista[i].Telepules, ' ', ido);
		END;
	END;
	
	if(db = 0) then BEGIN
		WriteLn('Nem volt szélcsend a mérések idején.');
	END;
END;

Procedure Feladat5();
var i:integer;
	k:integer;
	legalacsonyabb:integer = 100;
	legmagasabb:integer = 0;
	kozeparr:array[1..4] of integer;
	kozep:integer;
	ingadozas:integer;
	NA:boolean;
BEGIN
	WriteLn('5. feladat:');
	
	for i := 1 to 9 do BEGIN
		for k := 1 to 4 do BEGIN
			kozeparr[k] := 0;
		END;
		
		legalacsonyabb := 100;
		legmagasabb := 0;
		kozep := 0;
		ingadozas := 0;
		NA := false;
		
		for k := 1 to ossz do BEGIN
			if(Lista[k].Telepules = Telepulesek[i]) then BEGIN
				Case StrToInt(Lista[k].Ido[1..2]) Of
					1: kozeparr[1] := Lista[k].Homerseklet;
					7: kozeparr[2] := Lista[k].Homerseklet;
					13: kozeparr[3] := Lista[k].Homerseklet;
					19: kozeparr[4] := Lista[k].Homerseklet;
				END;
				
				if(Lista[k].Homerseklet > legmagasabb) then BEGIN
					legmagasabb := Lista[k].Homerseklet;
				END;
				
				if(Lista[k].Homerseklet < legalacsonyabb) then BEGIN
					legalacsonyabb := Lista[k].Homerseklet;
				END;
			END;
		END;
		
		for k := 1 to 4 do BEGIN
			if (kozeparr[k] = 0) then BEGIN
				NA := true;
				break;
			END else BEGIN
				kozep := kozep + kozeparr[k];
			END;
		END;
		
		ingadozas := legmagasabb - legalacsonyabb;
		if(NA) then BEGIN
			WriteLn(Telepulesek[i], ' NA; Hőmérséklet-ingadozás: ', ingadozas);
		END else BEGIN
			WriteLn(Telepulesek[i], ' Középhőmérséklet: ', kozep div 4,'; Hőmérséklet-ingadozás: ', ingadozas);
		END;
	END;
END;

Procedure Feladat6();
var i:integer;
	j:integer;
	g:integer;
	nev:string;
	ido:string;
BEGIN
	WriteLn('6. feladat:');
	for i := 1 to 9 do BEGIN
		nev := Telepulesek[i];
		Insert('.txt', nev, 3);
		Assign(fajl, nev);
		ReWrite(fajl);
		
		WriteLn(fajl, Telepulesek[i]);
		for j := 1 to ossz do BEGIN
			if(Lista[j].Telepules = Telepulesek[i]) then BEGIN
				ido := Lista[j].Ido;
				Insert(':', ido, 3);
				Write(fajl, ido, ' ');
				
				for g := StrToInt(Copy(Lista[j].Szelirany, 4, 5)) DownTo 1 do BEGIN
					Write(fajl, '#');
				END;
				
				WriteLn(fajl);
			END;
		END;
		
		Close(fajl);
	END;
	
	WriteLn('A fájlok elkészültek.');
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
	
	WriteLn;
	WriteLn;
END.
