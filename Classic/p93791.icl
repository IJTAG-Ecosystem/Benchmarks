/*
* Copyright Testonica Lab (C) 2016
*
* History:
* -------------+------------+-------------------------+------------------------
*   Version    |  Date      | Author                  | Organization
* -------------+------------+-------------------------+------------------------
*          1.0 | 10.05.2016 | Anton Tsertov           | Testonica Lab
*--------------+------------+-------------------------+------------------------
*
* CLASSIC benchmark based on ITC'02 p93791 and ScanMux Control Bit (SCB) network 
* design strategy.
*
* Uses modules from files: 
* - Instruments.icl
* - NetworkStructs.icl
* - EmptyModule.icl
*/

NameSpace p93791;
UseNameSpace root;

Module M0 {
    Attribute lic = 'h c6c35928;
    Parameter inputs = 103;
    Parameter outputs = 32;
    Parameter bidirs = 72;

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
    LogicSignal sel_SCBTop_SCBM4 {
        SEL & SCBTop.DO & SCBM4.DO;
    }
    LogicSignal sel_SCBTop_SCBM5 {
        SEL & SCBTop.DO & SCBM5.DO;
    }
    LogicSignal sel_SCBTop_SCBM6 {
        SEL & SCBTop.DO & SCBM6.DO;
    }
    LogicSignal sel_SCBTop_SCBM11 {
        SEL & SCBTop.DO & SCBM11.DO;
    }
	LogicSignal sel_SCBTop_SCBM12 {
        SEL & SCBTop.DO & SCBM12.DO;
    }
	LogicSignal sel_SCBTop_SCBM13 {
        SEL & SCBTop.DO & SCBM13.DO;
    }
	LogicSignal sel_SCBTop_SCBM14 {
        SEL & SCBTop.DO & SCBM14.DO;
    }
	LogicSignal sel_SCBTop_SCBM17 {
        SEL & SCBTop.DO & SCBM17.DO;
    }
	LogicSignal sel_SCBTop_SCBM19 {
        SEL & SCBTop.DO & SCBM19.DO;
    }
	LogicSignal sel_SCBTop_SCBM20 {
        SEL & SCBTop.DO & SCBM20.DO;
    }
	LogicSignal sel_SCBTop_SCBM23 {
        SEL & SCBTop.DO & SCBM23.DO;
    }
	LogicSignal sel_SCBTop_SCBM27 {
        SEL & SCBTop.DO & SCBM27.DO;
    }
	LogicSignal sel_SCBTop_SCBM29 {
        SEL & SCBTop.DO & SCBM29.DO;
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
    Instance m1 Of p93791::M1 {
        InputPort SI = sMuxOutputs; 
        InputPort SEL = sel_SCBTop_SCBM1;
    }
   
    ScanMux sMuxM1 SelectedBy SCBM1.DO {
        1'b0 : sMuxOutputs;
        1'b1 : m1;
    }
    
    Instance SCBM4 Of SCB {
        InputPort SI = SCBM1.SO;
        InputPort SEL = sel_nSCBTop;
    }
    Instance m4 Of p93791::M4 {
        InputPort SI = sMuxM1;
        InputPort SEL = sel_SCBTop_SCBM4; 
    }
    ScanMux sMuxM4 SelectedBy SCBM4.DO {
        1'b0 : sMuxM1;
        1'b1 : m4;
    }
    
	Instance SCBM5 Of SCB {
        InputPort SI = SCBM4.SO;
        InputPort SEL = sel_nSCBTop;
    }
    Instance m5 Of EmptyModule  {
        InputPort SI = sMuxM4; 
        Parameter inputs = 102;
        Parameter outputs = 80;
		Parameter bidirs = 66;
        InputPort SEL = sel_SCBTop_SCBM5;
    }
    
    ScanMux sMuxM5 SelectedBy SCBM5.DO {
        1'b0 : sMuxM4;
        1'b1 : m5;
    }
	
    Instance SCBM6 Of SCB {
        InputPort SI = SCBM5.SO;
        InputPort SEL = sel_nSCBTop;
    }
    Instance m6 Of p93791::M6  {
        InputPort SI = sMuxM5; 
        InputPort SEL = sel_SCBTop_SCBM6;
    }
    
    ScanMux sMuxM6 SelectedBy SCBM6.DO {
        1'b0 : sMuxM5;
        1'b1 : m6;
    }
    
	Instance SCBM11 Of SCB {
        InputPort SI = SCBM6.SO;
        InputPort SEL = sel_nSCBTop;
    }
    Instance m11 Of p93791::M11  {
        InputPort SI = sMuxM6; 
		InputPort SEL = sel_SCBTop_SCBM11;
    }
    
    ScanMux sMuxM11 SelectedBy SCBM11.DO {
        1'b0 : sMuxM6;
        1'b1 : m11;
    }
    
	Instance SCBM12 Of SCB {
        InputPort SI = SCBM11.SO;
        InputPort SEL = sel_nSCBTop;
    }
    Instance m12 Of p93791::M12  {
        InputPort SI = sMuxM11; 
		InputPort SEL = sel_SCBTop_SCBM12;
    }
    
    ScanMux sMuxM12 SelectedBy SCBM12.DO {
        1'b0 : sMuxM11;
        1'b1 : m12;
    }
	
	Instance SCBM13 Of SCB {
        InputPort SI = SCBM12.SO;
        InputPort SEL = sel_nSCBTop;
    }
    Instance m13 Of p93791::M13  {
        InputPort SI = sMuxM12; 
		InputPort SEL = sel_SCBTop_SCBM13;
    }
    
    ScanMux sMuxM13 SelectedBy SCBM13.DO {
        1'b0 : sMuxM12;
        1'b1 : m13;
    }
	
	Instance SCBM14 Of SCB {
        InputPort SI = SCBM13.SO;
        InputPort SEL = sel_nSCBTop;
    }
    Instance m14 Of p93791::M14  {
        InputPort SI = sMuxM13; 
		InputPort SEL = sel_SCBTop_SCBM14;
    }
    
    ScanMux sMuxM14 SelectedBy SCBM14.DO {
        1'b0 : sMuxM13;
        1'b1 : m14;
    }
	
	Instance SCBM17 Of SCB {
        InputPort SI = SCBM14.SO;
        InputPort SEL = sel_nSCBTop;
    }
    Instance m17 Of p93791::M17  {
        InputPort SI = sMuxM14; 
		InputPort SEL = sel_SCBTop_SCBM17;
    }
    
    ScanMux sMuxM17 SelectedBy SCBM17.DO {
        1'b0 : sMuxM14;
        1'b1 : m17;
    }
	
	Instance SCBM19 Of SCB {
        InputPort SI = SCBM17.SO;
        InputPort SEL = sel_nSCBTop;
    }
    Instance m19 Of p93791::M19  {
        InputPort SI = sMuxM17; 
		InputPort SEL = sel_SCBTop_SCBM19;
    }
    
    ScanMux sMuxM19 SelectedBy SCBM19.DO {
        1'b0 : sMuxM17;
        1'b1 : m19;
    }
	
	Instance SCBM20 Of SCB {
        InputPort SI = SCBM19.SO;
        InputPort SEL = sel_nSCBTop;
    }
    Instance m20 Of p93791::M20  {
        InputPort SI = sMuxM19; 
		InputPort SEL = sel_SCBTop_SCBM20;
    }
    
    ScanMux sMuxM20 SelectedBy SCBM20.DO {
        1'b0 : sMuxM19;
        1'b1 : m20;
    }
	
	Instance SCBM23 Of SCB {
        InputPort SI = SCBM20.SO;
        InputPort SEL = sel_nSCBTop;
    }
    Instance m23 Of p93791::M23  {
        InputPort SI = sMuxM20; 
		InputPort SEL = sel_SCBTop_SCBM23;
    }
    
    ScanMux sMuxM23 SelectedBy SCBM23.DO {
        1'b0 : sMuxM20;
        1'b1 : m23;
    }
	
	Instance SCBM27 Of SCB {
        InputPort SI = SCBM23.SO;
        InputPort SEL = sel_nSCBTop;
    }
    Instance m27 Of p93791::M27  {
        InputPort SI = sMuxM23; 
		InputPort SEL = sel_SCBTop_SCBM27;
    }
    
    ScanMux sMuxM27 SelectedBy SCBM27.DO {
        1'b0 : sMuxM23;
        1'b1 : m27;
    }
	
	Instance SCBM29 Of SCB {
        InputPort SI = SCBM27.SO;
        InputPort SEL = sel_nSCBTop;
    }
    Instance m29 Of p93791::M29  {
        InputPort SI = sMuxM27; 
		InputPort SEL = sel_SCBTop_SCBM29;
    }
    
    ScanMux sMuxM29 SelectedBy SCBM29.DO {
        1'b0 : sMuxM27;
        1'b1 : m29;
    }
    ScanMux sMuxTop SelectedBy SCBTop.DO {
        1'b0 : SCBM29.SO;
        1'b1 : sMuxM29;
    }
}

/* Module 1 Level 1 Inputs 109 Outputs 32 Bidirs 72 ScanChains 46 : 168 168 166 166 163 163 163 163 162 162 162 162 151 151 151 151 151 151 150 146 146 146 146 146 146 146 146 146 146 146 146 146 146 146 146 146 146 145 145 145 145 143 143 141 141 1*/
Module M1 {
	Attribute lic = 'h c62fd0e;
	Parameter inputs = 109;
	Parameter outputs = 32;
	Parameter bidirs = 72;
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
	LogicSignal sel_SCBTop_SCBsc30 {
		SEL & SCBTop.DO & SCBsc30.DO;
	}
	LogicSignal sel_SCBTop_SCBsc31 {
		SEL & SCBTop.DO & SCBsc31.DO;
	}
	LogicSignal sel_SCBTop_SCBsc32 {
		SEL & SCBTop.DO & SCBsc32.DO;
	}
	LogicSignal sel_SCBTop_SCBsc33 {
		SEL & SCBTop.DO & SCBsc33.DO;
	}
	LogicSignal sel_SCBTop_SCBsc34 {
		SEL & SCBTop.DO & SCBsc34.DO;
	}
	LogicSignal sel_SCBTop_SCBsc35 {
		SEL & SCBTop.DO & SCBsc35.DO;
	}
	LogicSignal sel_SCBTop_SCBsc36 {
		SEL & SCBTop.DO & SCBsc36.DO;
	}
	LogicSignal sel_SCBTop_SCBsc37 {
		SEL & SCBTop.DO & SCBsc37.DO;
	}
	LogicSignal sel_SCBTop_SCBsc38 {
		SEL & SCBTop.DO & SCBsc38.DO;
	}
	LogicSignal sel_SCBTop_SCBsc39 {
		SEL & SCBTop.DO & SCBsc39.DO;
	}
	LogicSignal sel_SCBTop_SCBsc40 {
		SEL & SCBTop.DO & SCBsc40.DO;
	}
	LogicSignal sel_SCBTop_SCBsc41 {
		SEL & SCBTop.DO & SCBsc41.DO;
	}
	LogicSignal sel_SCBTop_SCBsc42 {
		SEL & SCBTop.DO & SCBsc42.DO;
	}
	LogicSignal sel_SCBTop_SCBsc43 {
		SEL & SCBTop.DO & SCBsc43.DO;
	}
	LogicSignal sel_SCBTop_SCBsc44 {
		SEL & SCBTop.DO & SCBsc44.DO;
	}
	LogicSignal sel_SCBTop_SCBsc45 {
		SEL & SCBTop.DO & SCBsc45.DO;
	}
	LogicSignal sel_SCBTop_SCBsc46 {
		SEL & SCBTop.DO & SCBsc46.DO;
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
		Parameter Size = 168;
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
		Parameter Size = 168;
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
		Parameter Size = 166;
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
		Parameter Size = 166;
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
		Parameter Size = 163;
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
		Parameter Size = 163;
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
		Parameter Size = 163;
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
		Parameter Size = 163;
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
		Parameter Size = 162;
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
		Parameter Size = 162;
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
		Parameter Size = 162;
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
		Parameter Size = 162;
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
		Parameter Size = 151;
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
		Parameter Size = 151;
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
		Parameter Size = 151;
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
		Parameter Size = 151;
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
		Parameter Size = 151;
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
		Parameter Size = 151;
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
		Parameter Size = 150;
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
		Parameter Size = 146;
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
		Parameter Size = 146;
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
		Parameter Size = 146;
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
		Parameter Size = 146;
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
		Parameter Size = 146;
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
		Parameter Size = 146;
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
		Parameter Size = 146;
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
		Parameter Size = 146;
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
		Parameter Size = 146;
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
		Parameter Size = 146;
	}
	ScanMux sMuxsc29 SelectedBy SCBsc29.DO {
		1'b0 : sMuxsc28;
		1'b1 : sc29.SO;
	}
	/* Scan Register 30*/
	Instance SCBsc30 Of SCB {
		InputPort SI = SCBsc29.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc30 Of SReg {
		InputPort SI = sMuxsc29;
		InputPort SEL = sel_SCBTop_SCBsc30;
		Parameter Size = 146;
	}
	ScanMux sMuxsc30 SelectedBy SCBsc30.DO {
		1'b0 : sMuxsc29;
		1'b1 : sc30.SO;
	}
	/* Scan Register 31*/
	Instance SCBsc31 Of SCB {
		InputPort SI = SCBsc30.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc31 Of SReg {
		InputPort SI = sMuxsc30;
		InputPort SEL = sel_SCBTop_SCBsc31;
		Parameter Size = 146;
	}
	ScanMux sMuxsc31 SelectedBy SCBsc31.DO {
		1'b0 : sMuxsc30;
		1'b1 : sc31.SO;
	}
	/* Scan Register 32*/
	Instance SCBsc32 Of SCB {
		InputPort SI = SCBsc31.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc32 Of SReg {
		InputPort SI = sMuxsc31;
		InputPort SEL = sel_SCBTop_SCBsc32;
		Parameter Size = 146;
	}
	ScanMux sMuxsc32 SelectedBy SCBsc32.DO {
		1'b0 : sMuxsc31;
		1'b1 : sc32.SO;
	}
	/* Scan Register 33*/
	Instance SCBsc33 Of SCB {
		InputPort SI = SCBsc32.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc33 Of SReg {
		InputPort SI = sMuxsc32;
		InputPort SEL = sel_SCBTop_SCBsc33;
		Parameter Size = 146;
	}
	ScanMux sMuxsc33 SelectedBy SCBsc33.DO {
		1'b0 : sMuxsc32;
		1'b1 : sc33.SO;
	}
	/* Scan Register 34*/
	Instance SCBsc34 Of SCB {
		InputPort SI = SCBsc33.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc34 Of SReg {
		InputPort SI = sMuxsc33;
		InputPort SEL = sel_SCBTop_SCBsc34;
		Parameter Size = 146;
	}
	ScanMux sMuxsc34 SelectedBy SCBsc34.DO {
		1'b0 : sMuxsc33;
		1'b1 : sc34.SO;
	}
	/* Scan Register 35*/
	Instance SCBsc35 Of SCB {
		InputPort SI = SCBsc34.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc35 Of SReg {
		InputPort SI = sMuxsc34;
		InputPort SEL = sel_SCBTop_SCBsc35;
		Parameter Size = 146;
	}
	ScanMux sMuxsc35 SelectedBy SCBsc35.DO {
		1'b0 : sMuxsc34;
		1'b1 : sc35.SO;
	}
	/* Scan Register 36*/
	Instance SCBsc36 Of SCB {
		InputPort SI = SCBsc35.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc36 Of SReg {
		InputPort SI = sMuxsc35;
		InputPort SEL = sel_SCBTop_SCBsc36;
		Parameter Size = 146;
	}
	ScanMux sMuxsc36 SelectedBy SCBsc36.DO {
		1'b0 : sMuxsc35;
		1'b1 : sc36.SO;
	}
	/* Scan Register 37*/
	Instance SCBsc37 Of SCB {
		InputPort SI = SCBsc36.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc37 Of SReg {
		InputPort SI = sMuxsc36;
		InputPort SEL = sel_SCBTop_SCBsc37;
		Parameter Size = 146;
	}
	ScanMux sMuxsc37 SelectedBy SCBsc37.DO {
		1'b0 : sMuxsc36;
		1'b1 : sc37.SO;
	}
	/* Scan Register 38*/
	Instance SCBsc38 Of SCB {
		InputPort SI = SCBsc37.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc38 Of SReg {
		InputPort SI = sMuxsc37;
		InputPort SEL = sel_SCBTop_SCBsc38;
		Parameter Size = 145;
	}
	ScanMux sMuxsc38 SelectedBy SCBsc38.DO {
		1'b0 : sMuxsc37;
		1'b1 : sc38.SO;
	}
	/* Scan Register 39*/
	Instance SCBsc39 Of SCB {
		InputPort SI = SCBsc38.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc39 Of SReg {
		InputPort SI = sMuxsc38;
		InputPort SEL = sel_SCBTop_SCBsc39;
		Parameter Size = 145;
	}
	ScanMux sMuxsc39 SelectedBy SCBsc39.DO {
		1'b0 : sMuxsc38;
		1'b1 : sc39.SO;
	}
	/* Scan Register 40*/
	Instance SCBsc40 Of SCB {
		InputPort SI = SCBsc39.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc40 Of SReg {
		InputPort SI = sMuxsc39;
		InputPort SEL = sel_SCBTop_SCBsc40;
		Parameter Size = 145;
	}
	ScanMux sMuxsc40 SelectedBy SCBsc40.DO {
		1'b0 : sMuxsc39;
		1'b1 : sc40.SO;
	}
	/* Scan Register 41*/
	Instance SCBsc41 Of SCB {
		InputPort SI = SCBsc40.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc41 Of SReg {
		InputPort SI = sMuxsc40;
		InputPort SEL = sel_SCBTop_SCBsc41;
		Parameter Size = 145;
	}
	ScanMux sMuxsc41 SelectedBy SCBsc41.DO {
		1'b0 : sMuxsc40;
		1'b1 : sc41.SO;
	}
	/* Scan Register 42*/
	Instance SCBsc42 Of SCB {
		InputPort SI = SCBsc41.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc42 Of SReg {
		InputPort SI = sMuxsc41;
		InputPort SEL = sel_SCBTop_SCBsc42;
		Parameter Size = 143;
	}
	ScanMux sMuxsc42 SelectedBy SCBsc42.DO {
		1'b0 : sMuxsc41;
		1'b1 : sc42.SO;
	}
	/* Scan Register 43*/
	Instance SCBsc43 Of SCB {
		InputPort SI = SCBsc42.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc43 Of SReg {
		InputPort SI = sMuxsc42;
		InputPort SEL = sel_SCBTop_SCBsc43;
		Parameter Size = 143;
	}
	ScanMux sMuxsc43 SelectedBy SCBsc43.DO {
		1'b0 : sMuxsc42;
		1'b1 : sc43.SO;
	}
	/* Scan Register 44*/
	Instance SCBsc44 Of SCB {
		InputPort SI = SCBsc43.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc44 Of SReg {
		InputPort SI = sMuxsc43;
		InputPort SEL = sel_SCBTop_SCBsc44;
		Parameter Size = 141;
	}
	ScanMux sMuxsc44 SelectedBy SCBsc44.DO {
		1'b0 : sMuxsc43;
		1'b1 : sc44.SO;
	}
	/* Scan Register 45*/
	Instance SCBsc45 Of SCB {
		InputPort SI = SCBsc44.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc45 Of SReg {
		InputPort SI = sMuxsc44;
		InputPort SEL = sel_SCBTop_SCBsc45;
		Parameter Size = 141;
	}
	ScanMux sMuxsc45 SelectedBy SCBsc45.DO {
		1'b0 : sMuxsc44;
		1'b1 : sc45.SO;
	}
	/* Scan Register 46*/
	Instance SCBsc46 Of SCB {
		InputPort SI = SCBsc45.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc46 Of SReg {
		InputPort SI = sMuxsc45;
		InputPort SEL = sel_SCBTop_SCBsc46;
		Parameter Size = 1;
	}
	ScanMux sMuxsc46 SelectedBy SCBsc46.DO {
		1'b0 : sMuxsc45;
		1'b1 : sc46.SO;
	}
	
	Instance SCBM2 Of SCB {
        InputPort SI = SCBsc46.SO;
        InputPort SEL = sel_nSCBTop;
    }
    Instance m2 Of EmptyModule_NoBidirs  {
        InputPort SI = sMuxsc46; 
        Parameter inputs = 40;
        Parameter outputs = 34;
        InputPort SEL = sel_SCBTop_SCBM2;
    }
    LogicSignal sel_SCBTop_SCBM2 {
        SEL & SCBTop.DO & SCBM2.DO;
    }
    ScanMux sMuxM2 SelectedBy SCBM2.DO {
        1'b0 : sMuxsc46;
        1'b1 : m2;
    }
	
	Instance SCBM3 Of SCB {
        InputPort SI = SCBM2.SO;
        InputPort SEL = sel_nSCBTop;
    }
    Instance m3 Of EmptyModule_NoBidirs  {
        InputPort SI = sMuxM2; 
        Parameter inputs = 40;
        Parameter outputs = 29;
        InputPort SEL = sel_SCBTop_SCBM3;
    }
    LogicSignal sel_SCBTop_SCBM3 {
        SEL & SCBTop.DO & SCBM3.DO;
    }
    ScanMux sMuxM3 SelectedBy SCBM3.DO {
        1'b0 : sMuxM2;
        1'b1 : m3;
    }
	
	ScanMux sMuxTop SelectedBy SCBTop.DO {
		1'b0 : SCBM3.SO;
		1'b1 : sMuxM3;
	}
}


/* Module 4 Level 1 Inputs 15 Outputs 30 Bidirs 72 ScanChains 23 : 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 4 4 4 4 4 4 4*/
Module M4 {
	Attribute lic = 'h 6397c6fc;
	Parameter inputs = 15;
	Parameter outputs = 30;
	Parameter bidirs = 72;
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
		Parameter Size = 5;
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
		Parameter Size = 5;
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
		Parameter Size = 5;
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
		Parameter Size = 5;
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
		Parameter Size = 5;
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
		Parameter Size = 5;
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
		Parameter Size = 5;
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
		Parameter Size = 5;
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
		Parameter Size = 5;
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
		Parameter Size = 5;
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
		Parameter Size = 5;
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
		Parameter Size = 5;
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
		Parameter Size = 5;
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
		Parameter Size = 5;
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
		Parameter Size = 5;
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
		Parameter Size = 5;
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
		Parameter Size = 4;
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
		Parameter Size = 4;
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
		Parameter Size = 4;
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
		Parameter Size = 4;
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
		Parameter Size = 4;
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
		Parameter Size = 4;
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
		Parameter Size = 4;
	}
	ScanMux sMuxsc23 SelectedBy SCBsc23.DO {
		1'b0 : sMuxsc22;
		1'b1 : sc23.SO;
	}
	ScanMux sMuxTop SelectedBy SCBTop.DO {
		1'b0 : SCBsc23;
		1'b1 : sMuxsc23;
	}
}


/* Module 6 Level 1 Inputs 417 Outputs 324 Bidirs 72 ScanChains 46 : 521 521 521 521 521 521 521 521 521 520 520 520 520 520 520 520 520 520 520 520 520 520 520 520 520 520 520 520 520 520 520 520 520 520 520 520 520 520 520 500 500 500 500 500 500 500*/
Module M6 {
	Attribute lic = 'h c0a63bd9;
	Parameter inputs = 417;
	Parameter outputs = 324;
	Parameter bidirs = 72;
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
	LogicSignal sel_SCBTop_SCBsc30 {
		SEL & SCBTop.DO & SCBsc30.DO;
	}
	LogicSignal sel_SCBTop_SCBsc31 {
		SEL & SCBTop.DO & SCBsc31.DO;
	}
	LogicSignal sel_SCBTop_SCBsc32 {
		SEL & SCBTop.DO & SCBsc32.DO;
	}
	LogicSignal sel_SCBTop_SCBsc33 {
		SEL & SCBTop.DO & SCBsc33.DO;
	}
	LogicSignal sel_SCBTop_SCBsc34 {
		SEL & SCBTop.DO & SCBsc34.DO;
	}
	LogicSignal sel_SCBTop_SCBsc35 {
		SEL & SCBTop.DO & SCBsc35.DO;
	}
	LogicSignal sel_SCBTop_SCBsc36 {
		SEL & SCBTop.DO & SCBsc36.DO;
	}
	LogicSignal sel_SCBTop_SCBsc37 {
		SEL & SCBTop.DO & SCBsc37.DO;
	}
	LogicSignal sel_SCBTop_SCBsc38 {
		SEL & SCBTop.DO & SCBsc38.DO;
	}
	LogicSignal sel_SCBTop_SCBsc39 {
		SEL & SCBTop.DO & SCBsc39.DO;
	}
	LogicSignal sel_SCBTop_SCBsc40 {
		SEL & SCBTop.DO & SCBsc40.DO;
	}
	LogicSignal sel_SCBTop_SCBsc41 {
		SEL & SCBTop.DO & SCBsc41.DO;
	}
	LogicSignal sel_SCBTop_SCBsc42 {
		SEL & SCBTop.DO & SCBsc42.DO;
	}
	LogicSignal sel_SCBTop_SCBsc43 {
		SEL & SCBTop.DO & SCBsc43.DO;
	}
	LogicSignal sel_SCBTop_SCBsc44 {
		SEL & SCBTop.DO & SCBsc44.DO;
	}
	LogicSignal sel_SCBTop_SCBsc45 {
		SEL & SCBTop.DO & SCBsc45.DO;
	}
	LogicSignal sel_SCBTop_SCBsc46 {
		SEL & SCBTop.DO & SCBsc46.DO;
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
		Parameter Size = 521;
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
		Parameter Size = 521;
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
		Parameter Size = 521;
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
		Parameter Size = 521;
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
		Parameter Size = 521;
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
		Parameter Size = 521;
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
		Parameter Size = 521;
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
		Parameter Size = 521;
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
		Parameter Size = 521;
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
		Parameter Size = 520;
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
		Parameter Size = 520;
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
		Parameter Size = 520;
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
		Parameter Size = 520;
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
		Parameter Size = 520;
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
		Parameter Size = 520;
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
		Parameter Size = 520;
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
		Parameter Size = 520;
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
		Parameter Size = 520;
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
		Parameter Size = 520;
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
		Parameter Size = 520;
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
		Parameter Size = 520;
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
		Parameter Size = 520;
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
		Parameter Size = 520;
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
		Parameter Size = 520;
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
		Parameter Size = 520;
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
		Parameter Size = 520;
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
		Parameter Size = 520;
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
		Parameter Size = 520;
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
		Parameter Size = 520;
	}
	ScanMux sMuxsc29 SelectedBy SCBsc29.DO {
		1'b0 : sMuxsc28;
		1'b1 : sc29.SO;
	}
	/* Scan Register 30*/
	Instance SCBsc30 Of SCB {
		InputPort SI = SCBsc29.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc30 Of SReg {
		InputPort SI = sMuxsc29;
		InputPort SEL = sel_SCBTop_SCBsc30;
		Parameter Size = 520;
	}
	ScanMux sMuxsc30 SelectedBy SCBsc30.DO {
		1'b0 : sMuxsc29;
		1'b1 : sc30.SO;
	}
	/* Scan Register 31*/
	Instance SCBsc31 Of SCB {
		InputPort SI = SCBsc30.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc31 Of SReg {
		InputPort SI = sMuxsc30;
		InputPort SEL = sel_SCBTop_SCBsc31;
		Parameter Size = 520;
	}
	ScanMux sMuxsc31 SelectedBy SCBsc31.DO {
		1'b0 : sMuxsc30;
		1'b1 : sc31.SO;
	}
	/* Scan Register 32*/
	Instance SCBsc32 Of SCB {
		InputPort SI = SCBsc31.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc32 Of SReg {
		InputPort SI = sMuxsc31;
		InputPort SEL = sel_SCBTop_SCBsc32;
		Parameter Size = 520;
	}
	ScanMux sMuxsc32 SelectedBy SCBsc32.DO {
		1'b0 : sMuxsc31;
		1'b1 : sc32.SO;
	}
	/* Scan Register 33*/
	Instance SCBsc33 Of SCB {
		InputPort SI = SCBsc32.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc33 Of SReg {
		InputPort SI = sMuxsc32;
		InputPort SEL = sel_SCBTop_SCBsc33;
		Parameter Size = 520;
	}
	ScanMux sMuxsc33 SelectedBy SCBsc33.DO {
		1'b0 : sMuxsc32;
		1'b1 : sc33.SO;
	}
	/* Scan Register 34*/
	Instance SCBsc34 Of SCB {
		InputPort SI = SCBsc33.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc34 Of SReg {
		InputPort SI = sMuxsc33;
		InputPort SEL = sel_SCBTop_SCBsc34;
		Parameter Size = 520;
	}
	ScanMux sMuxsc34 SelectedBy SCBsc34.DO {
		1'b0 : sMuxsc33;
		1'b1 : sc34.SO;
	}
	/* Scan Register 35*/
	Instance SCBsc35 Of SCB {
		InputPort SI = SCBsc34.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc35 Of SReg {
		InputPort SI = sMuxsc34;
		InputPort SEL = sel_SCBTop_SCBsc35;
		Parameter Size = 520;
	}
	ScanMux sMuxsc35 SelectedBy SCBsc35.DO {
		1'b0 : sMuxsc34;
		1'b1 : sc35.SO;
	}
	/* Scan Register 36*/
	Instance SCBsc36 Of SCB {
		InputPort SI = SCBsc35.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc36 Of SReg {
		InputPort SI = sMuxsc35;
		InputPort SEL = sel_SCBTop_SCBsc36;
		Parameter Size = 520;
	}
	ScanMux sMuxsc36 SelectedBy SCBsc36.DO {
		1'b0 : sMuxsc35;
		1'b1 : sc36.SO;
	}
	/* Scan Register 37*/
	Instance SCBsc37 Of SCB {
		InputPort SI = SCBsc36.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc37 Of SReg {
		InputPort SI = sMuxsc36;
		InputPort SEL = sel_SCBTop_SCBsc37;
		Parameter Size = 520;
	}
	ScanMux sMuxsc37 SelectedBy SCBsc37.DO {
		1'b0 : sMuxsc36;
		1'b1 : sc37.SO;
	}
	/* Scan Register 38*/
	Instance SCBsc38 Of SCB {
		InputPort SI = SCBsc37.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc38 Of SReg {
		InputPort SI = sMuxsc37;
		InputPort SEL = sel_SCBTop_SCBsc38;
		Parameter Size = 520;
	}
	ScanMux sMuxsc38 SelectedBy SCBsc38.DO {
		1'b0 : sMuxsc37;
		1'b1 : sc38.SO;
	}
	/* Scan Register 39*/
	Instance SCBsc39 Of SCB {
		InputPort SI = SCBsc38.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc39 Of SReg {
		InputPort SI = sMuxsc38;
		InputPort SEL = sel_SCBTop_SCBsc39;
		Parameter Size = 520;
	}
	ScanMux sMuxsc39 SelectedBy SCBsc39.DO {
		1'b0 : sMuxsc38;
		1'b1 : sc39.SO;
	}
	/* Scan Register 40*/
	Instance SCBsc40 Of SCB {
		InputPort SI = SCBsc39.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc40 Of SReg {
		InputPort SI = sMuxsc39;
		InputPort SEL = sel_SCBTop_SCBsc40;
		Parameter Size = 500;
	}
	ScanMux sMuxsc40 SelectedBy SCBsc40.DO {
		1'b0 : sMuxsc39;
		1'b1 : sc40.SO;
	}
	/* Scan Register 41*/
	Instance SCBsc41 Of SCB {
		InputPort SI = SCBsc40.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc41 Of SReg {
		InputPort SI = sMuxsc40;
		InputPort SEL = sel_SCBTop_SCBsc41;
		Parameter Size = 500;
	}
	ScanMux sMuxsc41 SelectedBy SCBsc41.DO {
		1'b0 : sMuxsc40;
		1'b1 : sc41.SO;
	}
	/* Scan Register 42*/
	Instance SCBsc42 Of SCB {
		InputPort SI = SCBsc41.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc42 Of SReg {
		InputPort SI = sMuxsc41;
		InputPort SEL = sel_SCBTop_SCBsc42;
		Parameter Size = 500;
	}
	ScanMux sMuxsc42 SelectedBy SCBsc42.DO {
		1'b0 : sMuxsc41;
		1'b1 : sc42.SO;
	}
	/* Scan Register 43*/
	Instance SCBsc43 Of SCB {
		InputPort SI = SCBsc42.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc43 Of SReg {
		InputPort SI = sMuxsc42;
		InputPort SEL = sel_SCBTop_SCBsc43;
		Parameter Size = 500;
	}
	ScanMux sMuxsc43 SelectedBy SCBsc43.DO {
		1'b0 : sMuxsc42;
		1'b1 : sc43.SO;
	}
	/* Scan Register 44*/
	Instance SCBsc44 Of SCB {
		InputPort SI = SCBsc43.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc44 Of SReg {
		InputPort SI = sMuxsc43;
		InputPort SEL = sel_SCBTop_SCBsc44;
		Parameter Size = 500;
	}
	ScanMux sMuxsc44 SelectedBy SCBsc44.DO {
		1'b0 : sMuxsc43;
		1'b1 : sc44.SO;
	}
	/* Scan Register 45*/
	Instance SCBsc45 Of SCB {
		InputPort SI = SCBsc44.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc45 Of SReg {
		InputPort SI = sMuxsc44;
		InputPort SEL = sel_SCBTop_SCBsc45;
		Parameter Size = 500;
	}
	ScanMux sMuxsc45 SelectedBy SCBsc45.DO {
		1'b0 : sMuxsc44;
		1'b1 : sc45.SO;
	}
	/* Scan Register 46*/
	Instance SCBsc46 Of SCB {
		InputPort SI = SCBsc45.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc46 Of SReg {
		InputPort SI = sMuxsc45;
		InputPort SEL = sel_SCBTop_SCBsc46;
		Parameter Size = 500;
	}
	ScanMux sMuxsc46 SelectedBy SCBsc46.DO {
		1'b0 : sMuxsc45;
		1'b1 : sc46.SO;
	}
	
	Instance SCBM7 Of SCB {
        InputPort SI = SCBsc46.SO;
        InputPort SEL = sel_nSCBTop;
    }
    Instance m7 Of EmptyModule_NoBidirs  {
        InputPort SI = sMuxsc46; 
        Parameter inputs = 9;
        Parameter outputs = 32;
        InputPort SEL = sel_SCBTop_SCBM7;
    }
    LogicSignal sel_SCBTop_SCBM7 {
        SEL & SCBTop.DO & SCBM7.DO;
    }
    ScanMux sMuxM7 SelectedBy SCBM7.DO {
        1'b0 : sMuxsc46;
        1'b1 : m7;
    }
	
	Instance SCBM8 Of SCB {
        InputPort SI = SCBM7.SO;
        InputPort SEL = sel_nSCBTop;
    }
    Instance m8 Of EmptyModule_NoBidirs  {
        InputPort SI = sMuxM7; 
        Parameter inputs = 9;
        Parameter outputs = 32;
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
        Parameter inputs = 43;
        Parameter outputs = 34;
        InputPort SEL = sel_SCBTop_SCBM9;
    }
    LogicSignal sel_SCBTop_SCBM9 {
        SEL & SCBTop.DO & SCBM9.DO;
    }
    ScanMux sMuxM9 SelectedBy SCBM9.DO {
        1'b0 : sMuxM8;
        1'b1 : m9;
    }
	
	Instance SCBM10 Of SCB {
        InputPort SI = SCBM9.SO;
        InputPort SEL = sel_nSCBTop;
    }
    Instance m10 Of EmptyModule_NoBidirs  {
        InputPort SI = sMuxM9; 
        Parameter inputs = 267;
        Parameter outputs = 128;
        InputPort SEL = sel_SCBTop_SCBM10;
    }
    LogicSignal sel_SCBTop_SCBM10 {
        SEL & SCBTop.DO & SCBM10.DO;
    }
    ScanMux sMuxM10 SelectedBy SCBM10.DO {
        1'b0 : sMuxM9;
        1'b1 : m10;
    }
	ScanMux sMuxTop SelectedBy SCBTop.DO {
		1'b0 : SCBM10.SO;
		1'b1 : sMuxM10;
	}
}

/* Module 11 Level 1 Inputs 146 Outputs 68 Bidirs 72 ScanChains 11 : 82 82 82 81 81 81 18 18 17 17 17*/
Module M11 {
	Attribute lic = 'h c7de1abe;
	Parameter inputs = 146;
	Parameter outputs = 68;
	Parameter bidirs = 72;
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
		Parameter Size = 82;
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
		Parameter Size = 82;
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
		Parameter Size = 82;
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
		Parameter Size = 81;
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
		Parameter Size = 81;
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
		Parameter Size = 81;
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
		Parameter Size = 18;
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
		Parameter Size = 18;
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
		Parameter Size = 17;
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
		Parameter Size = 17;
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
		Parameter Size = 17;
	}
	ScanMux sMuxsc11 SelectedBy SCBsc11.DO {
		1'b0 : sMuxsc10;
		1'b1 : sc11.SO;
	}
	ScanMux sMuxTop SelectedBy SCBTop.DO {
		1'b0 : SCBsc11;
		1'b1 : sMuxsc11;
	}
}


/* Module 12 Level 1 Inputs 289 Outputs 8 Bidirs 72 ScanChains 46 : 93 93 93 93 93 93 93 93 93 93 93 93 93 93 93 93 93 93 93 93 93 93 93 93 93 93 93 93 93 93 93 93 93 92 92 92 92 92 92 92 92 92 92 92 92 92*/
Module M12 {
	Attribute lic = 'h 3352a811;
	Parameter inputs = 289;
	Parameter outputs = 8;
	Parameter bidirs = 72;
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
	LogicSignal sel_SCBTop_SCBsc30 {
		SEL & SCBTop.DO & SCBsc30.DO;
	}
	LogicSignal sel_SCBTop_SCBsc31 {
		SEL & SCBTop.DO & SCBsc31.DO;
	}
	LogicSignal sel_SCBTop_SCBsc32 {
		SEL & SCBTop.DO & SCBsc32.DO;
	}
	LogicSignal sel_SCBTop_SCBsc33 {
		SEL & SCBTop.DO & SCBsc33.DO;
	}
	LogicSignal sel_SCBTop_SCBsc34 {
		SEL & SCBTop.DO & SCBsc34.DO;
	}
	LogicSignal sel_SCBTop_SCBsc35 {
		SEL & SCBTop.DO & SCBsc35.DO;
	}
	LogicSignal sel_SCBTop_SCBsc36 {
		SEL & SCBTop.DO & SCBsc36.DO;
	}
	LogicSignal sel_SCBTop_SCBsc37 {
		SEL & SCBTop.DO & SCBsc37.DO;
	}
	LogicSignal sel_SCBTop_SCBsc38 {
		SEL & SCBTop.DO & SCBsc38.DO;
	}
	LogicSignal sel_SCBTop_SCBsc39 {
		SEL & SCBTop.DO & SCBsc39.DO;
	}
	LogicSignal sel_SCBTop_SCBsc40 {
		SEL & SCBTop.DO & SCBsc40.DO;
	}
	LogicSignal sel_SCBTop_SCBsc41 {
		SEL & SCBTop.DO & SCBsc41.DO;
	}
	LogicSignal sel_SCBTop_SCBsc42 {
		SEL & SCBTop.DO & SCBsc42.DO;
	}
	LogicSignal sel_SCBTop_SCBsc43 {
		SEL & SCBTop.DO & SCBsc43.DO;
	}
	LogicSignal sel_SCBTop_SCBsc44 {
		SEL & SCBTop.DO & SCBsc44.DO;
	}
	LogicSignal sel_SCBTop_SCBsc45 {
		SEL & SCBTop.DO & SCBsc45.DO;
	}
	LogicSignal sel_SCBTop_SCBsc46 {
		SEL & SCBTop.DO & SCBsc46.DO;
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
		Parameter Size = 93;
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
		Parameter Size = 93;
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
		Parameter Size = 93;
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
		Parameter Size = 93;
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
		Parameter Size = 93;
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
		Parameter Size = 93;
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
		Parameter Size = 93;
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
		Parameter Size = 93;
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
		Parameter Size = 93;
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
		Parameter Size = 93;
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
		Parameter Size = 93;
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
		Parameter Size = 93;
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
		Parameter Size = 93;
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
		Parameter Size = 93;
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
		Parameter Size = 93;
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
		Parameter Size = 93;
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
		Parameter Size = 93;
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
		Parameter Size = 93;
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
		Parameter Size = 93;
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
		Parameter Size = 93;
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
		Parameter Size = 93;
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
		Parameter Size = 93;
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
		Parameter Size = 93;
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
		Parameter Size = 93;
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
		Parameter Size = 93;
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
		Parameter Size = 93;
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
		Parameter Size = 93;
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
		Parameter Size = 93;
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
		Parameter Size = 93;
	}
	ScanMux sMuxsc29 SelectedBy SCBsc29.DO {
		1'b0 : sMuxsc28;
		1'b1 : sc29.SO;
	}
	/* Scan Register 30*/
	Instance SCBsc30 Of SCB {
		InputPort SI = SCBsc29.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc30 Of SReg {
		InputPort SI = sMuxsc29;
		InputPort SEL = sel_SCBTop_SCBsc30;
		Parameter Size = 93;
	}
	ScanMux sMuxsc30 SelectedBy SCBsc30.DO {
		1'b0 : sMuxsc29;
		1'b1 : sc30.SO;
	}
	/* Scan Register 31*/
	Instance SCBsc31 Of SCB {
		InputPort SI = SCBsc30.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc31 Of SReg {
		InputPort SI = sMuxsc30;
		InputPort SEL = sel_SCBTop_SCBsc31;
		Parameter Size = 93;
	}
	ScanMux sMuxsc31 SelectedBy SCBsc31.DO {
		1'b0 : sMuxsc30;
		1'b1 : sc31.SO;
	}
	/* Scan Register 32*/
	Instance SCBsc32 Of SCB {
		InputPort SI = SCBsc31.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc32 Of SReg {
		InputPort SI = sMuxsc31;
		InputPort SEL = sel_SCBTop_SCBsc32;
		Parameter Size = 93;
	}
	ScanMux sMuxsc32 SelectedBy SCBsc32.DO {
		1'b0 : sMuxsc31;
		1'b1 : sc32.SO;
	}
	/* Scan Register 33*/
	Instance SCBsc33 Of SCB {
		InputPort SI = SCBsc32.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc33 Of SReg {
		InputPort SI = sMuxsc32;
		InputPort SEL = sel_SCBTop_SCBsc33;
		Parameter Size = 93;
	}
	ScanMux sMuxsc33 SelectedBy SCBsc33.DO {
		1'b0 : sMuxsc32;
		1'b1 : sc33.SO;
	}
	/* Scan Register 34*/
	Instance SCBsc34 Of SCB {
		InputPort SI = SCBsc33.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc34 Of SReg {
		InputPort SI = sMuxsc33;
		InputPort SEL = sel_SCBTop_SCBsc34;
		Parameter Size = 92;
	}
	ScanMux sMuxsc34 SelectedBy SCBsc34.DO {
		1'b0 : sMuxsc33;
		1'b1 : sc34.SO;
	}
	/* Scan Register 35*/
	Instance SCBsc35 Of SCB {
		InputPort SI = SCBsc34.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc35 Of SReg {
		InputPort SI = sMuxsc34;
		InputPort SEL = sel_SCBTop_SCBsc35;
		Parameter Size = 92;
	}
	ScanMux sMuxsc35 SelectedBy SCBsc35.DO {
		1'b0 : sMuxsc34;
		1'b1 : sc35.SO;
	}
	/* Scan Register 36*/
	Instance SCBsc36 Of SCB {
		InputPort SI = SCBsc35.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc36 Of SReg {
		InputPort SI = sMuxsc35;
		InputPort SEL = sel_SCBTop_SCBsc36;
		Parameter Size = 92;
	}
	ScanMux sMuxsc36 SelectedBy SCBsc36.DO {
		1'b0 : sMuxsc35;
		1'b1 : sc36.SO;
	}
	/* Scan Register 37*/
	Instance SCBsc37 Of SCB {
		InputPort SI = SCBsc36.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc37 Of SReg {
		InputPort SI = sMuxsc36;
		InputPort SEL = sel_SCBTop_SCBsc37;
		Parameter Size = 92;
	}
	ScanMux sMuxsc37 SelectedBy SCBsc37.DO {
		1'b0 : sMuxsc36;
		1'b1 : sc37.SO;
	}
	/* Scan Register 38*/
	Instance SCBsc38 Of SCB {
		InputPort SI = SCBsc37.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc38 Of SReg {
		InputPort SI = sMuxsc37;
		InputPort SEL = sel_SCBTop_SCBsc38;
		Parameter Size = 92;
	}
	ScanMux sMuxsc38 SelectedBy SCBsc38.DO {
		1'b0 : sMuxsc37;
		1'b1 : sc38.SO;
	}
	/* Scan Register 39*/
	Instance SCBsc39 Of SCB {
		InputPort SI = SCBsc38.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc39 Of SReg {
		InputPort SI = sMuxsc38;
		InputPort SEL = sel_SCBTop_SCBsc39;
		Parameter Size = 92;
	}
	ScanMux sMuxsc39 SelectedBy SCBsc39.DO {
		1'b0 : sMuxsc38;
		1'b1 : sc39.SO;
	}
	/* Scan Register 40*/
	Instance SCBsc40 Of SCB {
		InputPort SI = SCBsc39.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc40 Of SReg {
		InputPort SI = sMuxsc39;
		InputPort SEL = sel_SCBTop_SCBsc40;
		Parameter Size = 92;
	}
	ScanMux sMuxsc40 SelectedBy SCBsc40.DO {
		1'b0 : sMuxsc39;
		1'b1 : sc40.SO;
	}
	/* Scan Register 41*/
	Instance SCBsc41 Of SCB {
		InputPort SI = SCBsc40.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc41 Of SReg {
		InputPort SI = sMuxsc40;
		InputPort SEL = sel_SCBTop_SCBsc41;
		Parameter Size = 92;
	}
	ScanMux sMuxsc41 SelectedBy SCBsc41.DO {
		1'b0 : sMuxsc40;
		1'b1 : sc41.SO;
	}
	/* Scan Register 42*/
	Instance SCBsc42 Of SCB {
		InputPort SI = SCBsc41.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc42 Of SReg {
		InputPort SI = sMuxsc41;
		InputPort SEL = sel_SCBTop_SCBsc42;
		Parameter Size = 92;
	}
	ScanMux sMuxsc42 SelectedBy SCBsc42.DO {
		1'b0 : sMuxsc41;
		1'b1 : sc42.SO;
	}
	/* Scan Register 43*/
	Instance SCBsc43 Of SCB {
		InputPort SI = SCBsc42.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc43 Of SReg {
		InputPort SI = sMuxsc42;
		InputPort SEL = sel_SCBTop_SCBsc43;
		Parameter Size = 92;
	}
	ScanMux sMuxsc43 SelectedBy SCBsc43.DO {
		1'b0 : sMuxsc42;
		1'b1 : sc43.SO;
	}
	/* Scan Register 44*/
	Instance SCBsc44 Of SCB {
		InputPort SI = SCBsc43.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc44 Of SReg {
		InputPort SI = sMuxsc43;
		InputPort SEL = sel_SCBTop_SCBsc44;
		Parameter Size = 92;
	}
	ScanMux sMuxsc44 SelectedBy SCBsc44.DO {
		1'b0 : sMuxsc43;
		1'b1 : sc44.SO;
	}
	/* Scan Register 45*/
	Instance SCBsc45 Of SCB {
		InputPort SI = SCBsc44.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc45 Of SReg {
		InputPort SI = sMuxsc44;
		InputPort SEL = sel_SCBTop_SCBsc45;
		Parameter Size = 92;
	}
	ScanMux sMuxsc45 SelectedBy SCBsc45.DO {
		1'b0 : sMuxsc44;
		1'b1 : sc45.SO;
	}
	/* Scan Register 46*/
	Instance SCBsc46 Of SCB {
		InputPort SI = SCBsc45.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc46 Of SReg {
		InputPort SI = sMuxsc45;
		InputPort SEL = sel_SCBTop_SCBsc46;
		Parameter Size = 92;
	}
	ScanMux sMuxsc46 SelectedBy SCBsc46.DO {
		1'b0 : sMuxsc45;
		1'b1 : sc46.SO;
	}
	ScanMux sMuxTop SelectedBy SCBTop.DO {
		1'b0 : SCBsc46;
		1'b1 : sMuxsc46;
	}
}


/* Module 13 Level 1 Inputs 111 Outputs 31 Bidirs 72 ScanChains 46 : 219 219 219 219 219 219 219 219 219 219 219 219 219 218 218 218 218 218 218 218 218 218 218 218 218 218 218 207 207 207 207 206 206 206 206 206 206 174 174 174 174 174 174 174 173 173*/
Module M13 {
	Attribute lic = 'h d5832df6;
	Parameter inputs = 111;
	Parameter outputs = 31;
	Parameter bidirs = 72;
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
	LogicSignal sel_SCBTop_SCBsc30 {
		SEL & SCBTop.DO & SCBsc30.DO;
	}
	LogicSignal sel_SCBTop_SCBsc31 {
		SEL & SCBTop.DO & SCBsc31.DO;
	}
	LogicSignal sel_SCBTop_SCBsc32 {
		SEL & SCBTop.DO & SCBsc32.DO;
	}
	LogicSignal sel_SCBTop_SCBsc33 {
		SEL & SCBTop.DO & SCBsc33.DO;
	}
	LogicSignal sel_SCBTop_SCBsc34 {
		SEL & SCBTop.DO & SCBsc34.DO;
	}
	LogicSignal sel_SCBTop_SCBsc35 {
		SEL & SCBTop.DO & SCBsc35.DO;
	}
	LogicSignal sel_SCBTop_SCBsc36 {
		SEL & SCBTop.DO & SCBsc36.DO;
	}
	LogicSignal sel_SCBTop_SCBsc37 {
		SEL & SCBTop.DO & SCBsc37.DO;
	}
	LogicSignal sel_SCBTop_SCBsc38 {
		SEL & SCBTop.DO & SCBsc38.DO;
	}
	LogicSignal sel_SCBTop_SCBsc39 {
		SEL & SCBTop.DO & SCBsc39.DO;
	}
	LogicSignal sel_SCBTop_SCBsc40 {
		SEL & SCBTop.DO & SCBsc40.DO;
	}
	LogicSignal sel_SCBTop_SCBsc41 {
		SEL & SCBTop.DO & SCBsc41.DO;
	}
	LogicSignal sel_SCBTop_SCBsc42 {
		SEL & SCBTop.DO & SCBsc42.DO;
	}
	LogicSignal sel_SCBTop_SCBsc43 {
		SEL & SCBTop.DO & SCBsc43.DO;
	}
	LogicSignal sel_SCBTop_SCBsc44 {
		SEL & SCBTop.DO & SCBsc44.DO;
	}
	LogicSignal sel_SCBTop_SCBsc45 {
		SEL & SCBTop.DO & SCBsc45.DO;
	}
	LogicSignal sel_SCBTop_SCBsc46 {
		SEL & SCBTop.DO & SCBsc46.DO;
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
		Parameter Size = 219;
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
		Parameter Size = 219;
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
		Parameter Size = 219;
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
		Parameter Size = 219;
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
		Parameter Size = 219;
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
		Parameter Size = 219;
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
		Parameter Size = 219;
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
		Parameter Size = 219;
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
		Parameter Size = 219;
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
		Parameter Size = 219;
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
		Parameter Size = 219;
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
		Parameter Size = 219;
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
		Parameter Size = 219;
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
		Parameter Size = 218;
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
		Parameter Size = 218;
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
		Parameter Size = 218;
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
		Parameter Size = 218;
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
		Parameter Size = 218;
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
		Parameter Size = 218;
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
		Parameter Size = 218;
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
		Parameter Size = 218;
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
		Parameter Size = 218;
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
		Parameter Size = 218;
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
		Parameter Size = 218;
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
		Parameter Size = 218;
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
		Parameter Size = 218;
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
		Parameter Size = 218;
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
		Parameter Size = 207;
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
		Parameter Size = 207;
	}
	ScanMux sMuxsc29 SelectedBy SCBsc29.DO {
		1'b0 : sMuxsc28;
		1'b1 : sc29.SO;
	}
	/* Scan Register 30*/
	Instance SCBsc30 Of SCB {
		InputPort SI = SCBsc29.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc30 Of SReg {
		InputPort SI = sMuxsc29;
		InputPort SEL = sel_SCBTop_SCBsc30;
		Parameter Size = 207;
	}
	ScanMux sMuxsc30 SelectedBy SCBsc30.DO {
		1'b0 : sMuxsc29;
		1'b1 : sc30.SO;
	}
	/* Scan Register 31*/
	Instance SCBsc31 Of SCB {
		InputPort SI = SCBsc30.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc31 Of SReg {
		InputPort SI = sMuxsc30;
		InputPort SEL = sel_SCBTop_SCBsc31;
		Parameter Size = 207;
	}
	ScanMux sMuxsc31 SelectedBy SCBsc31.DO {
		1'b0 : sMuxsc30;
		1'b1 : sc31.SO;
	}
	/* Scan Register 32*/
	Instance SCBsc32 Of SCB {
		InputPort SI = SCBsc31.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc32 Of SReg {
		InputPort SI = sMuxsc31;
		InputPort SEL = sel_SCBTop_SCBsc32;
		Parameter Size = 206;
	}
	ScanMux sMuxsc32 SelectedBy SCBsc32.DO {
		1'b0 : sMuxsc31;
		1'b1 : sc32.SO;
	}
	/* Scan Register 33*/
	Instance SCBsc33 Of SCB {
		InputPort SI = SCBsc32.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc33 Of SReg {
		InputPort SI = sMuxsc32;
		InputPort SEL = sel_SCBTop_SCBsc33;
		Parameter Size = 206;
	}
	ScanMux sMuxsc33 SelectedBy SCBsc33.DO {
		1'b0 : sMuxsc32;
		1'b1 : sc33.SO;
	}
	/* Scan Register 34*/
	Instance SCBsc34 Of SCB {
		InputPort SI = SCBsc33.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc34 Of SReg {
		InputPort SI = sMuxsc33;
		InputPort SEL = sel_SCBTop_SCBsc34;
		Parameter Size = 206;
	}
	ScanMux sMuxsc34 SelectedBy SCBsc34.DO {
		1'b0 : sMuxsc33;
		1'b1 : sc34.SO;
	}
	/* Scan Register 35*/
	Instance SCBsc35 Of SCB {
		InputPort SI = SCBsc34.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc35 Of SReg {
		InputPort SI = sMuxsc34;
		InputPort SEL = sel_SCBTop_SCBsc35;
		Parameter Size = 206;
	}
	ScanMux sMuxsc35 SelectedBy SCBsc35.DO {
		1'b0 : sMuxsc34;
		1'b1 : sc35.SO;
	}
	/* Scan Register 36*/
	Instance SCBsc36 Of SCB {
		InputPort SI = SCBsc35.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc36 Of SReg {
		InputPort SI = sMuxsc35;
		InputPort SEL = sel_SCBTop_SCBsc36;
		Parameter Size = 206;
	}
	ScanMux sMuxsc36 SelectedBy SCBsc36.DO {
		1'b0 : sMuxsc35;
		1'b1 : sc36.SO;
	}
	/* Scan Register 37*/
	Instance SCBsc37 Of SCB {
		InputPort SI = SCBsc36.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc37 Of SReg {
		InputPort SI = sMuxsc36;
		InputPort SEL = sel_SCBTop_SCBsc37;
		Parameter Size = 206;
	}
	ScanMux sMuxsc37 SelectedBy SCBsc37.DO {
		1'b0 : sMuxsc36;
		1'b1 : sc37.SO;
	}
	/* Scan Register 38*/
	Instance SCBsc38 Of SCB {
		InputPort SI = SCBsc37.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc38 Of SReg {
		InputPort SI = sMuxsc37;
		InputPort SEL = sel_SCBTop_SCBsc38;
		Parameter Size = 174;
	}
	ScanMux sMuxsc38 SelectedBy SCBsc38.DO {
		1'b0 : sMuxsc37;
		1'b1 : sc38.SO;
	}
	/* Scan Register 39*/
	Instance SCBsc39 Of SCB {
		InputPort SI = SCBsc38.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc39 Of SReg {
		InputPort SI = sMuxsc38;
		InputPort SEL = sel_SCBTop_SCBsc39;
		Parameter Size = 174;
	}
	ScanMux sMuxsc39 SelectedBy SCBsc39.DO {
		1'b0 : sMuxsc38;
		1'b1 : sc39.SO;
	}
	/* Scan Register 40*/
	Instance SCBsc40 Of SCB {
		InputPort SI = SCBsc39.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc40 Of SReg {
		InputPort SI = sMuxsc39;
		InputPort SEL = sel_SCBTop_SCBsc40;
		Parameter Size = 174;
	}
	ScanMux sMuxsc40 SelectedBy SCBsc40.DO {
		1'b0 : sMuxsc39;
		1'b1 : sc40.SO;
	}
	/* Scan Register 41*/
	Instance SCBsc41 Of SCB {
		InputPort SI = SCBsc40.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc41 Of SReg {
		InputPort SI = sMuxsc40;
		InputPort SEL = sel_SCBTop_SCBsc41;
		Parameter Size = 174;
	}
	ScanMux sMuxsc41 SelectedBy SCBsc41.DO {
		1'b0 : sMuxsc40;
		1'b1 : sc41.SO;
	}
	/* Scan Register 42*/
	Instance SCBsc42 Of SCB {
		InputPort SI = SCBsc41.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc42 Of SReg {
		InputPort SI = sMuxsc41;
		InputPort SEL = sel_SCBTop_SCBsc42;
		Parameter Size = 174;
	}
	ScanMux sMuxsc42 SelectedBy SCBsc42.DO {
		1'b0 : sMuxsc41;
		1'b1 : sc42.SO;
	}
	/* Scan Register 43*/
	Instance SCBsc43 Of SCB {
		InputPort SI = SCBsc42.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc43 Of SReg {
		InputPort SI = sMuxsc42;
		InputPort SEL = sel_SCBTop_SCBsc43;
		Parameter Size = 174;
	}
	ScanMux sMuxsc43 SelectedBy SCBsc43.DO {
		1'b0 : sMuxsc42;
		1'b1 : sc43.SO;
	}
	/* Scan Register 44*/
	Instance SCBsc44 Of SCB {
		InputPort SI = SCBsc43.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc44 Of SReg {
		InputPort SI = sMuxsc43;
		InputPort SEL = sel_SCBTop_SCBsc44;
		Parameter Size = 174;
	}
	ScanMux sMuxsc44 SelectedBy SCBsc44.DO {
		1'b0 : sMuxsc43;
		1'b1 : sc44.SO;
	}
	/* Scan Register 45*/
	Instance SCBsc45 Of SCB {
		InputPort SI = SCBsc44.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc45 Of SReg {
		InputPort SI = sMuxsc44;
		InputPort SEL = sel_SCBTop_SCBsc45;
		Parameter Size = 173;
	}
	ScanMux sMuxsc45 SelectedBy SCBsc45.DO {
		1'b0 : sMuxsc44;
		1'b1 : sc45.SO;
	}
	/* Scan Register 46*/
	Instance SCBsc46 Of SCB {
		InputPort SI = SCBsc45.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc46 Of SReg {
		InputPort SI = sMuxsc45;
		InputPort SEL = sel_SCBTop_SCBsc46;
		Parameter Size = 173;
	}
	ScanMux sMuxsc46 SelectedBy SCBsc46.DO {
		1'b0 : sMuxsc45;
		1'b1 : sc46.SO;
	}
	ScanMux sMuxTop SelectedBy SCBTop.DO {
		1'b0 : SCBsc46;
		1'b1 : sMuxsc46;
	}
}


/* Module 14 Level 1 Inputs 111 Outputs 31 Bidirs 72 ScanChains 46 : 219 219 219 219 219 219 219 219 219 219 219 219 219 218 218 218 218 218 218 218 218 218 218 218 218 218 218 207 207 207 207 206 206 206 206 206 206 174 174 174 174 174 174 174 173 173*/
Module M14 {
	Attribute lic = 'h af526344;
	Parameter inputs = 111;
	Parameter outputs = 31;
	Parameter bidirs = 72;
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
	LogicSignal sel_SCBTop_SCBsc30 {
		SEL & SCBTop.DO & SCBsc30.DO;
	}
	LogicSignal sel_SCBTop_SCBsc31 {
		SEL & SCBTop.DO & SCBsc31.DO;
	}
	LogicSignal sel_SCBTop_SCBsc32 {
		SEL & SCBTop.DO & SCBsc32.DO;
	}
	LogicSignal sel_SCBTop_SCBsc33 {
		SEL & SCBTop.DO & SCBsc33.DO;
	}
	LogicSignal sel_SCBTop_SCBsc34 {
		SEL & SCBTop.DO & SCBsc34.DO;
	}
	LogicSignal sel_SCBTop_SCBsc35 {
		SEL & SCBTop.DO & SCBsc35.DO;
	}
	LogicSignal sel_SCBTop_SCBsc36 {
		SEL & SCBTop.DO & SCBsc36.DO;
	}
	LogicSignal sel_SCBTop_SCBsc37 {
		SEL & SCBTop.DO & SCBsc37.DO;
	}
	LogicSignal sel_SCBTop_SCBsc38 {
		SEL & SCBTop.DO & SCBsc38.DO;
	}
	LogicSignal sel_SCBTop_SCBsc39 {
		SEL & SCBTop.DO & SCBsc39.DO;
	}
	LogicSignal sel_SCBTop_SCBsc40 {
		SEL & SCBTop.DO & SCBsc40.DO;
	}
	LogicSignal sel_SCBTop_SCBsc41 {
		SEL & SCBTop.DO & SCBsc41.DO;
	}
	LogicSignal sel_SCBTop_SCBsc42 {
		SEL & SCBTop.DO & SCBsc42.DO;
	}
	LogicSignal sel_SCBTop_SCBsc43 {
		SEL & SCBTop.DO & SCBsc43.DO;
	}
	LogicSignal sel_SCBTop_SCBsc44 {
		SEL & SCBTop.DO & SCBsc44.DO;
	}
	LogicSignal sel_SCBTop_SCBsc45 {
		SEL & SCBTop.DO & SCBsc45.DO;
	}
	LogicSignal sel_SCBTop_SCBsc46 {
		SEL & SCBTop.DO & SCBsc46.DO;
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
		Parameter Size = 219;
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
		Parameter Size = 219;
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
		Parameter Size = 219;
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
		Parameter Size = 219;
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
		Parameter Size = 219;
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
		Parameter Size = 219;
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
		Parameter Size = 219;
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
		Parameter Size = 219;
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
		Parameter Size = 219;
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
		Parameter Size = 219;
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
		Parameter Size = 219;
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
		Parameter Size = 219;
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
		Parameter Size = 219;
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
		Parameter Size = 218;
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
		Parameter Size = 218;
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
		Parameter Size = 218;
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
		Parameter Size = 218;
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
		Parameter Size = 218;
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
		Parameter Size = 218;
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
		Parameter Size = 218;
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
		Parameter Size = 218;
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
		Parameter Size = 218;
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
		Parameter Size = 218;
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
		Parameter Size = 218;
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
		Parameter Size = 218;
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
		Parameter Size = 218;
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
		Parameter Size = 218;
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
		Parameter Size = 207;
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
		Parameter Size = 207;
	}
	ScanMux sMuxsc29 SelectedBy SCBsc29.DO {
		1'b0 : sMuxsc28;
		1'b1 : sc29.SO;
	}
	/* Scan Register 30*/
	Instance SCBsc30 Of SCB {
		InputPort SI = SCBsc29.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc30 Of SReg {
		InputPort SI = sMuxsc29;
		InputPort SEL = sel_SCBTop_SCBsc30;
		Parameter Size = 207;
	}
	ScanMux sMuxsc30 SelectedBy SCBsc30.DO {
		1'b0 : sMuxsc29;
		1'b1 : sc30.SO;
	}
	/* Scan Register 31*/
	Instance SCBsc31 Of SCB {
		InputPort SI = SCBsc30.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc31 Of SReg {
		InputPort SI = sMuxsc30;
		InputPort SEL = sel_SCBTop_SCBsc31;
		Parameter Size = 207;
	}
	ScanMux sMuxsc31 SelectedBy SCBsc31.DO {
		1'b0 : sMuxsc30;
		1'b1 : sc31.SO;
	}
	/* Scan Register 32*/
	Instance SCBsc32 Of SCB {
		InputPort SI = SCBsc31.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc32 Of SReg {
		InputPort SI = sMuxsc31;
		InputPort SEL = sel_SCBTop_SCBsc32;
		Parameter Size = 206;
	}
	ScanMux sMuxsc32 SelectedBy SCBsc32.DO {
		1'b0 : sMuxsc31;
		1'b1 : sc32.SO;
	}
	/* Scan Register 33*/
	Instance SCBsc33 Of SCB {
		InputPort SI = SCBsc32.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc33 Of SReg {
		InputPort SI = sMuxsc32;
		InputPort SEL = sel_SCBTop_SCBsc33;
		Parameter Size = 206;
	}
	ScanMux sMuxsc33 SelectedBy SCBsc33.DO {
		1'b0 : sMuxsc32;
		1'b1 : sc33.SO;
	}
	/* Scan Register 34*/
	Instance SCBsc34 Of SCB {
		InputPort SI = SCBsc33.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc34 Of SReg {
		InputPort SI = sMuxsc33;
		InputPort SEL = sel_SCBTop_SCBsc34;
		Parameter Size = 206;
	}
	ScanMux sMuxsc34 SelectedBy SCBsc34.DO {
		1'b0 : sMuxsc33;
		1'b1 : sc34.SO;
	}
	/* Scan Register 35*/
	Instance SCBsc35 Of SCB {
		InputPort SI = SCBsc34.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc35 Of SReg {
		InputPort SI = sMuxsc34;
		InputPort SEL = sel_SCBTop_SCBsc35;
		Parameter Size = 206;
	}
	ScanMux sMuxsc35 SelectedBy SCBsc35.DO {
		1'b0 : sMuxsc34;
		1'b1 : sc35.SO;
	}
	/* Scan Register 36*/
	Instance SCBsc36 Of SCB {
		InputPort SI = SCBsc35.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc36 Of SReg {
		InputPort SI = sMuxsc35;
		InputPort SEL = sel_SCBTop_SCBsc36;
		Parameter Size = 206;
	}
	ScanMux sMuxsc36 SelectedBy SCBsc36.DO {
		1'b0 : sMuxsc35;
		1'b1 : sc36.SO;
	}
	/* Scan Register 37*/
	Instance SCBsc37 Of SCB {
		InputPort SI = SCBsc36.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc37 Of SReg {
		InputPort SI = sMuxsc36;
		InputPort SEL = sel_SCBTop_SCBsc37;
		Parameter Size = 206;
	}
	ScanMux sMuxsc37 SelectedBy SCBsc37.DO {
		1'b0 : sMuxsc36;
		1'b1 : sc37.SO;
	}
	/* Scan Register 38*/
	Instance SCBsc38 Of SCB {
		InputPort SI = SCBsc37.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc38 Of SReg {
		InputPort SI = sMuxsc37;
		InputPort SEL = sel_SCBTop_SCBsc38;
		Parameter Size = 174;
	}
	ScanMux sMuxsc38 SelectedBy SCBsc38.DO {
		1'b0 : sMuxsc37;
		1'b1 : sc38.SO;
	}
	/* Scan Register 39*/
	Instance SCBsc39 Of SCB {
		InputPort SI = SCBsc38.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc39 Of SReg {
		InputPort SI = sMuxsc38;
		InputPort SEL = sel_SCBTop_SCBsc39;
		Parameter Size = 174;
	}
	ScanMux sMuxsc39 SelectedBy SCBsc39.DO {
		1'b0 : sMuxsc38;
		1'b1 : sc39.SO;
	}
	/* Scan Register 40*/
	Instance SCBsc40 Of SCB {
		InputPort SI = SCBsc39.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc40 Of SReg {
		InputPort SI = sMuxsc39;
		InputPort SEL = sel_SCBTop_SCBsc40;
		Parameter Size = 174;
	}
	ScanMux sMuxsc40 SelectedBy SCBsc40.DO {
		1'b0 : sMuxsc39;
		1'b1 : sc40.SO;
	}
	/* Scan Register 41*/
	Instance SCBsc41 Of SCB {
		InputPort SI = SCBsc40.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc41 Of SReg {
		InputPort SI = sMuxsc40;
		InputPort SEL = sel_SCBTop_SCBsc41;
		Parameter Size = 174;
	}
	ScanMux sMuxsc41 SelectedBy SCBsc41.DO {
		1'b0 : sMuxsc40;
		1'b1 : sc41.SO;
	}
	/* Scan Register 42*/
	Instance SCBsc42 Of SCB {
		InputPort SI = SCBsc41.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc42 Of SReg {
		InputPort SI = sMuxsc41;
		InputPort SEL = sel_SCBTop_SCBsc42;
		Parameter Size = 174;
	}
	ScanMux sMuxsc42 SelectedBy SCBsc42.DO {
		1'b0 : sMuxsc41;
		1'b1 : sc42.SO;
	}
	/* Scan Register 43*/
	Instance SCBsc43 Of SCB {
		InputPort SI = SCBsc42.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc43 Of SReg {
		InputPort SI = sMuxsc42;
		InputPort SEL = sel_SCBTop_SCBsc43;
		Parameter Size = 174;
	}
	ScanMux sMuxsc43 SelectedBy SCBsc43.DO {
		1'b0 : sMuxsc42;
		1'b1 : sc43.SO;
	}
	/* Scan Register 44*/
	Instance SCBsc44 Of SCB {
		InputPort SI = SCBsc43.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc44 Of SReg {
		InputPort SI = sMuxsc43;
		InputPort SEL = sel_SCBTop_SCBsc44;
		Parameter Size = 174;
	}
	ScanMux sMuxsc44 SelectedBy SCBsc44.DO {
		1'b0 : sMuxsc43;
		1'b1 : sc44.SO;
	}
	/* Scan Register 45*/
	Instance SCBsc45 Of SCB {
		InputPort SI = SCBsc44.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc45 Of SReg {
		InputPort SI = sMuxsc44;
		InputPort SEL = sel_SCBTop_SCBsc45;
		Parameter Size = 173;
	}
	ScanMux sMuxsc45 SelectedBy SCBsc45.DO {
		1'b0 : sMuxsc44;
		1'b1 : sc45.SO;
	}
	/* Scan Register 46*/
	Instance SCBsc46 Of SCB {
		InputPort SI = SCBsc45.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc46 Of SReg {
		InputPort SI = sMuxsc45;
		InputPort SEL = sel_SCBTop_SCBsc46;
		Parameter Size = 173;
	}
	ScanMux sMuxsc46 SelectedBy SCBsc46.DO {
		1'b0 : sMuxsc45;
		1'b1 : sc46.SO;
	}
	
	Instance SCBM15 Of SCB {
        InputPort SI = SCBsc46.SO;
        InputPort SEL = sel_nSCBTop;
    }
    Instance m15 Of EmptyModule_NoBidirs  {
        InputPort SI = sMuxsc46; 
        Parameter inputs = 44;
        Parameter outputs = 34;
        InputPort SEL = sel_SCBTop_SCBM15;
    }
    LogicSignal sel_SCBTop_SCBM15 {
        SEL & SCBTop.DO & SCBM15.DO;
    }
    ScanMux sMuxM15 SelectedBy SCBM15.DO {
        1'b0 : sMuxsc46;
        1'b1 : m15;
    }
	
	Instance SCBM16 Of SCB {
        InputPort SI = SCBM15.SO;
        InputPort SEL = sel_nSCBTop;
    }
    Instance m16 Of EmptyModule_NoBidirs  {
        InputPort SI = sMuxM15; 
        Parameter inputs = 137;
        Parameter outputs = 64;
        InputPort SEL = sel_SCBTop_SCBM16;
    }
    LogicSignal sel_SCBTop_SCBM16 {
        SEL & SCBTop.DO & SCBM16.DO;
    }
    ScanMux sMuxM16 SelectedBy SCBM16.DO {
        1'b0 : sMuxM15;
        1'b1 : m16;
    }
	
	ScanMux sMuxTop SelectedBy SCBTop.DO {
		1'b0 : SCBM16.SO;
		1'b1 : sMuxM16;
	}
}


/* Module 17 Level 1 Inputs 144 Outputs 67 Bidirs 72 ScanChains 43 : 150 150 150 150 150 150 150 150 149 149 149 149 149 149 149 149 149 149 149 149 149 149 149 149 149 149 149 149 149 149 149 149 149 149 149 148 148 146 146 145 145 145 145*/
Module M17 {
	Attribute lic = 'h ce939215;
	Parameter inputs = 144;
	Parameter outputs = 67;
	Parameter bidirs = 72;
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
	LogicSignal sel_SCBTop_SCBsc30 {
		SEL & SCBTop.DO & SCBsc30.DO;
	}
	LogicSignal sel_SCBTop_SCBsc31 {
		SEL & SCBTop.DO & SCBsc31.DO;
	}
	LogicSignal sel_SCBTop_SCBsc32 {
		SEL & SCBTop.DO & SCBsc32.DO;
	}
	LogicSignal sel_SCBTop_SCBsc33 {
		SEL & SCBTop.DO & SCBsc33.DO;
	}
	LogicSignal sel_SCBTop_SCBsc34 {
		SEL & SCBTop.DO & SCBsc34.DO;
	}
	LogicSignal sel_SCBTop_SCBsc35 {
		SEL & SCBTop.DO & SCBsc35.DO;
	}
	LogicSignal sel_SCBTop_SCBsc36 {
		SEL & SCBTop.DO & SCBsc36.DO;
	}
	LogicSignal sel_SCBTop_SCBsc37 {
		SEL & SCBTop.DO & SCBsc37.DO;
	}
	LogicSignal sel_SCBTop_SCBsc38 {
		SEL & SCBTop.DO & SCBsc38.DO;
	}
	LogicSignal sel_SCBTop_SCBsc39 {
		SEL & SCBTop.DO & SCBsc39.DO;
	}
	LogicSignal sel_SCBTop_SCBsc40 {
		SEL & SCBTop.DO & SCBsc40.DO;
	}
	LogicSignal sel_SCBTop_SCBsc41 {
		SEL & SCBTop.DO & SCBsc41.DO;
	}
	LogicSignal sel_SCBTop_SCBsc42 {
		SEL & SCBTop.DO & SCBsc42.DO;
	}
	LogicSignal sel_SCBTop_SCBsc43 {
		SEL & SCBTop.DO & SCBsc43.DO;
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
		Parameter Size = 150;
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
		Parameter Size = 150;
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
		Parameter Size = 150;
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
		Parameter Size = 150;
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
		Parameter Size = 150;
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
		Parameter Size = 150;
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
		Parameter Size = 150;
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
		Parameter Size = 150;
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
		Parameter Size = 149;
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
		Parameter Size = 149;
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
		Parameter Size = 149;
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
		Parameter Size = 149;
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
		Parameter Size = 149;
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
		Parameter Size = 149;
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
		Parameter Size = 149;
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
		Parameter Size = 149;
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
		Parameter Size = 149;
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
		Parameter Size = 149;
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
		Parameter Size = 149;
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
		Parameter Size = 149;
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
		Parameter Size = 149;
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
		Parameter Size = 149;
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
		Parameter Size = 149;
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
		Parameter Size = 149;
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
		Parameter Size = 149;
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
		Parameter Size = 149;
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
		Parameter Size = 149;
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
		Parameter Size = 149;
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
		Parameter Size = 149;
	}
	ScanMux sMuxsc29 SelectedBy SCBsc29.DO {
		1'b0 : sMuxsc28;
		1'b1 : sc29.SO;
	}
	/* Scan Register 30*/
	Instance SCBsc30 Of SCB {
		InputPort SI = SCBsc29.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc30 Of SReg {
		InputPort SI = sMuxsc29;
		InputPort SEL = sel_SCBTop_SCBsc30;
		Parameter Size = 149;
	}
	ScanMux sMuxsc30 SelectedBy SCBsc30.DO {
		1'b0 : sMuxsc29;
		1'b1 : sc30.SO;
	}
	/* Scan Register 31*/
	Instance SCBsc31 Of SCB {
		InputPort SI = SCBsc30.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc31 Of SReg {
		InputPort SI = sMuxsc30;
		InputPort SEL = sel_SCBTop_SCBsc31;
		Parameter Size = 149;
	}
	ScanMux sMuxsc31 SelectedBy SCBsc31.DO {
		1'b0 : sMuxsc30;
		1'b1 : sc31.SO;
	}
	/* Scan Register 32*/
	Instance SCBsc32 Of SCB {
		InputPort SI = SCBsc31.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc32 Of SReg {
		InputPort SI = sMuxsc31;
		InputPort SEL = sel_SCBTop_SCBsc32;
		Parameter Size = 149;
	}
	ScanMux sMuxsc32 SelectedBy SCBsc32.DO {
		1'b0 : sMuxsc31;
		1'b1 : sc32.SO;
	}
	/* Scan Register 33*/
	Instance SCBsc33 Of SCB {
		InputPort SI = SCBsc32.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc33 Of SReg {
		InputPort SI = sMuxsc32;
		InputPort SEL = sel_SCBTop_SCBsc33;
		Parameter Size = 149;
	}
	ScanMux sMuxsc33 SelectedBy SCBsc33.DO {
		1'b0 : sMuxsc32;
		1'b1 : sc33.SO;
	}
	/* Scan Register 34*/
	Instance SCBsc34 Of SCB {
		InputPort SI = SCBsc33.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc34 Of SReg {
		InputPort SI = sMuxsc33;
		InputPort SEL = sel_SCBTop_SCBsc34;
		Parameter Size = 149;
	}
	ScanMux sMuxsc34 SelectedBy SCBsc34.DO {
		1'b0 : sMuxsc33;
		1'b1 : sc34.SO;
	}
	/* Scan Register 35*/
	Instance SCBsc35 Of SCB {
		InputPort SI = SCBsc34.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc35 Of SReg {
		InputPort SI = sMuxsc34;
		InputPort SEL = sel_SCBTop_SCBsc35;
		Parameter Size = 149;
	}
	ScanMux sMuxsc35 SelectedBy SCBsc35.DO {
		1'b0 : sMuxsc34;
		1'b1 : sc35.SO;
	}
	/* Scan Register 36*/
	Instance SCBsc36 Of SCB {
		InputPort SI = SCBsc35.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc36 Of SReg {
		InputPort SI = sMuxsc35;
		InputPort SEL = sel_SCBTop_SCBsc36;
		Parameter Size = 148;
	}
	ScanMux sMuxsc36 SelectedBy SCBsc36.DO {
		1'b0 : sMuxsc35;
		1'b1 : sc36.SO;
	}
	/* Scan Register 37*/
	Instance SCBsc37 Of SCB {
		InputPort SI = SCBsc36.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc37 Of SReg {
		InputPort SI = sMuxsc36;
		InputPort SEL = sel_SCBTop_SCBsc37;
		Parameter Size = 148;
	}
	ScanMux sMuxsc37 SelectedBy SCBsc37.DO {
		1'b0 : sMuxsc36;
		1'b1 : sc37.SO;
	}
	/* Scan Register 38*/
	Instance SCBsc38 Of SCB {
		InputPort SI = SCBsc37.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc38 Of SReg {
		InputPort SI = sMuxsc37;
		InputPort SEL = sel_SCBTop_SCBsc38;
		Parameter Size = 146;
	}
	ScanMux sMuxsc38 SelectedBy SCBsc38.DO {
		1'b0 : sMuxsc37;
		1'b1 : sc38.SO;
	}
	/* Scan Register 39*/
	Instance SCBsc39 Of SCB {
		InputPort SI = SCBsc38.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc39 Of SReg {
		InputPort SI = sMuxsc38;
		InputPort SEL = sel_SCBTop_SCBsc39;
		Parameter Size = 146;
	}
	ScanMux sMuxsc39 SelectedBy SCBsc39.DO {
		1'b0 : sMuxsc38;
		1'b1 : sc39.SO;
	}
	/* Scan Register 40*/
	Instance SCBsc40 Of SCB {
		InputPort SI = SCBsc39.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc40 Of SReg {
		InputPort SI = sMuxsc39;
		InputPort SEL = sel_SCBTop_SCBsc40;
		Parameter Size = 145;
	}
	ScanMux sMuxsc40 SelectedBy SCBsc40.DO {
		1'b0 : sMuxsc39;
		1'b1 : sc40.SO;
	}
	/* Scan Register 41*/
	Instance SCBsc41 Of SCB {
		InputPort SI = SCBsc40.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc41 Of SReg {
		InputPort SI = sMuxsc40;
		InputPort SEL = sel_SCBTop_SCBsc41;
		Parameter Size = 145;
	}
	ScanMux sMuxsc41 SelectedBy SCBsc41.DO {
		1'b0 : sMuxsc40;
		1'b1 : sc41.SO;
	}
	/* Scan Register 42*/
	Instance SCBsc42 Of SCB {
		InputPort SI = SCBsc41.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc42 Of SReg {
		InputPort SI = sMuxsc41;
		InputPort SEL = sel_SCBTop_SCBsc42;
		Parameter Size = 145;
	}
	ScanMux sMuxsc42 SelectedBy SCBsc42.DO {
		1'b0 : sMuxsc41;
		1'b1 : sc42.SO;
	}
	/* Scan Register 43*/
	Instance SCBsc43 Of SCB {
		InputPort SI = SCBsc42.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc43 Of SReg {
		InputPort SI = sMuxsc42;
		InputPort SEL = sel_SCBTop_SCBsc43;
		Parameter Size = 145;
	}
	ScanMux sMuxsc43 SelectedBy SCBsc43.DO {
		1'b0 : sMuxsc42;
		1'b1 : sc43.SO;
	}
	
	Instance SCBM18 Of SCB {
        InputPort SI = SCBsc43.SO;
        InputPort SEL = sel_nSCBTop;
    }
    Instance m18 Of EmptyModule_NoBidirs  {
        InputPort SI = sMuxsc43; 
        Parameter inputs = 79;
        Parameter outputs = 34;
        InputPort SEL = sel_SCBTop_SCBM18;
    }
    LogicSignal sel_SCBTop_SCBM18 {
        SEL & SCBTop.DO & SCBM18.DO;
    }
    ScanMux sMuxM18 SelectedBy SCBM18.DO {
        1'b0 : sMuxsc43;
        1'b1 : m18;
    }
	ScanMux sMuxTop SelectedBy SCBTop.DO {
		1'b0 : SCBM18.SO;
		1'b1 : sMuxM18;
	}
}


/* Module 19 Level 1 Inputs 466 Outputs 365 Bidirs 72 ScanChains 44 : 100 100 100 100 100 100 100 100 100 100 100 100 100 100 100 100 100 99 99 99 99 99 99 98 98 98 98 98 98 98 98 98 98 98 98 98 98 98 98 98 98 97 97 97*/
Module M19 {
	Attribute lic = 'h 4effac7b;
	Parameter inputs = 466;
	Parameter outputs = 365;
	Parameter bidirs = 72;
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
	LogicSignal sel_SCBTop_SCBsc30 {
		SEL & SCBTop.DO & SCBsc30.DO;
	}
	LogicSignal sel_SCBTop_SCBsc31 {
		SEL & SCBTop.DO & SCBsc31.DO;
	}
	LogicSignal sel_SCBTop_SCBsc32 {
		SEL & SCBTop.DO & SCBsc32.DO;
	}
	LogicSignal sel_SCBTop_SCBsc33 {
		SEL & SCBTop.DO & SCBsc33.DO;
	}
	LogicSignal sel_SCBTop_SCBsc34 {
		SEL & SCBTop.DO & SCBsc34.DO;
	}
	LogicSignal sel_SCBTop_SCBsc35 {
		SEL & SCBTop.DO & SCBsc35.DO;
	}
	LogicSignal sel_SCBTop_SCBsc36 {
		SEL & SCBTop.DO & SCBsc36.DO;
	}
	LogicSignal sel_SCBTop_SCBsc37 {
		SEL & SCBTop.DO & SCBsc37.DO;
	}
	LogicSignal sel_SCBTop_SCBsc38 {
		SEL & SCBTop.DO & SCBsc38.DO;
	}
	LogicSignal sel_SCBTop_SCBsc39 {
		SEL & SCBTop.DO & SCBsc39.DO;
	}
	LogicSignal sel_SCBTop_SCBsc40 {
		SEL & SCBTop.DO & SCBsc40.DO;
	}
	LogicSignal sel_SCBTop_SCBsc41 {
		SEL & SCBTop.DO & SCBsc41.DO;
	}
	LogicSignal sel_SCBTop_SCBsc42 {
		SEL & SCBTop.DO & SCBsc42.DO;
	}
	LogicSignal sel_SCBTop_SCBsc43 {
		SEL & SCBTop.DO & SCBsc43.DO;
	}
	LogicSignal sel_SCBTop_SCBsc44 {
		SEL & SCBTop.DO & SCBsc44.DO;
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
		Parameter Size = 100;
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
		Parameter Size = 100;
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
		Parameter Size = 100;
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
		Parameter Size = 100;
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
		Parameter Size = 100;
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
		Parameter Size = 100;
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
		Parameter Size = 100;
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
		Parameter Size = 100;
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
		Parameter Size = 100;
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
		Parameter Size = 100;
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
		Parameter Size = 100;
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
		Parameter Size = 100;
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
		Parameter Size = 100;
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
		Parameter Size = 100;
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
		Parameter Size = 100;
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
		Parameter Size = 100;
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
		Parameter Size = 100;
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
		Parameter Size = 99;
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
		Parameter Size = 99;
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
		Parameter Size = 99;
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
		Parameter Size = 99;
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
		Parameter Size = 99;
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
		Parameter Size = 99;
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
		Parameter Size = 98;
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
		Parameter Size = 98;
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
		Parameter Size = 98;
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
		Parameter Size = 98;
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
		Parameter Size = 98;
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
		Parameter Size = 98;
	}
	ScanMux sMuxsc29 SelectedBy SCBsc29.DO {
		1'b0 : sMuxsc28;
		1'b1 : sc29.SO;
	}
	/* Scan Register 30*/
	Instance SCBsc30 Of SCB {
		InputPort SI = SCBsc29.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc30 Of SReg {
		InputPort SI = sMuxsc29;
		InputPort SEL = sel_SCBTop_SCBsc30;
		Parameter Size = 98;
	}
	ScanMux sMuxsc30 SelectedBy SCBsc30.DO {
		1'b0 : sMuxsc29;
		1'b1 : sc30.SO;
	}
	/* Scan Register 31*/
	Instance SCBsc31 Of SCB {
		InputPort SI = SCBsc30.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc31 Of SReg {
		InputPort SI = sMuxsc30;
		InputPort SEL = sel_SCBTop_SCBsc31;
		Parameter Size = 98;
	}
	ScanMux sMuxsc31 SelectedBy SCBsc31.DO {
		1'b0 : sMuxsc30;
		1'b1 : sc31.SO;
	}
	/* Scan Register 32*/
	Instance SCBsc32 Of SCB {
		InputPort SI = SCBsc31.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc32 Of SReg {
		InputPort SI = sMuxsc31;
		InputPort SEL = sel_SCBTop_SCBsc32;
		Parameter Size = 98;
	}
	ScanMux sMuxsc32 SelectedBy SCBsc32.DO {
		1'b0 : sMuxsc31;
		1'b1 : sc32.SO;
	}
	/* Scan Register 33*/
	Instance SCBsc33 Of SCB {
		InputPort SI = SCBsc32.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc33 Of SReg {
		InputPort SI = sMuxsc32;
		InputPort SEL = sel_SCBTop_SCBsc33;
		Parameter Size = 98;
	}
	ScanMux sMuxsc33 SelectedBy SCBsc33.DO {
		1'b0 : sMuxsc32;
		1'b1 : sc33.SO;
	}
	/* Scan Register 34*/
	Instance SCBsc34 Of SCB {
		InputPort SI = SCBsc33.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc34 Of SReg {
		InputPort SI = sMuxsc33;
		InputPort SEL = sel_SCBTop_SCBsc34;
		Parameter Size = 98;
	}
	ScanMux sMuxsc34 SelectedBy SCBsc34.DO {
		1'b0 : sMuxsc33;
		1'b1 : sc34.SO;
	}
	/* Scan Register 35*/
	Instance SCBsc35 Of SCB {
		InputPort SI = SCBsc34.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc35 Of SReg {
		InputPort SI = sMuxsc34;
		InputPort SEL = sel_SCBTop_SCBsc35;
		Parameter Size = 98;
	}
	ScanMux sMuxsc35 SelectedBy SCBsc35.DO {
		1'b0 : sMuxsc34;
		1'b1 : sc35.SO;
	}
	/* Scan Register 36*/
	Instance SCBsc36 Of SCB {
		InputPort SI = SCBsc35.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc36 Of SReg {
		InputPort SI = sMuxsc35;
		InputPort SEL = sel_SCBTop_SCBsc36;
		Parameter Size = 98;
	}
	ScanMux sMuxsc36 SelectedBy SCBsc36.DO {
		1'b0 : sMuxsc35;
		1'b1 : sc36.SO;
	}
	/* Scan Register 37*/
	Instance SCBsc37 Of SCB {
		InputPort SI = SCBsc36.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc37 Of SReg {
		InputPort SI = sMuxsc36;
		InputPort SEL = sel_SCBTop_SCBsc37;
		Parameter Size = 98;
	}
	ScanMux sMuxsc37 SelectedBy SCBsc37.DO {
		1'b0 : sMuxsc36;
		1'b1 : sc37.SO;
	}
	/* Scan Register 38*/
	Instance SCBsc38 Of SCB {
		InputPort SI = SCBsc37.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc38 Of SReg {
		InputPort SI = sMuxsc37;
		InputPort SEL = sel_SCBTop_SCBsc38;
		Parameter Size = 98;
	}
	ScanMux sMuxsc38 SelectedBy SCBsc38.DO {
		1'b0 : sMuxsc37;
		1'b1 : sc38.SO;
	}
	/* Scan Register 39*/
	Instance SCBsc39 Of SCB {
		InputPort SI = SCBsc38.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc39 Of SReg {
		InputPort SI = sMuxsc38;
		InputPort SEL = sel_SCBTop_SCBsc39;
		Parameter Size = 98;
	}
	ScanMux sMuxsc39 SelectedBy SCBsc39.DO {
		1'b0 : sMuxsc38;
		1'b1 : sc39.SO;
	}
	/* Scan Register 40*/
	Instance SCBsc40 Of SCB {
		InputPort SI = SCBsc39.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc40 Of SReg {
		InputPort SI = sMuxsc39;
		InputPort SEL = sel_SCBTop_SCBsc40;
		Parameter Size = 98;
	}
	ScanMux sMuxsc40 SelectedBy SCBsc40.DO {
		1'b0 : sMuxsc39;
		1'b1 : sc40.SO;
	}
	/* Scan Register 41*/
	Instance SCBsc41 Of SCB {
		InputPort SI = SCBsc40.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc41 Of SReg {
		InputPort SI = sMuxsc40;
		InputPort SEL = sel_SCBTop_SCBsc41;
		Parameter Size = 98;
	}
	ScanMux sMuxsc41 SelectedBy SCBsc41.DO {
		1'b0 : sMuxsc40;
		1'b1 : sc41.SO;
	}
	/* Scan Register 42*/
	Instance SCBsc42 Of SCB {
		InputPort SI = SCBsc41.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc42 Of SReg {
		InputPort SI = sMuxsc41;
		InputPort SEL = sel_SCBTop_SCBsc42;
		Parameter Size = 97;
	}
	ScanMux sMuxsc42 SelectedBy SCBsc42.DO {
		1'b0 : sMuxsc41;
		1'b1 : sc42.SO;
	}
	/* Scan Register 43*/
	Instance SCBsc43 Of SCB {
		InputPort SI = SCBsc42.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc43 Of SReg {
		InputPort SI = sMuxsc42;
		InputPort SEL = sel_SCBTop_SCBsc43;
		Parameter Size = 97;
	}
	ScanMux sMuxsc43 SelectedBy SCBsc43.DO {
		1'b0 : sMuxsc42;
		1'b1 : sc43.SO;
	}
	/* Scan Register 44*/
	Instance SCBsc44 Of SCB {
		InputPort SI = SCBsc43.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc44 Of SReg {
		InputPort SI = sMuxsc43;
		InputPort SEL = sel_SCBTop_SCBsc44;
		Parameter Size = 97;
	}
	ScanMux sMuxsc44 SelectedBy SCBsc44.DO {
		1'b0 : sMuxsc43;
		1'b1 : sc44.SO;
	}
	ScanMux sMuxTop SelectedBy SCBTop.DO {
		1'b0 : SCBsc44;
		1'b1 : sMuxsc44;
	}
}

/* Module 20 Level 1 Inputs 136 Outputs 12 Bidirs 72 ScanChains 44 : 181 181 181 181 180 180 180 180 180 180 180 180 180 180 180 180 180 180 180 180 180 180 180 168 168 168 168 168 168 168 168 168 168 168 168 168 168 157 133 133 133 133 133 132*/
Module M20 {
	Attribute lic = 'h 6d991ac4;
	Parameter inputs = 136;
	Parameter outputs = 12;
	Parameter bidirs = 72;
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
	LogicSignal sel_SCBTop_SCBsc30 {
		SEL & SCBTop.DO & SCBsc30.DO;
	}
	LogicSignal sel_SCBTop_SCBsc31 {
		SEL & SCBTop.DO & SCBsc31.DO;
	}
	LogicSignal sel_SCBTop_SCBsc32 {
		SEL & SCBTop.DO & SCBsc32.DO;
	}
	LogicSignal sel_SCBTop_SCBsc33 {
		SEL & SCBTop.DO & SCBsc33.DO;
	}
	LogicSignal sel_SCBTop_SCBsc34 {
		SEL & SCBTop.DO & SCBsc34.DO;
	}
	LogicSignal sel_SCBTop_SCBsc35 {
		SEL & SCBTop.DO & SCBsc35.DO;
	}
	LogicSignal sel_SCBTop_SCBsc36 {
		SEL & SCBTop.DO & SCBsc36.DO;
	}
	LogicSignal sel_SCBTop_SCBsc37 {
		SEL & SCBTop.DO & SCBsc37.DO;
	}
	LogicSignal sel_SCBTop_SCBsc38 {
		SEL & SCBTop.DO & SCBsc38.DO;
	}
	LogicSignal sel_SCBTop_SCBsc39 {
		SEL & SCBTop.DO & SCBsc39.DO;
	}
	LogicSignal sel_SCBTop_SCBsc40 {
		SEL & SCBTop.DO & SCBsc40.DO;
	}
	LogicSignal sel_SCBTop_SCBsc41 {
		SEL & SCBTop.DO & SCBsc41.DO;
	}
	LogicSignal sel_SCBTop_SCBsc42 {
		SEL & SCBTop.DO & SCBsc42.DO;
	}
	LogicSignal sel_SCBTop_SCBsc43 {
		SEL & SCBTop.DO & SCBsc43.DO;
	}
	LogicSignal sel_SCBTop_SCBsc44 {
		SEL & SCBTop.DO & SCBsc44.DO;
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
		Parameter Size = 181;
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
		Parameter Size = 181;
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
		Parameter Size = 181;
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
		Parameter Size = 181;
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
		Parameter Size = 180;
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
		Parameter Size = 180;
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
		Parameter Size = 180;
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
		Parameter Size = 180;
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
		Parameter Size = 180;
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
		Parameter Size = 180;
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
		Parameter Size = 180;
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
		Parameter Size = 180;
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
		Parameter Size = 180;
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
		Parameter Size = 180;
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
		Parameter Size = 180;
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
		Parameter Size = 180;
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
		Parameter Size = 180;
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
		Parameter Size = 180;
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
		Parameter Size = 180;
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
		Parameter Size = 180;
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
		Parameter Size = 180;
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
		Parameter Size = 180;
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
		Parameter Size = 180;
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
		Parameter Size = 168;
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
		Parameter Size = 168;
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
		Parameter Size = 168;
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
		Parameter Size = 168;
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
		Parameter Size = 168;
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
		Parameter Size = 168;
	}
	ScanMux sMuxsc29 SelectedBy SCBsc29.DO {
		1'b0 : sMuxsc28;
		1'b1 : sc29.SO;
	}
	/* Scan Register 30*/
	Instance SCBsc30 Of SCB {
		InputPort SI = SCBsc29.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc30 Of SReg {
		InputPort SI = sMuxsc29;
		InputPort SEL = sel_SCBTop_SCBsc30;
		Parameter Size = 168;
	}
	ScanMux sMuxsc30 SelectedBy SCBsc30.DO {
		1'b0 : sMuxsc29;
		1'b1 : sc30.SO;
	}
	/* Scan Register 31*/
	Instance SCBsc31 Of SCB {
		InputPort SI = SCBsc30.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc31 Of SReg {
		InputPort SI = sMuxsc30;
		InputPort SEL = sel_SCBTop_SCBsc31;
		Parameter Size = 168;
	}
	ScanMux sMuxsc31 SelectedBy SCBsc31.DO {
		1'b0 : sMuxsc30;
		1'b1 : sc31.SO;
	}
	/* Scan Register 32*/
	Instance SCBsc32 Of SCB {
		InputPort SI = SCBsc31.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc32 Of SReg {
		InputPort SI = sMuxsc31;
		InputPort SEL = sel_SCBTop_SCBsc32;
		Parameter Size = 168;
	}
	ScanMux sMuxsc32 SelectedBy SCBsc32.DO {
		1'b0 : sMuxsc31;
		1'b1 : sc32.SO;
	}
	/* Scan Register 33*/
	Instance SCBsc33 Of SCB {
		InputPort SI = SCBsc32.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc33 Of SReg {
		InputPort SI = sMuxsc32;
		InputPort SEL = sel_SCBTop_SCBsc33;
		Parameter Size = 168;
	}
	ScanMux sMuxsc33 SelectedBy SCBsc33.DO {
		1'b0 : sMuxsc32;
		1'b1 : sc33.SO;
	}
	/* Scan Register 34*/
	Instance SCBsc34 Of SCB {
		InputPort SI = SCBsc33.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc34 Of SReg {
		InputPort SI = sMuxsc33;
		InputPort SEL = sel_SCBTop_SCBsc34;
		Parameter Size = 168;
	}
	ScanMux sMuxsc34 SelectedBy SCBsc34.DO {
		1'b0 : sMuxsc33;
		1'b1 : sc34.SO;
	}
	/* Scan Register 35*/
	Instance SCBsc35 Of SCB {
		InputPort SI = SCBsc34.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc35 Of SReg {
		InputPort SI = sMuxsc34;
		InputPort SEL = sel_SCBTop_SCBsc35;
		Parameter Size = 168;
	}
	ScanMux sMuxsc35 SelectedBy SCBsc35.DO {
		1'b0 : sMuxsc34;
		1'b1 : sc35.SO;
	}
	/* Scan Register 36*/
	Instance SCBsc36 Of SCB {
		InputPort SI = SCBsc35.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc36 Of SReg {
		InputPort SI = sMuxsc35;
		InputPort SEL = sel_SCBTop_SCBsc36;
		Parameter Size = 168;
	}
	ScanMux sMuxsc36 SelectedBy SCBsc36.DO {
		1'b0 : sMuxsc35;
		1'b1 : sc36.SO;
	}
	/* Scan Register 37*/
	Instance SCBsc37 Of SCB {
		InputPort SI = SCBsc36.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc37 Of SReg {
		InputPort SI = sMuxsc36;
		InputPort SEL = sel_SCBTop_SCBsc37;
		Parameter Size = 168;
	}
	ScanMux sMuxsc37 SelectedBy SCBsc37.DO {
		1'b0 : sMuxsc36;
		1'b1 : sc37.SO;
	}
	/* Scan Register 38*/
	Instance SCBsc38 Of SCB {
		InputPort SI = SCBsc37.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc38 Of SReg {
		InputPort SI = sMuxsc37;
		InputPort SEL = sel_SCBTop_SCBsc38;
		Parameter Size = 157;
	}
	ScanMux sMuxsc38 SelectedBy SCBsc38.DO {
		1'b0 : sMuxsc37;
		1'b1 : sc38.SO;
	}
	/* Scan Register 39*/
	Instance SCBsc39 Of SCB {
		InputPort SI = SCBsc38.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc39 Of SReg {
		InputPort SI = sMuxsc38;
		InputPort SEL = sel_SCBTop_SCBsc39;
		Parameter Size = 133;
	}
	ScanMux sMuxsc39 SelectedBy SCBsc39.DO {
		1'b0 : sMuxsc38;
		1'b1 : sc39.SO;
	}
	/* Scan Register 40*/
	Instance SCBsc40 Of SCB {
		InputPort SI = SCBsc39.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc40 Of SReg {
		InputPort SI = sMuxsc39;
		InputPort SEL = sel_SCBTop_SCBsc40;
		Parameter Size = 133;
	}
	ScanMux sMuxsc40 SelectedBy SCBsc40.DO {
		1'b0 : sMuxsc39;
		1'b1 : sc40.SO;
	}
	/* Scan Register 41*/
	Instance SCBsc41 Of SCB {
		InputPort SI = SCBsc40.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc41 Of SReg {
		InputPort SI = sMuxsc40;
		InputPort SEL = sel_SCBTop_SCBsc41;
		Parameter Size = 133;
	}
	ScanMux sMuxsc41 SelectedBy SCBsc41.DO {
		1'b0 : sMuxsc40;
		1'b1 : sc41.SO;
	}
	/* Scan Register 42*/
	Instance SCBsc42 Of SCB {
		InputPort SI = SCBsc41.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc42 Of SReg {
		InputPort SI = sMuxsc41;
		InputPort SEL = sel_SCBTop_SCBsc42;
		Parameter Size = 133;
	}
	ScanMux sMuxsc42 SelectedBy SCBsc42.DO {
		1'b0 : sMuxsc41;
		1'b1 : sc42.SO;
	}
	/* Scan Register 43*/
	Instance SCBsc43 Of SCB {
		InputPort SI = SCBsc42.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc43 Of SReg {
		InputPort SI = sMuxsc42;
		InputPort SEL = sel_SCBTop_SCBsc43;
		Parameter Size = 133;
	}
	ScanMux sMuxsc43 SelectedBy SCBsc43.DO {
		1'b0 : sMuxsc42;
		1'b1 : sc43.SO;
	}
	/* Scan Register 44*/
	Instance SCBsc44 Of SCB {
		InputPort SI = SCBsc43.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc44 Of SReg {
		InputPort SI = sMuxsc43;
		InputPort SEL = sel_SCBTop_SCBsc44;
		Parameter Size = 132;
	}
	ScanMux sMuxsc44 SelectedBy SCBsc44.DO {
		1'b0 : sMuxsc43;
		1'b1 : sc44.SO;
	}
	
	Instance SCBM21 Of SCB {
        InputPort SI = SCBsc44.SO;
        InputPort SEL = sel_nSCBTop;
    }
    Instance m21 Of EmptyModule_NoBidirs  {
        InputPort SI = sMuxsc44; 
        Parameter inputs = 79;
        Parameter outputs = 34;
        InputPort SEL = sel_SCBTop_SCBM21;
    }
    LogicSignal sel_SCBTop_SCBM21 {
        SEL & SCBTop.DO & SCBM21.DO;
    }
    ScanMux sMuxM21 SelectedBy SCBM21.DO {
        1'b0 : sMuxsc44;
        1'b1 : m21;
    }
	
	Instance SCBM22 Of SCB {
        InputPort SI = SCBM21.SO;
        InputPort SEL = sel_nSCBTop;
    }
    Instance m22 Of EmptyModule_NoBidirs  {
        InputPort SI = sMuxM21; 
        Parameter inputs = 42;
        Parameter outputs = 34;
        InputPort SEL = sel_SCBTop_SCBM22;
    }
    LogicSignal sel_SCBTop_SCBM22 {
        SEL & SCBTop.DO & SCBM22.DO;
    }
    ScanMux sMuxM22 SelectedBy SCBM22.DO {
        1'b0 : sMuxM21;
        1'b1 : m22;
    }
	
	ScanMux sMuxTop SelectedBy SCBTop.DO {
		1'b0 : SCBM22.SO;
		1'b1 : sMuxM22;
	}
}


/* Module 23 Level 1 Inputs 105 Outputs 28 Bidirs 72 ScanChains 46 : 175 175 175 175 171 171 171 171 171 171 171 171 171 171 171 171 171 171 171 171 171 171 171 171 171 171 171 171 171 171 171 171 170 170 170 170 170 170 170 170 170 155 155 155 155 1*/
Module M23 {
	Attribute lic = 'h 60ea2188;
	Parameter inputs = 105;
	Parameter outputs = 28;
	Parameter bidirs = 72;
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
	LogicSignal sel_SCBTop_SCBsc30 {
		SEL & SCBTop.DO & SCBsc30.DO;
	}
	LogicSignal sel_SCBTop_SCBsc31 {
		SEL & SCBTop.DO & SCBsc31.DO;
	}
	LogicSignal sel_SCBTop_SCBsc32 {
		SEL & SCBTop.DO & SCBsc32.DO;
	}
	LogicSignal sel_SCBTop_SCBsc33 {
		SEL & SCBTop.DO & SCBsc33.DO;
	}
	LogicSignal sel_SCBTop_SCBsc34 {
		SEL & SCBTop.DO & SCBsc34.DO;
	}
	LogicSignal sel_SCBTop_SCBsc35 {
		SEL & SCBTop.DO & SCBsc35.DO;
	}
	LogicSignal sel_SCBTop_SCBsc36 {
		SEL & SCBTop.DO & SCBsc36.DO;
	}
	LogicSignal sel_SCBTop_SCBsc37 {
		SEL & SCBTop.DO & SCBsc37.DO;
	}
	LogicSignal sel_SCBTop_SCBsc38 {
		SEL & SCBTop.DO & SCBsc38.DO;
	}
	LogicSignal sel_SCBTop_SCBsc39 {
		SEL & SCBTop.DO & SCBsc39.DO;
	}
	LogicSignal sel_SCBTop_SCBsc40 {
		SEL & SCBTop.DO & SCBsc40.DO;
	}
	LogicSignal sel_SCBTop_SCBsc41 {
		SEL & SCBTop.DO & SCBsc41.DO;
	}
	LogicSignal sel_SCBTop_SCBsc42 {
		SEL & SCBTop.DO & SCBsc42.DO;
	}
	LogicSignal sel_SCBTop_SCBsc43 {
		SEL & SCBTop.DO & SCBsc43.DO;
	}
	LogicSignal sel_SCBTop_SCBsc44 {
		SEL & SCBTop.DO & SCBsc44.DO;
	}
	LogicSignal sel_SCBTop_SCBsc45 {
		SEL & SCBTop.DO & SCBsc45.DO;
	}
	LogicSignal sel_SCBTop_SCBsc46 {
		SEL & SCBTop.DO & SCBsc46.DO;
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
		Parameter Size = 175;
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
		Parameter Size = 175;
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
		Parameter Size = 175;
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
		Parameter Size = 175;
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
		Parameter Size = 171;
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
		Parameter Size = 171;
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
		Parameter Size = 171;
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
		Parameter Size = 171;
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
		Parameter Size = 171;
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
		Parameter Size = 171;
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
		Parameter Size = 171;
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
		Parameter Size = 171;
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
		Parameter Size = 171;
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
		Parameter Size = 171;
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
		Parameter Size = 171;
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
		Parameter Size = 171;
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
		Parameter Size = 171;
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
		Parameter Size = 171;
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
		Parameter Size = 171;
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
		Parameter Size = 171;
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
		Parameter Size = 171;
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
		Parameter Size = 171;
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
		Parameter Size = 171;
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
		Parameter Size = 171;
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
		Parameter Size = 171;
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
		Parameter Size = 171;
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
		Parameter Size = 171;
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
		Parameter Size = 171;
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
		Parameter Size = 171;
	}
	ScanMux sMuxsc29 SelectedBy SCBsc29.DO {
		1'b0 : sMuxsc28;
		1'b1 : sc29.SO;
	}
	/* Scan Register 30*/
	Instance SCBsc30 Of SCB {
		InputPort SI = SCBsc29.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc30 Of SReg {
		InputPort SI = sMuxsc29;
		InputPort SEL = sel_SCBTop_SCBsc30;
		Parameter Size = 171;
	}
	ScanMux sMuxsc30 SelectedBy SCBsc30.DO {
		1'b0 : sMuxsc29;
		1'b1 : sc30.SO;
	}
	/* Scan Register 31*/
	Instance SCBsc31 Of SCB {
		InputPort SI = SCBsc30.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc31 Of SReg {
		InputPort SI = sMuxsc30;
		InputPort SEL = sel_SCBTop_SCBsc31;
		Parameter Size = 171;
	}
	ScanMux sMuxsc31 SelectedBy SCBsc31.DO {
		1'b0 : sMuxsc30;
		1'b1 : sc31.SO;
	}
	/* Scan Register 32*/
	Instance SCBsc32 Of SCB {
		InputPort SI = SCBsc31.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc32 Of SReg {
		InputPort SI = sMuxsc31;
		InputPort SEL = sel_SCBTop_SCBsc32;
		Parameter Size = 171;
	}
	ScanMux sMuxsc32 SelectedBy SCBsc32.DO {
		1'b0 : sMuxsc31;
		1'b1 : sc32.SO;
	}
	/* Scan Register 33*/
	Instance SCBsc33 Of SCB {
		InputPort SI = SCBsc32.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc33 Of SReg {
		InputPort SI = sMuxsc32;
		InputPort SEL = sel_SCBTop_SCBsc33;
		Parameter Size = 170;
	}
	ScanMux sMuxsc33 SelectedBy SCBsc33.DO {
		1'b0 : sMuxsc32;
		1'b1 : sc33.SO;
	}
	/* Scan Register 34*/
	Instance SCBsc34 Of SCB {
		InputPort SI = SCBsc33.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc34 Of SReg {
		InputPort SI = sMuxsc33;
		InputPort SEL = sel_SCBTop_SCBsc34;
		Parameter Size = 170;
	}
	ScanMux sMuxsc34 SelectedBy SCBsc34.DO {
		1'b0 : sMuxsc33;
		1'b1 : sc34.SO;
	}
	/* Scan Register 35*/
	Instance SCBsc35 Of SCB {
		InputPort SI = SCBsc34.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc35 Of SReg {
		InputPort SI = sMuxsc34;
		InputPort SEL = sel_SCBTop_SCBsc35;
		Parameter Size = 170;
	}
	ScanMux sMuxsc35 SelectedBy SCBsc35.DO {
		1'b0 : sMuxsc34;
		1'b1 : sc35.SO;
	}
	/* Scan Register 36*/
	Instance SCBsc36 Of SCB {
		InputPort SI = SCBsc35.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc36 Of SReg {
		InputPort SI = sMuxsc35;
		InputPort SEL = sel_SCBTop_SCBsc36;
		Parameter Size = 170;
	}
	ScanMux sMuxsc36 SelectedBy SCBsc36.DO {
		1'b0 : sMuxsc35;
		1'b1 : sc36.SO;
	}
	/* Scan Register 37*/
	Instance SCBsc37 Of SCB {
		InputPort SI = SCBsc36.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc37 Of SReg {
		InputPort SI = sMuxsc36;
		InputPort SEL = sel_SCBTop_SCBsc37;
		Parameter Size = 170;
	}
	ScanMux sMuxsc37 SelectedBy SCBsc37.DO {
		1'b0 : sMuxsc36;
		1'b1 : sc37.SO;
	}
	/* Scan Register 38*/
	Instance SCBsc38 Of SCB {
		InputPort SI = SCBsc37.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc38 Of SReg {
		InputPort SI = sMuxsc37;
		InputPort SEL = sel_SCBTop_SCBsc38;
		Parameter Size = 170;
	}
	ScanMux sMuxsc38 SelectedBy SCBsc38.DO {
		1'b0 : sMuxsc37;
		1'b1 : sc38.SO;
	}
	/* Scan Register 39*/
	Instance SCBsc39 Of SCB {
		InputPort SI = SCBsc38.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc39 Of SReg {
		InputPort SI = sMuxsc38;
		InputPort SEL = sel_SCBTop_SCBsc39;
		Parameter Size = 170;
	}
	ScanMux sMuxsc39 SelectedBy SCBsc39.DO {
		1'b0 : sMuxsc38;
		1'b1 : sc39.SO;
	}
	/* Scan Register 40*/
	Instance SCBsc40 Of SCB {
		InputPort SI = SCBsc39.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc40 Of SReg {
		InputPort SI = sMuxsc39;
		InputPort SEL = sel_SCBTop_SCBsc40;
		Parameter Size = 170;
	}
	ScanMux sMuxsc40 SelectedBy SCBsc40.DO {
		1'b0 : sMuxsc39;
		1'b1 : sc40.SO;
	}
	/* Scan Register 41*/
	Instance SCBsc41 Of SCB {
		InputPort SI = SCBsc40.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc41 Of SReg {
		InputPort SI = sMuxsc40;
		InputPort SEL = sel_SCBTop_SCBsc41;
		Parameter Size = 170;
	}
	ScanMux sMuxsc41 SelectedBy SCBsc41.DO {
		1'b0 : sMuxsc40;
		1'b1 : sc41.SO;
	}
	/* Scan Register 42*/
	Instance SCBsc42 Of SCB {
		InputPort SI = SCBsc41.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc42 Of SReg {
		InputPort SI = sMuxsc41;
		InputPort SEL = sel_SCBTop_SCBsc42;
		Parameter Size = 155;
	}
	ScanMux sMuxsc42 SelectedBy SCBsc42.DO {
		1'b0 : sMuxsc41;
		1'b1 : sc42.SO;
	}
	/* Scan Register 43*/
	Instance SCBsc43 Of SCB {
		InputPort SI = SCBsc42.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc43 Of SReg {
		InputPort SI = sMuxsc42;
		InputPort SEL = sel_SCBTop_SCBsc43;
		Parameter Size = 155;
	}
	ScanMux sMuxsc43 SelectedBy SCBsc43.DO {
		1'b0 : sMuxsc42;
		1'b1 : sc43.SO;
	}
	/* Scan Register 44*/
	Instance SCBsc44 Of SCB {
		InputPort SI = SCBsc43.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc44 Of SReg {
		InputPort SI = sMuxsc43;
		InputPort SEL = sel_SCBTop_SCBsc44;
		Parameter Size = 155;
	}
	ScanMux sMuxsc44 SelectedBy SCBsc44.DO {
		1'b0 : sMuxsc43;
		1'b1 : sc44.SO;
	}
	/* Scan Register 45*/
	Instance SCBsc45 Of SCB {
		InputPort SI = SCBsc44.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc45 Of SReg {
		InputPort SI = sMuxsc44;
		InputPort SEL = sel_SCBTop_SCBsc45;
		Parameter Size = 155;
	}
	ScanMux sMuxsc45 SelectedBy SCBsc45.DO {
		1'b0 : sMuxsc44;
		1'b1 : sc45.SO;
	}
	/* Scan Register 46*/
	Instance SCBsc46 Of SCB {
		InputPort SI = SCBsc45.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc46 Of SReg {
		InputPort SI = sMuxsc45;
		InputPort SEL = sel_SCBTop_SCBsc46;
		Parameter Size = 1;
	}
	ScanMux sMuxsc46 SelectedBy SCBsc46.DO {
		1'b0 : sMuxsc45;
		1'b1 : sc46.SO;
	}
	
	Instance SCBM24 Of SCB {
        InputPort SI = SCBsc46.SO;
        InputPort SEL = sel_nSCBTop;
    }
    Instance m24 Of EmptyModule_NoBidirs  {
        InputPort SI = sMuxsc46; 
        Parameter inputs = 17;
        Parameter outputs = 4;
        InputPort SEL = sel_SCBTop_SCBM24;
    }
    LogicSignal sel_SCBTop_SCBM24 {
        SEL & SCBTop.DO & SCBM24.DO;
    }
    ScanMux sMuxM24 SelectedBy SCBM24.DO {
        1'b0 : sMuxsc46;
        1'b1 : m24;
    }
	
	Instance SCBM25 Of SCB {
        InputPort SI = SCBM24.SO;
        InputPort SEL = sel_nSCBTop;
    }
    Instance m25 Of EmptyModule_NoBidirs  {
        InputPort SI = sMuxM24; 
        Parameter inputs = 29;
        Parameter outputs = 16;
        InputPort SEL = sel_SCBTop_SCBM25;
    }
    LogicSignal sel_SCBTop_SCBM25 {
        SEL & SCBTop.DO & SCBM25.DO;
    }
    ScanMux sMuxM25 SelectedBy SCBM25.DO {
        1'b0 : sMuxM24;
        1'b1 : m25;
    }
	
	Instance SCBM26 Of SCB {
        InputPort SI = SCBM25.SO;
        InputPort SEL = sel_nSCBTop;
    }
    Instance m26 Of EmptyModule_NoBidirs  {
        InputPort SI = sMuxM25; 
        Parameter inputs = 42;
        Parameter outputs = 34;
        InputPort SEL = sel_SCBTop_SCBM26;
    }
    LogicSignal sel_SCBTop_SCBM26 {
        SEL & SCBTop.DO & SCBM26.DO;
    }
    ScanMux sMuxM26 SelectedBy SCBM26.DO {
        1'b0 : sMuxM25;
        1'b1 : m26;
    }
	
	ScanMux sMuxTop SelectedBy SCBTop.DO {
		1'b0 : SCBM26.SO;
		1'b1 : sMuxM26;
	}
}


/* Module 27 Level 1 Inputs 30 Outputs 7 Bidirs 72 ScanChains 46 : 68 68 68 68 68 68 68 68 68 68 68 68 68 68 68 68 68 68 68 68 68 68 68 68 68 68 67 67 67 67 67 67 67 67 67 67 67 67 67 67 60 60 50 50 50 50*/
Module M27 {
	Attribute lic = 'h 1dcc2a3e;
	Parameter inputs = 30;
	Parameter outputs = 7;
	Parameter bidirs = 72;
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
	LogicSignal sel_SCBTop_SCBsc30 {
		SEL & SCBTop.DO & SCBsc30.DO;
	}
	LogicSignal sel_SCBTop_SCBsc31 {
		SEL & SCBTop.DO & SCBsc31.DO;
	}
	LogicSignal sel_SCBTop_SCBsc32 {
		SEL & SCBTop.DO & SCBsc32.DO;
	}
	LogicSignal sel_SCBTop_SCBsc33 {
		SEL & SCBTop.DO & SCBsc33.DO;
	}
	LogicSignal sel_SCBTop_SCBsc34 {
		SEL & SCBTop.DO & SCBsc34.DO;
	}
	LogicSignal sel_SCBTop_SCBsc35 {
		SEL & SCBTop.DO & SCBsc35.DO;
	}
	LogicSignal sel_SCBTop_SCBsc36 {
		SEL & SCBTop.DO & SCBsc36.DO;
	}
	LogicSignal sel_SCBTop_SCBsc37 {
		SEL & SCBTop.DO & SCBsc37.DO;
	}
	LogicSignal sel_SCBTop_SCBsc38 {
		SEL & SCBTop.DO & SCBsc38.DO;
	}
	LogicSignal sel_SCBTop_SCBsc39 {
		SEL & SCBTop.DO & SCBsc39.DO;
	}
	LogicSignal sel_SCBTop_SCBsc40 {
		SEL & SCBTop.DO & SCBsc40.DO;
	}
	LogicSignal sel_SCBTop_SCBsc41 {
		SEL & SCBTop.DO & SCBsc41.DO;
	}
	LogicSignal sel_SCBTop_SCBsc42 {
		SEL & SCBTop.DO & SCBsc42.DO;
	}
	LogicSignal sel_SCBTop_SCBsc43 {
		SEL & SCBTop.DO & SCBsc43.DO;
	}
	LogicSignal sel_SCBTop_SCBsc44 {
		SEL & SCBTop.DO & SCBsc44.DO;
	}
	LogicSignal sel_SCBTop_SCBsc45 {
		SEL & SCBTop.DO & SCBsc45.DO;
	}
	LogicSignal sel_SCBTop_SCBsc46 {
		SEL & SCBTop.DO & SCBsc46.DO;
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
		Parameter Size = 68;
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
		Parameter Size = 68;
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
		Parameter Size = 68;
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
		Parameter Size = 68;
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
		Parameter Size = 68;
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
		Parameter Size = 68;
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
		Parameter Size = 68;
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
		Parameter Size = 68;
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
		Parameter Size = 68;
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
		Parameter Size = 68;
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
		Parameter Size = 68;
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
		Parameter Size = 68;
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
		Parameter Size = 68;
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
		Parameter Size = 68;
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
		Parameter Size = 68;
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
		Parameter Size = 68;
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
		Parameter Size = 68;
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
		Parameter Size = 68;
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
		Parameter Size = 68;
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
		Parameter Size = 68;
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
		Parameter Size = 68;
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
		Parameter Size = 68;
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
		Parameter Size = 68;
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
		Parameter Size = 68;
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
		Parameter Size = 68;
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
		Parameter Size = 68;
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
		Parameter Size = 67;
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
		Parameter Size = 67;
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
		Parameter Size = 67;
	}
	ScanMux sMuxsc29 SelectedBy SCBsc29.DO {
		1'b0 : sMuxsc28;
		1'b1 : sc29.SO;
	}
	/* Scan Register 30*/
	Instance SCBsc30 Of SCB {
		InputPort SI = SCBsc29.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc30 Of SReg {
		InputPort SI = sMuxsc29;
		InputPort SEL = sel_SCBTop_SCBsc30;
		Parameter Size = 67;
	}
	ScanMux sMuxsc30 SelectedBy SCBsc30.DO {
		1'b0 : sMuxsc29;
		1'b1 : sc30.SO;
	}
	/* Scan Register 31*/
	Instance SCBsc31 Of SCB {
		InputPort SI = SCBsc30.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc31 Of SReg {
		InputPort SI = sMuxsc30;
		InputPort SEL = sel_SCBTop_SCBsc31;
		Parameter Size = 67;
	}
	ScanMux sMuxsc31 SelectedBy SCBsc31.DO {
		1'b0 : sMuxsc30;
		1'b1 : sc31.SO;
	}
	/* Scan Register 32*/
	Instance SCBsc32 Of SCB {
		InputPort SI = SCBsc31.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc32 Of SReg {
		InputPort SI = sMuxsc31;
		InputPort SEL = sel_SCBTop_SCBsc32;
		Parameter Size = 67;
	}
	ScanMux sMuxsc32 SelectedBy SCBsc32.DO {
		1'b0 : sMuxsc31;
		1'b1 : sc32.SO;
	}
	/* Scan Register 33*/
	Instance SCBsc33 Of SCB {
		InputPort SI = SCBsc32.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc33 Of SReg {
		InputPort SI = sMuxsc32;
		InputPort SEL = sel_SCBTop_SCBsc33;
		Parameter Size = 67;
	}
	ScanMux sMuxsc33 SelectedBy SCBsc33.DO {
		1'b0 : sMuxsc32;
		1'b1 : sc33.SO;
	}
	/* Scan Register 34*/
	Instance SCBsc34 Of SCB {
		InputPort SI = SCBsc33.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc34 Of SReg {
		InputPort SI = sMuxsc33;
		InputPort SEL = sel_SCBTop_SCBsc34;
		Parameter Size = 67;
	}
	ScanMux sMuxsc34 SelectedBy SCBsc34.DO {
		1'b0 : sMuxsc33;
		1'b1 : sc34.SO;
	}
	/* Scan Register 35*/
	Instance SCBsc35 Of SCB {
		InputPort SI = SCBsc34.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc35 Of SReg {
		InputPort SI = sMuxsc34;
		InputPort SEL = sel_SCBTop_SCBsc35;
		Parameter Size = 67;
	}
	ScanMux sMuxsc35 SelectedBy SCBsc35.DO {
		1'b0 : sMuxsc34;
		1'b1 : sc35.SO;
	}
	/* Scan Register 36*/
	Instance SCBsc36 Of SCB {
		InputPort SI = SCBsc35.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc36 Of SReg {
		InputPort SI = sMuxsc35;
		InputPort SEL = sel_SCBTop_SCBsc36;
		Parameter Size = 67;
	}
	ScanMux sMuxsc36 SelectedBy SCBsc36.DO {
		1'b0 : sMuxsc35;
		1'b1 : sc36.SO;
	}
	/* Scan Register 37*/
	Instance SCBsc37 Of SCB {
		InputPort SI = SCBsc36.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc37 Of SReg {
		InputPort SI = sMuxsc36;
		InputPort SEL = sel_SCBTop_SCBsc37;
		Parameter Size = 67;
	}
	ScanMux sMuxsc37 SelectedBy SCBsc37.DO {
		1'b0 : sMuxsc36;
		1'b1 : sc37.SO;
	}
	/* Scan Register 38*/
	Instance SCBsc38 Of SCB {
		InputPort SI = SCBsc37.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc38 Of SReg {
		InputPort SI = sMuxsc37;
		InputPort SEL = sel_SCBTop_SCBsc38;
		Parameter Size = 67;
	}
	ScanMux sMuxsc38 SelectedBy SCBsc38.DO {
		1'b0 : sMuxsc37;
		1'b1 : sc38.SO;
	}
	/* Scan Register 39*/
	Instance SCBsc39 Of SCB {
		InputPort SI = SCBsc38.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc39 Of SReg {
		InputPort SI = sMuxsc38;
		InputPort SEL = sel_SCBTop_SCBsc39;
		Parameter Size = 67;
	}
	ScanMux sMuxsc39 SelectedBy SCBsc39.DO {
		1'b0 : sMuxsc38;
		1'b1 : sc39.SO;
	}
	/* Scan Register 40*/
	Instance SCBsc40 Of SCB {
		InputPort SI = SCBsc39.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc40 Of SReg {
		InputPort SI = sMuxsc39;
		InputPort SEL = sel_SCBTop_SCBsc40;
		Parameter Size = 67;
	}
	ScanMux sMuxsc40 SelectedBy SCBsc40.DO {
		1'b0 : sMuxsc39;
		1'b1 : sc40.SO;
	}
	/* Scan Register 41*/
	Instance SCBsc41 Of SCB {
		InputPort SI = SCBsc40.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc41 Of SReg {
		InputPort SI = sMuxsc40;
		InputPort SEL = sel_SCBTop_SCBsc41;
		Parameter Size = 60;
	}
	ScanMux sMuxsc41 SelectedBy SCBsc41.DO {
		1'b0 : sMuxsc40;
		1'b1 : sc41.SO;
	}
	/* Scan Register 42*/
	Instance SCBsc42 Of SCB {
		InputPort SI = SCBsc41.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc42 Of SReg {
		InputPort SI = sMuxsc41;
		InputPort SEL = sel_SCBTop_SCBsc42;
		Parameter Size = 60;
	}
	ScanMux sMuxsc42 SelectedBy SCBsc42.DO {
		1'b0 : sMuxsc41;
		1'b1 : sc42.SO;
	}
	/* Scan Register 43*/
	Instance SCBsc43 Of SCB {
		InputPort SI = SCBsc42.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc43 Of SReg {
		InputPort SI = sMuxsc42;
		InputPort SEL = sel_SCBTop_SCBsc43;
		Parameter Size = 50;
	}
	ScanMux sMuxsc43 SelectedBy SCBsc43.DO {
		1'b0 : sMuxsc42;
		1'b1 : sc43.SO;
	}
	/* Scan Register 44*/
	Instance SCBsc44 Of SCB {
		InputPort SI = SCBsc43.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc44 Of SReg {
		InputPort SI = sMuxsc43;
		InputPort SEL = sel_SCBTop_SCBsc44;
		Parameter Size = 50;
	}
	ScanMux sMuxsc44 SelectedBy SCBsc44.DO {
		1'b0 : sMuxsc43;
		1'b1 : sc44.SO;
	}
	/* Scan Register 45*/
	Instance SCBsc45 Of SCB {
		InputPort SI = SCBsc44.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc45 Of SReg {
		InputPort SI = sMuxsc44;
		InputPort SEL = sel_SCBTop_SCBsc45;
		Parameter Size = 50;
	}
	ScanMux sMuxsc45 SelectedBy SCBsc45.DO {
		1'b0 : sMuxsc44;
		1'b1 : sc45.SO;
	}
	/* Scan Register 46*/
	Instance SCBsc46 Of SCB {
		InputPort SI = SCBsc45.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc46 Of SReg {
		InputPort SI = sMuxsc45;
		InputPort SEL = sel_SCBTop_SCBsc46;
		Parameter Size = 50;
	}
	ScanMux sMuxsc46 SelectedBy SCBsc46.DO {
		1'b0 : sMuxsc45;
		1'b1 : sc46.SO;
	}
	
	Instance SCBM28 Of SCB {
        InputPort SI = SCBsc46.SO;
        InputPort SEL = sel_nSCBTop;
    }
    Instance m28 Of EmptyModule_NoBidirs  {
        InputPort SI = sMuxsc46; 
        Parameter inputs = 109;
        Parameter outputs = 50;
        InputPort SEL = sel_SCBTop_SCBM28;
    }
    LogicSignal sel_SCBTop_SCBM28 {
        SEL & SCBTop.DO & SCBM28.DO;
    }
    ScanMux sMuxM28 SelectedBy SCBM28.DO {
        1'b0 : sMuxsc46;
        1'b1 : m28;
    }
	ScanMux sMuxTop SelectedBy SCBTop.DO {
		1'b0 : SCBM28.SO;
		1'b1 : sMuxM28;
	}
}


/* Module 29 Level 1 Inputs 117 Outputs 42 Bidirs 72 ScanChains 35 : 189 188 188 188 188 188 187 187 187 187 187 187 186 186 186 186 186 186 186 186 186 186 186 186 186 186 186 186 186 186 186 185 185 185 185*/
Module M29 {
	Attribute lic = 'h 2053e58e;
	Parameter inputs = 117;
	Parameter outputs = 42;
	Parameter bidirs = 72;
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
	LogicSignal sel_SCBTop_SCBsc30 {
		SEL & SCBTop.DO & SCBsc30.DO;
	}
	LogicSignal sel_SCBTop_SCBsc31 {
		SEL & SCBTop.DO & SCBsc31.DO;
	}
	LogicSignal sel_SCBTop_SCBsc32 {
		SEL & SCBTop.DO & SCBsc32.DO;
	}
	LogicSignal sel_SCBTop_SCBsc33 {
		SEL & SCBTop.DO & SCBsc33.DO;
	}
	LogicSignal sel_SCBTop_SCBsc34 {
		SEL & SCBTop.DO & SCBsc34.DO;
	}
	LogicSignal sel_SCBTop_SCBsc35 {
		SEL & SCBTop.DO & SCBsc35.DO;
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
		Parameter Size = 189;
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
		Parameter Size = 188;
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
		Parameter Size = 188;
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
		Parameter Size = 188;
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
		Parameter Size = 188;
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
		Parameter Size = 188;
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
		Parameter Size = 187;
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
		Parameter Size = 187;
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
		Parameter Size = 187;
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
		Parameter Size = 187;
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
		Parameter Size = 187;
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
		Parameter Size = 187;
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
		Parameter Size = 186;
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
		Parameter Size = 186;
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
		Parameter Size = 186;
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
		Parameter Size = 186;
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
		Parameter Size = 186;
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
		Parameter Size = 186;
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
		Parameter Size = 186;
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
		Parameter Size = 186;
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
		Parameter Size = 186;
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
		Parameter Size = 186;
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
		Parameter Size = 186;
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
		Parameter Size = 186;
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
		Parameter Size = 186;
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
		Parameter Size = 186;
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
		Parameter Size = 186;
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
		Parameter Size = 186;
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
		Parameter Size = 186;
	}
	ScanMux sMuxsc29 SelectedBy SCBsc29.DO {
		1'b0 : sMuxsc28;
		1'b1 : sc29.SO;
	}
	/* Scan Register 30*/
	Instance SCBsc30 Of SCB {
		InputPort SI = SCBsc29.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc30 Of SReg {
		InputPort SI = sMuxsc29;
		InputPort SEL = sel_SCBTop_SCBsc30;
		Parameter Size = 186;
	}
	ScanMux sMuxsc30 SelectedBy SCBsc30.DO {
		1'b0 : sMuxsc29;
		1'b1 : sc30.SO;
	}
	/* Scan Register 31*/
	Instance SCBsc31 Of SCB {
		InputPort SI = SCBsc30.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc31 Of SReg {
		InputPort SI = sMuxsc30;
		InputPort SEL = sel_SCBTop_SCBsc31;
		Parameter Size = 186;
	}
	ScanMux sMuxsc31 SelectedBy SCBsc31.DO {
		1'b0 : sMuxsc30;
		1'b1 : sc31.SO;
	}
	/* Scan Register 32*/
	Instance SCBsc32 Of SCB {
		InputPort SI = SCBsc31.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc32 Of SReg {
		InputPort SI = sMuxsc31;
		InputPort SEL = sel_SCBTop_SCBsc32;
		Parameter Size = 185;
	}
	ScanMux sMuxsc32 SelectedBy SCBsc32.DO {
		1'b0 : sMuxsc31;
		1'b1 : sc32.SO;
	}
	/* Scan Register 33*/
	Instance SCBsc33 Of SCB {
		InputPort SI = SCBsc32.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc33 Of SReg {
		InputPort SI = sMuxsc32;
		InputPort SEL = sel_SCBTop_SCBsc33;
		Parameter Size = 185;
	}
	ScanMux sMuxsc33 SelectedBy SCBsc33.DO {
		1'b0 : sMuxsc32;
		1'b1 : sc33.SO;
	}
	/* Scan Register 34*/
	Instance SCBsc34 Of SCB {
		InputPort SI = SCBsc33.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc34 Of SReg {
		InputPort SI = sMuxsc33;
		InputPort SEL = sel_SCBTop_SCBsc34;
		Parameter Size = 185;
	}
	ScanMux sMuxsc34 SelectedBy SCBsc34.DO {
		1'b0 : sMuxsc33;
		1'b1 : sc34.SO;
	}
	/* Scan Register 35*/
	Instance SCBsc35 Of SCB {
		InputPort SI = SCBsc34.SO;
		InputPort SEL = sel_nSCBTop;
	}
	Instance sc35 Of SReg {
		InputPort SI = sMuxsc34;
		InputPort SEL = sel_SCBTop_SCBsc35;
		Parameter Size = 185;
	}
	ScanMux sMuxsc35 SelectedBy SCBsc35.DO {
		1'b0 : sMuxsc34;
		1'b1 : sc35.SO;
	}
	
	Instance SCBM30 Of SCB {
        InputPort SI = SCBsc35.SO;
        InputPort SEL = sel_nSCBTop;
    }
    Instance m30 Of EmptyModule_NoBidirs  {
        InputPort SI = sMuxsc35; 
        Parameter inputs = 43;
        Parameter outputs = 34;
        InputPort SEL = sel_SCBTop_SCBM30;
    }
    LogicSignal sel_SCBTop_SCBM30 {
        SEL & SCBTop.DO & SCBM30.DO;
    }
    ScanMux sMuxM30 SelectedBy SCBM30.DO {
        1'b0 : sMuxsc35;
        1'b1 : m30;
    }
	
	Instance SCBM31 Of SCB {
        InputPort SI = SCBM30.SO;
        InputPort SEL = sel_nSCBTop;
    }
    Instance m31 Of EmptyModule_NoBidirs  {
        InputPort SI = sMuxM30; 
        Parameter inputs = 148;
        Parameter outputs = 70;
        InputPort SEL = sel_SCBTop_SCBM31;
    }
    LogicSignal sel_SCBTop_SCBM31 {
        SEL & SCBTop.DO & SCBM31.DO;
    }
    ScanMux sMuxM31 SelectedBy SCBM31.DO {
        1'b0 : sMuxM30;
        1'b1 : m31;
    }
	
	Instance SCBM32 Of SCB {
        InputPort SI = SCBM31.SO;
        InputPort SEL = sel_nSCBTop;
    }
    Instance m32 Of EmptyModule_NoBidirs  {
        InputPort SI = sMuxM31; 
        Parameter inputs = 268;
        Parameter outputs = 128;
        InputPort SEL = sel_SCBTop_SCBM32;
    }
    LogicSignal sel_SCBTop_SCBM32 {
        SEL & SCBTop.DO & SCBM32.DO;
    }
    ScanMux sMuxM32 SelectedBy SCBM32.DO {
        1'b0 : sMuxM31;
        1'b1 : m32;
    }
	
	ScanMux sMuxTop SelectedBy SCBTop.DO {
		1'b0 : SCBM32.SO;
		1'b1 : sMuxM32;
	}
}
