program palindrome;
uses crt;

Procedure Palindrome();
var szam:integer;
	ered:integer = 0;
	mar:integer;
	i:integer;
BEGIN
	Write('Adj meg egy számot: ');
	ReadLn(szam);
	
	i := szam;
	While NOT(i = 0) do BEGIN
		mar := i mod 10;
		ered := ered*10+mar;
		i := i div 10;
	END;
	
	if(ered = szam) then BEGIN
		WriteLn(szam, ' palindrom');
	END else BEGIN
		WriteLn(szam, ' nem palindrom');
	END;
END;

BEGIN
	ClrScr;
	
	Palindrome();
	
	WriteLn;
	WriteLn;
END.
