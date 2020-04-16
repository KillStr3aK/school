//Emelt érettségi 2006 október, https://www.informatikatanarok.hu/media/uploads/Informatika_erettsegi/Emelt/e_info_06okt_fl.pdf
program zene;
uses crt;
Type Adatok = record
	Radio:integer;
	Perc:integer;
	Masodperc:integer;
	Cim:string[50];
END;

const max = 1000;
var fajl:text;
	ossz:integer = 0;
	Musor:array[1..max] of Adatok;
	
//Olvassa be a musor.txt állományban talált adatokat, s annak felhasználásával oldja meg a következő feladatokat! 
Procedure Feladat1();
var i:integer;
BEGIN
	Assign(fajl, 'musor.txt');
	Reset(fajl);
	
	ReadLn(fajl, ossz);
	for i := 1 to ossz do BEGIN
		ReadLn(fajl, Musor[i].Radio, Musor[i].Perc, Musor[i].Masodperc, Musor[i].Cim);
	END;
	
	Close(fajl);
END;

//Írja a képernyőre, hogy melyik csatornán hány számot lehetett meghallgatni! 
Procedure Feladat2();
var i:integer;
	darab:array[1..3] of integer;
BEGIN
	WriteLn('2. feladat:');
	
	for i := 1 to 3 do BEGIN
		darab[i] := 0;
	END;
	
	for i := 1 to ossz do BEGIN
		darab[Musor[i].Radio] := darab[Musor[i].Radio] + 1;
	END;
	
	for i := 1 to 3 do BEGIN
		WriteLn('Az ', i, '. adón ', darab[i], ' zenét lehetett hallani.');
	END;
END;

//Adja meg, mennyi idő telt el az első Eric Clapton szám kezdete és az utolsó Eric Clapton szám vége között az 1. adón! Az eredményt óra:perc:másodperc formában írja a képernyőre! 
Procedure Feladat3();
var i:integer;
	masodperc:int64 = 0;
	elso:integer = 0;
	utolso:integer = 0;
	orak:integer = 0;
	percek:integer = 0;
BEGIN
	WriteLn('3. feladat:');
	
	for i := 1 to ossz do BEGIN
		if(Musor[i].Radio = 1) then BEGIN
			if not(Pos('Eric Clapton', Musor[i].Cim) = 0) then BEGIN
				if(elso = 0) then BEGIN
					elso := i;
				END;
				
				utolso := i;
			END;
		END;
	END;
	
	for i := elso to utolso do BEGIN
		if(Musor[i].Radio = 1) then BEGIN
			masodperc := masodperc + Musor[i].Masodperc + (Musor[i].Perc*60); //Összeadom a másodperceket és a perceket is átváltom másodpercbe
		END;
	END;
	
	orak := masodperc div 3600;
	masodperc := masodperc mod 3600;
	percek := masodperc div 60;
	masodperc := masodperc mod 60;
	WriteLn(orak, ':', percek, ':', masodperc, ' telt el az első és utolsó Eric Clapton szám között');
END;

//Amikor az „Omega:Legenda” című száma elkezdődött, Eszter rögtön csatornát váltott.
//Írja a képernyőre, hogy a szám melyik adón volt hallható, és azt, hogy a másik két adón milyen számok szóltak ekkor.
//Mivel a számok a kezdés időpontja szerint növekvő sorrendben vannak, így a másik két adón már elkezdődött a számok lejátszása. Feltételezheti, hogy a másik két adón volt még adás. 
Procedure Feladat4();
var i:integer;
	melyik:integer;
	miszolt:array[1..3] of integer;
BEGIN
	WriteLn('4. feladat:');
	
	for i := 1 to ossz do BEGIN
		if(Musor[i].Cim = ' Omega:Legenda') then BEGIN
			melyik := i; //Eltárolom azt a sorszámot ahol az Omega:Legenda számot játszották
			miszolt[Musor[i].Radio] := i;
		END;
	END;
	
	{i := 0; //Ugyan az csak először while ciklussal csináltam
	while(i < melyik) do BEGIN
		i := i + 1;
		
		if(Musor[i].Radio <> Musor[melyik].Radio) then BEGIN
			miszolt[Musor[i].Radio] := i;
		END;
	END;}
	
	for i := 1 to melyik-1 do BEGIN //Azért melyik-1 mert arról a 'melyik' sorról már tudjuk, hogy mit játszik
		if(Musor[i].Radio <> Musor[melyik].Radio) then BEGIN
			miszolt[Musor[i].Radio] := i;
		END;
	END;
	
	for i := 1 to 3 do BEGIN
		WriteLn('Az ', i, '. adón a ', Musor[miszolt[i]].Cim, ' szólt.');
	END;
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
	WriteLn;
END.
