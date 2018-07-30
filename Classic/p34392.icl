/*
* Copyright Testonica Lab (C) 2016
*
*
* History:
* -------------+------------+-------------------------+------------------------
*   Version    |  Date      | Author                  | Organization
* -------------+------------+-------------------------+------------------------
*          1.0 | 10.05.2016 | Anton Tsertov           | Testonica Lab
*--------------+------------+-------------------------+------------------------
*
* CLASSIC benchmark based on ITC'02 P34392 and ScanMux Control Bit (SCB) network 
* design strategy.
*
* Uses modules from files: 
* - Instruments.icl
* - NetworkStructs.icl
* - EmptyModule.icl
*/

NameSpace p34392;
UseNameSpace root;

Module M0 {
    Attribute lic = 'h 1d3dee48;
    Parameter inputs = 32;
    Parameter outputs = 27;
    Parameter bidirs = 114;

    ScanInPort SI;
    ScanOutPort SO {
        Source sMuxTop;
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
    
    LogicSignal sel_nSCBTop {
        SEL & ~SCBTop.DO;
    }
    
    LogicSignal sel_SCBTop_SCBIn {
        SEL & SCBTop.DO & sMuxInputs.DO;
    }
    LogicSignal sel_SCBTop_SCBOut {
        SEL & SCBTop.DO & sMuxOutputs.DO;
    }
    LogicSignal sel_SCBTop_SCBM1 {
        SEL & SCBTop.DO & SCBM1.DO;
    }
    LogicSignal sel_SCBTop_SCBM2 {
        SEL & SCBTop.DO & SCBM5.DO;
    }
    LogicSignal sel_SCBTop_SCBM10 {
        SEL & SCBTop.DO & SCBM6.DO;
    }
    LogicSignal sel_SCBTop_SCBM18 {
        SEL & SCBTop.DO & SCBM7.DO;
    }
    
    Instance SCBTop Of SCB {
        InputPort SI = SI;
        InputPort SEL = SEL;
    }
   
    Instance SCBIn Of SCB {
        InputPort SI = SCBTop.SO;
        InputPort SEL = sel_nSCBTop;
    }   
    Instance wrpIn Of SReg {
        InputPort SI = SCBTop.SO;
        InputPort DI = DI; 
        InputPort SEL = sel_SCBTop_SCBIn;
        Parameter Size = $inputs+$bidirs;
    }
    ScanMux sMuxInputs SelectedBy SCBIn.DO {
        1'b0 : SCBTop.SO;
        1'b1 : wrpIn;
    }
    
    Instance SCBOut Of SCB {
        InputPort SI = SCBIn.SO;
        InputPort SEL = sel_nSCBTop;
    } 
    Instance wrpOut Of SReg {
        InputPort SI = sMuxInputs;
        InputPort DI = toDO; 
        InputPort SEL = sel_SCBTop_SCBOut;
        Parameter Size = $outputs+$bidirs;
    }
    ScanMux sMuxOutputs SelectedBy SCBOut.DO {
        1'b0 : sMuxInputs;
        1'b1 : wrpOut;
    }
    
    Instance SCBM1 Of SCB {
        InputPort SI = SCBOut.SO;
        InputPort SEL = sel_nSCBTop;
    } 
    Instance m1 Of p34392::M1 {
        InputPort SI = sMuxOutputs; 
        InputPort SEL = sel_SCBTop_SCBM1;
    }
   
    ScanMux sMuxM1 SelectedBy SCBM1.DO {
        1'b0 : sMuxOutputs;
        1'b1 : m1;
    }
    
    Instance SCBM2 Of SCB {
        InputPort SI = SCBM1.SO;
        InputPort SEL = sel_nSCBTop;
    }
    Instance m2 Of p34392::M2 {
        InputPort SI = sMuxM1;
        InputPort SEL = sel_SCBTop_SCBM2; 
    }
    ScanMux sMuxM2 SelectedBy SCBM2.DO {
        1'b0 : sMuxM1;
        1'b1 : m2;
    }
    
    Instance SCBM10 Of SCB {
        InputPort SI = SCBM2.SO;
        InputPort SEL = sel_nSCBTop;
    }
    Instance m10 Of p34392::M10 {
        InputPort SI = sMuxM2;
        InputPort SEL = sel_SCBTop_SCBM10; 
    }
    ScanMux sMuxM10 SelectedBy SCBM10.DO {
        1'b0 : sMuxM2;
        1'b1 : m10;
    }
	
    Instance SCBM18 Of SCB {
        InputPort SI = SCBM10.SO;
        InputPort SEL = sel_nSCBTop;
    }
    Instance m18 Of p34392::M18 {
        InputPort SI = sMuxM10;
        InputPort SEL = sel_SCBTop_SCBM18; 
    }
    
    ScanMux sMuxM18 SelectedBy SCBM18.DO {
        1'b0 : sMuxM10;
        1'b1 : m18;
    }
    
    ScanMux sMuxTop SelectedBy SCBTop.DO {
        1'b0 : SCBM18.SO;
        1'b1 : sMuxM18;
    }
}


/* Module 1 Level 1 Inputs 15 Outputs 94 Bidirs 0 ScanChains 1 : 806*/
Module M1 {
	Attribute lic = 'h 4e4712b7;
	Parameter inputs = 15;
	Parameter outputs = 94;
	Parameter bidirs = 0;
	ScanInPort SI;
	ScanOutPort SO {
		Source sMuxTop;
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

	LogicSignal sel_nSCBTop {
		SEL & ~SCBTop.DO;
	}
	LogicSignal sel_SCBTop_SCBIn {
        SEL & SCBTop.DO & sMuxInputs.DO;
    }
    LogicSignal sel_SCBTop_SCBOut {
        SEL & SCBTop.DO & sMuxOutputs.DO;
    }
	LogicSignal sel_SCBTop_SCBsc1 {
		SEL & SCBTop.DO & SCBsc1.DO;
	}
	Instance SCBTop Of SCB {
		InputPort SI = SI;
		InputPort SEL = SEL;
	}
	Instance SCBIn Of SCB {
		InputPort SI = SCBTop.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance wrpIn Of SReg {
		InputPort SI = SCBTop.SO;
		InputPort DI = DI;
		InputPort SEL = sel_SCBTop_SCBIn;
		Parameter Size = $inputs+$bidirs;
	}
	ScanMux sMuxInputs SelectedBy SCBIn.DO {
		1'b0 : SCBTop.SO;
		1'b1 : wrpIn;
	}
	Instance SCBOut Of SCB {
		InputPort SI = SCBIn.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance wrpOut Of SReg {
		InputPort SI = sMuxInputs;
		InputPort DI = toDO;
		InputPort SEL = sel_SCBTop_SCBOut;
		Parameter Size = $outputs+$bidirs;
	}
	ScanMux sMuxOutputs SelectedBy SCBOut.DO {
		1'b0 : sMuxInputs;
		1'b1 : wrpOut;
	}

	/*Scan Register 1*/
	Instance SCBsc1 Of SCB {
		InputPort SI = SCBOut.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc1 Of SReg {
		InputPort SI = sMuxOutputs;
		InputPort SEL = sel_SCBTop_SCBsc1;
		Parameter Size = 806;
	}
	ScanMux sMuxsc1 SelectedBy SCBsc1.DO {
		1'b0 : sMuxOutputs;
		1'b1 : sc1.SO;
	}

	ScanMux sMuxTop SelectedBy SCBTop.DO {
		1'b0 : SCBsc1;
		1'b1 : sMuxsc1;
	}
}

/* Module 2 Level 1 Inputs 165 Outputs 263 Bidirs 0 ScanChains 29 : 570 569 569 567 567 567 567 567 567 567 567 567 567 566 566 44 44 44 44 38 32 16 16 16 16 11 9 8 8*/
Module M2 {
	Attribute lic = 'h be5dcbd5;
	Parameter inputs = 165;
	Parameter outputs = 263;
	Parameter bidirs = 0;
	ScanInPort SI;
	ScanOutPort SO {
		Source sMuxTop;
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

	LogicSignal sel_nSCBTop {
		SEL & ~SCBTop.DO;
	}
	LogicSignal sel_SCBTop_SCBIn {
        SEL & SCBTop.DO & sMuxInputs.DO;
    }
    LogicSignal sel_SCBTop_SCBOut {
        SEL & SCBTop.DO & sMuxOutputs.DO;
    }
	LogicSignal sel_SCBTop_SCBsc1 {
		SEL & SCBTop.DO & SCBsc1.DO;
	}
	LogicSignal sel_SCBTop_SCBsc2 {
		SEL & SCBTop.DO & SCBsc2.DO;
	}
	LogicSignal sel_SCBTop_SCBsc3 {
		SEL & SCBTop.DO & SCBsc3.DO;
	}
	LogicSignal sel_SCBTop_SCBsc4 {
		SEL & SCBTop.DO & SCBsc4.DO;
	}
	LogicSignal sel_SCBTop_SCBsc5 {
		SEL & SCBTop.DO & SCBsc5.DO;
	}
	LogicSignal sel_SCBTop_SCBsc6 {
		SEL & SCBTop.DO & SCBsc6.DO;
	}
	LogicSignal sel_SCBTop_SCBsc7 {
		SEL & SCBTop.DO & SCBsc7.DO;
	}
	LogicSignal sel_SCBTop_SCBsc8 {
		SEL & SCBTop.DO & SCBsc8.DO;
	}
	LogicSignal sel_SCBTop_SCBsc9 {
		SEL & SCBTop.DO & SCBsc9.DO;
	}
	LogicSignal sel_SCBTop_SCBsc10 {
		SEL & SCBTop.DO & SCBsc10.DO;
	}
	LogicSignal sel_SCBTop_SCBsc11 {
		SEL & SCBTop.DO & SCBsc11.DO;
	}
	LogicSignal sel_SCBTop_SCBsc12 {
		SEL & SCBTop.DO & SCBsc12.DO;
	}
	LogicSignal sel_SCBTop_SCBsc13 {
		SEL & SCBTop.DO & SCBsc13.DO;
	}
	LogicSignal sel_SCBTop_SCBsc14 {
		SEL & SCBTop.DO & SCBsc14.DO;
	}
	LogicSignal sel_SCBTop_SCBsc15 {
		SEL & SCBTop.DO & SCBsc15.DO;
	}
	LogicSignal sel_SCBTop_SCBsc16 {
		SEL & SCBTop.DO & SCBsc16.DO;
	}
	LogicSignal sel_SCBTop_SCBsc17 {
		SEL & SCBTop.DO & SCBsc17.DO;
	}
	LogicSignal sel_SCBTop_SCBsc18 {
		SEL & SCBTop.DO & SCBsc18.DO;
	}
	LogicSignal sel_SCBTop_SCBsc19 {
		SEL & SCBTop.DO & SCBsc19.DO;
	}
	LogicSignal sel_SCBTop_SCBsc20 {
		SEL & SCBTop.DO & SCBsc20.DO;
	}
	LogicSignal sel_SCBTop_SCBsc21 {
		SEL & SCBTop.DO & SCBsc21.DO;
	}
	LogicSignal sel_SCBTop_SCBsc22 {
		SEL & SCBTop.DO & SCBsc22.DO;
	}
	LogicSignal sel_SCBTop_SCBsc23 {
		SEL & SCBTop.DO & SCBsc23.DO;
	}
	LogicSignal sel_SCBTop_SCBsc24 {
		SEL & SCBTop.DO & SCBsc24.DO;
	}
	LogicSignal sel_SCBTop_SCBsc25 {
		SEL & SCBTop.DO & SCBsc25.DO;
	}
	LogicSignal sel_SCBTop_SCBsc26 {
		SEL & SCBTop.DO & SCBsc26.DO;
	}
	LogicSignal sel_SCBTop_SCBsc27 {
		SEL & SCBTop.DO & SCBsc27.DO;
	}
	LogicSignal sel_SCBTop_SCBsc28 {
		SEL & SCBTop.DO & SCBsc28.DO;
	}
	LogicSignal sel_SCBTop_SCBsc29 {
		SEL & SCBTop.DO & SCBsc29.DO;
	}
	Instance SCBTop Of SCB {
		InputPort SI = SI;
		InputPort SEL = SEL;
	}
	Instance SCBIn Of SCB {
		InputPort SI = SCBTop.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance wrpIn Of SReg {
		InputPort SI = SCBTop.SO;
		InputPort DI = DI;
		InputPort SEL = sel_SCBTop_SCBIn;
		Parameter Size = $inputs+$bidirs;
	}
	ScanMux sMuxInputs SelectedBy SCBIn.DO {
		1'b0 : SCBTop.SO;
		1'b1 : wrpIn;
	}
	Instance SCBOut Of SCB {
		InputPort SI = SCBIn.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance wrpOut Of SReg {
		InputPort SI = sMuxInputs;
		InputPort DI = toDO;
		InputPort SEL = sel_SCBTop_SCBOut;
		Parameter Size = $outputs+$bidirs;
	}
	ScanMux sMuxOutputs SelectedBy SCBOut.DO {
		1'b0 : sMuxInputs;
		1'b1 : wrpOut;
	}

	/*Scan Register 1*/
	Instance SCBsc1 Of SCB {
		InputPort SI = SCBOut.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc1 Of SReg {
		InputPort SI = sMuxOutputs;
		InputPort SEL = sel_SCBTop_SCBsc1;
		Parameter Size = 570;
	}
	ScanMux sMuxsc1 SelectedBy SCBsc1.DO {
		1'b0 : sMuxOutputs;
		1'b1 : sc1.SO;
	}

	/* Scan Register 2*/
	Instance SCBsc2 Of SCB {
		InputPort SI = SCBsc1.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc2 Of SReg {
		InputPort SI = sMuxsc1;
		InputPort SEL = sel_SCBTop_SCBsc2;
		Parameter Size = 569;
	}
	ScanMux sMuxsc2 SelectedBy SCBsc2.DO {
		1'b0 : sMuxsc1;
		1'b1 : sc2.SO;
	}
	/* Scan Register 3*/
	Instance SCBsc3 Of SCB {
		InputPort SI = SCBsc2.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc3 Of SReg {
		InputPort SI = sMuxsc2;
		InputPort SEL = sel_SCBTop_SCBsc3;
		Parameter Size = 569;
	}
	ScanMux sMuxsc3 SelectedBy SCBsc3.DO {
		1'b0 : sMuxsc2;
		1'b1 : sc3.SO;
	}
	/* Scan Register 4*/
	Instance SCBsc4 Of SCB {
		InputPort SI = SCBsc3.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc4 Of SReg {
		InputPort SI = sMuxsc3;
		InputPort SEL = sel_SCBTop_SCBsc4;
		Parameter Size = 567;
	}
	ScanMux sMuxsc4 SelectedBy SCBsc4.DO {
		1'b0 : sMuxsc3;
		1'b1 : sc4.SO;
	}
	/* Scan Register 5*/
	Instance SCBsc5 Of SCB {
		InputPort SI = SCBsc4.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc5 Of SReg {
		InputPort SI = sMuxsc4;
		InputPort SEL = sel_SCBTop_SCBsc5;
		Parameter Size = 567;
	}
	ScanMux sMuxsc5 SelectedBy SCBsc5.DO {
		1'b0 : sMuxsc4;
		1'b1 : sc5.SO;
	}
	/* Scan Register 6*/
	Instance SCBsc6 Of SCB {
		InputPort SI = SCBsc5.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc6 Of SReg {
		InputPort SI = sMuxsc5;
		InputPort SEL = sel_SCBTop_SCBsc6;
		Parameter Size = 567;
	}
	ScanMux sMuxsc6 SelectedBy SCBsc6.DO {
		1'b0 : sMuxsc5;
		1'b1 : sc6.SO;
	}
	/* Scan Register 7*/
	Instance SCBsc7 Of SCB {
		InputPort SI = SCBsc6.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc7 Of SReg {
		InputPort SI = sMuxsc6;
		InputPort SEL = sel_SCBTop_SCBsc7;
		Parameter Size = 567;
	}
	ScanMux sMuxsc7 SelectedBy SCBsc7.DO {
		1'b0 : sMuxsc6;
		1'b1 : sc7.SO;
	}
	/* Scan Register 8*/
	Instance SCBsc8 Of SCB {
		InputPort SI = SCBsc7.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc8 Of SReg {
		InputPort SI = sMuxsc7;
		InputPort SEL = sel_SCBTop_SCBsc8;
		Parameter Size = 567;
	}
	ScanMux sMuxsc8 SelectedBy SCBsc8.DO {
		1'b0 : sMuxsc7;
		1'b1 : sc8.SO;
	}
	/* Scan Register 9*/
	Instance SCBsc9 Of SCB {
		InputPort SI = SCBsc8.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc9 Of SReg {
		InputPort SI = sMuxsc8;
		InputPort SEL = sel_SCBTop_SCBsc9;
		Parameter Size = 567;
	}
	ScanMux sMuxsc9 SelectedBy SCBsc9.DO {
		1'b0 : sMuxsc8;
		1'b1 : sc9.SO;
	}
	/* Scan Register 10*/
	Instance SCBsc10 Of SCB {
		InputPort SI = SCBsc9.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc10 Of SReg {
		InputPort SI = sMuxsc9;
		InputPort SEL = sel_SCBTop_SCBsc10;
		Parameter Size = 567;
	}
	ScanMux sMuxsc10 SelectedBy SCBsc10.DO {
		1'b0 : sMuxsc9;
		1'b1 : sc10.SO;
	}
	/* Scan Register 11*/
	Instance SCBsc11 Of SCB {
		InputPort SI = SCBsc10.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc11 Of SReg {
		InputPort SI = sMuxsc10;
		InputPort SEL = sel_SCBTop_SCBsc11;
		Parameter Size = 567;
	}
	ScanMux sMuxsc11 SelectedBy SCBsc11.DO {
		1'b0 : sMuxsc10;
		1'b1 : sc11.SO;
	}
	/* Scan Register 12*/
	Instance SCBsc12 Of SCB {
		InputPort SI = SCBsc11.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc12 Of SReg {
		InputPort SI = sMuxsc11;
		InputPort SEL = sel_SCBTop_SCBsc12;
		Parameter Size = 567;
	}
	ScanMux sMuxsc12 SelectedBy SCBsc12.DO {
		1'b0 : sMuxsc11;
		1'b1 : sc12.SO;
	}
	/* Scan Register 13*/
	Instance SCBsc13 Of SCB {
		InputPort SI = SCBsc12.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc13 Of SReg {
		InputPort SI = sMuxsc12;
		InputPort SEL = sel_SCBTop_SCBsc13;
		Parameter Size = 567;
	}
	ScanMux sMuxsc13 SelectedBy SCBsc13.DO {
		1'b0 : sMuxsc12;
		1'b1 : sc13.SO;
	}
	/* Scan Register 14*/
	Instance SCBsc14 Of SCB {
		InputPort SI = SCBsc13.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc14 Of SReg {
		InputPort SI = sMuxsc13;
		InputPort SEL = sel_SCBTop_SCBsc14;
		Parameter Size = 566;
	}
	ScanMux sMuxsc14 SelectedBy SCBsc14.DO {
		1'b0 : sMuxsc13;
		1'b1 : sc14.SO;
	}
	/* Scan Register 15*/
	Instance SCBsc15 Of SCB {
		InputPort SI = SCBsc14.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc15 Of SReg {
		InputPort SI = sMuxsc14;
		InputPort SEL = sel_SCBTop_SCBsc15;
		Parameter Size = 566;
	}
	ScanMux sMuxsc15 SelectedBy SCBsc15.DO {
		1'b0 : sMuxsc14;
		1'b1 : sc15.SO;
	}
	/* Scan Register 16*/
	Instance SCBsc16 Of SCB {
		InputPort SI = SCBsc15.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc16 Of SReg {
		InputPort SI = sMuxsc15;
		InputPort SEL = sel_SCBTop_SCBsc16;
		Parameter Size = 44;
	}
	ScanMux sMuxsc16 SelectedBy SCBsc16.DO {
		1'b0 : sMuxsc15;
		1'b1 : sc16.SO;
	}
	/* Scan Register 17*/
	Instance SCBsc17 Of SCB {
		InputPort SI = SCBsc16.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc17 Of SReg {
		InputPort SI = sMuxsc16;
		InputPort SEL = sel_SCBTop_SCBsc17;
		Parameter Size = 44;
	}
	ScanMux sMuxsc17 SelectedBy SCBsc17.DO {
		1'b0 : sMuxsc16;
		1'b1 : sc17.SO;
	}
	/* Scan Register 18*/
	Instance SCBsc18 Of SCB {
		InputPort SI = SCBsc17.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc18 Of SReg {
		InputPort SI = sMuxsc17;
		InputPort SEL = sel_SCBTop_SCBsc18;
		Parameter Size = 44;
	}
	ScanMux sMuxsc18 SelectedBy SCBsc18.DO {
		1'b0 : sMuxsc17;
		1'b1 : sc18.SO;
	}
	/* Scan Register 19*/
	Instance SCBsc19 Of SCB {
		InputPort SI = SCBsc18.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc19 Of SReg {
		InputPort SI = sMuxsc18;
		InputPort SEL = sel_SCBTop_SCBsc19;
		Parameter Size = 44;
	}
	ScanMux sMuxsc19 SelectedBy SCBsc19.DO {
		1'b0 : sMuxsc18;
		1'b1 : sc19.SO;
	}
	/* Scan Register 20*/
	Instance SCBsc20 Of SCB {
		InputPort SI = SCBsc19.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc20 Of SReg {
		InputPort SI = sMuxsc19;
		InputPort SEL = sel_SCBTop_SCBsc20;
		Parameter Size = 38;
	}
	ScanMux sMuxsc20 SelectedBy SCBsc20.DO {
		1'b0 : sMuxsc19;
		1'b1 : sc20.SO;
	}
	/* Scan Register 21*/
	Instance SCBsc21 Of SCB {
		InputPort SI = SCBsc20.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc21 Of SReg {
		InputPort SI = sMuxsc20;
		InputPort SEL = sel_SCBTop_SCBsc21;
		Parameter Size = 32;
	}
	ScanMux sMuxsc21 SelectedBy SCBsc21.DO {
		1'b0 : sMuxsc20;
		1'b1 : sc21.SO;
	}
	/* Scan Register 22*/
	Instance SCBsc22 Of SCB {
		InputPort SI = SCBsc21.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc22 Of SReg {
		InputPort SI = sMuxsc21;
		InputPort SEL = sel_SCBTop_SCBsc22;
		Parameter Size = 16;
	}
	ScanMux sMuxsc22 SelectedBy SCBsc22.DO {
		1'b0 : sMuxsc21;
		1'b1 : sc22.SO;
	}
	/* Scan Register 23*/
	Instance SCBsc23 Of SCB {
		InputPort SI = SCBsc22.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc23 Of SReg {
		InputPort SI = sMuxsc22;
		InputPort SEL = sel_SCBTop_SCBsc23;
		Parameter Size = 16;
	}
	ScanMux sMuxsc23 SelectedBy SCBsc23.DO {
		1'b0 : sMuxsc22;
		1'b1 : sc23.SO;
	}
	/* Scan Register 24*/
	Instance SCBsc24 Of SCB {
		InputPort SI = SCBsc23.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc24 Of SReg {
		InputPort SI = sMuxsc23;
		InputPort SEL = sel_SCBTop_SCBsc24;
		Parameter Size = 16;
	}
	ScanMux sMuxsc24 SelectedBy SCBsc24.DO {
		1'b0 : sMuxsc23;
		1'b1 : sc24.SO;
	}
	/* Scan Register 25*/
	Instance SCBsc25 Of SCB {
		InputPort SI = SCBsc24.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc25 Of SReg {
		InputPort SI = sMuxsc24;
		InputPort SEL = sel_SCBTop_SCBsc25;
		Parameter Size = 16;
	}
	ScanMux sMuxsc25 SelectedBy SCBsc25.DO {
		1'b0 : sMuxsc24;
		1'b1 : sc25.SO;
	}
	/* Scan Register 26*/
	Instance SCBsc26 Of SCB {
		InputPort SI = SCBsc25.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc26 Of SReg {
		InputPort SI = sMuxsc25;
		InputPort SEL = sel_SCBTop_SCBsc26;
		Parameter Size = 11;
	}
	ScanMux sMuxsc26 SelectedBy SCBsc26.DO {
		1'b0 : sMuxsc25;
		1'b1 : sc26.SO;
	}
	/* Scan Register 27*/
	Instance SCBsc27 Of SCB {
		InputPort SI = SCBsc26.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc27 Of SReg {
		InputPort SI = sMuxsc26;
		InputPort SEL = sel_SCBTop_SCBsc27;
		Parameter Size = 9;
	}
	ScanMux sMuxsc27 SelectedBy SCBsc27.DO {
		1'b0 : sMuxsc26;
		1'b1 : sc27.SO;
	}
	/* Scan Register 28*/
	Instance SCBsc28 Of SCB {
		InputPort SI = SCBsc27.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc28 Of SReg {
		InputPort SI = sMuxsc27;
		InputPort SEL = sel_SCBTop_SCBsc28;
		Parameter Size = 8;
	}
	ScanMux sMuxsc28 SelectedBy SCBsc28.DO {
		1'b0 : sMuxsc27;
		1'b1 : sc28.SO;
	}
	/* Scan Register 29*/
	Instance SCBsc29 Of SCB {
		InputPort SI = SCBsc28.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc29 Of SReg {
		InputPort SI = sMuxsc28;
		InputPort SEL = sel_SCBTop_SCBsc29;
		Parameter Size = 8;
	}
	ScanMux sMuxsc29 SelectedBy SCBsc29.DO {
		1'b0 : sMuxsc28;
		1'b1 : sc29.SO;
	}
	
	Instance SCBM3 Of SCB {
        InputPort SI = SCBsc29.SO;
        InputPort SEL = sel_nSCBTop;
    }
    Instance m3 Of EmptyModule_NoBidirs  {
        InputPort SI = sMuxsc29; 
        Parameter inputs = 37;
        Parameter outputs = 25;
        InputPort SEL = sel_SCBTop_SCBM3;
    }
    LogicSignal sel_SCBTop_SCBM3 {
        SEL & SCBTop.DO & SCBM3.DO;
    }
    ScanMux sMuxM3 SelectedBy SCBM3.DO {
        1'b0 : sMuxsc29;
        1'b1 : m3;
    }
	
	Instance SCBM4 Of SCB {
        InputPort SI = SCBM3.SO;
        InputPort SEL = sel_nSCBTop;
    }
    Instance m4 Of EmptyModule_NoBidirs  {
        InputPort SI = sMuxM3; 
        Parameter inputs = 38;
        Parameter outputs = 25;
        InputPort SEL = sel_SCBTop_SCBM4;
    }
    LogicSignal sel_SCBTop_SCBM4 {
        SEL & SCBTop.DO & SCBM4.DO;
    }
    ScanMux sMuxM4 SelectedBy SCBM4.DO {
        1'b0 : sMuxM3;
        1'b1 : m4;
    }
	
	Instance SCBM5 Of SCB {
        InputPort SI = SCBM4.SO;
        InputPort SEL = sel_nSCBTop;
    }
    Instance m5 Of EmptyModule_NoBidirs  {
        InputPort SI = sMuxM4; 
        Parameter inputs = 62;
        Parameter outputs = 25;
        InputPort SEL = sel_SCBTop_SCBM5;
    }
    LogicSignal sel_SCBTop_SCBM5 {
        SEL & SCBTop.DO & SCBM5.DO;
    }
    ScanMux sMuxM5 SelectedBy SCBM5.DO {
        1'b0 : sMuxM4;
        1'b1 : m5;
    }
	
	Instance SCBM6 Of SCB {
        InputPort SI = SCBM5.SO;
        InputPort SEL = sel_nSCBTop;
    }
    Instance m6 Of EmptyModule_NoBidirs  {
        InputPort SI = sMuxM5; 
        Parameter inputs = 11;
        Parameter outputs = 8;
        InputPort SEL = sel_SCBTop_SCBM6;
    }
    LogicSignal sel_SCBTop_SCBM6 {
        SEL & SCBTop.DO & SCBM6.DO;
    }
    ScanMux sMuxM6 SelectedBy SCBM6.DO {
        1'b0 : sMuxM5;
        1'b1 : m6;
    }
	
	Instance SCBM7 Of SCB {
        InputPort SI = SCBM6.SO;
        InputPort SEL = sel_nSCBTop;
    }
    Instance m7 Of EmptyModule_NoBidirs  {
        InputPort SI = sMuxM6; 
        Parameter inputs = 9;
        Parameter outputs = 8;
        InputPort SEL = sel_SCBTop_SCBM7;
    }
    LogicSignal sel_SCBTop_SCBM7 {
        SEL & SCBTop.DO & SCBM7.DO;
    }
    ScanMux sMuxM7 SelectedBy SCBM7.DO {
        1'b0 : sMuxM6;
        1'b1 : m7;
    }
	
	Instance SCBM8 Of SCB {
        InputPort SI = SCBM7.SO;
        InputPort SEL = sel_nSCBTop;
    }
    Instance m8 Of EmptyModule_NoBidirs  {
        InputPort SI = sMuxM7; 
        Parameter inputs = 46;
        Parameter outputs = 17;
        InputPort SEL = sel_SCBTop_SCBM8;
    }
    LogicSignal sel_SCBTop_SCBM8 {
        SEL & SCBTop.DO & SCBM8.DO;
    }
    ScanMux sMuxM8 SelectedBy SCBM8.DO {
        1'b0 : sMuxM7;
        1'b1 : m8;
    }
	
	Instance SCBM9 Of SCB {
        InputPort SI = SCBM8.SO;
        InputPort SEL = sel_nSCBTop;
    }
    Instance m9 Of EmptyModule_NoBidirs  {
        InputPort SI = sMuxM8; 
        Parameter inputs = 41;
        Parameter outputs = 33;
        InputPort SEL = sel_SCBTop_SCBM9;
    }
    LogicSignal sel_SCBTop_SCBM9 {
        SEL & SCBTop.DO & SCBM9.DO;
    }
    ScanMux sMuxM9 SelectedBy SCBM9.DO {
        1'b0 : sMuxM8;
        1'b1 : m9;
    }
	ScanMux sMuxTop SelectedBy SCBTop.DO {
		1'b0 : SCBM9.SO;
		1'b1 : sMuxM9;
	}
}


/* Module 10 Level 1 Inputs 129 Outputs 207 Bidirs 0 ScanChains 19 : 519 501 501 480 438 429 393 362 286 276 268 64 54 36 36 28 24 20 16*/
Module M10 {
	Attribute lic = 'h e7c3a535;
	Parameter inputs = 129;
	Parameter outputs = 207;
	Parameter bidirs = 0;
	ScanInPort SI;
	ScanOutPort SO {
		Source sMuxTop;
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

	LogicSignal sel_nSCBTop {
		SEL & ~SCBTop.DO;
	}
	
	LogicSignal sel_SCBTop_SCBIn {
        SEL & SCBTop.DO & sMuxInputs.DO;
    }
    LogicSignal sel_SCBTop_SCBOut {
        SEL & SCBTop.DO & sMuxOutputs.DO;
    }
	
	LogicSignal sel_SCBTop_SCBsc1 {
		SEL & SCBTop.DO & SCBsc1.DO;
	}
	LogicSignal sel_SCBTop_SCBsc2 {
		SEL & SCBTop.DO & SCBsc2.DO;
	}
	LogicSignal sel_SCBTop_SCBsc3 {
		SEL & SCBTop.DO & SCBsc3.DO;
	}
	LogicSignal sel_SCBTop_SCBsc4 {
		SEL & SCBTop.DO & SCBsc4.DO;
	}
	LogicSignal sel_SCBTop_SCBsc5 {
		SEL & SCBTop.DO & SCBsc5.DO;
	}
	LogicSignal sel_SCBTop_SCBsc6 {
		SEL & SCBTop.DO & SCBsc6.DO;
	}
	LogicSignal sel_SCBTop_SCBsc7 {
		SEL & SCBTop.DO & SCBsc7.DO;
	}
	LogicSignal sel_SCBTop_SCBsc8 {
		SEL & SCBTop.DO & SCBsc8.DO;
	}
	LogicSignal sel_SCBTop_SCBsc9 {
		SEL & SCBTop.DO & SCBsc9.DO;
	}
	LogicSignal sel_SCBTop_SCBsc10 {
		SEL & SCBTop.DO & SCBsc10.DO;
	}
	LogicSignal sel_SCBTop_SCBsc11 {
		SEL & SCBTop.DO & SCBsc11.DO;
	}
	LogicSignal sel_SCBTop_SCBsc12 {
		SEL & SCBTop.DO & SCBsc12.DO;
	}
	LogicSignal sel_SCBTop_SCBsc13 {
		SEL & SCBTop.DO & SCBsc13.DO;
	}
	LogicSignal sel_SCBTop_SCBsc14 {
		SEL & SCBTop.DO & SCBsc14.DO;
	}
	LogicSignal sel_SCBTop_SCBsc15 {
		SEL & SCBTop.DO & SCBsc15.DO;
	}
	LogicSignal sel_SCBTop_SCBsc16 {
		SEL & SCBTop.DO & SCBsc16.DO;
	}
	LogicSignal sel_SCBTop_SCBsc17 {
		SEL & SCBTop.DO & SCBsc17.DO;
	}
	LogicSignal sel_SCBTop_SCBsc18 {
		SEL & SCBTop.DO & SCBsc18.DO;
	}
	LogicSignal sel_SCBTop_SCBsc19 {
		SEL & SCBTop.DO & SCBsc19.DO;
	}
	Instance SCBTop Of SCB {
		InputPort SI = SI;
		InputPort SEL = SEL;
	}
	Instance SCBIn Of SCB {
		InputPort SI = SCBTop.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance wrpIn Of SReg {
		InputPort SI = SCBTop.SO;
		InputPort DI = DI;
		InputPort SEL = sel_SCBTop_SCBIn;
		Parameter Size = $inputs+$bidirs;
	}
	ScanMux sMuxInputs SelectedBy SCBIn.DO {
		1'b0 : SCBTop.SO;
		1'b1 : wrpIn;
	}
	Instance SCBOut Of SCB {
		InputPort SI = SCBIn.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance wrpOut Of SReg {
		InputPort SI = sMuxInputs;
		InputPort DI = toDO;
		InputPort SEL = sel_SCBTop_SCBOut;
		Parameter Size = $outputs+$bidirs;
	}
	ScanMux sMuxOutputs SelectedBy SCBOut.DO {
		1'b0 : sMuxInputs;
		1'b1 : wrpOut;
	}

	/*Scan Register 1*/
	Instance SCBsc1 Of SCB {
		InputPort SI = SCBOut.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc1 Of SReg {
		InputPort SI = sMuxOutputs;
		InputPort SEL = sel_SCBTop_SCBsc1;
		Parameter Size = 519;
	}
	ScanMux sMuxsc1 SelectedBy SCBsc1.DO {
		1'b0 : sMuxOutputs;
		1'b1 : sc1.SO;
	}

	/* Scan Register 2*/
	Instance SCBsc2 Of SCB {
		InputPort SI = SCBsc1.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc2 Of SReg {
		InputPort SI = sMuxsc1;
		InputPort SEL = sel_SCBTop_SCBsc2;
		Parameter Size = 501;
	}
	ScanMux sMuxsc2 SelectedBy SCBsc2.DO {
		1'b0 : sMuxsc1;
		1'b1 : sc2.SO;
	}
	/* Scan Register 3*/
	Instance SCBsc3 Of SCB {
		InputPort SI = SCBsc2.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc3 Of SReg {
		InputPort SI = sMuxsc2;
		InputPort SEL = sel_SCBTop_SCBsc3;
		Parameter Size = 501;
	}
	ScanMux sMuxsc3 SelectedBy SCBsc3.DO {
		1'b0 : sMuxsc2;
		1'b1 : sc3.SO;
	}
	/* Scan Register 4*/
	Instance SCBsc4 Of SCB {
		InputPort SI = SCBsc3.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc4 Of SReg {
		InputPort SI = sMuxsc3;
		InputPort SEL = sel_SCBTop_SCBsc4;
		Parameter Size = 480;
	}
	ScanMux sMuxsc4 SelectedBy SCBsc4.DO {
		1'b0 : sMuxsc3;
		1'b1 : sc4.SO;
	}
	/* Scan Register 5*/
	Instance SCBsc5 Of SCB {
		InputPort SI = SCBsc4.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc5 Of SReg {
		InputPort SI = sMuxsc4;
		InputPort SEL = sel_SCBTop_SCBsc5;
		Parameter Size = 438;
	}
	ScanMux sMuxsc5 SelectedBy SCBsc5.DO {
		1'b0 : sMuxsc4;
		1'b1 : sc5.SO;
	}
	/* Scan Register 6*/
	Instance SCBsc6 Of SCB {
		InputPort SI = SCBsc5.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc6 Of SReg {
		InputPort SI = sMuxsc5;
		InputPort SEL = sel_SCBTop_SCBsc6;
		Parameter Size = 429;
	}
	ScanMux sMuxsc6 SelectedBy SCBsc6.DO {
		1'b0 : sMuxsc5;
		1'b1 : sc6.SO;
	}
	/* Scan Register 7*/
	Instance SCBsc7 Of SCB {
		InputPort SI = SCBsc6.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc7 Of SReg {
		InputPort SI = sMuxsc6;
		InputPort SEL = sel_SCBTop_SCBsc7;
		Parameter Size = 393;
	}
	ScanMux sMuxsc7 SelectedBy SCBsc7.DO {
		1'b0 : sMuxsc6;
		1'b1 : sc7.SO;
	}
	/* Scan Register 8*/
	Instance SCBsc8 Of SCB {
		InputPort SI = SCBsc7.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc8 Of SReg {
		InputPort SI = sMuxsc7;
		InputPort SEL = sel_SCBTop_SCBsc8;
		Parameter Size = 362;
	}
	ScanMux sMuxsc8 SelectedBy SCBsc8.DO {
		1'b0 : sMuxsc7;
		1'b1 : sc8.SO;
	}
	/* Scan Register 9*/
	Instance SCBsc9 Of SCB {
		InputPort SI = SCBsc8.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc9 Of SReg {
		InputPort SI = sMuxsc8;
		InputPort SEL = sel_SCBTop_SCBsc9;
		Parameter Size = 286;
	}
	ScanMux sMuxsc9 SelectedBy SCBsc9.DO {
		1'b0 : sMuxsc8;
		1'b1 : sc9.SO;
	}
	/* Scan Register 10*/
	Instance SCBsc10 Of SCB {
		InputPort SI = SCBsc9.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc10 Of SReg {
		InputPort SI = sMuxsc9;
		InputPort SEL = sel_SCBTop_SCBsc10;
		Parameter Size = 276;
	}
	ScanMux sMuxsc10 SelectedBy SCBsc10.DO {
		1'b0 : sMuxsc9;
		1'b1 : sc10.SO;
	}
	/* Scan Register 11*/
	Instance SCBsc11 Of SCB {
		InputPort SI = SCBsc10.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc11 Of SReg {
		InputPort SI = sMuxsc10;
		InputPort SEL = sel_SCBTop_SCBsc11;
		Parameter Size = 268;
	}
	ScanMux sMuxsc11 SelectedBy SCBsc11.DO {
		1'b0 : sMuxsc10;
		1'b1 : sc11.SO;
	}
	/* Scan Register 12*/
	Instance SCBsc12 Of SCB {
		InputPort SI = SCBsc11.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc12 Of SReg {
		InputPort SI = sMuxsc11;
		InputPort SEL = sel_SCBTop_SCBsc12;
		Parameter Size = 64;
	}
	ScanMux sMuxsc12 SelectedBy SCBsc12.DO {
		1'b0 : sMuxsc11;
		1'b1 : sc12.SO;
	}
	/* Scan Register 13*/
	Instance SCBsc13 Of SCB {
		InputPort SI = SCBsc12.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc13 Of SReg {
		InputPort SI = sMuxsc12;
		InputPort SEL = sel_SCBTop_SCBsc13;
		Parameter Size = 54;
	}
	ScanMux sMuxsc13 SelectedBy SCBsc13.DO {
		1'b0 : sMuxsc12;
		1'b1 : sc13.SO;
	}
	/* Scan Register 14*/
	Instance SCBsc14 Of SCB {
		InputPort SI = SCBsc13.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc14 Of SReg {
		InputPort SI = sMuxsc13;
		InputPort SEL = sel_SCBTop_SCBsc14;
		Parameter Size = 36;
	}
	ScanMux sMuxsc14 SelectedBy SCBsc14.DO {
		1'b0 : sMuxsc13;
		1'b1 : sc14.SO;
	}
	/* Scan Register 15*/
	Instance SCBsc15 Of SCB {
		InputPort SI = SCBsc14.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc15 Of SReg {
		InputPort SI = sMuxsc14;
		InputPort SEL = sel_SCBTop_SCBsc15;
		Parameter Size = 36;
	}
	ScanMux sMuxsc15 SelectedBy SCBsc15.DO {
		1'b0 : sMuxsc14;
		1'b1 : sc15.SO;
	}
	/* Scan Register 16*/
	Instance SCBsc16 Of SCB {
		InputPort SI = SCBsc15.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc16 Of SReg {
		InputPort SI = sMuxsc15;
		InputPort SEL = sel_SCBTop_SCBsc16;
		Parameter Size = 28;
	}
	ScanMux sMuxsc16 SelectedBy SCBsc16.DO {
		1'b0 : sMuxsc15;
		1'b1 : sc16.SO;
	}
	/* Scan Register 17*/
	Instance SCBsc17 Of SCB {
		InputPort SI = SCBsc16.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc17 Of SReg {
		InputPort SI = sMuxsc16;
		InputPort SEL = sel_SCBTop_SCBsc17;
		Parameter Size = 24;
	}
	ScanMux sMuxsc17 SelectedBy SCBsc17.DO {
		1'b0 : sMuxsc16;
		1'b1 : sc17.SO;
	}
	/* Scan Register 18*/
	Instance SCBsc18 Of SCB {
		InputPort SI = SCBsc17.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc18 Of SReg {
		InputPort SI = sMuxsc17;
		InputPort SEL = sel_SCBTop_SCBsc18;
		Parameter Size = 20;
	}
	ScanMux sMuxsc18 SelectedBy SCBsc18.DO {
		1'b0 : sMuxsc17;
		1'b1 : sc18.SO;
	}
	/* Scan Register 19*/
	Instance SCBsc19 Of SCB {
		InputPort SI = SCBsc18.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc19 Of SReg {
		InputPort SI = sMuxsc18;
		InputPort SEL = sel_SCBTop_SCBsc19;
		Parameter Size = 16;
	}
	ScanMux sMuxsc19 SelectedBy SCBsc19.DO {
		1'b0 : sMuxsc18;
		1'b1 : sc19.SO;
	}
	
	Instance SCBM11 Of SCB {
        InputPort SI = SCBsc19.SO;
        InputPort SEL = sel_nSCBTop;
    }
    Instance m11 Of EmptyModule_NoBidirs  {
        InputPort SI = sMuxsc19; 
        Parameter inputs = 23;
        Parameter outputs = 8;
        InputPort SEL = sel_SCBTop_SCBM11;
    }
    LogicSignal sel_SCBTop_SCBM11 {
        SEL & SCBTop.DO & SCBM11.DO;
    }
    ScanMux sMuxM11 SelectedBy SCBM11.DO {
        1'b0 : sMuxsc19;
        1'b1 : m11;
    }
	
	Instance SCBM12 Of SCB {
        InputPort SI = SCBM11.SO;
        InputPort SEL = sel_nSCBTop;
    }
    Instance m12 Of EmptyModule_NoBidirs  {
        InputPort SI = sMuxM11; 
        Parameter inputs = 7;
        Parameter outputs = 4;
        InputPort SEL = sel_SCBTop_SCBM12;
    }
    LogicSignal sel_SCBTop_SCBM12 {
        SEL & SCBTop.DO & SCBM12.DO;
    }
    ScanMux sMuxM12 SelectedBy SCBM12.DO {
        1'b0 : sMuxM11;
        1'b1 : m12;
    }
	
	Instance SCBM13 Of SCB {
        InputPort SI = SCBM12.SO;
        InputPort SEL = sel_nSCBTop;
    }
    Instance m13 Of EmptyModule_NoBidirs  {
        InputPort SI = sMuxM12; 
        Parameter inputs = 12;
        Parameter outputs = 16;
        InputPort SEL = sel_SCBTop_SCBM13;
    }
    LogicSignal sel_SCBTop_SCBM13 {
        SEL & SCBTop.DO & SCBM13.DO;
    }
    ScanMux sMuxM13 SelectedBy SCBM13.DO {
        1'b0 : sMuxM12;
        1'b1 : m13;
    }
	
	Instance SCBM14 Of SCB {
        InputPort SI = SCBM13.SO;
        InputPort SEL = sel_nSCBTop;
    }
    Instance m14 Of EmptyModule_NoBidirs  {
        InputPort SI = sMuxM13; 
        Parameter inputs = 11;
        Parameter outputs = 8;
        InputPort SEL = sel_SCBTop_SCBM14;
    }
    LogicSignal sel_SCBTop_SCBM14 {
        SEL & SCBTop.DO & SCBM14.DO;
    }
    ScanMux sMuxM14 SelectedBy SCBM14.DO {
        1'b0 : sMuxM13;
        1'b1 : m14;
    }
	
	Instance SCBM15 Of SCB {
        InputPort SI = SCBM14.SO;
        InputPort SEL = sel_nSCBTop;
    }
    Instance m15 Of EmptyModule_NoBidirs  {
        InputPort SI = sMuxM14; 
        Parameter inputs = 22;
        Parameter outputs = 8;
        InputPort SEL = sel_SCBTop_SCBM15;
    }
    LogicSignal sel_SCBTop_SCBM15 {
        SEL & SCBTop.DO & SCBM15.DO;
    }
    ScanMux sMuxM15 SelectedBy SCBM15.DO {
        1'b0 : sMuxM14;
        1'b1 : m15;
    }
	
	Instance SCBM16 Of SCB {
        InputPort SI = SCBM15.SO;
        InputPort SEL = sel_nSCBTop;
    }
    Instance m16 Of EmptyModule_NoBidirs  {
        InputPort SI = sMuxM15; 
        Parameter inputs = 7;
        Parameter outputs = 7;
        InputPort SEL = sel_SCBTop_SCBM16;
    }
    LogicSignal sel_SCBTop_SCBM16 {
        SEL & SCBTop.DO & SCBM16.DO;
    }
    ScanMux sMuxM16 SelectedBy SCBM16.DO {
        1'b0 : sMuxM15;
        1'b1 : m16;
    }
	
	Instance SCBM17 Of SCB {
        InputPort SI = SCBM16.SO;
        InputPort SEL = sel_nSCBTop;
    }
    Instance m17 Of EmptyModule_NoBidirs  {
        InputPort SI = sMuxM16; 
        Parameter inputs = 15;
        Parameter outputs = 4;
        InputPort SEL = sel_SCBTop_SCBM17;
    }
    LogicSignal sel_SCBTop_SCBM17 {
        SEL & SCBTop.DO & SCBM17.DO;
    }
    ScanMux sMuxM17 SelectedBy SCBM17.DO {
        1'b0 : sMuxM16;
        1'b1 : m17;
    }
	ScanMux sMuxTop SelectedBy SCBTop.DO {
		1'b0 : SCBM16.SO;
		1'b1 : sMuxM16;
	}
	
}


/* Module 18 Level 1 Inputs 175 Outputs 212 Bidirs 0 ScanChains 14 : 729 697 671 645 635 556 515 502 350 316 285 253 203 198*/
Module M18 {
	Attribute lic = 'h 2bd24002;
	Parameter inputs = 175;
	Parameter outputs = 212;
	Parameter bidirs = 0;
	ScanInPort SI;
	ScanOutPort SO {
		Source sMuxTop;
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

	LogicSignal sel_nSCBTop {
		SEL & ~SCBTop.DO;
	}
	
	LogicSignal sel_SCBTop_SCBIn {
        SEL & SCBTop.DO & sMuxInputs.DO;
    }
    LogicSignal sel_SCBTop_SCBOut {
        SEL & SCBTop.DO & sMuxOutputs.DO;
    }
	
	LogicSignal sel_SCBTop_SCBsc1 {
		SEL & SCBTop.DO & SCBsc1.DO;
	}
	LogicSignal sel_SCBTop_SCBsc2 {
		SEL & SCBTop.DO & SCBsc2.DO;
	}
	LogicSignal sel_SCBTop_SCBsc3 {
		SEL & SCBTop.DO & SCBsc3.DO;
	}
	LogicSignal sel_SCBTop_SCBsc4 {
		SEL & SCBTop.DO & SCBsc4.DO;
	}
	LogicSignal sel_SCBTop_SCBsc5 {
		SEL & SCBTop.DO & SCBsc5.DO;
	}
	LogicSignal sel_SCBTop_SCBsc6 {
		SEL & SCBTop.DO & SCBsc6.DO;
	}
	LogicSignal sel_SCBTop_SCBsc7 {
		SEL & SCBTop.DO & SCBsc7.DO;
	}
	LogicSignal sel_SCBTop_SCBsc8 {
		SEL & SCBTop.DO & SCBsc8.DO;
	}
	LogicSignal sel_SCBTop_SCBsc9 {
		SEL & SCBTop.DO & SCBsc9.DO;
	}
	LogicSignal sel_SCBTop_SCBsc10 {
		SEL & SCBTop.DO & SCBsc10.DO;
	}
	LogicSignal sel_SCBTop_SCBsc11 {
		SEL & SCBTop.DO & SCBsc11.DO;
	}
	LogicSignal sel_SCBTop_SCBsc12 {
		SEL & SCBTop.DO & SCBsc12.DO;
	}
	LogicSignal sel_SCBTop_SCBsc13 {
		SEL & SCBTop.DO & SCBsc13.DO;
	}
	LogicSignal sel_SCBTop_SCBsc14 {
		SEL & SCBTop.DO & SCBsc14.DO;
	}
	Instance SCBTop Of SCB {
		InputPort SI = SI;
		InputPort SEL = SEL;
	}
	Instance SCBIn Of SCB {
		InputPort SI = SCBTop.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance wrpIn Of SReg {
		InputPort SI = SCBTop.SO;
		InputPort DI = DI;
		InputPort SEL = sel_SCBTop_SCBIn;
		Parameter Size = $inputs+$bidirs;
	}
	ScanMux sMuxInputs SelectedBy SCBIn.DO {
		1'b0 : SCBTop.SO;
		1'b1 : wrpIn;
	}
	Instance SCBOut Of SCB {
		InputPort SI = SCBIn.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance wrpOut Of SReg {
		InputPort SI = sMuxInputs;
		InputPort DI = toDO;
		InputPort SEL = sel_SCBTop_SCBOut;
		Parameter Size = $outputs+$bidirs;
	}
	ScanMux sMuxOutputs SelectedBy SCBOut.DO {
		1'b0 : sMuxInputs;
		1'b1 : wrpOut;
	}

	/*Scan Register 1*/
	Instance SCBsc1 Of SCB {
		InputPort SI = SCBOut.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc1 Of SReg {
		InputPort SI = sMuxOutputs;
		InputPort SEL = sel_SCBTop_SCBsc1;
		Parameter Size = 729;
	}
	ScanMux sMuxsc1 SelectedBy SCBsc1.DO {
		1'b0 : sMuxOutputs;
		1'b1 : sc1.SO;
	}

	/* Scan Register 2*/
	Instance SCBsc2 Of SCB {
		InputPort SI = SCBsc1.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc2 Of SReg {
		InputPort SI = sMuxsc1;
		InputPort SEL = sel_SCBTop_SCBsc2;
		Parameter Size = 697;
	}
	ScanMux sMuxsc2 SelectedBy SCBsc2.DO {
		1'b0 : sMuxsc1;
		1'b1 : sc2.SO;
	}
	/* Scan Register 3*/
	Instance SCBsc3 Of SCB {
		InputPort SI = SCBsc2.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc3 Of SReg {
		InputPort SI = sMuxsc2;
		InputPort SEL = sel_SCBTop_SCBsc3;
		Parameter Size = 671;
	}
	ScanMux sMuxsc3 SelectedBy SCBsc3.DO {
		1'b0 : sMuxsc2;
		1'b1 : sc3.SO;
	}
	/* Scan Register 4*/
	Instance SCBsc4 Of SCB {
		InputPort SI = SCBsc3.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc4 Of SReg {
		InputPort SI = sMuxsc3;
		InputPort SEL = sel_SCBTop_SCBsc4;
		Parameter Size = 645;
	}
	ScanMux sMuxsc4 SelectedBy SCBsc4.DO {
		1'b0 : sMuxsc3;
		1'b1 : sc4.SO;
	}
	/* Scan Register 5*/
	Instance SCBsc5 Of SCB {
		InputPort SI = SCBsc4.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc5 Of SReg {
		InputPort SI = sMuxsc4;
		InputPort SEL = sel_SCBTop_SCBsc5;
		Parameter Size = 635;
	}
	ScanMux sMuxsc5 SelectedBy SCBsc5.DO {
		1'b0 : sMuxsc4;
		1'b1 : sc5.SO;
	}
	/* Scan Register 6*/
	Instance SCBsc6 Of SCB {
		InputPort SI = SCBsc5.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc6 Of SReg {
		InputPort SI = sMuxsc5;
		InputPort SEL = sel_SCBTop_SCBsc6;
		Parameter Size = 556;
	}
	ScanMux sMuxsc6 SelectedBy SCBsc6.DO {
		1'b0 : sMuxsc5;
		1'b1 : sc6.SO;
	}
	/* Scan Register 7*/
	Instance SCBsc7 Of SCB {
		InputPort SI = SCBsc6.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc7 Of SReg {
		InputPort SI = sMuxsc6;
		InputPort SEL = sel_SCBTop_SCBsc7;
		Parameter Size = 515;
	}
	ScanMux sMuxsc7 SelectedBy SCBsc7.DO {
		1'b0 : sMuxsc6;
		1'b1 : sc7.SO;
	}
	/* Scan Register 8*/
	Instance SCBsc8 Of SCB {
		InputPort SI = SCBsc7.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc8 Of SReg {
		InputPort SI = sMuxsc7;
		InputPort SEL = sel_SCBTop_SCBsc8;
		Parameter Size = 502;
	}
	ScanMux sMuxsc8 SelectedBy SCBsc8.DO {
		1'b0 : sMuxsc7;
		1'b1 : sc8.SO;
	}
	/* Scan Register 9*/
	Instance SCBsc9 Of SCB {
		InputPort SI = SCBsc8.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc9 Of SReg {
		InputPort SI = sMuxsc8;
		InputPort SEL = sel_SCBTop_SCBsc9;
		Parameter Size = 350;
	}
	ScanMux sMuxsc9 SelectedBy SCBsc9.DO {
		1'b0 : sMuxsc8;
		1'b1 : sc9.SO;
	}
	/* Scan Register 10*/
	Instance SCBsc10 Of SCB {
		InputPort SI = SCBsc9.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc10 Of SReg {
		InputPort SI = sMuxsc9;
		InputPort SEL = sel_SCBTop_SCBsc10;
		Parameter Size = 316;
	}
	ScanMux sMuxsc10 SelectedBy SCBsc10.DO {
		1'b0 : sMuxsc9;
		1'b1 : sc10.SO;
	}
	/* Scan Register 11*/
	Instance SCBsc11 Of SCB {
		InputPort SI = SCBsc10.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc11 Of SReg {
		InputPort SI = sMuxsc10;
		InputPort SEL = sel_SCBTop_SCBsc11;
		Parameter Size = 285;
	}
	ScanMux sMuxsc11 SelectedBy SCBsc11.DO {
		1'b0 : sMuxsc10;
		1'b1 : sc11.SO;
	}
	/* Scan Register 12*/
	Instance SCBsc12 Of SCB {
		InputPort SI = SCBsc11.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc12 Of SReg {
		InputPort SI = sMuxsc11;
		InputPort SEL = sel_SCBTop_SCBsc12;
		Parameter Size = 253;
	}
	ScanMux sMuxsc12 SelectedBy SCBsc12.DO {
		1'b0 : sMuxsc11;
		1'b1 : sc12.SO;
	}
	/* Scan Register 13*/
	Instance SCBsc13 Of SCB {
		InputPort SI = SCBsc12.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc13 Of SReg {
		InputPort SI = sMuxsc12;
		InputPort SEL = sel_SCBTop_SCBsc13;
		Parameter Size = 203;
	}
	ScanMux sMuxsc13 SelectedBy SCBsc13.DO {
		1'b0 : sMuxsc12;
		1'b1 : sc13.SO;
	}
	/* Scan Register 14*/
	Instance SCBsc14 Of SCB {
		InputPort SI = SCBsc13.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc14 Of SReg {
		InputPort SI = sMuxsc13;
		InputPort SEL = sel_SCBTop_SCBsc14;
		Parameter Size = 198;
	}
	ScanMux sMuxsc14 SelectedBy SCBsc14.DO {
		1'b0 : sMuxsc13;
		1'b1 : sc14.SO;
	}
	
	Instance SCBM19 Of SCB {
        InputPort SI = SCBsc14.SO;
        InputPort SEL = sel_nSCBTop;
    }
    Instance m19 Of EmptyModule_NoBidirs  {
        InputPort SI = sMuxsc14; 
        Parameter inputs = 62;
        Parameter outputs = 25;
        InputPort SEL = sel_SCBTop_SCBM19;
    }
    LogicSignal sel_SCBTop_SCBM19 {
        SEL & SCBTop.DO & SCBM19.DO;
    }
    ScanMux sMuxM19 SelectedBy SCBM19.DO {
        1'b0 : sMuxsc14;
        1'b1 : m19;
    }
	
	ScanMux sMuxTop SelectedBy SCBTop.DO {
		1'b0 : SCBM19.SO;
		1'b1 : sMuxM19;
	}
}
