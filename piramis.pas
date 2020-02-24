program piramis;
uses crt;

Procedure Kiir(n:integer);
var i:integer;
	k:integer;
BEGIN
	for i := 1 to n do BEGIN
		for k := 1 to 2*n - 1 do BEGIN
			if((k >= n-(i-1)) AND (k <= n+(i-1))) then BEGIN
				Write('*');
			END else BEGIN
				Write(' ');
			END;
		END;
	END;
END;

Procedure Piramis();
var	szam:integer;
BEGIN
	Write('Hány sorból álljon a piramis?: ');
	ReadLn(szam);
	
	Kiir(szam);
END;

BEGIN
	ClrScr;
	
	Piramis();
	
	WriteLn;
	WriteLn;
END.
