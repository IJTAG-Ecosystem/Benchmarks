/*
* Copyright Testonica Lab (C) 2016
*
*
* History:
* -------------+------------+-------------------------+------------------------
*   Version    |  Date      | Author                  | Organization
* -------------+------------+-------------------------+------------------------
*          1.0 | 8.03.2016  | Anton Tsertov           | Testonica Lab
*--------------+------------+-------------------------+------------------------
*          1.0 | 13.05.2016 | Anton Tsertov           | Testonica Lab
*--------------+------------+-------------------------+------------------------
*          2.1 | 02.11.2016 | Dmitri Mihhailov        | Testonica Lab
*--------------+------------+-------------------------+------------------------
*
* Uses modules from files: Instruments.icl, NetworkStructs.icl
* 
*
*/

Module Mingle {
	Attribute lic = 'h d3a0c41d;
	Parameter regSize = 32;
	Parameter regSize1 = $regSize;
	Parameter regSize2 = $regSize;
	Parameter regSize3 = $regSize;
	Parameter regSize4 = $regSize;
	Parameter regSize5 = $regSize;
	Parameter regSize6 = $regSize;
	Parameter regSize7 = $regSize;
	Parameter regSize8 = $regSize;
	
	ScanInPort SI;
	CaptureEnPort CE;
	ShiftEnPort SE;
	UpdateEnPort UE;
	SelectPort SEL;
	ResetPort RST;
	TCKPort TCK;
	ScanOutPort SO {
		Source SIB2.SO;
	}
	
	// Level 1
	Instance SIB1 Of SIB_mux_pre {
		InputPort SI = SI;
		InputPort fromSO = SCB3.SO;
	}
	Instance SIB2 Of SIB_mux_pre {
		InputPort SI = SIB1.SO;
		InputPort fromSO = SCB2.SO;
	}
	
	// Branch A
	LogicSignal sel_Void1 {
		SIB2.toSEL & ~SCB1.toSEL & ~SCB2.toSEL;
	}
	LogicSignal sel_WI1 {
		SIB2.toSEL & SCB1.toSEL & ~SCB2.toSEL;
	}
	LogicSignal sel_SIB3 {
		SIB2.toSEL & SCB2.toSEL;
	}
	LogicSignal sel_SIB4 {
		SIB2.toSEL & SCB2.toSEL;
	}
	LogicSignal sel_SCB1 {
		SIB2.toSEL & SCB2.toSEL;
	}
	Instance WI1 Of WrappedInstr {
		InputPort SI = SIB2.toSI;
		InputPort SEL = sel_WI1;
		Parameter Size = $regSize1;
	}
	Instance Void1 Of BypassReg {
		InputPort SI = SIB2.toSI;
		InputPort SEL = sel_Void1;
	}
	Instance SCB1 Of SCB {
		InputPort SI = SIB2.toSI;
		InputPort SEL = sel_SCB1;
	}
	ScanMux sMux1 SelectedBy SCB1.DO {
		1'b0 : Void1.SO;
		1'b1 : WI1.SO;
	}
	Instance SIB3 Of SIB_mux_pre {
		InputPort SI = SCB1.SO;
		InputPort fromSO = SIBpost2.SO;
		InputPort SEL = sel_SIB3;
	}
	Instance SIBpost1 Of SIB_mux_post {
		InputPort SI = SIB3.toSI;
		InputPort fromSO = WI3.SO;
	}
	Instance WI3 Of WrappedInstr {
		InputPort SI = SIBpost1.toSI;
		Parameter Size = $regSize3;
	}
	Instance SIBpost2 Of SIB_mux_post {
		InputPort SI = SIBpost1.SO;
		InputPort fromSO = WI4.SO;
	}
	Instance WI4 Of WrappedInstr {
		InputPort SI = SIBpost2.toSI;
		Parameter Size = $regSize4;
	}
	Instance SIB4 Of SIB_mux_pre {
		InputPort SI = SIB3.SO;
		InputPort fromSO = WI2.SO;
		InputPort SEL = sel_SIB4;
	}
	Instance WI2 Of WrappedInstr {
		InputPort SI = SIB4.toSI;
		Parameter Size = $regSize2;
	}
	
	ScanMux sMux2 SelectedBy SCB2.DO {
		1'b1 : SIB4.SO;
		1'b0 : sMux1;
	}
	Instance SCB2 Of SCB {
		InputPort SI = sMux2;
	}
	
	// Branch B
	LogicSignal sel_SIB5 {
		SIB1.toSEL & ~SCB3.toSEL;
	}
	LogicSignal sel_SIBpost3 {
		SIB1.toSEL & SCB3.toSEL;
	}
	Instance SIB5 Of SIB_mux_pre {
		InputPort SI = SIB1.toSI;
		InputPort SEL = sel_SIB5;
		InputPort fromSO = SIB6.SO;
	}
	Instance WI5 Of WrappedInstr {
		InputPort SI = SIB5.toSI;
		Parameter Size = $regSize5;
	}
	Instance SIB6 Of SIB_mux_pre {
		InputPort SI = WI5.SO;
		InputPort fromSO = WI6.SO;
	}
	Instance WI6 Of WrappedInstr {
		InputPort SI = SIB6.toSI;
		Parameter Size = $regSize6;
	}
	Instance SIBpost3 Of SIB_mux_post {
		InputPort SEL = sel_SIBpost3;
		InputPort SI = SIB1.toSI;
		InputPort fromSO = SIB7.SO;
	}
	Instance WI7 Of WrappedInstr {
		InputPort SI = SIBpost3.toSI;
		Parameter Size = $regSize7;
	}
	Instance SIB7 Of SIB_mux_pre {
		InputPort SI = WI7.SO;
		InputPort fromSO = WI8.SO;
	}
	Instance WI8 Of WrappedInstr {
		InputPort SI = SIB7.toSI;
		Parameter Size = $regSize8;
	}
	
	ScanMux sMux3 SelectedBy SCB3.DO {
		1'b0 : SIB5.SO;
		1'b1 : SIBpost3.SO;
	}
	Instance SCB3 Of SCB {
		InputPort SI = sMux3;
	}
}
