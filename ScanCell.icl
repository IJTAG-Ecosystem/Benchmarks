/*
*
* -------------+------------+-------------------------+------------------------
*   Version    |  Date      | Author                  | Organization
* -------------+------------+-------------------------+------------------------
*          1.0 | 18.04.2016 | Anton Tsertov           | Testonica Lab
*--------------+------------+-------------------------+------------------------
*          2.0 | 15.05.2016 | Anton Tsertov           | Testonica Lab
*--------------+------------+-------------------------+------------------------
*          2.1 | 19.02.2017 | Riccardo Cantoro        | Politecnico di Torino
*--------------+------------+-------------------------+------------------------
*          2.5 | 26.06.2018 | Jan Burchard		      | Mentor A Siemens Business
*              |            | Anton Tsertov		      | Testonica Lab
*--------------+------------+-------------------------+------------------------
*/

Module ScanCell {
	Attribute lic = 'h 619af116;
	ScanInPort SI;
	ShiftEnPort SE;
	CaptureEnPort CE;
	UpdateEnPort UE;
	SelectPort SEL;
	ResetPort RST;
	TCKPort TCK;
	ScanOutPort SO { 
		Source SMux;
	}
	ScanInterface flex_Scan { 
		Port SI; 
		Port SO; 
		Port SEL; 
	}
	
	ScanInPort maskSI;
	SelectPort maskSEL;
	ScanOutPort maskSO { 
		Source scbMask.SO;
	}
	ScanInterface mask_Scan { 
		Port maskSI; 
		Port maskSO; 
		Port maskSEL; 
	}
	
	LogicSignal ls_maskSEL {
		SEL & maskSEL;
	}
	LogicSignal ls_sRegSEL {
		SEL & scbMask.toSEL;
	}
	
	Instance scbMask Of SCB {
		InputPort SI = maskSI;
		InputPort SEL = ls_maskSEL;
	}
	
	Instance sBit Of SBit {
		InputPort SI = SI;
		InputPort SEL = ls_sRegSEL;
		Parameter Size = 1;
	}
		
	ScanMux SMux SelectedBy scbMask.DO[0] {
		0: SI;
		1: sBit.SO;
	}
	
}
