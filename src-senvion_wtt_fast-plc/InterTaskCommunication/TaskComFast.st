PROGRAM TaskComFast
VAR
	IntMainToFast			: MainToFast;
	IntFastToMain			: FastToMain;
	ChkCnt					: DINT;
	MainToFastChkCntErr		: DINT;
	
	Parameter1	   	: REAL;
	Parameter2		: REAL;
	Parameter3		: REAL;
	Parameter4		: REAL;
	
END_VAR

(* -------------------------------------------------------------------*)
(* -- Data from WTT_FAST to WTT_MAIN                                 --*)
(* -------------------------------------------------------------------*)
ChkCnt := ChkCnt + 1;

IntMainToFast.ChkCntStart 	:= ChkCnt;
IntFastToMain.Speed			:= 1500;
IntFastToMain.Status		:= TRUE;
IntMainToFast.ChkCntEnd 	:= ChkCnt;

Mem_AtomicCopy(Dst := ADR(FastToMain), Src := ADR(IntFastToMain), Len := SIZEOF(FastToMain));

(* -------------------------------------------------------------------*)
(* -- Data from WTT_MAIN  to WTT_FAST                                 --*)
(* -------------------------------------------------------------------*)

Mem_AtomicCopy(Dst := ADR(IntMainToFast), Src := ADR(MainToFast), Len := SIZEOF(MainToFast));

IF(IntMainToFast.ChkCntStart = IntMainToFast.ChkCntEnd)THEN
	Parameter1 := IntMainToFast.Parameter1;		
	Parameter2 := IntMainToFast.Parameter2;		
	Parameter3 := IntMainToFast.Parameter3;		
	Parameter4 := IntMainToFast.Parameter4;		
ELSE
	MainToFastChkCntErr := MainToFastChkCntErr + 1;
END_IF

END_PROGRAM