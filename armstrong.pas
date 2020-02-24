program armstrong;
uses crt;

Procedure Armstrong();
var number:integer;
	count:integer = 0;
	result:integer = 0;
	mul:integer = 1;
	cnt:integer;
	rem:integer;
	q:integer;
BEGIN
	Write('Adj meg egy számot: ');
	ReadLn(number);
	
	q := number;
	While NOT(q = 0) do BEGIN
		q := q div 10;
		count := count + 1;
	END;
	
	cnt := count;
	q := number;
	
	While NOT(q = 0) do BEGIN
		rem := q mod 10;
		While NOT(cnt = 0) do BEGIN
			mul := mul*rem;
			cnt := cnt - 1;
		END;
		
		result := result+mul;
		cnt :=count;
		q := q div 10;
		mul := 1;
	END;
	
	if(result = number) then BEGIN
		WriteLn(number, ' egy armstrong szám');
	END else BEGIN
		WriteLn(number, ' nem egy armstrong szám');
	END;
END;

BEGIN
	ClrScr;
	
	Armstrong();
	
	WriteLn;
	WriteLn;
END.
