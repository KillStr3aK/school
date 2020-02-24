program primek;
uses crt;

const fajlnev = 'primek.txt';
	max = 500;

var fajl:text; 
	i:integer;
	k:integer;

Procedure Primszamok();
var tomb:array[2..max] of boolean;
BEGIN
	for i := 2 to max do BEGIN
		tomb[i] := true;
	END;
	
	for i := 2 to max do BEGIN
		if not(tomb[i]) then BEGIN
			continue;
		END;
		
		for k := 2 to (max div i) do BEGIN
			tomb[i*k] := false;
		END;
	END;
	
	Assign(fajl, fajlnev);
	ReWrite(fajl);
	
	for i := 2 to max do BEGIN
		if(tomb[i]) then BEGIN
			WriteLn(fajl, i);
		END;
	END;
	
	Close(fajl);
END;

BEGIN
	ClrScr;
	
	Primszamok();
	
	WriteLn;
	WriteLn;
END.
