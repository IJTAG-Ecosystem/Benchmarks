/*
* Copyright Testonica Lab (C) 2016
*
* History:
* -------------+------------+-------------------------+------------------------
*   Version    |  Date      | Author                  | Organization
* -------------+------------+-------------------------+------------------------
*          1.0 | 8.03.2016  | Anton Tsertov           | Testonica Lab
*--------------+------------+-------------------------+------------------------
*          2.0 | 13.05.2016 | Anton Tsertov           | Testonica Lab
*--------------+------------+-------------------------+------------------------
*          2.1 | 02.11.2016 | Dmitri Mihhailov        | Testonica Lab
*--------------+------------+-------------------------+------------------------
*
* Uses modules from files: Instruments.icl, NetworkStructs.icl
*/


Module TreeFlat {
	Attribute lic = 'h eddde80e;
	Parameter regSize = 8;
	ScanInPort SI;
	CaptureEnPort CE;
	ShiftEnPort SE;
	UpdateEnPort UE;
	SelectPort SEL;
	ResetPort RST;
	TCKPort TCK;
	ScanOutPort SO {
		Source SCB1.SO;
	}
	
	Instance SIB_main Of SIB_mux_pre {
		InputPort SI = SI;
		InputPort fromSO = SIB10.SO;
		InputPort SEL = sel_SIB_MAIN;
	}
	
	Instance SCB1 Of SCB {
		InputPort SI = sMuxSO;
		InputPort SEL = SEL;
	}
	
	ScanMux sMuxSO SelectedBy SCB1.DO {
		1'b0 : SIB_main.SO;
		1'b1 : WI_10.SO;
	}
	
	LogicSignal sel_SIB_MAIN {
        ~SCB1.DO & SEL;
	}
	LogicSignal sel_WI0 {
		SEL & SCB1.DO | SIB0.toSEL;
	}
	LogicSignal sel_WI1 {
		SEL & SCB1.DO | SIB1.toSEL;
	}
	LogicSignal sel_WI2 {
		SEL & SCB1.DO | SIB2.toSEL;
	}
	LogicSignal sel_WI3 {
		SEL & SCB1.DO | SIB3.toSEL;
	}
	LogicSignal sel_WI4 {
		SEL & SCB1.DO | SIB4.toSEL;
	}
	LogicSignal sel_WI5 {
		SEL & SCB1.DO | SIB5.toSEL;
	}
	LogicSignal sel_WI6 {
		SEL & SCB1.DO | SIB6.toSEL;
	}
	LogicSignal sel_WI7 {
		SEL & SCB1.DO | SIB7.toSEL;
	}
	LogicSignal sel_WI8 {
		SEL & SCB1.DO | SIB8.toSEL;
	}
	LogicSignal sel_WI9 {
		SEL & SCB1.DO | SIB9.toSEL;
	}
	LogicSignal sel_WI10 {
		SEL & SCB1.DO | SIB10.toSEL;
	}
	// 0 bit
	Instance SIB0 Of SIB_mux_pre {
		InputPort SI = SIB_main.toSI;
		InputPort fromSO = WI_0.SO;
	}
	
	Instance WI_0 Of WrappedInstr {
		InputPort SI = sMux0;
		InputPort SEL = sel_WI0;
		Parameter Size = $regSize;
	}
	
	ScanMux sMux0 SelectedBy SCB1.DO {
		1'b0 : SIB0.toSI;
		1'b1 : SI;
	}
	
	// 1 bit
	Instance SIB1 Of SIB_mux_pre {
		InputPort SI = SIB0.SO;
		InputPort fromSO = WI_1.SO;
	}
	
	Instance WI_1 Of WrappedInstr {
		InputPort SI = sMux1;
		InputPort SEL = sel_WI1;
		Parameter Size = $regSize;
	}
	
	ScanMux sMux1 SelectedBy SCB1.DO {
		1'b0 : SIB1.toSI;
		1'b1 : WI_0.SO;
	}
	
	// 2 bit
	Instance SIB2 Of SIB_mux_pre {
		InputPort SI = SIB1.SO;
		InputPort fromSO = WI_2.SO;
	}
	
	Instance WI_2 Of WrappedInstr {
		InputPort SI = sMux2;
		InputPort SEL = sel_WI2;
		Parameter Size = $regSize;
	}
	
	ScanMux sMux2 SelectedBy SCB1.DO {
		1'b0 : SIB2.toSI;
		1'b1 : WI_1.SO;
	}
	
	// 3 bit
	Instance SIB3 Of SIB_mux_pre {
		InputPort SI = SIB2.SO;
		InputPort fromSO = WI_3.SO;
	}
	
	Instance WI_3 Of WrappedInstr {
		InputPort SI = sMux3;
		InputPort SEL = sel_WI3;
		Parameter Size = $regSize;
	}
	
	ScanMux sMux3 SelectedBy SCB1.DO {
		1'b0 : SIB3.toSI;
		1'b1 : WI_2.SO;
	}
	
	// 4 bit
	Instance SIB4 Of SIB_mux_pre {
		InputPort SI = SIB3.SO;
		InputPort fromSO = WI_4.SO;
	}
	
	Instance WI_4 Of WrappedInstr {
		InputPort SI = sMux4;
		InputPort SEL = sel_WI4;
		Parameter Size = $regSize;
	}
	
	ScanMux sMux4 SelectedBy SCB1.DO {
		1'b0 : SIB4.toSI;
		1'b1 : WI_3.SO;
	}
	
	// 5 bit
	Instance SIB5 Of SIB_mux_pre {
		InputPort SI = SIB4.SO;
		InputPort fromSO = WI_5.SO;
	}
	
	Instance WI_5 Of WrappedInstr {
		InputPort SI = sMux5;
		InputPort SEL = sel_WI5;
		Parameter Size = $regSize;
	}
	
	ScanMux sMux5 SelectedBy SCB1.DO {
		1'b0 : SIB5.toSI;
		1'b1 : WI_4.SO;
	}
	
	// 6 bit
	Instance SIB6 Of SIB_mux_pre {
		InputPort SI = SIB5.SO;
		InputPort fromSO = WI_6.SO;
	}
	
	Instance WI_6 Of WrappedInstr {
		InputPort SI = sMux6;
		InputPort SEL = sel_WI6;
		Parameter Size = $regSize;
	}
	
	ScanMux sMux6 SelectedBy SCB1.DO {
		1'b0 : SIB6.toSI;
		1'b1 : WI_5.SO;
	}
	
	// 7 bit
	Instance SIB7 Of SIB_mux_pre {
		InputPort SI = SIB6.SO;
		InputPort fromSO = WI_7.SO;
	}
	
	Instance WI_7 Of WrappedInstr {
		InputPort SI = sMux7;
		InputPort SEL = sel_WI7;
		Parameter Size = $regSize;
	}
	
	ScanMux sMux7 SelectedBy SCB1.DO {
		1'b0 : SIB7.toSI;
		1'b1 : WI_6.SO;
	}
	
	// 8 bit
	Instance SIB8 Of SIB_mux_pre {
		InputPort SI = SIB7.SO;
		InputPort fromSO = WI_8.SO;
	}
	
	Instance WI_8 Of WrappedInstr {
		InputPort SI = sMux8;
		InputPort SEL = sel_WI8;
		Parameter Size = $regSize;
	}
	
	ScanMux sMux8 SelectedBy SCB1.DO {
		1'b0 : SIB8.toSI;
		1'b1 : WI_7.SO;
	}
	
	// 9 bit
	Instance SIB9 Of SIB_mux_pre {
		InputPort SI = SIB8.SO;
		InputPort fromSO = WI_9.SO;
	}
	
	Instance WI_9 Of WrappedInstr {
		InputPort SI = sMux9;
		InputPort SEL = sel_WI9;
		Parameter Size = $regSize;
	}
	
	ScanMux sMux9 SelectedBy SCB1.DO {
		1'b0 : SIB9.toSI;
		1'b1 : WI_8.SO;
	}
	
	// 10 bit
	Instance SIB10 Of SIB_mux_pre {
		InputPort SI = SIB9.SO;
		InputPort fromSO = WI_10.SO;
	}
	
	Instance WI_10 Of WrappedInstr {
		InputPort SI = sMux10;
		InputPort SEL = sel_WI10;
		Parameter Size = $regSize;
	}
	
	ScanMux sMux10 SelectedBy SCB1.DO {
		1'b0 : SIB10.toSI;
		1'b1 : WI_9.SO;
	}
}
