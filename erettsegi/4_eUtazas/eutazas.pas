//Emelt érettségi 2019 október, http://dload.oktatas.educatio.hu/erettsegi/feladatok_2019osz_emelt/e_inf_19okt_fl.pdf
{$mode objfpc} //Objektumorientált mód
{$M+} //Konstruktor engedélyezése
program eutazas;
uses crt,
	dateutils,
	sysutils,
	strutils,
	classes;
	
const m_iMaxMegallo = 30;
const adatok = 'utasadat.txt';
const figyelmeztetesek = 'figyelmeztetes.txt';
const formatum = 'yyyyMMdd';

var fajl:text;
	figyfajl:text;
	osszesen:integer;
	i:integer;
	utasitottak:integer = 0;
	ingyenesek:integer = 0;
	kedvezmenyesek:integer = 0;
	megallo:array [0..m_iMaxMegallo] of integer;
	
type Buszutas = class
	private
		var m_iMegallo:integer;
			m_sFelDatum:string;
			m_sAzonosito:string;
			m_sJegyTipus:string;
			m_sErvenyesseg:string;
		
	public
		{constructor Ujutas(megallo:integer;feldatum:string;azonosito:string;tipus:string;erv:string); - régi constructor}
		constructor Ujutas();
		
		Function Ervenyesseg():boolean;
		Function Kedvezmenyes():boolean;
		Function Ingyenes():boolean;
END;

constructor Buszutas.Ujutas();
BEGIN
	m_iMegallo := 0;
	m_sFeldatum := '\0';
	m_sAzonosito := '\0';
	m_sJegyTipus := '\0';
	m_sErvenyesseg := '\0';
END;

{constructor Buszutas.Ujutas(megallo:integer;feldatum:string;azonosito:string;tipus:string;erv:string); - régi constructor
BEGIN
	m_iMegallo := megallo;
	m_sFeldatum := feldatum;
	m_sAzonosito := azonosito;
	m_sJegyTipus := tipus;
	m_sErvenyesseg := erv;
END;}
	
Function Buszutas.Ervenyesseg():boolean;
BEGIN
	if(length(m_sErvenyesseg) <= 2) then BEGIN
		if(m_sErvenyesseg = '0') then BEGIN
			exit(false);
		END else BEGIN
			exit(true);
		END;
	END else BEGIN

		if(CompareDate(ScanDateTime(formatum, m_sFelDatum), ScanDateTime(formatum, m_sErvenyesseg)) > 0) then BEGIN
			exit(false);
		END;
	END;
	
	exit(true);
END;

Function Buszutas.Ingyenes():boolean;
BEGIN
	if((CompareStr(m_sJegyTipus, 'NYP') = 0) OR (CompareStr(m_sJegyTipus, 'GYK') = 0) OR (CompareStr(m_sJegyTipus, 'RVS') = 0)) then BEGIN
		exit(true);
	END else BEGIN
		exit(false);
	END;
END;

Function Buszutas.Kedvezmenyes():boolean;
BEGIN
	if((CompareStr(m_sJegyTipus, 'TAB') = 0) OR (CompareStr(m_sJegyTipus, 'NYB') = 0)) then BEGIN
		exit(true);
	END else BEGIN
		exit(false);
	END;
END;

Function napokszama(e1:integer;h1:integer;n1:integer;e2:integer;h2:integer;n2:integer):integer; {Bennevoltak a számítások a feladatba csak belekellett irni pascal verzióba}
var d1:integer;
	d2:integer;
BEGIN
	h1 := (h1+9) mod 12;
	e1 := e1-h1 div 10;
	d1 := 365*e1+(e1 div 4)-(e1 div 100)+(e1 div 400)+((h1*306+5) div 10)+n1-1;
	h2 := (h2+9) mod 12;
	e2 := e2-h2 div 10;
	d2 := 365*e2+(e2 div 4)-(e2 div 100)+(e2 div 400)+(h2*306+5) div 10+n2-1;
	napokszama := d2-d1;
END;

Function LejartBerlet(menetdatum:string;ervenyes:string):boolean;
var e1:integer;
	e2:integer;
	h1:integer;
	h2:integer;
	n1:integer;
	n2:integer;
BEGIN
	if(length(ervenyes) > 2) then BEGIN
		e1 := StrToIntDef(Copy(menetdatum, 1, 4), 0);
		e2 := StrToIntDef(Copy(ervenyes, 1, 4), 0);
		h1 := StrToIntDef(Copy(menetdatum, 4, 2), 0);
		h2 := StrToIntDef(Copy(ervenyes, 4, 2), 0);
		n1 := StrToIntDef(Copy(menetdatum, 6, 2), 0);
		n2 := StrToIntDef(Copy(ervenyes, 6, 2), 0);
		
		if((napokszama(e1, h1, n1, e2, h2, n2) >= 0) AND (napokszama(e1, h1, n1, e2, h2, n2) <= 3)) then BEGIN
			exit(true);
		END;
	END;
	
	exit(false);
END;

Procedure Figyelmeztetes(azonosito:string;berlet:string);
var figyfajl:text;
BEGIN
	AssignFile(figyfajl, figyelmeztetesek);
	Append(figyfajl);
	
	Insert('-', berlet, 5);
	Insert('-', berlet, 8);
	
	WriteLn(figyfajl, azonosito, ' ', berlet);
	Close(figyfajl);
END;

procedure Beolvasas();
var utas:Buszutas;
	sor:string;
	soradatok:array[1..5] of string;
	jmegallo:integer;
BEGIN
	AssignFile(fajl, adatok);
	Reset(fajl);
	while not EOF(fajl) do BEGIN {EOF = End Of File}
		ReadLn(fajl, sor);
		for i := 1 to 5 do BEGIN
			soradatok[i] := ExtractWord(i, sor, [' ']);
		END;

		{utas := Buszutas.Ujutas(StrToIntDef(soradatok[0], 0), soradatok[1], soradatok[2], soradatok[3], soradatok[4]); - régi constructor}
		utas := Buszutas.Ujutas();
		utas.m_iMegallo := StrToIntDef(soradatok[1], 0);
		utas.m_sFelDatum := ExtractWord(1, ExtractWord(2, sor, [' ']), ['-']);
		utas.m_sAzonosito := soradatok[3];
		utas.m_sJegyTipus := soradatok[4];
		utas.m_sErvenyesseg := soradatok[5];
		
		jmegallo := utas.m_iMegallo;
		
		if not(utas.Ervenyesseg()) then BEGIN
			utasitottak := utasitottak + 1;
		END;
		
		if(utas.Ervenyesseg() AND utas.Ingyenes() AND NOT utas.Kedvezmenyes()) then BEGIN
			ingyenesek := ingyenesek + 1;
		END;
		
		if(utas.Ervenyesseg() AND NOT utas.Ingyenes() AND utas.Kedvezmenyes()) then BEGIN
			kedvezmenyesek := kedvezmenyesek + 1;
		END;
		{WriteLn(StrToIntDef(soradatok[0], 0), ' ', ExtractWord(1, ExtractWord(2, sor, [' ']), ['-']), ' ', soradatok[2], ' ', soradatok[3], ' ', soradatok[4], ' ', soradatok[5]); - csak debug}
		
		if(LejartBerlet(utas.m_sFelDatum, utas.m_sErvenyesseg)) then BEGIN
			Figyelmeztetes(utas.m_sAzonosito, utas.m_sErvenyesseg);
		END;
		
		osszesen := osszesen + 1;
		megallo[jmegallo] := megallo[jmegallo] + 1;
	END;
	
	Close(fajl);
END;

Function Hanyutas():integer;
BEGIN
	Hanyutas := osszesen;
END;

Function Elutasitottak():integer;
BEGIN
	Elutasitottak := utasitottak;
END;

Function LegtobbMegallo():integer;
var megalloindex:integer = 0;
BEGIN
	for i := 0 to m_iMaxMegallo do BEGIN
		if(megallo[i] > megallo[megalloindex]) then BEGIN
			megalloindex := i;
		END;
	END;
	
	LegtobbMegallo := megalloindex;
END;

BEGIN
	AssignFile(figyfajl, figyelmeztetesek); //Csak hogy ne írja bele újra és újra ugyanazt
	ReWrite(figyfajl);
	Close(figyfajl);
	
	ClrScr;
	Beolvasas();
	
	WriteLn('A buszra ', Hanyutas(),' utas akart felszállni.');
	WriteLn('A buszra ', Elutasitottak(),' utas nem szállhatott fel.');
	WriteLn('A legtöbb utas (', megallo[LegtobbMegallo()], ' fő) a ', LegtobbMegallo(), '. megállóban próbált felszállni.');
	WriteLn('Ingyenesen utazók száma: ', ingyenesek, ' fő', #13#10, 'A kedvezményesen utazók száma: ', kedvezmenyesek, ' fő'); {#13#10 = új sorba irja}
	
	WriteLn;
	WriteLn;
END.
