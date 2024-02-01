PROGRAM TimeHdl 
VAR
	timespec_microseconds_Ds	: timespec_microseconds;
	DtOld						: DT;
	DtTmActLoc					: DT;
	SysTmUsec					: UDINT;
	USecOld						: UDINT;
	USecAct						:UDINT;
END_VAR
VAR_OUTPUT
	DTMS : DTMS;
END_VAR

(* --- Get time from system *)
clock_gettime(ADR(timespec_microseconds_Ds),TIMESPEC_RESOLUTION_MICROSECONDS,CLOCK_ID_CLOCK_RTCNANO);

DtTmActLoc := timespec_microseconds_Ds.dateAndTime;

(* WppTimeShiftMinutes_GDi: Wird aus der Monitoring Vorgabe in TimeZone_GpSt geholt *)
DTMS.DateAndTime := DINT_TO_DT(DT_TO_DINT(DtTmActLoc) + DtTmShSec);

(* --- SysTmUsec are in s from CPU start *)
SysTmUsec			:= timespec_microseconds_Ds.microseconds;
USecAct  			:= ((USecAct + ABS(SysTmUsec - USecOld)) MOD 1000000);
DTMS.Millisecond 	:= UDINT_TO_UINT(USecAct / 1000);

IF (TIME_TO_BOOL (ABS(DTMS.DateAndTime - DtOld))) THEN
	USecAct := 0;
END_IF

USecOld := SysTmUsec;
DtOld := DTMS.DateAndTime;

DtTmAct 		:= DTMS.DateAndTime;				(* --- Actual local time without summer time shift *)		
DtTmActSec 		:= DT_TO_UDINT(DtTmAct);			(* --- Actual local time in second since 1.1.1970 *)
DtTmActUtc 		:= Tcs_RTC_GetDateAndTime(0);		(* --- Actual UTC Date and Time from the control system *)
DtTmActUtcSec 	:= DT_TO_UDINT(DtTmActUtc);			(* --- Actual UTC Date and Time from the control system in seconds since 1.1.1970 *)


(* TODO: check where we can get this information*)
(*ActDateAndTimeDST_GDt 	:=*) 						(* --- Actual local time with summer time shift *) 	


(* TODO: This information must be read out of the system/parameter - for start fix to GMT+00:00*)
DtTmShStri := 'GMT+00:00';	(* --- Time shift from UTC in the format 'GMT+00:00'*)
(*DtTmShM :=*) (*TODO: Calculate time shift from UTC in minutes *)
	
(*IecTmUtc := ;*)	(* TODO: Get IEC norm timestamp *)

END_PROGRAM