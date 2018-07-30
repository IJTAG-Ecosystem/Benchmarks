/*
* Copyright Testonica Lab (C) 2016
*
* History:
* -------------+------------+-------------------------+------------------------
*   Version    |  Date      | Author                  | Organization
* -------------+------------+-------------------------+------------------------
*          1.0 | 29.03.2016 | Anton Tsertov           | Testonica Lab
*--------------+------------+-------------------------+------------------------
*          2.0 | 02.05.2016 | Anton Tsertov           | Testonica Lab
*--------------+------------+-------------------------+------------------------
*          2.1 | 28.02.2017 | Anton Tsertov           | Testonica Lab
*--------------+------------+-------------------------+------------------------
*
* Uses modules from files: Instruments.icl
* 
*/

Module EmptyModule {
	Attribute lic = 'h e478fd8a;
	Parameter inputs = 1;
	Parameter outputs = 1;
	Parameter bidirs = 1;
	Parameter size = $inputs + $outputs + $bidirs * 3;
	ScanInPort SI;
	ScanOutPort SO {
		Source wrpCntrl.SO;
	}
	ShiftEnPort SE;
	CaptureEnPort CE;
	UpdateEnPort UE;
	SelectPort SEL;
	ResetPort RST;
	TCKPort TCK;

	ScanInterface scan_client { 
		Port SI; 
		Port SO; 
		Port SEL; 
	}
	
	Instance wrpIn Of WrappedScan {
		InputPort SI = SI;
		Parameter dataWidth = $inputs+$bidirs;
	}
	Instance wrpOut Of WrappedScan {
		InputPort SI = wrpIn.SO;
		Parameter dataWidth = $outputs+$bidirs;
	}
	Instance wrpCntrl Of WrappedScan {
		InputPort SI = wrpOut.SO; 
		Parameter dataWidth = $bidirs;
	}
}

Module EmptyModule_NoBidirs {
	Attribute lic = 'h ec3fc0d1;
	Parameter inputs = 1;
	Parameter outputs = 1;
	Parameter size = $inputs + $outputs;
	ScanInPort SI;
	ScanOutPort SO {
		Source wrpOut.SO;
	}
	ShiftEnPort SE;
	CaptureEnPort CE;
	UpdateEnPort UE;
	SelectPort SEL;
	ResetPort RST;
	TCKPort TCK;

	ScanInterface scan_client { 
		Port SI; 
		Port SO; 
		Port SEL; 
	}
	
	Instance wrpIn Of WrappedScan {
		InputPort SI = SI;
		Parameter dataWidth = $inputs;
	}
	Instance wrpOut Of WrappedScan {
		InputPort SI = wrpIn.SO;
		Parameter dataWidth = $outputs;
	}
}
