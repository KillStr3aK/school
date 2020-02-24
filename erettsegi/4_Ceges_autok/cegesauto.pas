//Emelt érettségi 2019 május, http://informatika.fazekas.hu/wp-content/uploads/2015/10/Céges-autók.pdf
program cegesauto;
uses crt, strutils, sysutils;

const m_iMaxSor = 500;
	autokfajl = 'autok.txt';
	
type Autok = record
	m_iNap:integer;
	m_iAzonosito:integer;
	m_iOraAllas:int64;
	m_sIdoPont:string;
	m_sRendszam:string;
	m_bParkol:boolean;
	
	m_iId:integer;
END;

var fajl:text;
	adat:array[1..m_iMaxSor] of Autok;
	osszesen:integer = 1;
	i:integer;
	k:integer;

Procedure Beolvasas();
var sor:string;
	sortores:array[1..6] of string;
BEGIN
	Assign(fajl, autokfajl);
	Reset(fajl);
	
	While NOT EOF(fajl) do BEGIN
		ReadLn(fajl, sor);
		for i := 1 to 6 do BEGIN
			sortores[i] := ExtractWord(i, sor, [' ']);
		END;
		
		adat[osszesen].m_iNap := StrToInt(sortores[1]);
		adat[osszesen].m_iAzonosito := StrToInt(sortores[4]);
		adat[osszesen].m_iOraAllas := StrToInt(sortores[5]);
		
		adat[osszesen].m_sIdoPont := sortores[2];
		adat[osszesen].m_sRendszam := sortores[3];
		adat[osszesen].m_bParkol := StrToBool(sortores[6]);
		adat[osszesen].m_iId := StrToInt(Copy(adat[osszesen].m_sRendszam, 6, 6));
		
		osszesen := osszesen + 1;
	END;
END;

Procedure Feladat2();
var nap:integer = 0;
	auto:integer = 0;
	ora:integer = 0;
BEGIN
	WriteLn('2. feladat');
	for i := 1 to osszesen do BEGIN
		if(adat[i].m_iNap > nap) then BEGIN
			nap := adat[i].m_iNap;
		END;
	END;

	for i := 1 to osszesen do BEGIN
		if not(adat[i].m_iNap = nap) then BEGIN
			continue;
		END;

		if((StrToInt(ExtractWord(1, adat[i].m_sIdoPont, [':'])) > ora) AND (adat[i].m_bParkol = false)) then BEGIN
			auto := i;
		END;
	END;
	
	WriteLn(nap, '. nap rendszám: ', adat[auto].m_sRendszam);
END;

Procedure Feladat3();
var nap:integer;
BEGIN
	WriteLn('3. feladat');
	Write('Nap: ');
	ReadLn(nap);
	WriteLn('Forgalom a(z) ', nap,'. napon: ');
	for	i := 1 to osszesen do BEGIN
		if not(adat[i].m_iNap = nap) then BEGIN
			continue;
		END;
		
		if(adat[i].m_bParkol = true) then BEGIN
			WriteLn(adat[i].m_sIdoPont, ' ', adat[i].m_sRendszam, ' ', adat[i].m_iAzonosito, ' ', 'be');
		END else BEGIN
			WriteLn(adat[i].m_sIdoPont, ' ', adat[i].m_sRendszam, ' ', adat[i].m_iAzonosito, ' ', 'ki');
		END;
	END;
END;

Procedure Feladat4();
var kint:array[0..9] of boolean;
	ossz:integer = 0;
BEGIN
	WriteLn('4. feladat');

	for k := 0 to 9 do BEGIN
		kint[k] := false;
	END;
	
	for k := 0 to 9 do BEGIN
		for i := 1 to osszesen do BEGIN
			if not(adat[i].m_iId = k) then BEGIN
				continue;
			END;
				
			kint[k] := adat[i].m_bParkol;
		END;
	END;
	
	for k := 0 to 9 do BEGIN
		if not(kint[k]) then BEGIN
			ossz := ossz + 1;
		END;
	END;
	
	WriteLn('A hónap végén ', ossz, ' autót nem hoztak vissza.');
END;

Procedure Feladat5();
var bentiora:array[0..9] of int64;
	kintiora:array[0..9] of int64;
BEGIN
	WriteLn('5. feladat');
	
	for k := 0 to 9 do BEGIN
		kintiora[k] := 0;
	END;
	
	for k := 0 to 9 do BEGIN
		for i := 1 to osszesen do BEGIN
			if not(adat[i].m_iId = k) then BEGIN
				continue;
			END;
			
			if not(adat[i].m_bParkol) AND (kintiora[k] = 0) then BEGIN
				kintiora[k] := adat[i].m_iOraAllas;
			END;
			
			if(adat[i].m_bParkol) then BEGIN
				bentiora[k] := adat[i].m_iOraAllas
			END;
		END;
	END;
	
	for k := 0 to 9 do BEGIN
		WriteLn('CEG30', k, ' ', (bentiora[k] - kintiora[k]), ' km');
	END;
END;

Procedure Feladat6();
var azonosito:integer = 0;
	megtettkm:array[0..9] of int64;
	legtobbkm:integer = 0;
	elozo:integer = 1;
BEGIN
	WriteLn('6. feladat');
	
	for k := 0 to 9 do BEGIN
		megtettkm[k] := 0;
	END;
	
	for k := 0 to 9 do BEGIN
		for i := 1 to osszesen do BEGIN
			if not(adat[i].m_iId = k) then BEGIN
				continue;
			END;
			
			if(adat[i].m_bParkol) then BEGIN
				if(megtettkm[k] < adat[i].m_iOraAllas) then BEGIN
					megtettkm[k] := adat[i].m_iOraAllas - adat[elozo].m_iOraAllas;
					azonosito := adat[i].m_iAzonosito;
					elozo := i;
				END;
			END;
		END;
	END;
	
	for k := 0 to 9 do BEGIN
		if(megtettkm[k] > legtobbkm) then BEGIN
			legtobbkm := megtettkm[k];
		END;
	END;
	
	WriteLn('Leghosszabb út: ', legtobbkm, ' km, személy:', azonosito);
END;

Procedure Feladat7();
var rendszam:string;
	menet:text;
BEGIN
	Write('Rendszám: ');
	ReadLn(rendszam);
	
	Insert('_menetlevel.txt', rendszam, (length(rendszam)+1));
	Assign(menet, rendszam);
	ReWrite(menet);
	
	for k := 0 to 9 do BEGIN
		for i := 1 to osszesen do BEGIN
			if not(adat[i].m_iId = k) then BEGIN
				continue;
			END;
			
			if(adat[i].m_bParkol = true) then BEGIN
				WriteLn(menet, adat[i].m_iAzonosito, #9, adat[i].m_iNap, '. ', adat[i].m_sIdoPont, #9, adat[i].m_iOraAllas, ' km ', #9, adat[i].m_iNap, '. ', adat[i].m_sIdoPont, #9, adat[i].m_iOraAllas, ' km ');
			END;
			
			if(adat[i].m_bParkol = false) then BEGIN
				//Write(menet, adat[i].m_iNap, '. ', adat[i].m_sIdoPont, #9, adat[i].m_iOraAllas, ' km ');
			END;
		END;
	END;
	
	WriteLn('Menetlevél kész.');
	Close(menet);
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
END.
