FUNCTION_BLOCK UpDnCnt

VAR_INPUT
	IN		: BOOL;
	Cyc		: UDINT;
	RsCond	: INT;
END_VAR
VAR_OUTPUT
	OUT		: BOOL;
	CntEnd	: BOOL;
END_VAR
VAR
	Cnt: UDINT;
END_VAR

(* --- Reset Condition 0: Out will be FALSE, if IN FALSE *)
(* --- Reset Condition 1: Out will be FALSE, if IN FALSE and the time was counted down *)

IF (IN) THEN
	IF (Cnt >= Cyc) THEN
		Cnt := Cyc;
		OUT := TRUE;
	ELSE
		Cnt := Cnt + 1;
	END_IF
ELSE
	IF (Cnt <= 0) THEN
		Cnt := 0;
		OUT := FALSE; 
	ELSE
		Cnt := Cnt - 1;
	END_IF
	
	IF(RsCond = 0)THEN
		OUT := FALSE; 
	END_IF
END_IF

CntEnd := Cnt >= Cyc;


END_FUNCTION_BLOCK