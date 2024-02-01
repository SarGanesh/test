PROGRAM PLC_PRG
VAR
	InitWttlRdy 		: BOOL;
	WttLibraryVersion	: STRING(31);
	Error               : DINT := 0;
END_VAR

(* -------------------------------------------------------------------------------------------- *)
(* --- Initialization of WTT_IO *)
(* -------------------------------------------------------------------------------------------- *)
IF NOT (InitWttlRdy) THEN

	Util_LogInfo(CONCAT('Init WTT Libs for ', 'WTT_FAST'));

	Error := WTTL_Init('WTT_IO');

	IF (NOT (Error = 0)) THEN
						
		Util_LogErr(CONCAT('WTT_FAST: Initialize wtt library with Error:', DINT_TO_STRING(Error)));
						
	END_IF

	WttLibraryVersion := WTTL_GetVersion(0);

	Util_LogInfo(CONCAT('WTT_FAST: using wtt library ', WttLibraryVersion));

	InitWttlRdy := TRUE;
END_IF

(* -------------------------------------------------------------------------------------------- *)
(* --- Get handles for WTT_IO *)
(* -------------------------------------------------------------------------------------------- *)
IF NOT(GetHandles.InitDone)THEN
	GetHandles();
ELSE
	RETURN;
END_IF

(* -------------------------------------------------------------------------------------------- *)
(* --- Function programming *)
(* -------------------------------------------------------------------------------------------- *)
TaskComFast();

END_PROGRAM