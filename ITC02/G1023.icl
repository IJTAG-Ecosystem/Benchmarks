/*
* Copyright Testonica Lab (C) 2016
*
*
* History:
* -------------+------------+-------------------------+------------------------
*   Version    |  Date      | Author                  | Organization
* -------------+------------+-------------------------+------------------------
*          1.0 | 11.04.2016 | Anton Tsertov           | Testonica Lab
*--------------+------------+-------------------------+------------------------
*          2.0 | 03.05.2016 | Anton Tsertov           | Testonica Lab
*--------------+------------+-------------------------+------------------------
*          2.1 | 13.09.2016 | Riccardo Cantoro        | Politecnico di Torino
*--------------+------------+-------------------------+------------------------
*          2.2 | 22.11.2016 | Anton Tsertov           | Testonica Lab
*--------------+------------+-------------------------+------------------------
*          2.3 | 09.12.2016 | Dmitri Mihhailov        | Testonica Lab
*--------------+------------+-------------------------+------------------------
*          2.4 | 23.12.2016 | Dmitri Mihhailov        | Testonica Lab
*--------------+------------+-------------------------+------------------------
*          2.5 | 26.06.2018 | Jan Burchard		      | Mentor A Siemens Business
*              |            | Anton Tsertov		      | Testonica Lab
*--------------+------------+-------------------------+------------------------
*
* Uses modules from files: 
* - Instruments.icl
* - EmptyModule.icl
*/


NameSpace G1023;

UseNameSpace root;
Module M0 {
	Attribute lic = 'h 2e475bc2;
	Parameter inputs = 4;
	Parameter outputs = 63;
	Parameter bidirs = 53;

	Parameter inputs_m1 = 139;
	Parameter inputs_m2 = 68;
	Parameter inputs_m3 = 9;
	Parameter inputs_m4 = 88;
	Parameter inputs_m5 = 19;
	Parameter inputs_m6 = 15;
	Parameter inputs_m7 = 15;
	Parameter inputs_m8 = 35;
	Parameter inputs_m9 = 35;
	Parameter inputs_m10 = 35;
	Parameter inputs_m11 = 35;
	Parameter inputs_m12 = 35;
	
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
	DataInPort DIm7[$inputs_m7+$bidirs-1 : 0];
	DataInPort toDOm7[$outputs_m7+$bidirs-1 : 0];
	DataInPort DIm8[$inputs_m8+$bidirs-1 : 0];
	DataInPort toDOm8[$outputs_m8+$bidirs-1 : 0];
	DataInPort DIm9[$inputs_m9+$bidirs-1 : 0];
	DataInPort toDOm9[$outputs_m9+$bidirs-1 : 0];
	DataInPort DIm10[$inputs_m10+$bidirs-1 : 0];
	DataInPort toDOm10[$outputs_m10+$bidirs-1 : 0];
	DataInPort DIm11[$inputs_m11+$bidirs-1 : 0];
	DataInPort toDOm11[$outputs_m11+$bidirs-1 : 0];
	DataInPort DIm12[$inputs_m12+$bidirs-1 : 0];
	DataInPort toDOm12[$outputs_m12+$bidirs-1 : 0];
	
	Instance sibTop Of SIB_mux_pre {
		InputPort SI = SI;
		InputPort fromSO = sibM14.SO;
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
	Instance m1 Of G1023::M1 {
		InputPort SI = sibM1.toSI;
		InputPort DI = DIm1;	
		InputPort toDO = toDOm1; 
	}
	Instance sibM2 Of SIB_mux_pre {
		InputPort SI = sibM1.SO;
		InputPort fromSO = m2.SO;
	}
	Instance m2 Of G1023::M2 {
		InputPort SI = sibM2.toSI;
		InputPort DI = DIm2;	
		InputPort toDO = toDOm2; 
	}
	Instance sibM3 Of SIB_mux_pre {
		InputPort SI = sibM2.SO;
		InputPort fromSO = m3.SO;
	}
	Instance m3 Of G1023::M3 {
		InputPort SI = sibM3.toSI; 
		InputPort DI = DIm3;	
		InputPort toDO = toDOm3;
	}
	Instance sibM4 Of SIB_mux_pre {
		InputPort SI = sibM3.SO;
		InputPort fromSO = m4.SO;
	}
	Instance m4 Of G1023::M4 {
		InputPort SI = sibM4.toSI;
		InputPort DI = DIm4;	
		InputPort toDO = toDOm4; 
	}
	Instance sibM5 Of SIB_mux_pre {
		InputPort SI = sibM4.SO;
		InputPort fromSO = m5.SO;
	}
	Instance m5 Of G1023::M5 {
		InputPort SI = sibM5.toSI;
		InputPort DI = DIm5;	
		InputPort toDO = toDOm5; 
	}
	Instance sibM6 Of SIB_mux_pre {
		InputPort SI = sibM5.SO;
		InputPort fromSO = m6.SO;
	}
	Instance m6 Of G1023::M6 {
		InputPort SI = sibM6.toSI; 
		InputPort DI = DIm6;	
		InputPort toDO = toDOm6;
	}
	Instance sibM7 Of SIB_mux_pre {
		InputPort SI = sibM6.SO;
		InputPort fromSO = m7.SO;
	}
	Instance m7 Of G1023::M7 {
		InputPort SI = sibM7.toSI;
		InputPort DI = DIm7;	
		InputPort toDO = toDOm7; 
	}
	Instance sibM8 Of SIB_mux_pre {
		InputPort SI = sibM7.SO;
		InputPort fromSO = m8.SO;
	}
	Instance m8 Of G1023::M8 {
		InputPort SI = sibM8.toSI; 
		InputPort DI = DIm8;	
		InputPort toDO = toDOm8;
	}
	Instance sibM9 Of SIB_mux_pre {
		InputPort SI = sibM8.SO;
		InputPort fromSO = m9.SO;
	}
	Instance m9 Of G1023::M9 {
		InputPort SI = sibM9.toSI;
		InputPort DI = DIm9;	
		InputPort toDO = toDOm9; 
	}
	Instance sibM10 Of SIB_mux_pre {
		InputPort SI = sibM9.SO;
		InputPort fromSO = m10.SO;
	}
	Instance m10 Of G1023::M10 {
		InputPort SI = sibM10.toSI;
		InputPort DI = DIm10;	
		InputPort toDO = toDOm10; 
	}
	Instance sibM11 Of SIB_mux_pre {
		InputPort SI = sibM10.SO;
		InputPort fromSO = m11.SO;
	}
	Instance m11 Of G1023::M11 {
		InputPort SI = sibM11.toSI;
		InputPort DI = DIm11;	
		InputPort toDO = toDOm11; 
	}
	Instance sibM12 Of SIB_mux_pre {
		InputPort SI = sibM11.SO;
		InputPort fromSO = m12.SO;
	}
	Instance m12 Of G1023::M12 {
		InputPort SI = sibM12.toSI;
		InputPort DI = DIm12;	
		InputPort toDO = toDOm12; 
	}
	
	Instance sibM13 Of SIB_mux_pre {
		InputPort SI = sibM12.SO;
		InputPort fromSO = m13.SO;
	}
	Instance m13 Of EmptyModule {
		InputPort SI = sibM13.toSI; 
		Parameter inputs = 58;
		Parameter outputs = 64;
		Parameter bidirs = 0;
	}
	Instance sibM14 Of SIB_mux_pre {
		InputPort SI = sibM13.SO;
		InputPort fromSO = m14.SO;
	}
	Instance m14 Of EmptyModule {
		InputPort SI = sibM14.toSI; 
		Parameter inputs = 140;
		Parameter outputs = 114;
		Parameter bidirs = 0;
	}
}

UseNameSpace root;
Module M1 {
	Attribute lic = 'h 4c2b518d;
	Parameter inputs = 139;
	Parameter outputs = 273;
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
		InputPort fromSO = sib14.SO;
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
		Parameter dataWidth = 43;
	}
	Instance sib2 Of SIB_mux_pre {
		InputPort SI = sib1.SO;
		InputPort fromSO = scanReg2.SO;
	}
	Instance scanReg2 Of WrappedScan {
		InputPort SI = sib2.toSI; 
		Parameter dataWidth = 43;
	}
	Instance sib3 Of SIB_mux_pre {
		InputPort SI = sib2.SO;
		InputPort fromSO = scanReg3.SO;
	}
	Instance scanReg3 Of WrappedScan {
		InputPort SI = sib3.toSI; 
		Parameter dataWidth = 43;
	}
	Instance sib4 Of SIB_mux_pre {
		InputPort SI = sib3.SO;
		InputPort fromSO = scanReg4.SO;
	}
	Instance scanReg4 Of WrappedScan {
		InputPort SI = sib4.toSI; 
		Parameter dataWidth = 43;
	}
	Instance sib5 Of SIB_mux_pre {
		InputPort SI = sib4.SO;
		InputPort fromSO = scanReg5.SO;
	}
	Instance scanReg5 Of WrappedScan {
		InputPort SI = sib5.toSI; 
		Parameter dataWidth = 42;
	}
	Instance sib6 Of SIB_mux_pre {
		InputPort SI = sib5.SO;
		InputPort fromSO = scanReg6.SO;
	}
	Instance scanReg6 Of WrappedScan {
		InputPort SI = sib6.toSI; 
		Parameter dataWidth = 42;
	}
	Instance sib7 Of SIB_mux_pre {
		InputPort SI = sib6.SO;
		InputPort fromSO = scanReg7.SO;
	}
	Instance scanReg7 Of WrappedScan {
		InputPort SI = sib7.toSI; 
		Parameter dataWidth = 42;
	}
	Instance sib8 Of SIB_mux_pre {
		InputPort SI = sib7.SO;
		InputPort fromSO = scanReg8.SO;
	}
	Instance scanReg8 Of WrappedScan {
		InputPort SI = sib8.toSI; 
		Parameter dataWidth = 42;
	}
	Instance sib9 Of SIB_mux_pre {
		InputPort SI = sib8.SO;
		InputPort fromSO = scanReg9.SO;
	}
	Instance scanReg9 Of WrappedScan {
		InputPort SI = sib9.toSI; 
		Parameter dataWidth = 42;
	}
	Instance sib10 Of SIB_mux_pre {
		InputPort SI = sib9.SO;
		InputPort fromSO = scanReg10.SO;
	}
	Instance scanReg10 Of WrappedScan {
		InputPort SI = sib10.toSI; 
		Parameter dataWidth = 42;
	}
	Instance sib11 Of SIB_mux_pre {
		InputPort SI = sib10.SO;
		InputPort fromSO = scanReg11.SO;
	}
	Instance scanReg11 Of WrappedScan {
		InputPort SI = sib11.toSI; 
		Parameter dataWidth = 42;
	}
	Instance sib12 Of SIB_mux_pre {
		InputPort SI = sib11.SO;
		InputPort fromSO = scanReg12.SO;
	}
	Instance scanReg12 Of WrappedScan {
		InputPort SI = sib12.toSI; 
		Parameter dataWidth = 42;
	}
	Instance sib13 Of SIB_mux_pre {
		InputPort SI = sib12.SO;
		InputPort fromSO = scanReg13.SO;
	}
	Instance scanReg13 Of WrappedScan {
		InputPort SI = sib13.toSI; 
		Parameter dataWidth = 42;
	}
	Instance sib14 Of SIB_mux_pre {
		InputPort SI = sib13.SO;
		InputPort fromSO = scanReg14.SO;
	}
	Instance scanReg14 Of WrappedScan {
		InputPort SI = sib14.toSI; 
		Parameter dataWidth = 42;
	}
	
}

Module M2 {
	Attribute lic = 'h afa1f515;
	Parameter inputs = 221;
	Parameter outputs = 215;
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
		Parameter dataWidth = 84;
	}
	Instance sib2 Of SIB_mux_pre {
		InputPort SI = sib1.SO;
		InputPort fromSO = scanReg2.SO;
	}
	Instance scanReg2 Of WrappedScan {
		InputPort SI = sib2.toSI; 
		Parameter dataWidth = 83;
	}
}

Module M3 {
	Attribute lic = 'h a5be499d;
	Parameter inputs = 192;
	Parameter outputs = 171;
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
		InputPort fromSO = sib1.SO;
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
		Parameter dataWidth = 53;
	}
}

Module M4 {
	Attribute lic = 'h 4bd15118;
	Parameter inputs = 145;
	Parameter outputs = 155;
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
		Parameter dataWidth = 54;
	}
	Instance sib2 Of SIB_mux_pre {
		InputPort SI = sib1.SO;
		InputPort fromSO = scanReg2.SO;
	}
	Instance scanReg2 Of WrappedScan {
		InputPort SI = sib2.toSI; 
		Parameter dataWidth = 54;
	}
	Instance sib3 Of SIB_mux_pre {
		InputPort SI = sib2.SO;
		InputPort fromSO = scanReg3.SO;
	}
	Instance scanReg3 Of WrappedScan {
		InputPort SI = sib3.toSI; 
		Parameter dataWidth = 54;
	}
	Instance sib4 Of SIB_mux_pre {
		InputPort SI = sib3.SO;
		InputPort fromSO = scanReg4.SO;
	}
	Instance scanReg4 Of WrappedScan {
		InputPort SI = sib4.toSI; 
		Parameter dataWidth = 54;
	}
}

Module M5 {
	Attribute lic = 'h eba12a97;
	Parameter inputs = 32;
	Parameter outputs = 27;
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
		Parameter dataWidth = 32;
	}
	Instance sib2 Of SIB_mux_pre {
		InputPort SI = sib1.SO;
		InputPort fromSO = scanReg2.SO;
	}
	Instance scanReg2 Of WrappedScan {
		InputPort SI = sib2.toSI; 
		Parameter dataWidth = 32;
	}
	Instance sib3 Of SIB_mux_pre {
		InputPort SI = sib2.SO;
		InputPort fromSO = scanReg3.SO;
	}
	Instance scanReg3 Of WrappedScan {
		InputPort SI = sib3.toSI; 
		Parameter dataWidth = 31;
	}
	Instance sib4 Of SIB_mux_pre {
		InputPort SI = sib3.SO;
		InputPort fromSO = scanReg4.SO;
	}
	Instance scanReg4 Of WrappedScan {
		InputPort SI = sib4.toSI; 
		Parameter dataWidth = 32;
	}
}

Module M6 {
	Attribute lic = 'h 4aa4634;
	Parameter inputs = 20;
	Parameter outputs = 18;
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
		Parameter dataWidth = 47;
	}
	Instance sib2 Of SIB_mux_pre {
		InputPort SI = sib1.SO;
		InputPort fromSO = scanReg2.SO;
	}
	Instance scanReg2 Of WrappedScan {
		InputPort SI = sib2.toSI; 
		Parameter dataWidth = 47;
	}
}

Module M7 {
	Attribute lic = 'h 45b53d81;
	Parameter inputs = 20;
	Parameter outputs = 18;
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
		Parameter dataWidth = 47;
	}
	Instance sib2 Of SIB_mux_pre {
		InputPort SI = sib1.SO;
		InputPort fromSO = scanReg2.SO;
	}
	Instance scanReg2 Of WrappedScan {
		InputPort SI = sib2.toSI; 
		Parameter dataWidth = 47;
	}
}

Module M8 {
	Attribute lic = 'h 881abaed;
	Parameter inputs = 63;
	Parameter outputs = 80;
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
		Parameter dataWidth = 52;
	}
	Instance sib2 Of SIB_mux_pre {
		InputPort SI = sib1.SO;
		InputPort fromSO = scanReg2.SO;
	}
	Instance scanReg2 Of WrappedScan {
		InputPort SI = sib2.toSI; 
		Parameter dataWidth = 52;
	}
}

Module M9 {
	Attribute lic = 'h 15132fed;
	Parameter inputs = 56;
	Parameter outputs = 34;
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
		InputPort fromSO = sib1.SO;
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
		Parameter dataWidth = 64;
	}
}

Module M10 {
	Attribute lic = 'h 52384b44;
	Parameter inputs = 301;
	Parameter outputs = 377;
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
		InputPort fromSO = sib1.SO;
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
		Parameter dataWidth = 13;
	}
}

Module M11 {
	Attribute lic = 'h 21c60c18;
	Parameter inputs = 145;
	Parameter outputs = 191;
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
		InputPort fromSO = sib1.SO;
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
		Parameter dataWidth = 9;
	}
}

Module M12 {
	Attribute lic = 'h 7932a973;
	Parameter inputs = 157;
	Parameter outputs = 161;
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
		InputPort fromSO = sib1.SO;
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
		Parameter dataWidth = 13;
	}
}

NameSpace G1023_Basic;

UseNameSpace root;
Module M1 {
	Attribute lic = 'h f515ed8b;
	Parameter inputs = 139;
	Parameter outputs = 273;

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
		InputPort fromSO = sib14.SO;
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
		InputPort fromSO = scanReg1.SO;
	}
	Instance scanReg1 Of WrappedScan {
		InputPort SI = sib1.toSI; 
		Parameter dataWidth = 43;
	}
	Instance sib2 Of SIB_mux_pre {
		InputPort SI = sib1.SO;
		InputPort fromSO = scanReg2.SO;
	}
	Instance scanReg2 Of WrappedScan {
		InputPort SI = sib2.toSI; 
		Parameter dataWidth = 43;
	}
	Instance sib3 Of SIB_mux_pre {
		InputPort SI = sib2.SO;
		InputPort fromSO = scanReg3.SO;
	}
	Instance scanReg3 Of WrappedScan {
		InputPort SI = sib3.toSI; 
		Parameter dataWidth = 43;
	}
	Instance sib4 Of SIB_mux_pre {
		InputPort SI = sib3.SO;
		InputPort fromSO = scanReg4.SO;
	}
	Instance scanReg4 Of WrappedScan {
		InputPort SI = sib4.toSI; 
		Parameter dataWidth = 43;
	}
	Instance sib5 Of SIB_mux_pre {
		InputPort SI = sib4.SO;
		InputPort fromSO = scanReg5.SO;
	}
	Instance scanReg5 Of WrappedScan {
		InputPort SI = sib5.toSI; 
		Parameter dataWidth = 42;
	}
	Instance sib6 Of SIB_mux_pre {
		InputPort SI = sib5.SO;
		InputPort fromSO = scanReg6.SO;
	}
	Instance scanReg6 Of WrappedScan {
		InputPort SI = sib6.toSI; 
		Parameter dataWidth = 42;
	}
	Instance sib7 Of SIB_mux_pre {
		InputPort SI = sib6.SO;
		InputPort fromSO = scanReg7.SO;
	}
	Instance scanReg7 Of WrappedScan {
		InputPort SI = sib7.toSI; 
		Parameter dataWidth = 42;
	}
	Instance sib8 Of SIB_mux_pre {
		InputPort SI = sib7.SO;
		InputPort fromSO = scanReg8.SO;
	}
	Instance scanReg8 Of WrappedScan {
		InputPort SI = sib8.toSI; 
		Parameter dataWidth = 42;
	}
	Instance sib9 Of SIB_mux_pre {
		InputPort SI = sib8.SO;
		InputPort fromSO = scanReg9.SO;
	}
	Instance scanReg9 Of WrappedScan {
		InputPort SI = sib9.toSI; 
		Parameter dataWidth = 42;
	}
	Instance sib10 Of SIB_mux_pre {
		InputPort SI = sib9.SO;
		InputPort fromSO = scanReg10.SO;
	}
	Instance scanReg10 Of WrappedScan {
		InputPort SI = sib10.toSI; 
		Parameter dataWidth = 42;
	}
	Instance sib11 Of SIB_mux_pre {
		InputPort SI = sib10.SO;
		InputPort fromSO = scanReg11.SO;
	}
	Instance scanReg11 Of WrappedScan {
		InputPort SI = sib11.toSI; 
		Parameter dataWidth = 42;
	}
	Instance sib12 Of SIB_mux_pre {
		InputPort SI = sib11.SO;
		InputPort fromSO = scanReg12.SO;
	}
	Instance scanReg12 Of WrappedScan {
		InputPort SI = sib12.toSI; 
		Parameter dataWidth = 42;
	}
	Instance sib13 Of SIB_mux_pre {
		InputPort SI = sib12.SO;
		InputPort fromSO = scanReg13.SO;
	}
	Instance scanReg13 Of WrappedScan {
		InputPort SI = sib13.toSI; 
		Parameter dataWidth = 42;
	}
	Instance sib14 Of SIB_mux_pre {
		InputPort SI = sib13.SO;
		InputPort fromSO = scanReg14.SO;
	}
	Instance scanReg14 Of WrappedScan {
		InputPort SI = sib14.toSI; 
		Parameter dataWidth = 42;
	}
	
}

Module M2 {
	Attribute lic = 'h 613f6d2d;
	Parameter inputs = 221;
	Parameter outputs = 215;

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
		InputPort fromSO = sib2.SO;
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
		InputPort fromSO = scanReg1.SO;
	}
	Instance scanReg1 Of WrappedScan {
		InputPort SI = sib1.toSI; 
		Parameter dataWidth = 84;
	}
	Instance sib2 Of SIB_mux_pre {
		InputPort SI = sib1.SO;
		InputPort fromSO = scanReg2.SO;
	}
	Instance scanReg2 Of WrappedScan {
		InputPort SI = sib2.toSI; 
		Parameter dataWidth = 83;
	}
}

Module M3 {
	Attribute lic = 'h b54aa29c;
	Parameter inputs = 192;
	Parameter outputs = 171;

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
		InputPort fromSO = scanReg1.SO;
	}
	Instance scanReg1 Of WrappedScan {
		InputPort SI = sib1.toSI; 
		Parameter dataWidth = 53;
	}
}

Module M4 {
	Attribute lic = 'h 729ae59;
	Parameter inputs = 145;
	Parameter outputs = 155;

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
		Parameter dataWidth = 54;
	}
	Instance sib2 Of SIB_mux_pre {
		InputPort SI = scanReg1.SO;
		InputPort fromSO = sib3.SO;
	}
	Instance scanReg2 Of WrappedScan {
		InputPort SI = sib2.toSI; 
		Parameter dataWidth = 54;
	}
	Instance sib3 Of SIB_mux_pre {
		InputPort SI = scanReg2.SO;
		InputPort fromSO = sib4.SO;
	}
	Instance scanReg3 Of WrappedScan {
		InputPort SI = sib3.toSI; 
		Parameter dataWidth = 54;
	}
	Instance sib4 Of SIB_mux_pre {
		InputPort SI = scanReg3.SO;
		InputPort fromSO = scanReg4.SO;
	}
	Instance scanReg4 Of WrappedScan {
		InputPort SI = sib4.toSI; 
		Parameter dataWidth = 54;
	}
}

Module M5 {
	Attribute lic = 'h 6f7ad1d8;
	Parameter inputs = 32;
	Parameter outputs = 27;

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
		InputPort fromSO = scr.SO;
	}
	Instance scanReg1 Of WrappedScan {
		InputPort SI = sib1.toSI; 
		InputPort SEL = sel_SR1;
		Parameter dataWidth = 32;
	}
	Instance scanReg2 Of WrappedScan {
		InputPort SI = sib1.toSI; 
		InputPort SEL = sel_SR2;
		Parameter dataWidth = 32;
	}
	Instance scanReg3 Of WrappedScan {
		InputPort SI = sib1.toSI;
		InputPort SEL = sel_SR3;
		Parameter dataWidth = 31;
	}
	Instance scanReg4 Of WrappedScan {
		InputPort SI = sib1.toSI;
		InputPort SEL = sel_SR4;
		Parameter dataWidth = 32;
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
	ScanMux sMux SelectedBy scr.DO[2:0] {
		0 : sib1.toSI;
		1 : scanReg1.SO;
		2 : scanReg2.SO;
		3 : scanReg3.SO;
		5 : scanReg4.SO;
	}
	Instance scr Of SCR {
		InputPort SI = sMux;
		Parameter size = 3;
	}
}

Module M6 {
	Attribute lic = 'h 6e157083;
	Parameter inputs = 20;
	Parameter outputs = 18;

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
		InputPort fromSO = sib2.SO;
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
		InputPort fromSO = scanReg1.SO;
	}
	Instance scanReg1 Of WrappedScan {
		InputPort SI = sib1.toSI; 
		Parameter dataWidth = 47;
	}
	Instance sib2 Of SIB_mux_pre {
		InputPort SI = sib1.SO;
		InputPort fromSO = scanReg2.SO;
	}
	Instance scanReg2 Of WrappedScan {
		InputPort SI = sib2.toSI; 
		Parameter dataWidth = 47;
	}
}

Module M7 {
	Attribute lic = 'h b9ae2565;
	Parameter inputs = 20;
	Parameter outputs = 18;

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
	LogicSignal sel_SR1{
		sib1.toSEL & scb1.DO;
	}
	LogicSignal sel_SR2{
		sib1.toSEL & scb2.DO;
	}
	Instance sib1 Of SIB_mux_pre {
		InputPort SI = sibWrp.SO;
		InputPort fromSO = scb1.SO;
	}
	Instance scanReg1 Of WrappedScan {
		InputPort SI = sib1.toSI;
		InputPort SEL = sel_SR1;
		Parameter dataWidth = 47;
	}
	ScanMux sMux1 SelectedBy scb1.toSEL {
		0 : sib1.toSI;
		1 : scanReg1.SO;
	}
	Instance scb2 Of SCB {
		InputPort SI = sMux2;
	}
	Instance scanReg2 Of WrappedScan {
		InputPort SI = sMux1; 
		InputPort SEL = sel_SR2;
		Parameter dataWidth = 47;
	}
	ScanMux sMux2 SelectedBy scb2.toSEL {
		0 : sMux1;
		1 : scanReg2.SO;
	}
	Instance scb1 Of SCB {
		InputPort SI = scb2.SO;
	}
}

Module M8 {
	Attribute lic = 'h dc3f2626;
	Parameter inputs = 63;
	Parameter outputs = 80;

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
		Parameter dataWidth = 52;
	}
	Instance sib2 Of SIB_mux_pre {
		InputPort SI = scanReg1.SO;
		InputPort fromSO = scanReg2.SO;
	}
	Instance scanReg2 Of WrappedScan {
		InputPort SI = sib2.toSI; 
		Parameter dataWidth = 52;
	}
}

Module M9 {
	Attribute lic = 'h 6452a8c2;
	Parameter inputs = 56;
	Parameter outputs = 34;

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
		InputPort fromSO = scanReg1.SO;
	}
	Instance scanReg1 Of WrappedScan {
		InputPort SI = sib1.toSI; 
		Parameter dataWidth = 64;
	}
}

Module M10 {
	Attribute lic = 'h a86a0ffc;
	Parameter inputs = 301;
	Parameter outputs = 377;

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
		InputPort fromSO = scanReg1.SO;
	}
	Instance scanReg1 Of WrappedScan {
		InputPort SI = sib1.toSI; 
		Parameter dataWidth = 13;
	}
}

Module M11 {
	Attribute lic = 'h 7a34bb53;
	Parameter inputs = 145;
	Parameter outputs = 191;

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
		InputPort fromSO = scanReg1.SO;
	}
	Instance scanReg1 Of WrappedScan {
		InputPort SI = sib1.toSI; 
		Parameter dataWidth = 9;
	}
}

Module M12 {
	Attribute lic = 'h b7dbe57f;
	Parameter inputs = 157;
	Parameter outputs = 161;

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
		InputPort fromSO = scanReg1.SO;
	}
	Instance scanReg1 Of WrappedScan {
		InputPort SI = sib1.toSI; 
		Parameter dataWidth = 13;
	}
}
