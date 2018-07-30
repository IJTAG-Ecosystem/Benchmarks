/*
* Copyright Testonica Lab (C) 2016
*
* History:
* -------------+------------+-------------------------+------------------------
*   Version    |  Date      | Author                  | Organization
* -------------+------------+-------------------------+------------------------
*          1.0 | 30.03.2016 | Anton Tsertov           | Testonica Lab
*--------------+------------+-------------------------+------------------------
*          2.0 | 01.05.2016 | Anton Tsertov           | Testonica Lab
*--------------+------------+-------------------------+------------------------
*          2.1 | 13.09.2016 | Riccardo Cantoro        | Politecnico di Torino
*--------------+------------+-------------------------+------------------------
*          2.5 | 26.06.2018 | Jan Burchard		      | Mentor A Siemens Business
*              |            | Anton Tsertov		      | Testonica Lab
*--------------+------------+-------------------------+------------------------
*
* Uses modules from files: 
* - Instruments.icl
* - EmptyModule.icl
*/

NameSpace A586710;

UseNameSpace root;
Module M0 {
    Attribute lic = 'h d40ccf7a;
	Parameter inputs = 31;
	Parameter outputs = 59;
	Parameter bidirs = 111;
	Parameter inputs_m1 = 437;
	Parameter inputs_m5 = 343;

	ScanInPort SI;
	ScanOutPort SO {
		Source sibTop.SO;
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
	
	DataInPort DI[$inputs+$bidirs-1 : 0];
	DataInPort toDO[$outputs+$bidirs-1 : 0];
	DataOutPort DO[$outputs+$bidirs-1 : 0] {
		Source wrpOut; 
	}
	
	DataInPort DIm1[$inputs_m1+$bidirs-1 : 0];
	DataInPort toDOm1[$outputs_m1+$bidirs-1 : 0];
	DataInPort DIm5[$inputs_m5+$bidirs-1 : 0];
	DataInPort toDOm5[$outputs_m5+$bidirs-1 : 0];
	
	Instance sibTop Of SIB_mux_pre {
		InputPort SI = SI;
		InputPort fromSO = sibM7.SO;
	}
	Instance sibWrp Of SIB_mux_pre {
		InputPort SI = sibTop.toSI;
		InputPort fromSO = wrpOut.SO;
	}
	Instance wrpIn Of SReg {
		InputPort SI = sibWrp.toSI;
		InputPort DI = DI; 
		Parameter Size = $inputs+$bidirs;
	}
	Instance wrpCntrl Of WrappedScan {
		InputPort SI = wrpIn.SO;
		Parameter dataWidth = $bidirs;
	}
	Instance wrpOut Of SReg {
		InputPort SI = wrpCntrl.SO;
		InputPort DI = toDO; 
		Parameter Size = $outputs+$bidirs;
	}
	Instance sibM1 Of SIB_mux_pre {
		InputPort SI = sibWrp.SO;
		InputPort fromSO = m1.SO;
	}
	Instance m1 Of A586710::M1 {
		InputPort SI = sibM1.toSI;
		InputPort DI = DIm1;	
		InputPort toDO = toDOm1;  
	}
	Instance sibM5 Of SIB_mux_pre {
		InputPort SI = sibM1.SO;
		InputPort fromSO = m5.SO;
	}
	Instance m5 Of A586710::M5 {
		InputPort SI = sibM5.toSI; 
		InputPort DI = DIm5;	
		InputPort toDO = toDOm5; 
	}
	Instance sibM6 Of SIB_mux_pre {
		InputPort SI = sibM5.SO;
		InputPort fromSO = m6.SO;
	}
	Instance m6 Of EmptyModule_NoBidirs  {
		InputPort SI = sibM6.toSI; 
		Parameter inputs = 34;
		Parameter outputs = 35;
	}
	Instance sibM7 Of SIB_mux_pre {
		InputPort SI = sibM6.SO;
		InputPort fromSO = m7.SO;
	}
	Instance m7 Of EmptyModule_NoBidirs  {
		InputPort SI = sibM7.toSI; 
		Parameter inputs = 226;
		Parameter outputs = 100;
	}
}

UseNameSpace root;
Module M1 {
    Attribute lic = 'h bd2cad1e;
	Parameter inputs = 437;
	Parameter outputs = 370;
	Parameter bidirs = 2;

	ScanInPort SI;
	ScanOutPort SO {
		Source sibTop.SO;
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
	
	DataInPort DI[$inputs+$bidirs-1 : 0];
	DataInPort toDO[$outputs+$bidirs-1 : 0];
	DataOutPort DO[$outputs+$bidirs-1 : 0] {
		Source wrpOut; 
	}
	Instance sibTop Of SIB_mux_pre {
		InputPort SI = SI;
		InputPort fromSO = sibM4.SO;
	}
	Instance sibWrp Of SIB_mux_pre {
		InputPort SI = sibTop.toSI;
		InputPort fromSO = wrpOut.SO;
	}
	Instance wrpIn Of SReg {
		InputPort SI = sibWrp.toSI;
		InputPort DI = DI; 
		Parameter Size = $inputs+$bidirs;
	}
	Instance wrpCntrl Of WrappedScan {
		InputPort SI = wrpIn.SO;
		Parameter dataWidth = $bidirs;
	}
	Instance wrpOut Of SReg {
		InputPort SI = wrpCntrl.SO;
		InputPort DI = toDO; 
		Parameter Size = $outputs+$bidirs;
	}
	Instance sib1 Of SIB_mux_pre {
		InputPort SI = sibWrp.SO;
		InputPort fromSO = scanReg1.SO;
	}
	Instance scanReg1 Of WrappedScan {
		InputPort SI = sib1.toSI; 
		Parameter dataWidth = 2155;
	}
	Instance sib2 Of SIB_mux_pre {
		InputPort SI = sib1.SO;
		InputPort fromSO = scanReg2.SO;
	}
	Instance scanReg2 Of WrappedScan {
		InputPort SI = sib2.toSI; 
		Parameter dataWidth = 2155;
	}
	Instance sib3 Of SIB_mux_pre {
		InputPort SI = sib2.SO;
		InputPort fromSO = scanReg3.SO;
	}
	Instance scanReg3 Of WrappedScan {
		InputPort SI = sib3.toSI; 
		Parameter dataWidth = 2141;
	}
	Instance sib4 Of SIB_mux_pre {
		InputPort SI = sib3.SO;
		InputPort fromSO = scanReg4.SO;
	}
	Instance scanReg4 Of WrappedScan {
		InputPort SI = sib4.toSI; 
		Parameter dataWidth = 2155;
	}
	Instance sib5 Of SIB_mux_pre {
		InputPort SI = sib4.SO;
		InputPort fromSO = scanReg5.SO;
	}
	Instance scanReg5 Of WrappedScan {
		InputPort SI = sib5.toSI; 
		Parameter dataWidth = 2155;
	}
	Instance sib6 Of SIB_mux_pre {
		InputPort SI = sib5.SO;
		InputPort fromSO = scanReg6.SO;
	}
	Instance scanReg6 Of WrappedScan {
		InputPort SI = sib6.toSI; 
		Parameter dataWidth = 2155;
	}
	Instance sib7 Of SIB_mux_pre {
		InputPort SI = sib6.SO;
		InputPort fromSO = scanReg7.SO;
	}
	Instance scanReg7 Of WrappedScan {
		InputPort SI = sib7.toSI; 
		Parameter dataWidth = 2155;
	}
	Instance sib8 Of SIB_mux_pre {
		InputPort SI = sib7.SO;
		InputPort fromSO = scanReg8.SO;
	}
	Instance scanReg8 Of WrappedScan {
		InputPort SI = sib8.toSI; 
		Parameter dataWidth = 2155;
	}
	Instance sibM2 Of SIB_mux_pre {
		InputPort SI = sib8.SO;
		InputPort fromSO = m2.SO;
	}
	Instance m2 Of EmptyModule_NoBidirs  {
		InputPort SI = sibM2.toSI; 
		Parameter inputs = 275;
		Parameter outputs = 222;
	}
	Instance sibM3 Of SIB_mux_pre {
		InputPort SI = sibM2.SO;
		InputPort fromSO = m3.SO;
	}
	Instance m3 Of EmptyModule_NoBidirs  {
		InputPort SI = sib8.toSI; 
		Parameter inputs = 407;
		Parameter outputs = 244;
	}
	Instance sibM4 Of SIB_mux_pre {
		InputPort SI = sibM3.SO;
		InputPort fromSO = m4.SO;
	}
	Instance m4 Of EmptyModule_NoBidirs  {
		InputPort SI = sib8.toSI; 
		Parameter inputs = 206;
		Parameter outputs = 324;
	}
}


UseNameSpace root;
Module M5 {
    Attribute lic = 'h 1a74f05b;
	Parameter inputs = 343;
	Parameter outputs = 218;
	Parameter bidirs = 111;

	ScanInPort SI;
	ScanOutPort SO {
		Source sibTop.SO;
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
	
	DataInPort DI[$inputs+$bidirs-1 : 0];
	DataInPort toDO[$outputs+$bidirs-1 : 0];
	DataOutPort DO[$outputs+$bidirs-1 : 0] {
		Source wrpOut; 
	}
	Instance sibTop Of SIB_mux_pre {
		InputPort SI = SI;
		InputPort fromSO = sib8.SO;
	}
	Instance sibWrp Of SIB_mux_pre {
		InputPort SI = sibTop.toSI;
		InputPort fromSO = wrpOut.SO;
	}
	Instance wrpIn Of SReg {
		InputPort SI = sibWrp.toSI;
		InputPort DI = DI; 
		Parameter Size = $inputs+$bidirs;
	}
	Instance wrpCntrl Of WrappedScan {
		InputPort SI = wrpIn.SO;
		Parameter dataWidth = $bidirs;
	}
	Instance wrpOut Of SReg {
		InputPort SI = wrpCntrl.SO;
		InputPort DI = toDO; 
		Parameter Size = $outputs+$bidirs;
	}
	Instance sib1 Of SIB_mux_pre {
		InputPort SI = sibWrp.SO;
		InputPort fromSO = scanReg1.SO;
	}
	Instance scanReg1 Of WrappedScan {
		InputPort SI = sib1.toSI; 
		Parameter dataWidth = 2548;
	}
	Instance sib2 Of SIB_mux_pre {
		InputPort SI = sib1.SO;
		InputPort fromSO = scanReg2.SO;
	}
	Instance scanReg2 Of WrappedScan {
		InputPort SI = sib2.toSI; 
		Parameter dataWidth = 2548;
	}
	Instance sib3 Of SIB_mux_pre {
		InputPort SI = sib2.SO;
		InputPort fromSO = scanReg3.SO;
	}
	Instance scanReg3 Of WrappedScan {
		InputPort SI = sib3.toSI; 
		Parameter dataWidth = 2540;
	}
	Instance sib4 Of SIB_mux_pre {
		InputPort SI = sib3.SO;
		InputPort fromSO = scanReg4.SO;
	}
	Instance scanReg4 Of WrappedScan {
		InputPort SI = sib4.toSI; 
		Parameter dataWidth = 2540;
	}
	Instance sib5 Of SIB_mux_pre {
		InputPort SI = sib4.SO;
		InputPort fromSO = scanReg5.SO;
	}
	Instance scanReg5 Of WrappedScan {
		InputPort SI = sib5.toSI; 
		Parameter dataWidth = 2548;
	}
	Instance sib6 Of SIB_mux_pre {
		InputPort SI = sib5.SO;
		InputPort fromSO = scanReg6.SO;
	}
	Instance scanReg6 Of WrappedScan {
		InputPort SI = sib6.toSI; 
		Parameter dataWidth = 2532;
	}
	Instance sib7 Of SIB_mux_pre {
		InputPort SI = sib6.SO;
		InputPort fromSO = scanReg7.SO;
	}
	Instance scanReg7 Of WrappedScan {
		InputPort SI = sib7.toSI; 
		Parameter dataWidth = 2548;
	}
	Instance sib8 Of SIB_mux_pre {
		InputPort SI = sib7.SO;
		InputPort fromSO = scanReg8.SO;
	}
	Instance scanReg8 Of WrappedScan {
		InputPort SI = sib8.toSI; 
		Parameter dataWidth = 2626;
	}
}

NameSpace A586710_Basic;

UseNameSpace root;

Module M1 {
    Attribute lic = 'h b0de5d46;
    Parameter inputs = 437;
    Parameter outputs = 370;
    Parameter bidirs = 2;

    ScanInPort SI;
    ScanOutPort SO {
        Source sibTop.SO;
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
    
    DataInPort DI[$inputs+$bidirs-1 : 0];
    DataInPort toDO[$outputs+$bidirs-1 : 0];
    DataOutPort DO[$outputs+$bidirs-1 : 0] {
        Source wrpOut; 
    }
    Instance sibTop Of SIB_mux_pre {
        InputPort SI = SI;
        InputPort fromSO = sib1.SO;
    }
    Instance sibWrp Of SIB_mux_pre {
        InputPort SI = sibTop.toSI;
        InputPort fromSO = sibM4.SO;
    }
    Instance wrpIn Of SReg {
        InputPort SI = sibWrp.toSI;
        InputPort DI = DI; 
        Parameter Size = $inputs+$bidirs;
    }
    Instance wrpOut Of SReg {
        InputPort SI = wrpIn.SO;
        InputPort DI = toDO; 
        Parameter Size = $outputs+$bidirs;
    }
	Instance wrpCntrl Of WrappedScan {
        InputPort SI = wrpOut.SO;
        Parameter dataWidth = $bidirs;
    }
    Instance sib1 Of SIB_mux_pre {
        InputPort SI = sibWrp.SO;
        InputPort fromSO = sib2.SO;
    }
    Instance scanReg1 Of WrappedScan {
        InputPort SI = sib1.toSI; 
        Parameter dataWidth = 2155;
    }
    Instance sib2 Of SIB_mux_pre {
        InputPort SI = scanReg1.SO;
        InputPort fromSO = sib3.SO;
    }
    Instance scanReg2 Of WrappedScan {
        InputPort SI = sib2.toSI; 
        Parameter dataWidth = 2155;
    }
    Instance sib3 Of SIB_mux_pre {
        InputPort SI = scanReg2.SO;
        InputPort fromSO = sib4.SO;
    }
    Instance scanReg3 Of WrappedScan {
        InputPort SI = sib3.toSI; 
        Parameter dataWidth = 2141;
    }
    Instance sib4 Of SIB_mux_pre {
        InputPort SI = scanReg3.SO;
        InputPort fromSO = sib5.SO;
    }
    Instance scanReg4 Of WrappedScan {
        InputPort SI = sib4.toSI; 
        Parameter dataWidth = 2155;
    }
    Instance sib5 Of SIB_mux_pre {
        InputPort SI = scanReg4.SO;
        InputPort fromSO = sib6.SO;
    }
    Instance scanReg5 Of WrappedScan {
        InputPort SI = sib5.toSI; 
        Parameter dataWidth = 2155;
    }
    Instance sib6 Of SIB_mux_pre {
        InputPort SI = scanReg5.SO;
        InputPort fromSO = sib7.SO;
    }
    Instance scanReg6 Of WrappedScan {
        InputPort SI = sib6.toSI; 
        Parameter dataWidth = 2155;
    }
    Instance sib7 Of SIB_mux_pre {
        InputPort SI = scanReg6.SO;
        InputPort fromSO = sib8.SO;
    }
    Instance scanReg7 Of WrappedScan {
        InputPort SI = sib7.toSI; 
        Parameter dataWidth = 2155;
    }
    Instance sib8 Of SIB_mux_pre {
        InputPort SI = scanReg7.SO;
        InputPort fromSO = scanReg8.SO;
    }
    Instance scanReg8 Of WrappedScan {
        InputPort SI = sib8.toSI; 
        Parameter dataWidth = 2155;
    }
    Instance sibM2 Of SIB_mux_pre {
        InputPort SI = wrpCntrl.SO;
        InputPort fromSO = m2.SO;
    }
    Instance m2 Of EmptyModule_NoBidirs  {
        InputPort SI = sibM2.toSI; 
        Parameter inputs = 275;
        Parameter outputs = 222;
    }
    Instance sibM3 Of SIB_mux_pre {
        InputPort SI = sibM2.SO;
        InputPort fromSO = m3.SO;
    }
    Instance m3 Of EmptyModule_NoBidirs  {
        InputPort SI = sibM3.toSI; 
        Parameter inputs = 407;
        Parameter outputs = 244;
    }
    Instance sibM4 Of SIB_mux_pre {
        InputPort SI = sibM3.SO;
        InputPort fromSO = m4.SO;
    }
    Instance m4 Of EmptyModule_NoBidirs  {
        InputPort SI = sibM4.toSI; 
        Parameter inputs = 206;
        Parameter outputs = 324;
    }
}


UseNameSpace root;
Module M5 {
    Attribute lic = 'h 297938e4;
    Parameter inputs = 343;
    Parameter outputs = 218;
    Parameter bidirs = 111;

    ScanInPort SI;
    ScanOutPort SO {
        Source sibTop.SO;
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
    
    DataInPort DI[$inputs+$bidirs-1 : 0];
    DataInPort toDO[$outputs+$bidirs-1 : 0];
    DataOutPort DO[$outputs+$bidirs-1 : 0] {
        Source wrpOut; 
    }
    Instance sibTop Of SIB_mux_pre {
        InputPort SI = SI;
        InputPort fromSO = sib8.SO;
    }
    Instance sibWrp Of SIB_mux_pre {
        InputPort SI = sibTop.toSI;
        InputPort fromSO = wrpCntrl.SO;
    }
    Instance wrpIn Of SReg {
        InputPort SI = sibWrp.toSI;
        InputPort DI = DI; 
        Parameter Size = $inputs+$bidirs;
    }
    Instance wrpOut Of SReg {
        InputPort SI = wrpIn.SO;
        InputPort DI = toDO; 
        Parameter Size = $outputs+$bidirs;
    }
	Instance wrpCntrl Of WrappedScan {
        InputPort SI = wrpOut.SO;
        Parameter dataWidth = $bidirs;
    }
    Instance sib1 Of SIB_mux_pre {
        InputPort SI = sibWrp.SO;
        InputPort fromSO = scanReg1.SO;
    }
    Instance scanReg1 Of WrappedScan {
        InputPort SI = sib1.toSI; 
        Parameter dataWidth = 2548;
    }
    Instance sib2 Of SIB_mux_pre {
        InputPort SI = sib1.SO;
        InputPort fromSO = scanReg2.SO;
    }
    Instance scanReg2 Of WrappedScan {
        InputPort SI = sib2.toSI; 
        Parameter dataWidth = 2548;
    }
    Instance sib3 Of SIB_mux_pre {
        InputPort SI = sib2.SO;
        InputPort fromSO = scanReg3.SO;
    }
    Instance scanReg3 Of WrappedScan {
        InputPort SI = sib3.toSI; 
        Parameter dataWidth = 2540;
    }
    Instance sib4 Of SIB_mux_pre {
        InputPort SI = sib3.SO;
        InputPort fromSO = scanReg4.SO;
    }
    Instance scanReg4 Of WrappedScan {
        InputPort SI = sib4.toSI; 
        Parameter dataWidth = 2540;
    }
    Instance sib5 Of SIB_mux_pre {
        InputPort SI = sib4.SO;
        InputPort fromSO = scanReg5.SO;
    }
    Instance scanReg5 Of WrappedScan {
        InputPort SI = sib5.toSI; 
        Parameter dataWidth = 2548;
    }
    Instance sib6 Of SIB_mux_pre {
        InputPort SI = sib5.SO;
        InputPort fromSO = scanReg6.SO;
    }
    Instance scanReg6 Of WrappedScan {
        InputPort SI = sib6.toSI; 
        Parameter dataWidth = 2532;
    }
    Instance sib7 Of SIB_mux_pre {
        InputPort SI = sib6.SO;
        InputPort fromSO = scanReg7.SO;
    }
    Instance scanReg7 Of WrappedScan {
        InputPort SI = sib7.toSI; 
        Parameter dataWidth = 2548;
    }
    Instance sib8 Of SIB_mux_pre {
        InputPort SI = sib7.SO;
        InputPort fromSO = scanReg8.SO;
    }
    Instance scanReg8 Of WrappedScan {
        InputPort SI = sib8.toSI; 
        Parameter dataWidth = 2626;
    }
}
