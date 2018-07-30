/*
* Copyright Testonica Lab (C) 2016
*
* History:
* -------------+------------+-------------------------+------------------------
*   Version    |  Date      | Author                  | Organization
* -------------+------------+-------------------------+------------------------
*          1.0 | 08.03.2016 | Anton Tsertov           | Testonica Lab
*--------------+------------+-------------------------+------------------------
*          2.0 | 02.05.2016 | Anton Tsertov           | Testonica Lab
*--------------+------------+-------------------------+------------------------
*          2.1 | 13.09.2016 | Riccardo Cantoro        | Politecnico di Torino
*--------------+------------+-------------------------+------------------------
*          2.5 | 26.06.2018 | Jan Burchard		      | Mentor A Siemens Business
*              |            | Anton Tsertov		      | Testonica Lab
*--------------+------------+-------------------------+------------------------
* Uses modules from files: 
* - A586710.icl
* - EmptyModule.icl
*/


Module TreeUnbalanced {
    Attribute lic = 'h cb06020e;
    
    Parameter inputs_m1 = 437;
	Parameter inputs_m5 = 343;
    
    ScanInPort SI;
    CaptureEnPort CE;
    ShiftEnPort SE;
    UpdateEnPort UE; 
    SelectPort SEL;
    ResetPort RST;
    TCKPort TCK;
    ScanOutPort SO {
        Source sib1.SO;
    }
    
    DataInPort DIm1[$inputs_m1+$bidirs-1 : 0];
	DataInPort toDOm1[$outputs_m1+$bidirs-1 : 0];
	DataInPort DIm5[$inputs_m5+$bidirs-1 : 0];
	DataInPort toDOm5[$outputs_m5+$bidirs-1 : 0];
    
	// Level 1
	Instance sib0 Of SIB_mux_pre {
		InputPort SI = SI;
		InputPort fromSO = M0.SO;
	}
	Instance M0 Of EmptyModule {
		InputPort SI = sib0.toSI;
		Parameter inputs = 31;
		Parameter outputs = 59;
		Parameter bidirs = 111;
	}
	Instance sib1 Of SIB_mux_pre {
		InputPort SI = sib0.SO;
		InputPort fromSO = sib2.SO;
	}	
	// Level 2
	Instance sibM6 Of SIB_mux_pre {
		InputPort SI = sib1.toSI;
		InputPort fromSO = m6.SO;
	}
	Instance m6 Of EmptyModule_NoBidirs  {
		InputPort SI = sibM6.toSI; 
		Parameter inputs = 34;
		Parameter outputs = 35;
	}
	Instance sib2 Of SIB_mux_pre {
		InputPort SI = sibM6.SO;
		InputPort fromSO = m1.SO;
	}
	// Level 3 and lower
	Instance sibM7 Of SIB_mux_pre {
		InputPort SI = sib2.toSI;
		InputPort fromSO = m7.SO;
	}
	Instance m7 Of EmptyModule_NoBidirs  {
		InputPort SI = sibM7.toSI; 
		Parameter inputs = 226;
		Parameter outputs = 100;
	}
	Instance m5 Of A586710_Basic::M5 {
		InputPort SI = sibM7.SO;
		InputPort DI = DIm5;	
		InputPort toDO = toDOm5;  
	}
	Instance m1 Of A586710_Basic::M1 {
		InputPort SI = m5.SO;
		InputPort DI = DIm1;	
		InputPort toDO = toDOm1;  
	}
}
