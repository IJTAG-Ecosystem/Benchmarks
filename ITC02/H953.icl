/*
* Copyright Testonica Lab (C) 2016
*
* History:
* -------------+------------+-------------------------+------------------------
*   Version    |  Date      | Author                  | Organization
* -------------+------------+-------------------------+------------------------
*          1.0 | 08.04.2016 | Anton Tsertov           | Testonica Lab
*--------------+------------+-------------------------+------------------------
*          1.2 | 22.11.2016 | Anton Tsertov           | Testonica Lab
*--------------+------------+-------------------------+------------------------
*          2.2 | 22.11.2016 | Anton Tsertov           | Testonica Lab
*--------------+------------+-------------------------+------------------------
*          2.3 | 21.12.2016 | Dmitri Mihhailov        | Testonica Lab
*--------------+------------+-------------------------+------------------------
*          2.4 | 26.06.2018 | Jan Burchard		      | Mentor A Siemens Business
*              |            | Anton Tsertov		      | Testonica Lab
*--------------+------------+-------------------------+------------------------
***
* Uses modules from files: Instruments.icl, EmptyModule.icl
* 
*/


NameSpace H953;

UseNameSpace root;
Module M0 {
	Attribute lic = 'h f965a01d;
	Parameter inputs = 12;
	Parameter outputs = 41;
	Parameter bidirs = 0;

	Parameter inputs_m1 = 112;
	Parameter inputs_m2 = 68;
	Parameter inputs_m3 = 9;
	Parameter inputs_m4 = 88;
	Parameter inputs_m5 = 19;
	Parameter inputs_m6 = 15;
	Parameter inputs_m8 = 35;
	
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
	
	
	DataOutPort DO[$outputs+$bidirs-1 : 0] {
		Source wrpOut; 
	}
	Instance sibTop Of SIB_mux_pre {
		InputPort SI = SI;
		InputPort fromSO = sibM8.SO;
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
	Instance wrpOut Of SReg {
		InputPort SI = wrpIn.SO;
		InputPort DI = toDO; 
		Parameter Size = $outputs+$bidirs;
	}
	Instance sibM1 Of SIB_mux_pre {
		InputPort SI = sibWrp.SO;
		InputPort fromSO = m1.SO;
	}
	Instance m1 Of H953::M1 {
		InputPort SI = sibM1.toSI;
		InputPort DI = DIm1;	
		InputPort toDO = toDOm1;		
	}
	Instance sibM2 Of SIB_mux_pre {
		InputPort SI = sibM1.SO;
		InputPort fromSO = m2.SO;
	}
	Instance m2 Of H953::M2 {
		InputPort SI = sibM2.toSI;
		InputPort DI = DIm2;	
		InputPort toDO = toDOm2;		
	}
	Instance sibM3 Of SIB_mux_pre {
		InputPort SI = sibM2.SO;
		InputPort fromSO = m3.SO;
	}
	Instance m3 Of H953::M3 {
		InputPort SI = sibM3.toSI;
		InputPort DI = DIm3;	
		InputPort toDO = toDOm3;		
	}
	Instance sibM4 Of SIB_mux_pre {
		InputPort SI = sibM3.SO;
		InputPort fromSO = m4.SO;
	}
	Instance m4 Of H953::M4 {
		InputPort SI = sibM4.toSI;
		InputPort DI = DIm4;	
		InputPort toDO = toDOm4;		
	}
	Instance sibM5 Of SIB_mux_pre {
		InputPort SI = sibM4.SO;
		InputPort fromSO = m5.SO;
	}
	Instance m5 Of H953::M5 {
		InputPort SI = sibM5.toSI;
		InputPort DI = DIm5;	
		InputPort toDO = toDOm5;		
	}
	Instance sibM6 Of SIB_mux_pre {
		InputPort SI = sibM5.SO;
		InputPort fromSO = m6.SO;
	}
	Instance m6 Of H953::M6 {
		InputPort SI = sibM6.toSI;
		InputPort DI = DIm6;	
		InputPort toDO = toDOm6;		
	}
	Instance sibM7 Of SIB_mux_pre {
		InputPort SI = sibM6.SO;
		InputPort fromSO = m7.SO;
	}
	Instance m7 Of EmptyModule {
		InputPort SI = sibM7.toSI; 
		Parameter inputs = 80;
		Parameter outputs = 32;
		Parameter bidirs = 0;
	}
	Instance sibM8 Of SIB_mux_pre {
		InputPort SI = sibM7.SO;
		InputPort fromSO = m8.SO;
	}
	Instance m8 Of H953::M8 {
		InputPort SI = sibM8.toSI;
		InputPort DI = DIm8;	
		InputPort toDO = toDOm8;		
	}
}

UseNameSpace root;
Module M1 {
	Attribute lic = 'h 5bc845a7;
	Parameter inputs = 112;
	Parameter outputs = 152;
	Parameter bidirs = 0;

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
		InputPort fromSO = sib4.SO;
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
	Instance wrpOut Of SReg {

		InputPort SI = wrpIn.SO;
		InputPort DI = toDO;
		Parameter Size = $outputs+$bidirs;
	}
	Instance sib1 Of SIB_mux_pre {
		InputPort SI = sibWrp.SO;
		InputPort fromSO = scanReg1.SO;
	}
	Instance scanReg1 Of WrappedScan {
		InputPort SI = sib1.toSI; 
		Parameter dataWidth = 348;
	}
	Instance sib2 Of SIB_mux_pre {
		InputPort SI = sib1.SO;
		InputPort fromSO = scanReg2.SO;
	}
	Instance scanReg2 Of WrappedScan {
		InputPort SI = sib2.toSI; 
		Parameter dataWidth = 348;
	}
	Instance sib3 Of SIB_mux_pre {
		InputPort SI = sib2.SO;
		InputPort fromSO = scanReg3.SO;
	}
	Instance scanReg3 Of WrappedScan {
		InputPort SI = sib3.toSI; 
		Parameter dataWidth = 348;
	}
	Instance sib4 Of SIB_mux_pre {
		InputPort SI = sib3.SO;
		InputPort fromSO = scanReg4.SO;
	}
	Instance scanReg4 Of WrappedScan {
		InputPort SI = sib4.toSI; 
		Parameter dataWidth = 85;
	}
}

Module M2 {
	Attribute lic = 'h afa1f515;
	Parameter inputs = 68;
	Parameter outputs = 89;
	Parameter bidirs = 0;

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
		InputPort fromSO = sib2.SO;
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
	Instance wrpOut Of SReg {

		InputPort SI = wrpIn.SO;
		InputPort DI = toDO;
		Parameter Size = $outputs+$bidirs;
	}
	Instance sib1 Of SIB_mux_pre {
		InputPort SI = sibWrp.SO;
		InputPort fromSO = scanReg1.SO;
	}
	Instance scanReg1 Of WrappedScan {
		InputPort SI = sib1.toSI; 
		Parameter dataWidth = 327;
	}
	Instance sib2 Of SIB_mux_pre {
		InputPort SI = sib1.SO;
		InputPort fromSO = scanReg2.SO;
	}
	Instance scanReg2 Of WrappedScan {
		InputPort SI = sib2.toSI; 
		Parameter dataWidth = 327;
	}
}

Module M3 {
	Attribute lic = 'h 452eb233;
	Parameter inputs = 9;
	Parameter outputs = 17;
	Parameter bidirs = 0;

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
		InputPort fromSO = sib2.SO;
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
	Instance wrpOut Of SReg {

		InputPort SI = wrpIn.SO;
		InputPort DI = toDO;
		Parameter Size = $outputs+$bidirs;
	}
	Instance sib1 Of SIB_mux_pre {
		InputPort SI = sibWrp.SO;
		InputPort fromSO = scanReg1.SO;
	}
	Instance scanReg1 Of WrappedScan {
		InputPort SI = sib1.toSI; 
		Parameter dataWidth = 31;
	}
	Instance sib2 Of SIB_mux_pre {
		InputPort SI = sib1.SO;
		InputPort fromSO = scanReg2.SO;
	}
	Instance scanReg2 Of WrappedScan {
		InputPort SI = sib2.toSI; 
		Parameter dataWidth = 32;
	}
}

Module M4 {
	Attribute lic = 'h 4bd15118;
	Parameter inputs = 88;
	Parameter outputs = 67;
	Parameter bidirs = 0;

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
		InputPort fromSO = sib4.SO;
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
	Instance wrpOut Of SReg {

		InputPort SI = wrpIn.SO;
		InputPort DI = toDO;
		Parameter Size = $outputs+$bidirs;
	}
	Instance sib1 Of SIB_mux_pre {
		InputPort SI = sibWrp.SO;
		InputPort fromSO = scanReg1.SO;
	}
	Instance scanReg1 Of WrappedScan {
		InputPort SI = sib1.toSI; 
		Parameter dataWidth = 21;
	}
	Instance sib2 Of SIB_mux_pre {
		InputPort SI = sib1.SO;
		InputPort fromSO = scanReg2.SO;
	}
	Instance scanReg2 Of WrappedScan {
		InputPort SI = sib2.toSI; 
		Parameter dataWidth = 21;
	}
	Instance sib3 Of SIB_mux_pre {
		InputPort SI = sib2.SO;
		InputPort fromSO = scanReg3.SO;
	}
	Instance scanReg3 Of WrappedScan {
		InputPort SI = sib3.toSI; 
		Parameter dataWidth = 21;
	}
	Instance sib4 Of SIB_mux_pre {
		InputPort SI = sib3.SO;
		InputPort fromSO = scanReg4.SO;
	}
	Instance scanReg4 Of WrappedScan {
		InputPort SI = sib4.toSI; 
		Parameter dataWidth = 21;
	}
}

Module M5 {
	Attribute lic = 'h eba12a97;
	Parameter inputs = 19;
	Parameter outputs = 13;
	Parameter bidirs = 0;

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
		InputPort fromSO = sib4.SO;
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
	Instance wrpOut Of SReg {

		InputPort SI = wrpIn.SO;
		InputPort DI = toDO;
		Parameter Size = $outputs+$bidirs;
	}
	Instance sib1 Of SIB_mux_pre {
		InputPort SI = sibWrp.SO;
		InputPort fromSO = scanReg1.SO;
	}
	Instance scanReg1 Of WrappedScan {
		InputPort SI = sib1.toSI; 
		Parameter dataWidth = 120;
	}
	Instance sib2 Of SIB_mux_pre {
		InputPort SI = sib1.SO;
		InputPort fromSO = scanReg2.SO;
	}
	Instance scanReg2 Of WrappedScan {
		InputPort SI = sib2.toSI; 
		Parameter dataWidth = 121;
	}
	Instance sib3 Of SIB_mux_pre {
		InputPort SI = sib2.SO;
		InputPort fromSO = scanReg3.SO;
	}
	Instance scanReg3 Of WrappedScan {
		InputPort SI = sib3.toSI; 
		Parameter dataWidth = 121;
	}
	Instance sib4 Of SIB_mux_pre {
		InputPort SI = sib3.SO;
		InputPort fromSO = scanReg4.SO;
	}
	Instance scanReg4 Of WrappedScan {
		InputPort SI = sib4.toSI; 
		Parameter dataWidth = 121;
	}
}

Module M6 {
	Attribute lic = 'h f9a4a03e;
	Parameter inputs = 15;
	Parameter outputs = 11;
	Parameter bidirs = 0;

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
		InputPort fromSO = sib4.SO;
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
	Instance wrpOut Of SReg {

		InputPort SI = wrpIn.SO;
		InputPort DI = toDO;
		Parameter Size = $outputs+$bidirs;
	}
	Instance sib1 Of SIB_mux_pre {
		InputPort SI = sibWrp.SO;
		InputPort fromSO = scanReg1.SO;
	}
	Instance scanReg1 Of WrappedScan {
		InputPort SI = sib1.toSI; 
		Parameter dataWidth = 184;
	}
	Instance sib2 Of SIB_mux_pre {
		InputPort SI = sib1.SO;
		InputPort fromSO = scanReg2.SO;
	}
	Instance scanReg2 Of WrappedScan {
		InputPort SI = sib2.toSI; 
		Parameter dataWidth = 184;
	}
	Instance sib3 Of SIB_mux_pre {
		InputPort SI = sib2.SO;
		InputPort fromSO = scanReg3.SO;
	}
	Instance scanReg3 Of WrappedScan {
		InputPort SI = sib3.toSI; 
		Parameter dataWidth = 184;
	}
	Instance sib4 Of SIB_mux_pre {
		InputPort SI = sib3.SO;
		InputPort fromSO = scanReg4.SO;
	}
	Instance scanReg4 Of WrappedScan {
		InputPort SI = sib4.toSI; 
		Parameter dataWidth = 185;
	}
}

Module M8 {
	Attribute lic = 'h 345fb1e7;
	Parameter inputs = 35;
	Parameter outputs = 69;
	Parameter bidirs = 0;

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
	Instance wrpOut Of SReg {

		InputPort SI = wrpIn.SO;
		InputPort DI = toDO;
		Parameter Size = $outputs+$bidirs;
	}
	Instance sib1 Of SIB_mux_pre {
		InputPort SI = sibWrp.SO;
		InputPort fromSO = scanReg1.SO;
	}
	Instance scanReg1 Of WrappedScan {
		InputPort SI = sib1.toSI; 
		Parameter dataWidth = 188;
	}
	Instance sib2 Of SIB_mux_pre {
		InputPort SI = sib1.SO;
		InputPort fromSO = scanReg2.SO;
	}
	Instance scanReg2 Of WrappedScan {
		InputPort SI = sib2.toSI; 
		Parameter dataWidth = 188;
	}
	Instance sib3 Of SIB_mux_pre {
		InputPort SI = sib2.SO;
		InputPort fromSO = scanReg3.SO;
	}
	Instance scanReg3 Of WrappedScan {
		InputPort SI = sib3.toSI; 
		Parameter dataWidth = 188;
	}
	Instance sib4 Of SIB_mux_pre {
		InputPort SI = sib3.SO;
		InputPort fromSO = scanReg4.SO;
	}
	Instance scanReg4 Of WrappedScan {
		InputPort SI = sib4.toSI; 
		Parameter dataWidth = 188;
	}
	Instance sib5 Of SIB_mux_pre {
		InputPort SI = sib4.SO;
		InputPort fromSO = scanReg5.SO;
	}
	Instance scanReg5 Of WrappedScan {
		InputPort SI = sib5.toSI; 
		Parameter dataWidth = 188;
	}
	Instance sib6 Of SIB_mux_pre {
		InputPort SI = sib5.SO;
		InputPort fromSO = scanReg6.SO;
	}
	Instance scanReg6 Of WrappedScan {
		InputPort SI = sib6.toSI; 
		Parameter dataWidth = 189;
	}
	Instance sib7 Of SIB_mux_pre {
		InputPort SI = sib6.SO;
		InputPort fromSO = scanReg7.SO;
	}
	Instance scanReg7 Of WrappedScan {
		InputPort SI = sib7.toSI; 
		Parameter dataWidth = 189;
	}
	Instance sib8 Of SIB_mux_pre {
		InputPort SI = sib7.SO;
		InputPort fromSO = scanReg8.SO;
	}
	Instance scanReg8 Of WrappedScan {
		InputPort SI = sib8.toSI; 
		Parameter dataWidth = 189;
	}
}

NameSpace H953_Basic;

UseNameSpace root;

Module M1 {
	Attribute lic = 'h d9a01d6a;
	Parameter inputs = 112;
	Parameter outputs = 152;

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
	
	DataInPort DI[$inputs-1 : 0];
	DataInPort toDO[$outputs-1 : 0];
	DataOutPort DO[$outputs-1 : 0] {
		Source wrpOut; 
	}
	Instance sibTop Of SIB_mux_pre {
		InputPort SI = SI;
		InputPort fromSO = sib1.SO;
	}
	Instance sibWrp Of SIB_mux_pre {
		InputPort SI = sibTop.toSI;
		InputPort fromSO = wrpOut.SO;
	}
	Instance wrpIn Of SReg {
		InputPort SI = sibWrp.toSI;
		InputPort DI = DI; 
		Parameter Size = $inputs;
	}
	Instance wrpOut Of SReg {
		InputPort SI = wrpIn.SO;
		InputPort DI = toDO; 
		Parameter Size = $outputs;
	}
	Instance sib1 Of SIB_mux_post {
		InputPort SI = sibWrp.SO;
		InputPort fromSO = sib2.SO;
	}
	Instance scanReg1 Of WrappedScan {
		InputPort SI = sib1.toSI; 
		Parameter dataWidth = 348;
	}
	Instance sib2 Of SIB_mux_post {
		InputPort SI = scanReg1.SO;
		InputPort fromSO = sib3.SO;
	}
	Instance scanReg2 Of WrappedScan {
		InputPort SI = sib2.toSI; 
		Parameter dataWidth = 348;
	}
	Instance sib3 Of SIB_mux_post {
		InputPort SI = scanReg2.SO;
		InputPort fromSO = sib4.SO;
	}
	Instance scanReg3 Of WrappedScan {
		InputPort SI = sib3.toSI; 
		Parameter dataWidth = 348;
	}
	Instance sib4 Of SIB_mux_post {
		InputPort SI = scanReg3.SO;
		InputPort fromSO = scanReg4.SO;
	}
	Instance scanReg4 Of WrappedScan {
		InputPort SI = sib4.toSI; 
		Parameter dataWidth = 85;
	}
}

Module M2 {
	Attribute lic = 'h 2063cddd;
	Parameter inputs = 68;
	Parameter outputs = 89;

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
	
	DataInPort DI[$inputs-1 : 0];
	DataInPort toDO[$outputs-1 : 0];
	DataOutPort DO[$outputs-1 : 0] {
		Source wrpOut; 
	}
	Instance sibTop Of SIB_mux_pre {
		InputPort SI = SI;
		InputPort fromSO = sib1.SO;
	}
	Instance sibWrp Of SIB_mux_pre {
		InputPort SI = sibTop.toSI;
		InputPort fromSO = wrpOut.SO;
	}
	Instance wrpIn Of SReg {
		InputPort SI = sibWrp.toSI;
		InputPort DI = DI; 
		Parameter Size = $inputs;
	}
	Instance wrpOut Of SReg {
		InputPort SI = wrpIn.SO;
		InputPort DI = toDO; 
		Parameter Size = $outputs;
	}
	Instance sib1 Of SIB_mux_pre {
		InputPort SI = sibWrp.SO;
		InputPort fromSO = scb1.SO;
	}
	LogicSignal sel_SR1 {
		SEL & sib1.toSEL & scb1.DO;
	}
	Instance scanReg1 Of WrappedScan {
		InputPort SI = sib1.toSI; 
		InputPort SEL = sel_SR1;
		Parameter dataWidth = 327;
	}
	ScanMux sMux1 SelectedBy scb1.DO {
		0: sib1.toSI;
		1: scanReg1.SO;
	}
	LogicSignal sel_SR2 {
		SEL & sib1.toSEL & scb2.DO;
	}
	Instance scanReg2 Of WrappedScan {
		InputPort SI = sMux1; 
		InputPort SEL = sel_SR2;
		Parameter dataWidth = 327;
	}
	ScanMux sMux2 SelectedBy scb2.DO {
		0: sMux1;
		1: scanReg2.SO;
	}
	Instance scb2 Of SCB {
		InputPort SI = sMux2;
	}
	Instance scb1 Of SCB {
		InputPort SI = scb2.SO;
	}
}

Module M3 {
	Attribute lic = 'h a2280e72;
	Parameter inputs = 9;
	Parameter outputs = 17;

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
	
	DataInPort DI[$inputs-1 : 0];
	DataInPort toDO[$outputs-1 : 0];
	DataOutPort DO[$outputs-1 : 0] {
		Source wrpOut; 
	}
	Instance sibTop Of SIB_mux_pre {
		InputPort SI = SI;
		InputPort fromSO = scanReg2.SO;
	}
	Instance sibWrp Of SIB_mux_pre {
		InputPort SI = sibTop.toSI;
		InputPort fromSO = wrpOut.SO;
	}
	Instance wrpIn Of SReg {
		InputPort SI = sibWrp.toSI;
		InputPort DI = DI; 
		Parameter Size = $inputs;
	}
	Instance wrpOut Of SReg {
		InputPort SI = wrpIn.SO;
		InputPort DI = toDO; 
		Parameter Size = $outputs;
	}
	Instance scanReg1 Of WrappedScan {
		InputPort SI = sibWrp.SO; 
		Parameter dataWidth = 31;
	}
	Instance scanReg2 Of WrappedScan {
		InputPort SI = scanReg1.SO; 
		Parameter dataWidth = 32;
	}
}

Module M4 {
	Attribute lic = 'h 729ae59;
	Parameter inputs = 88;
	Parameter outputs = 67;

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
	
	DataInPort DI[$inputs-1 : 0];
	DataInPort toDO[$outputs-1 : 0];
	DataOutPort DO[$outputs-1 : 0] {
		Source wrpOut; 
	}
	Instance sibTop Of SIB_mux_pre {
		InputPort SI = SI;
		InputPort fromSO = sib1.SO;
	}
	Instance sibWrp Of SIB_mux_pre {
		InputPort SI = sibTop.toSI;
		InputPort fromSO = wrpOut.SO;
	}
	Instance wrpIn Of SReg {
		InputPort SI = sibWrp.toSI;
		InputPort DI = DI; 
		Parameter Size = $inputs;
	}
	Instance wrpOut Of SReg {
		InputPort SI = wrpIn.SO;
		InputPort DI = toDO; 
		Parameter Size = $outputs;
	}
	Instance sib1 Of SIB_mux_pre {
		InputPort SI = sibWrp.SO;
		InputPort fromSO = sib2.SO;
	}
	Instance scanReg1 Of WrappedScan {
		InputPort SI = sib1.toSI; 
		Parameter dataWidth = 21;
	}
	Instance sib2 Of SIB_mux_pre {
		InputPort SI = scanReg1.SO;
		InputPort fromSO = sib3.SO;
	}
	Instance scanReg2 Of WrappedScan {
		InputPort SI = sib2.toSI; 
		Parameter dataWidth = 21;
	}
	Instance sib3 Of SIB_mux_pre {
		InputPort SI = scanReg2.SO;
		InputPort fromSO = sib4.SO;
	}
	Instance scanReg3 Of WrappedScan {
		InputPort SI = sib3.toSI; 
		Parameter dataWidth = 21;
	}
	Instance sib4 Of SIB_mux_pre {
		InputPort SI = scanReg3.SO;
		InputPort fromSO = scanReg4.SO;
	}
	Instance scanReg4 Of WrappedScan {
		InputPort SI = sib4.toSI; 
		Parameter dataWidth = 21;
	}
}

Module M5 {
	Attribute lic = 'h bd62f5c2;
	Parameter inputs = 19;
	Parameter outputs = 13;

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
	
	DataInPort DI[$inputs-1 : 0];
	DataInPort toDO[$outputs-1 : 0];
	DataOutPort DO[$outputs-1 : 0] {
		Source wrpOut; 
	}
	
	LogicSignal sel_SR1 {
		sib1.toSEL & (scr.DO[2:0] == 3'b001);
	}
	LogicSignal sel_SR2 {
		sib1.toSEL & (scr.DO[2:0] == 3'b010);
	}
	LogicSignal sel_SR3 {
		sib1.toSEL & (scr.DO[2:0] == 3'b011);
	}
	LogicSignal sel_SR4 {
		sib1.toSEL & (scr.DO[2:0] == 3'b101);
	}
	Instance sibTop Of SIB_mux_pre {
		InputPort SI = SI;
		InputPort fromSO = sib1.SO;
	}
	Instance sibWrp Of SIB_mux_pre {
		InputPort SI = sibTop.toSI;
		InputPort fromSO = wrpOut.SO;
	}
	Instance wrpIn Of SReg {
		InputPort SI = sibWrp.toSI;
		InputPort DI = DI; 
		Parameter Size = $inputs;
	}
	Instance wrpOut Of SReg {
		InputPort SI = wrpIn.SO;
		InputPort DI = toDO; 
		Parameter Size = $outputs;
	}
	Instance sib1 Of SIB_mux_pre {
		InputPort SI = sibWrp.SO;
		InputPort fromSO = scr.SO;
	}
	Instance scanReg1 Of WrappedScan {
		InputPort SI = sib1.toSI; 
		InputPort SEL = sel_SR1;
		Parameter dataWidth = 120;
	}
	Instance scanReg2 Of WrappedScan {
		InputPort SI = sib1.toSI; 
		InputPort SEL = sel_SR2;
		Parameter dataWidth = 121;
	}
	Instance scanReg3 Of WrappedScan {
		InputPort SI = sib1.toSI; 
		InputPort SEL = sel_SR3;
		Parameter dataWidth = 121;
	}
	Instance scanReg4 Of WrappedScan {
		InputPort SI = sib1.toSI;
		InputPort SEL = sel_SR4;
		Parameter dataWidth = 121;
	}
	ScanMux sMux SelectedBy scr.DO[2:0] {
		0: sib1.toSI;
		1: scanReg1.SO;
		2: scanReg2.SO;
		3: scanReg3.SO;
		5: scanReg4.SO;
	}
	Instance scr Of SCR {
		InputPort SI = sMux;
		Parameter size = 3;
	}
}

Module M6 {
	Attribute lic = 'h b63658ae;
	Parameter inputs = 15;
	Parameter outputs = 11;

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
	
	DataInPort DI[$inputs-1 : 0];
	DataInPort toDO[$outputs-1 : 0];
	DataOutPort DO[$outputs-1 : 0] {
		Source wrpOut; 
	}
	Instance sibTop Of SIB_mux_pre {
		InputPort SI = SI;
		InputPort fromSO = sib1.SO;
	}
	Instance sibWrp Of SIB_mux_pre {
		InputPort SI = sibTop.toSI;
		InputPort fromSO = wrpOut.SO;
	}
	Instance wrpIn Of SReg {
		InputPort SI = sibWrp.toSI;
		InputPort DI = DI; 
		Parameter Size = $inputs;
	}
	Instance wrpOut Of SReg {
		InputPort SI = wrpIn.SO;
		InputPort DI = toDO; 
		Parameter Size = $outputs;
	}
	Instance sib1 Of SIB_mux_pre {
		InputPort SI = sibWrp.SO;
		InputPort fromSO = sib2.SO;
	}
	Instance scanReg1 Of WrappedScan {
		InputPort SI = sib1.toSI; 
		Parameter dataWidth = 184;
	}
	Instance sib2 Of SIB_mux_pre {
		InputPort SI = scanReg1.SO;
		InputPort fromSO = sib3.SO;
	}
	Instance scanReg2 Of WrappedScan {
		InputPort SI = sib2.toSI; 
		Parameter dataWidth = 184;
	}
	Instance sib3 Of SIB_mux_pre {
		InputPort SI = scanReg2.SO;
		InputPort fromSO = sib4.SO;
	}
	Instance scanReg3 Of WrappedScan {
		InputPort SI = sib3.toSI; 
		Parameter dataWidth = 184;
	}
	Instance sib4 Of SIB_mux_pre {
		InputPort SI = scanReg3.SO;
		InputPort fromSO = scanReg4.SO;
	}
	Instance scanReg4 Of WrappedScan {
		InputPort SI = sib4.toSI; 
		Parameter dataWidth = 185;
	}
}

Module M8 {
	Attribute lic = 'h 32c601e3;
	Parameter inputs = 35;
	Parameter outputs = 69;

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
	
	DataInPort DI[$inputs-1 : 0];
	DataInPort toDO[$outputs-1 : 0];
	DataOutPort DO[$outputs-1 : 0] {
		Source wrpOut; 
	}
	Instance sibTop Of SIB_mux_pre {
		InputPort SI = SI;
		InputPort fromSO = sib5.SO;
	}
	Instance sibWrp Of SIB_mux_pre {
		InputPort SI = sibTop.toSI;
		InputPort fromSO = wrpOut.SO;
	}
	Instance wrpIn Of SReg {
		InputPort SI = sibWrp.toSI;
		InputPort DI = DI; 
		Parameter Size = $inputs;
	}
	Instance wrpOut Of SReg {
		InputPort SI = wrpIn.SO;
		InputPort DI = toDO; 
		Parameter Size = $outputs;
	}
	Instance sib1 Of SIB_mux_pre {
		InputPort SI = sibWrp.SO;
		InputPort fromSO = sib2.SO;
	}
	Instance scanReg1 Of WrappedScan {
		InputPort SI = sib1.toSI; 
		Parameter dataWidth = 188;
	}
	Instance sib2 Of SIB_mux_pre {
		InputPort SI = scanReg1.SO;
		InputPort fromSO = sib3.SO;
	}
	Instance scanReg2 Of WrappedScan {
		InputPort SI = sib2.toSI; 
		Parameter dataWidth = 188;
	}
	Instance sib3 Of SIB_mux_pre {
		InputPort SI = scanReg2.SO;
		InputPort fromSO = sib4.SO;
	}
	Instance scanReg3 Of WrappedScan {
		InputPort SI = sib3.toSI; 
		Parameter dataWidth = 188;
	}
	Instance sib4 Of SIB_mux_pre {
		InputPort SI = scanReg3.SO;
		InputPort fromSO = scanReg4.SO;
	}
	Instance scanReg4 Of WrappedScan {
		InputPort SI = sib4.toSI; 
		Parameter dataWidth = 188;
	}
	Instance sib5 Of SIB_mux_pre {
		InputPort SI = sib1.SO;
		InputPort fromSO = sib6.SO;
	}
	Instance scanReg5 Of WrappedScan {
		InputPort SI = sib5.toSI; 
		Parameter dataWidth = 188;
	}
	Instance sib6 Of SIB_mux_pre {
		InputPort SI = scanReg5.SO;
		InputPort fromSO = sib7.SO;
	}
	Instance scanReg6 Of WrappedScan {
		InputPort SI = sib6.toSI; 
		Parameter dataWidth = 189;
	}
	Instance sib7 Of SIB_mux_pre {
		InputPort SI = scanReg6.SO;
		InputPort fromSO = sib8.SO;
	}
	Instance scanReg7 Of WrappedScan {
		InputPort SI = sib7.toSI; 
		Parameter dataWidth = 189;
	}
	Instance sib8 Of SIB_mux_pre {
		InputPort SI = scanReg7.SO;
		InputPort fromSO = scanReg8.SO;
	}
	Instance scanReg8 Of WrappedScan {
		InputPort SI = sib8.toSI; 
		Parameter dataWidth = 189;
	}
}
