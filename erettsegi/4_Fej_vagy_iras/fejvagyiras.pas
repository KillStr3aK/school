//Emelt érettségi 2015 október http://dload.oktatas.educatio.hu/erettsegi/feladatok_2015osz_emelt/e_inf_15okt_fl.pdf
program fejvagyiras;
uses crt, math;

const kiserlet = 'kiserlet.txt';
	  maxdobasok = 1000;

var i:integer;
	fajl:text;

Procedure Feladat1();
BEGIN
	WriteLn('1. feladat');
	Write('A pénzfeldobás eredménye: ');
	
	Randomize;
	if(RandomRange(0, 2)= 0) then BEGIN
		Write('I');
	END else BEGIN
		Write('F');
	END;
END;

Procedure Feladat2();
var tipp:string[1];
	szam:integer;
BEGIN
	WriteLn('2. feladat');
	Write('Tippeljen! (F/I)= ');
	ReadLn(tipp);
	
	if(tipp = 'I') then BEGIN
		szam := 0;
	END else BEGIN
		szam := 1
	END;
	
	Randomize;
	if(RandomRange(0, 2)= szam) then BEGIN
		Write('Ön eltalálta!');
	END else BEGIN
		Write('Ön nem találta el.');
	END;
END;

Procedure Feladat3();
var kiserletek:integer = 0;
	sor:string[1];
BEGIN
	WriteLn('3. feladat');
	
	Assign(fajl, kiserlet);
	Reset(fajl);
	
	While NOT EOF(fajl) do BEGIN
		ReadLn(fajl, sor);
		
		if not(sor[0] = '') then BEGIN
			kiserletek := kiserletek + 1;
		END;
	END;
	
	Close(fajl);
	
	WriteLn('A kisérlet ', kiserletek, ' dobásból állt.');
END;

Procedure Feladat4();
var kiserletek:integer = 0;
	fej:integer = 0;
	szazalek:double = 0.0;
	sor:string[1];
BEGIN
	WriteLn('4. feladat');
	
	Assign(fajl, kiserlet);
	Reset(fajl);
	
	While NOT EOF(fajl) do BEGIN
		ReadLn(fajl, sor);
		
		if not(sor[0] = '') then BEGIN
			if(sor = 'F') then BEGIN
				fej := fej + 1;
			END;
			
			kiserletek := kiserletek + 1;
		END;
	END;
	
	Close(fajl);
	
	szazalek := (fej / kiserletek)*100;
	WriteLn('A kisérlet során a fej relatív gyakorisága ', szazalek:0:2, '% volt.');
END;

Procedure Feladat5();
var alkalom:integer = 0;
	sor:string[1];
	sorozat:string[3] = '';
BEGIN
	WriteLn('5. feladat');
	
	Assign(fajl, kiserlet);
	Reset(fajl);
	
	While NOT EOF(fajl) do BEGIN
		ReadLn(fajl, sor);
		
		if not(sor = '') then BEGIN
			if((sorozat = 'FFI') OR (sorozat = 'IFF')) then BEGIN
				alkalom := alkalom + 1;
			END;
		END;
		
		sorozat[2] := sorozat[1];
		sorozat[1] := sorozat[0];
		sorozat[0] := sor[0];
	END;
	
	Close(fajl);
	
	WriteLn('A kisérlet során ', alkalom, ' alkalommal dobtak pontosan 2 fejet egymás után.');
END;

Procedure Feladat6();
var sor:string;
BEGIN
	WriteLn('6. feladat');
	
	Assign(fajl, kiserlet);
	Reset(fajl);
	
	While NOT EOF(fajl) do BEGIN
		ReadLn(fajl, sor);
		
	END;
	
	Close(fajl);
	
	WriteLn('A leghosszabb tisztafej sorozat ', tag, ' tagból áll, kezdete a(z) ', dobas, '. dobás.');
END;

Procedure Feladat7();
var dobasok:array[0..maxdobasok] of string;
	dobasokfajl:text;
	tisztafej:integer = 0;
	iras:integer = 0;
BEGIN
	for i := 0 to maxdobasok do BEGIN
		Randomize;
		if(RandomRange(0, 2)= 0) then BEGIN
			dobasok[i] := 'I';
		END else BEGIN
			dobasok[i] := 'F';
		END;
	END;
	
	Assign(dobasokfajl, 'dobasok.txt');
	ReWrite(dobasokfajl);
	
	WriteLn('FFFF: ', tisztafej, ' FFFI: ', iras);
	for i := 0 to maxdobasok do BEGIN
		Write(dobasokfajl, dobasok[i]);
	END;
	
	Close(dobasokfajl);
END;

BEGIN
	ClrScr;
	
	Feladat1();
	WriteLn;
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
END.
