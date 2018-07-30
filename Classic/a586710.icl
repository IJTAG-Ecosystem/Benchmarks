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
* CLASSIC benchmark based on ITC'02 A586710 and ScanMux Control Bit (SCB) network 
* design strategy.
*
* Uses modules from files: 
* - Instruments.icl
* - NetworkStructs.icl
* - EmptyModule.icl
*/

NameSpace a586710;
UseNameSpace root;
Module M0 {
    Attribute lic = 'h 866650c0;
    Parameter inputs = 31;
    Parameter outputs = 59;
    Parameter bidirs = 111;

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
    LogicSignal sel_SCBTop_SCBM5 {
        SEL & SCBTop.DO & SCBM5.DO;
    }
    LogicSignal sel_SCBTop_SCBM6 {
        SEL & SCBTop.DO & SCBM6.DO;
    }
    LogicSignal sel_SCBTop_SCBM7 {
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
    Instance m1 Of a586710::M1 {
        InputPort SI = sMuxOutputs; 
        InputPort SEL = sel_SCBTop_SCBM1;
    }
   
    ScanMux sMuxM1 SelectedBy SCBM1.DO {
        1'b0 : sMuxOutputs;
        1'b1 : m1;
    }
    
    Instance SCBM5 Of SCB {
        InputPort SI = SCBM1.SO;
        InputPort SEL = sel_nSCBTop;
    }
    Instance m5 Of a586710::M5 {
        InputPort SI = sMuxM1;
        InputPort SEL = sel_SCBTop_SCBM5; 
    }
    ScanMux sMuxM5 SelectedBy SCBM5.DO {
        1'b0 : sMuxM1;
        1'b1 : m5;
    }
    
    Instance SCBM6 Of SCB {
        InputPort SI = SCBM5.SO;
        InputPort SEL = sel_nSCBTop;
    }
    Instance m6 Of EmptyModule_NoBidirs  {
        InputPort SI = sMuxM5; 
        Parameter inputs = 34;
        Parameter outputs = 35;
        InputPort SEL = sel_SCBTop_SCBM6;
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
        Parameter inputs = 226;
        Parameter outputs = 100;
        InputPort SEL = sel_SCBTop_SCBM7;
    }
    
    ScanMux sMuxM7 SelectedBy SCBM7.DO {
        1'b0 : sMuxM6;
        1'b1 : m7;
    }
    
    ScanMux sMuxTop SelectedBy SCBTop.DO {
        1'b0 : SCBM7.SO;
        1'b1 : sMuxM7;
    }
}


Module M1 {
    Attribute lic = 'h f83040cf;
    Parameter inputs = 437;
    Parameter outputs = 370;
    Parameter bidirs = 2;

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
    LogicSignal sel_SCBTop_SCBM2 {
        SEL & SCBTop.DO & SCBM2.DO;
    }
    LogicSignal sel_SCBTop_SCBM3 {
        SEL & SCBTop.DO & SCBM3.DO;
    }
    LogicSignal sel_SCBTop_SCBM4 {
        SEL & SCBTop.DO & SCBM4.DO;
    }
    LogicSignal sel_SCBTop_SCBsc1 {
        SEL & SCBTop.DO & SCBMsc1.DO;
    }
	LogicSignal sel_SCBTop_SCBsc2 {
        SEL & SCBTop.DO & SCBMsc2.DO;
    }
	LogicSignal sel_SCBTop_SCBsc3 {
        SEL & SCBTop.DO & SCBMsc3.DO;
    }
	LogicSignal sel_SCBTop_SCBsc4 {
        SEL & SCBTop.DO & SCBMsc4.DO;
    }
	LogicSignal sel_SCBTop_SCBsc5 {
        SEL & SCBTop.DO & SCBMsc5.DO;
    }
	LogicSignal sel_SCBTop_SCBsc6 {
        SEL & SCBTop.DO & SCBMsc6.DO;
    }
	LogicSignal sel_SCBTop_SCBsc7 {
        SEL & SCBTop.DO & SCBMsc7.DO;
    }
	LogicSignal sel_SCBTop_SCBsc8 {
        SEL & SCBTop.DO & SCBMsc8.DO;
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
    
    
    Instance SCBsc1 Of SCB {
        InputPort SI = SCBOut.SO;
        InputPort SEL = sel_nSCBTop;
    } 
    Instance sChain1 Of SReg {
        InputPort SI = sMuxOutputs; 
        InputPort SEL = sel_SCBTop_SCBsc1;
        Parameter Size = 2155;
    }
    ScanMux sMuxsc1 SelectedBy SCBsc1.DO {
        1'b0 : sMuxOutputs;
        1'b1 : sChain1.SO;
    }
    
	Instance SCBsc2 Of SCB {
        InputPort SI = SCBsc1.SO;
        InputPort SEL = sel_nSCBTop;
    } 
    Instance sChain2 Of SReg {
        InputPort SI = sMuxsc1; 
        InputPort SEL = sel_SCBTop_SCBsc2;
        Parameter Size = 2155;
    }
    ScanMux sMuxsc2 SelectedBy SCBsc2.DO {
        1'b0 : sMuxsc1;
        1'b1 : sChain2.SO;
    }
	
	Instance SCBsc3 Of SCB {
        InputPort SI = SCBsc2.SO;
        InputPort SEL = sel_nSCBTop;
    } 
    Instance sChain3 Of SReg {
        InputPort SI = sMuxsc2; 
        InputPort SEL = sel_SCBTop_SCBsc3;
        Parameter Size = 2141;
    }
    ScanMux sMuxsc3 SelectedBy SCBsc3.DO {
        1'b0 : sMuxsc2;
        1'b1 : sChain3.SO;
    }
	
	Instance SCBsc4 Of SCB {
        InputPort SI = SCBsc3.SO;
        InputPort SEL = sel_nSCBTop;
    } 
    Instance sChain4 Of SReg {
        InputPort SI = sMuxsc3; 
        InputPort SEL = sel_SCBTop_SCBsc4;
        Parameter Size = 2155;
    }
    ScanMux sMuxsc4 SelectedBy SCBsc4.DO {
        1'b0 : sMuxsc3;
        1'b1 : sChain4.SO;
    }
	
	Instance SCBsc5 Of SCB {
        InputPort SI = SCBsc4.SO;
        InputPort SEL = sel_nSCBTop;
    } 
    Instance sChain5 Of SReg {
        InputPort SI = sMuxsc4; 
        InputPort SEL = sel_SCBTop_SCBsc5;
        Parameter Size = 2155;
    }
    ScanMux sMuxsc5 SelectedBy SCBsc5.DO {
        1'b0 : sMuxsc4;
        1'b1 : sChain5.SO;
    }
	
	Instance SCBsc6 Of SCB {
        InputPort SI = SCBsc5.SO;
        InputPort SEL = sel_nSCBTop;
    } 
    Instance sChain6 Of SReg {
        InputPort SI = sMuxsc5; 
        InputPort SEL = sel_SCBTop_SCBsc6;
        Parameter Size = 2155;
    }
    ScanMux sMuxsc6 SelectedBy SCBsc6.DO {
        1'b0 : sMuxsc5;
        1'b1 : sChain6.SO;
    }
	
	Instance SCBsc7 Of SCB {
        InputPort SI = SCBsc6.SO;
        InputPort SEL = sel_nSCBTop;
    } 
    Instance sChain7 Of SReg {
        InputPort SI = sMuxsc6; 
        InputPort SEL = sel_SCBTop_SCBsc7;
        Parameter Size = 2155;
    }
    ScanMux sMuxsc7 SelectedBy SCBsc7.DO {
        1'b0 : sMuxsc6;
        1'b1 : sChain7.SO;
    }
	
	Instance SCBsc8 Of SCB {
        InputPort SI = SCBsc7.SO;
        InputPort SEL = sel_nSCBTop;
    } 
    Instance sChain8 Of SReg {
        InputPort SI = sMuxsc7; 
        InputPort SEL = sel_SCBTop_SCBsc8;
        Parameter Size = 2155;
    }
    ScanMux sMuxsc8 SelectedBy SCBsc8.DO {
        1'b0 : sMuxsc7;
        1'b1 : sChain8.SO;
    }
    
    
    Instance SCBM2 Of SCB {
        InputPort SI = SCBsc8.SO;
        InputPort SEL = sel_nSCBTop;
    }
    Instance m2 Of EmptyModule_NoBidirs  {
        InputPort SI = sMuxsc8; 
        Parameter inputs = 275;
        Parameter outputs = 222;
        InputPort SEL = sel_SCBTop_SCBM2;
    }
    
    ScanMux sMuxM2 SelectedBy SCBM2.DO {
        1'b0 : sMuxsc8;
        1'b1 : m2;
    }
    
	Instance SCBM3 Of SCB {
        InputPort SI = SCBM2.SO;
        InputPort SEL = sel_nSCBTop;
    }
    Instance m3 Of EmptyModule_NoBidirs  {
        InputPort SI = sMuxM2; 
        Parameter inputs = 407;
        Parameter outputs = 244;
        InputPort SEL = sel_SCBTop_SCBM3;
    }
    
    ScanMux sMuxM3 SelectedBy SCBM3.DO {
        1'b0 : sMuxM2;
        1'b1 : m3;
    }
	
	Instance SCBM4 Of SCB {
        InputPort SI = SCBM3.SO;
        InputPort SEL = sel_nSCBTop;
    }
    Instance m4 Of EmptyModule_NoBidirs  {
        InputPort SI = sMuxM3; 
        Parameter inputs = 206;
        Parameter outputs = 324;
        InputPort SEL = sel_SCBTop_SCBM4;
    }
    
    ScanMux sMuxM4 SelectedBy SCBM4.DO {
        1'b0 : sMuxM3;
        1'b1 : m4;
    }
	
	ScanMux sMuxTop SelectedBy SCBTop.DO {
        1'b0 : SCBM4.SO;
        1'b1 : sMuxM4;
    }
}


Module M5 {
    Attribute lic = 'h 7f78493e;
    Parameter inputs = 343;
    Parameter outputs = 218;
    Parameter bidirs = 111;

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
        SEL & SCBTop.DO & SCBMsc1.DO;
    }
	LogicSignal sel_SCBTop_SCBsc2 {
        SEL & SCBTop.DO & SCBMsc2.DO;
    }
	LogicSignal sel_SCBTop_SCBsc3 {
        SEL & SCBTop.DO & SCBMsc3.DO;
    }
	LogicSignal sel_SCBTop_SCBsc4 {
        SEL & SCBTop.DO & SCBMsc4.DO;
    }
	LogicSignal sel_SCBTop_SCBsc5 {
        SEL & SCBTop.DO & SCBMsc5.DO;
    }
	LogicSignal sel_SCBTop_SCBsc6 {
        SEL & SCBTop.DO & SCBMsc6.DO;
    }
	LogicSignal sel_SCBTop_SCBsc7 {
        SEL & SCBTop.DO & SCBMsc7.DO;
    }
	LogicSignal sel_SCBTop_SCBsc8 {
        SEL & SCBTop.DO & SCBMsc8.DO;
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
    
    
    Instance SCBsc1 Of SCB {
        InputPort SI = SCBOut.SO;
        InputPort SEL = sel_nSCBTop;
    } 
    Instance sChain1 Of SReg {
        InputPort SI = sMuxOutputs; 
        InputPort SEL = sel_SCBTop_SCBsc1;
        Parameter Size = 2548;
    }
    ScanMux sMuxsc1 SelectedBy SCBsc1.DO {
        1'b0 : sMuxOutputs;
        1'b1 : sChain1.SO;
    }
    
	Instance SCBsc2 Of SCB {
        InputPort SI = SCBsc1.SO;
        InputPort SEL = sel_nSCBTop;
    } 
    Instance sChain2 Of SReg {
        InputPort SI = sMuxsc1; 
        InputPort SEL = sel_SCBTop_SCBsc2;
        Parameter Size = 2548;
    }
    ScanMux sMuxsc2 SelectedBy SCBsc2.DO {
        1'b0 : sMuxsc1;
        1'b1 : sChain2.SO;
    }
	
	Instance SCBsc3 Of SCB {
        InputPort SI = SCBsc2.SO;
        InputPort SEL = sel_nSCBTop;
    } 
    Instance sChain3 Of SReg {
        InputPort SI = sMuxsc2; 
        InputPort SEL = sel_SCBTop_SCBsc3;
        Parameter Size = 2540;
    }
    ScanMux sMuxsc3 SelectedBy SCBsc3.DO {
        1'b0 : sMuxsc2;
        1'b1 : sChain3.SO;
    }
	
	Instance SCBsc4 Of SCB {
        InputPort SI = SCBsc3.SO;
        InputPort SEL = sel_nSCBTop;
    } 
    Instance sChain4 Of SReg {
        InputPort SI = sMuxsc3; 
        InputPort SEL = sel_SCBTop_SCBsc4;
        Parameter Size = 2540;
    }
    ScanMux sMuxsc4 SelectedBy SCBsc4.DO {
        1'b0 : sMuxsc3;
        1'b1 : sChain4.SO;
    }
	
	Instance SCBsc5 Of SCB {
        InputPort SI = SCBsc4.SO;
        InputPort SEL = sel_nSCBTop;
    } 
    Instance sChain5 Of SReg {
        InputPort SI = sMuxsc4; 
        InputPort SEL = sel_SCBTop_SCBsc5;
        Parameter Size = 2548;
    }
    ScanMux sMuxsc5 SelectedBy SCBsc5.DO {
        1'b0 : sMuxsc4;
        1'b1 : sChain5.SO;
    }
	
	Instance SCBsc6 Of SCB {
        InputPort SI = SCBsc5.SO;
        InputPort SEL = sel_nSCBTop;
    } 
    Instance sChain6 Of SReg {
        InputPort SI = sMuxsc5; 
        InputPort SEL = sel_SCBTop_SCBsc6;
        Parameter Size = 2532;
    }
    ScanMux sMuxsc6 SelectedBy SCBsc6.DO {
        1'b0 : sMuxsc5;
        1'b1 : sChain6.SO;
    }
	
	Instance SCBsc7 Of SCB {
        InputPort SI = SCBsc6.SO;
        InputPort SEL = sel_nSCBTop;
    } 
    Instance sChain7 Of SReg {
        InputPort SI = sMuxsc6; 
        InputPort SEL = sel_SCBTop_SCBsc7;
        Parameter Size = 2548;
    }
    ScanMux sMuxsc7 SelectedBy SCBsc7.DO {
        1'b0 : sMuxsc6;
        1'b1 : sChain7.SO;
    }
	
	Instance SCBsc8 Of SCB {
        InputPort SI = SCBsc7.SO;
        InputPort SEL = sel_nSCBTop;
    } 
    Instance sChain8 Of SReg {
        InputPort SI = sMuxsc7; 
        InputPort SEL = sel_SCBTop_SCBsc8;
        Parameter Size = 2626;
    }
    ScanMux sMuxsc8 SelectedBy SCBsc8.DO {
        1'b0 : sMuxsc7;
        1'b1 : sChain8.SO;
    }
	
	ScanMux sMuxTop SelectedBy SCBTop.DO {
        1'b0 : SCBsc8.SO;
        1'b1 : sMuxsc8;
    }
}
