/*
* Copyright Testonica Lab (C) 2016
*
* History:
* -------------+------------+-------------------------+------------------------
*   Version    |  Date      | Author                  | Organization
* -------------+------------+-------------------------+------------------------
*          1.0 | 06.11.2017 | Anton Tsertov           | Testonica Lab
*--------------+------------+-------------------------+------------------------
*          1.2 | 04.01.2018 | Dmitri Mihhailov        | Testonica Lab
*--------------+------------+-------------------------+------------------------*
* Uses modules from files: Instruments.icl, NetworkStructs.icl
*/


Module TrapOrFlap {
	Attribute lic = 'h d149b37c;
	
	Parameter regSize = 8;
	Parameter conf1Size = 1024;
	Parameter conf2Size = 2048;
	
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

	Instance SIB_10 Of SIB_mux_pre {
		InputPort SI = SI;
		InputPort fromSO = SIB_22.SO;
		InputPort SEL = SEL;
	}
	
	Instance SIB_11 Of SIB_mux_pre {
		InputPort SI = SIB_10.SO;
		InputPort fromSO = SIB_24.SO;
		InputPort SEL = SEL;
	}
	
	Instance SIB_12 Of SIB_mux_pre {
		InputPort SI = SIB_11.SO;
		InputPort fromSO = SIB_26.SO;
		InputPort SEL = SEL;
	}
	
	ScanMux sMux4 SelectedBy SCB1.DO {
		1'b0 : SIB_12.SO;
		1'b1 : CONF2.SO;
	}
	
	Instance SCB1 Of SCB {
		InputPort SI = sMux4;
		InputPort SEL = SEL;
	}
		
	Instance SIB_20 Of SIB_mux_pre {
		InputPort SI = SIB_10.toSI;
		InputPort fromSO = SREG0.SO;
		InputPort SEL = SIB_10.toSEL;
	}
	
	Instance SIB_21 Of SIB_mux_pre {
		InputPort SI = SIB_20.SO;
		InputPort fromSO = WI_7.SO;
		InputPort SEL = SIB_10.toSEL;
	}
	
	Instance SIB_22 Of SIB_mux_pre {
		InputPort SI = SIB_21.SO;
		InputPort fromSO = sMux1;
		InputPort SEL = SIB_10.toSEL;
	}
	
	Instance SREG0 Of SReg {
		InputPort SI = SIB_20.toSI; 
		InputPort DI = 2'b11; 
		Parameter Size = 2;
	}
	
	Instance SIB_30 Of SIB_mux_pre {
		InputPort SI = SIB_21.toSI;
		InputPort fromSO = WI_8.SO;
		InputPort SEL = SIB_21.toSEL;
	}
	
	Instance WI_7 Of WrappedInstr {
		InputPort SI = SIB_30.SO;
		InputPort SEL = SIB_21.toSEL;
		Parameter Size = $regSize;
	}
	
	Instance WI_8 Of WrappedInstr {
		InputPort SI = SIB_30.toSI;
		InputPort SEL = SIB_30.toSEL;
		Parameter Size = $regSize;
	}
	
	LogicSignal sel_WI_1 {
		SREG0.DO[0] & SIB_22.toSEL;
	}
	
	LogicSignal sel_WI_2 {
		~SREG0.DO[0] & SIB_22.toSEL;
	}
	
	Instance WI_1 Of WrappedInstr {
		InputPort SI = SIB_22.toSI;
		InputPort SEL = sel_WI_1;
		Parameter Size = $regSize;
	}
	
	Instance WI_2 Of WrappedInstr {
		InputPort SI = SIB_22.toSI;
		InputPort SEL = sel_WI_2;
		Parameter Size = $regSize;
	}
	
	ScanMux sMux1 SelectedBy SREG0.DO[0] {
		1'b0 : WI_2.SO;
		1'b1 : WI_1.SO;
	}
	
	
	Instance SIB_23 Of SIB_mux_pre {
		InputPort SI = SIB_11.toSI;
		InputPort fromSO = WI_6.SO;
		InputPort SEL = SIB_11.toSEL;
	}
	
	Instance SIB_24 Of SIB_mux_pre {
		InputPort SI = SIB_23.SO;
		InputPort fromSO = SREG1.SO;
		InputPort SEL = SIB_11.toSEL;
	}
	
	LogicSignal sel_WI_5 {
		~SREG0.DO[1] & SIB_23.toSEL;
	}
	
	Instance WI_5 Of WrappedInstr {
		InputPort SI = SIB_23.toSI;
		InputPort SEL = sel_WI_5;
		Parameter Size = $regSize;
	}
	
	ScanMux sMux5 SelectedBy SREG0.DO[1] {
		1'b0 : WI_5.SO;
		1'b1 : SIB_23.toSI;
	}
	
	Instance WI_6 Of WrappedInstr {
		InputPort SI = sMux5;
		InputPort SEL =  SIB_23.toSEL;
		Parameter Size = $regSize;
	}
	
	LogicSignal sel_WI_3 {
		SREG1.DO[1] & SIB_24.toSEL;
	}
	
	Instance WI_3 Of WrappedInstr {
		InputPort SI = SIB_24.toSI;
		InputPort SEL = sel_WI_3;
		Parameter Size = $regSize;
	}
	
	ScanMux sMux2 SelectedBy SREG1.DO[1] {
		1'b0 : SIB_24.toSI;
		1'b1 : WI_3.SO;
	}
	
	ScanMux sMux3 SelectedBy SREG1.DO[0] {
		1'b0 : sMux2;
		1'b1 : WI_4.SO;
	}
	
	LogicSignal sel_WI_4 {
		SREG1.DO[0] & SIB_24.toSEL;
	}
	
	Instance WI_4 Of WrappedInstr {
		InputPort SI = sMux2;
		InputPort SEL = sel_WI_4;
		Parameter Size = $regSize;
	}
	
	Instance SREG1 Of SReg {
		InputPort SI = sMux3; 
		InputPort DI = 2'b00; 
		Parameter Size = 2;
	}
	
	LogicSignal sel_SIB_25_26 {
		~SCB1.DO & SIB_12.toSEL;
	}
	
	Instance SIB_25 Of SIB_mux_pre {
		InputPort SI = SIB_12.toSI;
		InputPort fromSO = CONF1.SO;
		InputPort SEL = sel_SIB_25_26;
	}
	
	Instance SIB_26 Of SIB_mux_pre {
		InputPort SI = SIB_25.SO;
		InputPort fromSO = CONF2.SO;
		InputPort SEL = sel_SIB_25_26;
	}
	
	ScanMux sMux6 SelectedBy SCB1.DO {
		1'b0 : SIB_25.toSI;
		1'b1 : SIB_12.SO;
	}
	
	ScanMux sMux7 SelectedBy SCB1.DO {
		1'b0 : SIB_26.toSI;
		1'b1 : CONF1.SO;
	}
	
	LogicSignal sel_CONF1 {
		SCB1.DO | SIB_25.toSEL;
	}
	
	LogicSignal sel_CONF2 {
		SCB1.DO | SIB_26.toSEL;
	}
	
	Instance CONF1 Of SReg {
		InputPort SI = sMux6; 
		InputPort DI = 0;
		InputPort SEL = sel_CONF1;
		Parameter Size = $conf1Size;
	}
	
	Instance CONF2 Of SReg {
		InputPort SI = sMux7; 
		InputPort DI = 0; 
		InputPort SEL = sel_CONF2;
		Parameter Size = $conf2Size;
	}
}