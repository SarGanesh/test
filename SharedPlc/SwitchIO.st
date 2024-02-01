FUNCTION SwitchIO : BOOL
VAR_INPUT
                Val:        BOOL;
                Switch: DINT;
END_VAR

VAR

END_VAR

CASE Switch OF
                -1: SwitchIO := Val XOR TRUE;
                0:  SwitchIO := FALSE;
                1:  SwitchIO := TRUE;
                2:  SwitchIO := Val;
END_CASE
                
END_FUNCTION
