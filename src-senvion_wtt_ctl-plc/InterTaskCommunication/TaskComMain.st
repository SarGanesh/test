PROGRAM TaskComMain
VAR
	IntMainToCtl			: MainToCtl;
	IntCtlToMain			: CtlToMain;
	ChkCnt					: DINT;
	MainToCtrlChkCntErr		: DINT;
	
	Parameter1 	: REAL;
	Parameter2 	: REAL;
	Parameter3 	: REAL;
	Parameter4 	: REAL;
	Parameter5 	: REAL;
	Parameter6 	: REAL;
	Wert1	   	: BOOL;
	Wert2		: INT;
	Wert3		: REAL;
	Wert4		: BOOL;
	Wert5		: REAL;
	
END_VAR

(* -------------------------------------------------------------------*)
(* -- Data from WTT_CTL to WTT_MAIN                                --*)
(* -------------------------------------------------------------------*)
ChkCnt := ChkCnt + 1;

IntCtlToMain.ChkCntStart := ChkCnt;
IntCtlToMain.Wert1 := TRUE;
IntCtlToMain.Wert2 := 22;
IntCtlToMain.Wert3 := 23;
IntCtlToMain.Wert4 := TRUE;
IntCtlToMain.Wert5 := 25;
IntCtlToMain.ChkCntEnd := ChkCnt;

Mem_AtomicCopy(Dst := ADR(CtlToMain), Src := ADR(IntCtlToMain), Len := SIZEOF(CtlToMain));

(* -------------------------------------------------------------------*)
(* -- Data from WTT_MAIN to WTT_CTL                                 --*)
(* -------------------------------------------------------------------*)

Mem_AtomicCopy(Dst := ADR(IntMainToCtl), Src := ADR(MainToCtl), Len := SIZEOF(MainToCtl));

IF(IntMainToCtl.ChkCntStart = IntMainToCtl.ChkCntEnd)THEN

	Parameter1 := IntMainToCtl.Parameter1;		
	Parameter2 := IntMainToCtl.Parameter2;		
	Parameter3 := IntMainToCtl.Parameter3;		
	Parameter4 := IntMainToCtl.Parameter4;		
	Parameter5 := IntMainToCtl.Parameter5;		
	Parameter6 := IntMainToCtl.Parameter6;		
	Wert1 := IntMainToCtl.Wert1;	   	
	Wert2 := IntMainToCtl.Wert2;			
	Wert3 := IntMainToCtl.Wert3;			
	Wert4 := IntMainToCtl.Wert4;			
	Wert5 := IntMainToCtl.Wert5;

ELSE
	MainToCtrlChkCntErr := MainToCtrlChkCntErr + 1;
END_IF



END_PROGRAM