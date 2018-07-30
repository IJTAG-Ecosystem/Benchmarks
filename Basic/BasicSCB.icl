/*
* Copyright Testonica Lab (C) 2016
*
* History:
* -------------+------------+-------------------------+------------------------
*   Version    |  Date      | Author                  | Organization
* -------------+------------+-------------------------+------------------------
*          1.0 | 8.03.2016  | Anton Tsertov           | Testonica Lab
*--------------+------------+-------------------------+------------------------
*          2.0 | 12.05.2016 | Anton Tsertov           | Testonica Lab
*--------------+------------+-------------------------+------------------------
*          2.1 | 13.09.2016 | Riccardo Cantoro        | Politecnico di Torino
*--------------+------------+-------------------------+------------------------
*
* Uses modules from files: Instruments.icl, NetworkStructs.icl
*
*/


Module BasicSCB {
    Attribute lic = 'h 51bd3f87;
    Parameter regSize = 32;
    Parameter regSize1 = $regSize;
    Parameter regSize2 = $regSize;
    Parameter regSize3 = $regSize;
    Parameter regSize4 = $regSize;
    Parameter regSize5 = $regSize;
    ScanInPort SI;
    CaptureEnPort CE;
    ShiftEnPort SE;
    UpdateEnPort UE;
    SelectPort SEL;
    ResetPort RST;
    TCKPort TCK;
    ScanOutPort SO {
        Source SCB7.SO;
    }
	LogicSignal sel_SCB1_SCB3 {
		SEL & SCB1.DO & SCB3.DO;
	}
	LogicSignal sel_nSCB1_SCB3 {
		SEL & ~SCB1.DO & SCB3.DO;
	}
	LogicSignal sel_nSCB3 {
		SEL & ~SCB3.DO;
	}
	LogicSignal sel_SCB2_SCB3 {
		SEL & SCB2.DO & SCB3.DO;
	}
	LogicSignal sel_SCB4_nSCB5_SCB6_nSCB7 {
		SEL & SCB4.DO & ~SCB5.DO & SCB6.DO & ~SCB7.DO;
	}
	LogicSignal sel_nSCB4_nSCB5_SCB6_nSCB7 {
		SEL & ~SCB4.DO & ~SCB5.DO & SCB6.DO & ~SCB7.DO;
	}
	LogicSignal sel_nSCB6_nSCB7 {
		SEL & ~SCB6.DO & ~SCB7.DO;
	}
	LogicSignal sel_nSCB5_SCB6_nSCB7 {
		SEL & ~SCB5.DO & SCB6.DO & ~SCB7.DO;
	}
	LogicSignal sel_SCB5_SCB6_nSCB7 {
		SEL & SCB5.DO & SCB6.DO & ~SCB7.DO;
	}
	LogicSignal sel_nSCB7 {
		SEL & ~SCB7.DO;
	}
	LogicSignal sel_nSCB2_SCB3 {
		SEL & ~SCB2.DO & SCB3.DO;
	}
	LogicSignal sel_nSCB2_SCB3_SCB8_SCB10 {
		SEL & ~SCB2.DO & SCB3.DO & SCB8.DO & SCB10.DO;
	}
	LogicSignal sel_nSCB2_nSCB8 {
		SEL & ~SCB2.DO & ~SCB8.DO;
	}
	LogicSignal sel_nSCB2_nSCB10_SCB3 {
		SEL & ~SCB2.DO & ~SCB10.DO & SCB3.DO;
	}
	LogicSignal sel_nSCB2_SCB10_SCB9_SCB3 {
		SEL & ~SCB2.DO & SCB10.DO & SCB9.DO & SCB3.DO;
	}
	LogicSignal sel_nSCB2_SCB10_nSCB9_SCB3 {
		SEL & ~SCB2.DO & SCB10.DO & ~SCB9.DO & SCB3.DO;
	}

	Instance WI1 Of WrappedInstr {
		InputPort SI = SI;
		InputPort SEL = sel_SCB1_SCB3;
		Parameter Size = $regSize1;
	}
	Instance Void1 Of BypassReg {
		InputPort SI = SI;
		InputPort SEL = sel_nSCB1_SCB3;
	}
	Instance SCB1 Of SCB {
		InputPort SI = SI;
		InputPort SEL = sel_nSCB3;
	}
	ScanMux sMux1 SelectedBy SCB1.DO {
		1'b0 : Void1.SO;
		1'b1 : WI1.SO;
	}
	Instance Void2 Of BypassReg {
		InputPort SI = sMux1;
		InputPort SEL = sel_SCB2_SCB3;
	}
	ScanMux sMux2 SelectedBy SCB2.DO {
		1'b0 : SCB10.SO;
		1'b1 : Void2.SO;
	}
	Instance SCB2 Of SCB {
		InputPort SI = SCB1.SO;
		InputPort SEL = sel_nSCB3;
	}
	ScanMux sMux3 SelectedBy SCB3.DO {
		1'b0 : SCB2.SO;
		1'b1 : sMux2;
	}
	Instance SCB3 Of SCB {
		InputPort SI = sMux3;
	}
	ScanMux sMux7 SelectedBy SCB7.DO {
		1'b0 : SCB6.SO;
		1'b1 : SCB3.SO;
	}
	Instance SCB7 Of SCB {
		InputPort SI = sMux7;
	}
	
	
	Instance Void4 Of BypassReg {
		InputPort SI = SCB3.SO;
		InputPort SEL = sel_nSCB4_nSCB5_SCB6_nSCB7;
	}
	Instance WI4 Of WrappedInstr {
		InputPort SI = SCB3.SO;
		InputPort SEL = sel_SCB4_nSCB5_SCB6_nSCB7;
		Parameter Size = $regSize4;
	}
	Instance SCB4 Of SCB {
		InputPort SI = SCB3.SO;
		InputPort SEL = sel_nSCB6_nSCB7;
	}
	ScanMux sMux4 SelectedBy SCB4.DO {
		1'b0 : Void4.SO;
		1'b1 : WI4.SO;
	}
	
	Instance Void5 Of BypassReg {
		InputPort SI = sMux4;
		InputPort SEL = sel_nSCB5_SCB6_nSCB7;
	}
	Instance WI5 Of WrappedInstr {
		InputPort SI = SCB3.SO;
		InputPort SEL = sel_SCB5_SCB6_nSCB7;
		Parameter Size = $regSize5;
	}
	Instance SCB5 Of SCB {
		InputPort SI = SCB4.SO;
		InputPort SEL = sel_nSCB6_nSCB7;
	}
	ScanMux sMux5 SelectedBy SCB5.DO {
		1'b0 : Void5.SO;
		1'b1 : WI5.SO;
	}
	ScanMux sMux6 SelectedBy SCB6.DO {
		1'b0 : SCB5.SO;
		1'b1 : sMux5;
	}
	Instance SCB6 Of SCB {
		InputPort SI = sMux6;
		InputPort SEL = sel_nSCB7;
	}
	Instance WI2 Of WrappedInstr {
		InputPort SI = sMux1;
		InputPort SEL = sel_nSCB2_SCB3_SCB8_SCB10;
		Parameter Size = $regSize2;
	}
	Instance Void3 Of BypassReg {
		InputPort SI = sMux1;
		InputPort SEL = sel_nSCB2_nSCB8;
	}
	Instance SCB8 Of SCB {
		InputPort SI = sMux1;
		InputPort SEL = sel_nSCB2_nSCB10_SCB3;
	}
	ScanMux sMux8 SelectedBy SCB8.DO {
		1'b0 : Void3.SO;
		1'b1 : WI2.SO;
	}
	Instance WI3 Of WrappedInstr {
		InputPort SI = sMux8;
		Parameter Size = $regSize3;
		InputPort SEL = sel_nSCB2_SCB10_SCB9_SCB3;
	}
	Instance Void6 Of BypassReg {
		InputPort SI = sMux8;
		InputPort SEL = sel_nSCB2_SCB10_nSCB9_SCB3;
	}
	Instance SCB9 Of SCB {
		InputPort SI = SCB8.SO;
		InputPort SEL = sel_nSCB2_nSCB10_SCB3;
	}
	ScanMux sMux9 SelectedBy SCB9.DO {
		1'b0 : Void6.SO;
		1'b1 : WI3.SO;
	}
	ScanMux sMux10 SelectedBy SCB10.DO {
		1'b0 : SCB9.SO;
		1'b1 : sMux9;
	}
	Instance SCB10 Of SCB {
		InputPort SI = sMux10;
		InputPort SEL = sel_nSCB2_SCB3;
	}
}
