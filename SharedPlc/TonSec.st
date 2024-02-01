FUNCTION_BLOCK TonSec
VAR_INPUT
	In		: BOOL;
	PTs		: DWORD; (* --- Time in seconds *)
END_VAR
VAR_OUTPUT
	ETs	:	DWORD;
	Q		: BOOL;
	PTDT	: DT;
	ETDT	: DT;	(* --- Time in seconds *)
END_VAR
VAR
	Str		: R_TRIG;
	StrTm 	: DT;
END_VAR
	
Str(S1 := In);
IF Str.Q0 THEN
	StrTm := DtTmActUtc; 
END_IF

PTDT := UDINT_TO_DT(DT_TO_UDINT(StrTm) + PTs);
IF In THEN
	IF ETDT < PTDT   THEN

		ETDT := DtTmActUtc;
		ETs := PTs - (DT_TO_UDINT(PTDT) - DT_TO_UDINT(ETDT));
	END_IF

	IF ETDT >= PTDT THEN
		Q := TRUE;
	END_IF
ELSE
	ETs		:=	0;
	ETDT	:=	BYTE_TO_DT(0);
	Q		:=	FALSE;
END_IF

END_FUNCTION_BLOCK