PROGRAM GetHandles
VAR CONSTANT
	NbrOfHandleBlocks 	: INT := 2;
END_VAR
VAR
	i 				: INT;
	ErrMsgDone		: BOOL;
END_VAR
VAR_OUTPUT
	InitDone		: BOOL;
END_VAR


i := i + 1;

IF(i > NbrOfHandleBlocks)THEN
	i :=1;
END_IF

(* -------------------------------------------------------------------------------------------- *)
(* --- Get handles from WTT_IO - program max. 10 handles in each block *)
(* -------------------------------------------------------------------------------------------- *)

CASE i OF
	1:
		Handles.Example1 := WTTL_GetPresHd(LogicalNodeName := 'WTUR', DataObjectName := 'Example1' , CalcPer := 0);

		
	2:
		Handles.Example2 := WTTL_GetPresHd(LogicalNodeName := 'WTUR', DataObjectName := 'Example2' , CalcPer := 0);
		

END_CASE


(* -------------------------------------------------------------------------------------------- *)
(* --- Check handles *)
(* -------------------------------------------------------------------------------------------- *)
IF	(Handles.Example1 <> 0) AND
	(Handles.Example2 <> 0) 
THEN
	InitDone := TRUE;
END_IF

IF NOT(InitDone) AND NOT(ErrMsgDone) AND (i = NbrOfHandleBlocks) THEN
	Util_LogErr('Error during initialization of the handles for WTT_FAST');
	ErrMsgDone := TRUE;
END_IF

END_PROGRAM