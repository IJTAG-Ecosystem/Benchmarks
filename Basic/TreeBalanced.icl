/*
* Copyright Testonica Lab (C) 2016
*
*
* History:
* -------------+------------+-------------------------+------------------------
*   Version    |  Date      | Author                  | Organization
* -------------+------------+-------------------------+------------------------
*          1.0 | 08.03.2016 | Anton Tsertov           | Testonica Lab
*--------------+------------+-------------------------+------------------------
*          2.0 | 02.05.2016 | Anton Tsertov           | Testonica Lab
*--------------+------------+-------------------------+------------------------
*          2.4 | 26.06.2018 | Jan Burchard		      | Mentor A Siemens Business
*              |            | Anton Tsertov		      | Testonica Lab
*--------------+------------+-------------------------+------------------------
*
* Uses modules from files: 
* - Instruments.icl
* - NetworkStructs.icl
* - EmptyModule.icl
* - H953.icl
*/


Module TreeBalanced {
	Attribute lic = 'h 8ea9f3ca;
	ScanInPort SI;
	CaptureEnPort CE;
	ShiftEnPort SE;
	UpdateEnPort UE;
	SelectPort SEL;
	ResetPort RST;
	TCKPort TCK;
	ScanOutPort SO {
		Source sib0.SO;
	}
	
	Parameter inputs_m1 = 112;
	Parameter inputs_m2 = 68;
	Parameter inputs_m3 = 9;
	Parameter inputs_m4 = 88;
	Parameter inputs_m5 = 19;
	Parameter inputs_m6 = 15;
	Parameter inputs_m8 = 35;
	
	DataInPort DIm1[$inputs_m1+$bidirs-1 : 0];
	DataInPort toDOm1[$outputs_m1+$bidirs-1 : 0];
	DataInPort DIm2[$inputs_m2+$bidirs-1 : 0];
	DataInPort toDOm2[$outputs_m2+$bidirs-1 : 0];
	DataInPort DIm3[$inputs_m3+$bidirs-1 : 0];
	DataInPort toDOm3[$outputs_m3+$bidirs-1 : 0];
	DataInPort DIm4[$inputs_m4+$bidirs-1 : 0];
	DataInPort toDOm4[$outputs_m4+$bidirs-1 : 0];
	DataInPort DIm5[$inputs_m5+$bidirs-1 : 0];
	DataInPort toDOm5[$outputs_m5+$bidirs-1 : 0];
	DataInPort DIm6[$inputs_m6+$bidirs-1 : 0];
	DataInPort toDOm6[$outputs_m6+$bidirs-1 : 0];
	DataInPort DIm8[$inputs_m8+$bidirs-1 : 0];
	DataInPort toDOm8[$outputs_m8+$bidirs-1 : 0];
	
	// Level 1
	Instance sib0 Of SIB_mux_pre {
		InputPort SI = SI;
		InputPort fromSO = sib2.SO;
	}
	
	// Level 2
	Instance sib1 Of SIB_mux_pre {
		InputPort SI = sib0.toSI;
		InputPort fromSO = sib3.SO;
	}
	Instance sib2 Of SIB_mux_pre {
		InputPort SI = sib1.SO;
		InputPort fromSO = m8.SO;
	}
	// Level 3
	Instance m6 Of H953_Basic::M6 {
		InputPort SI = sib1.toSI;
		InputPort DI = DIm6;	
		InputPort toDO = toDOm6;
	}
	Instance sib3 Of SIB_mux_pre {
		InputPort SI = m6.SO;
		InputPort fromSO = m2.SO;
	}
	Instance m1 Of H953_Basic::M1 {
		InputPort SI = sib2.toSI;
		InputPort DI = DIm1;	
		InputPort toDO = toDOm1;
	}
	Instance m4 Of H953_Basic::M4 {
		InputPort SI = m1.SO;
		InputPort DI = DIm4;	
		InputPort toDO = toDOm4;
	}
	Instance m8 Of H953_Basic::M8 {
		InputPort SI = m4.SO;
		InputPort DI = DIm8;	
		InputPort toDO = toDOm8;
	}
	// Level 4
	Instance sib4 Of SIB_mux_pre {
		InputPort SI = sib3.toSI;
		InputPort fromSO = m5.SO;
	}
	Instance m2 Of H953_Basic::M2 {
		InputPort SI = sib4.SO;
		InputPort DI = DIm2;	
		InputPort toDO = toDOm2;
	}
	// Level 5 
	Instance sib5 Of SIB_mux_pre {
		InputPort SI = sib4.toSI;
		InputPort fromSO = sibM7.SO;
	}
	Instance m5 Of H953_Basic::M5 {
		InputPort SI = sib5.SO;
		InputPort DI = DIm5;	
		InputPort toDO = toDOm5;
	}
	// Level 6 and lower
	Instance m3 Of H953_Basic::M3 {
		InputPort SI = sib5.toSI;
		InputPort DI = DIm3;	
		InputPort toDO = toDOm3;
	}
	Instance sibM7 Of SIB_mux_pre {
		InputPort SI = m3.SO;
		InputPort fromSO = m7.SO;
	}
	Instance m7 Of EmptyModule_NoBidirs  {
		InputPort SI = sibM7.toSI; 
		Parameter inputs = 80;
		Parameter outputs = 32;
	}
	
}
