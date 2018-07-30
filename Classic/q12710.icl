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
* CLASSIC benchmark based on ITC'02 q12710 and Segment Insertion Bit (SIB) network 
* design strategy.
*
* Uses modules from files: 
* - Instruments.icl
* - NetworkStructs.icl
* - EmptyModule.icl
*/

NameSpace q12710;

UseNameSpace root;
/* Module 0 Level 0 Inputs 0 Outputs 0 Bidirs 0 ScanChains 0 :*/
Module M0 {
	Attribute lic = 'h f2815966;
	Parameter inputs = 0;
	Parameter outputs = 0;
	Parameter bidirs = 0;
	ScanInPort SI;
	ScanOutPort SO {
		Source sibM4.SO;
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
	Instance sibIn Of SIB_mux_pre {
		InputPort SI = SI;
		InputPort fromSO = wrpIn.SO;
	}
	Instance wrpIn Of SReg {
		InputPort SI = sibIn.toSI;
		InputPort DI = DI;
		Parameter Size = $inputs+$bidirs;
	}
	Instance sibOut Of SIB_mux_pre {
		InputPort SI = sibIn.SO;
		InputPort fromSO = wrpOut.SO;
	}
	Instance wrpOut Of SReg {
		InputPort SI = sibOut.toSI;
		InputPort DI = toDO;
		Parameter Size = $outputs+$bidirs;
	}

		/* Module M1*/
	Instance sibM1 Of SIB_mux_pre {
		InputPort SI = sibOut.SO;
		InputPort fromSO = m1.SO;
	}
	Instance m1 Of q12710::M1 {
		InputPort SI = sibM1.toSI;
	}
	/* Module M2*/
	Instance sibM2 Of SIB_mux_pre {
		InputPort SI = sibM1.SO;
		InputPort fromSO = m2.SO;
	}
	Instance m2 Of q12710::M2 {
		InputPort SI = sibM2.toSI;
	}
	/* Module M3*/
	Instance sibM3 Of SIB_mux_pre {
		InputPort SI = sibM2.SO;
		InputPort fromSO = m3.SO;
	}
	Instance m3 Of q12710::M3 {
		InputPort SI = sibM3.toSI;
	}
	/* Module M4*/
	Instance sibM4 Of SIB_mux_pre {
		InputPort SI = sibM3.SO;
		InputPort fromSO = m4.SO;
	}
	Instance m4 Of q12710::M4 {
		InputPort SI = sibM4.toSI;
	}

}


/* Module 1 Level 1 Inputs 655 Outputs 777 Bidirs 0 ScanChains 3 : 971 701 413*/
Module M1 {
	Attribute lic = 'h e3a5a586;
	Parameter inputs = 655;
	Parameter outputs = 777;
	Parameter bidirs = 0;
	ScanInPort SI;
	ScanOutPort SO {
		Source sibSC3.SO;
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
	Instance sibIn Of SIB_mux_pre {
		InputPort SI = SI;
		InputPort fromSO = wrpIn.SO;
	}
	Instance wrpIn Of SReg {
		InputPort SI = sibIn.toSI;
		InputPort DI = DI;
		Parameter Size = $inputs+$bidirs;
	}
	Instance sibOut Of SIB_mux_pre {
		InputPort SI = sibIn.SO;
		InputPort fromSO = wrpOut.SO;
	}
	Instance wrpOut Of SReg {
		InputPort SI = sibOut.toSI;
		InputPort DI = toDO;
		Parameter Size = $outputs+$bidirs;
	}

	/*Scan Register 1*/
	Instance sibSC1 Of SIB_mux_pre {
		InputPort SI = sibOut.SO;
		InputPort fromSO = sc1.SO;
	}
	Instance sc1 Of SReg {
		InputPort SI = sibSC1.toSI;
		Parameter Size = 971;
	}

	/* Scan Register 2*/
	Instance sibSC2 Of SIB_mux_pre {
		InputPort SI = sibSC1.SO;
		InputPort fromSO = sc2.SO;
	}
	Instance sc2 Of SReg {
		InputPort SI = sibSC2.toSI;
		Parameter Size = 701;
	}
	/* Scan Register 3*/
	Instance sibSC3 Of SIB_mux_pre {
		InputPort SI = sibSC2.SO;
		InputPort fromSO = sc3.SO;
	}
	Instance sc3 Of SReg {
		InputPort SI = sibSC3.toSI;
		Parameter Size = 413;
	}
}


/* Module 2 Level 1 Inputs 3784 Outputs 3379 Bidirs 0 ScanChains 4 : 1109 1099 911 1689*/
Module M2 {
	Attribute lic = 'h c8379deb;
	Parameter inputs = 3784;
	Parameter outputs = 3379;
	Parameter bidirs = 0;
	ScanInPort SI;
	ScanOutPort SO {
		Source sibSC4.SO;
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
	Instance sibIn Of SIB_mux_pre {
		InputPort SI = SI;
		InputPort fromSO = wrpIn.SO;
	}
	Instance wrpIn Of SReg {
		InputPort SI = sibIn.toSI;
		InputPort DI = DI;
		Parameter Size = $inputs+$bidirs;
	}
	Instance sibOut Of SIB_mux_pre {
		InputPort SI = sibIn.SO;
		InputPort fromSO = wrpOut.SO;
	}
	Instance wrpOut Of SReg {
		InputPort SI = sibOut.toSI;
		InputPort DI = toDO;
		Parameter Size = $outputs+$bidirs;
	}

	/*Scan Register 1*/
	Instance sibSC1 Of SIB_mux_pre {
		InputPort SI = sibOut.SO;
		InputPort fromSO = sc1.SO;
	}
	Instance sc1 Of SReg {
		InputPort SI = sibSC1.toSI;
		Parameter Size = 1109;
	}

	/* Scan Register 2*/
	Instance sibSC2 Of SIB_mux_pre {
		InputPort SI = sibSC1.SO;
		InputPort fromSO = sc2.SO;
	}
	Instance sc2 Of SReg {
		InputPort SI = sibSC2.toSI;
		Parameter Size = 1099;
	}
	/* Scan Register 3*/
	Instance sibSC3 Of SIB_mux_pre {
		InputPort SI = sibSC2.SO;
		InputPort fromSO = sc3.SO;
	}
	Instance sc3 Of SReg {
		InputPort SI = sibSC3.toSI;
		Parameter Size = 911;
	}
	/* Scan Register 4*/
	Instance sibSC4 Of SIB_mux_pre {
		InputPort SI = sibSC3.SO;
		InputPort fromSO = sc4.SO;
	}
	Instance sc4 Of SReg {
		InputPort SI = sibSC4.toSI;
		Parameter Size = 1689;
	}
}


/* Module 3 Level 1 Inputs 970 Outputs 1316 Bidirs 0 ScanChains 3 : 631 1121 1297*/
Module M3 {
	Attribute lic = 'h 6c114e98;
	Parameter inputs = 970;
	Parameter outputs = 1316;
	Parameter bidirs = 0;
	ScanInPort SI;
	ScanOutPort SO {
		Source sibSC3.SO;
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
	Instance sibIn Of SIB_mux_pre {
		InputPort SI = SI;
		InputPort fromSO = wrpIn.SO;
	}
	Instance wrpIn Of SReg {
		InputPort SI = sibIn.toSI;
		InputPort DI = DI;
		Parameter Size = $inputs+$bidirs;
	}
	Instance sibOut Of SIB_mux_pre {
		InputPort SI = sibIn.SO;
		InputPort fromSO = wrpOut.SO;
	}
	Instance wrpOut Of SReg {
		InputPort SI = sibOut.toSI;
		InputPort DI = toDO;
		Parameter Size = $outputs+$bidirs;
	}

	/*Scan Register 1*/
	Instance sibSC1 Of SIB_mux_pre {
		InputPort SI = sibOut.SO;
		InputPort fromSO = sc1.SO;
	}
	Instance sc1 Of SReg {
		InputPort SI = sibSC1.toSI;
		Parameter Size = 631;
	}

	/* Scan Register 2*/
	Instance sibSC2 Of SIB_mux_pre {
		InputPort SI = sibSC1.SO;
		InputPort fromSO = sc2.SO;
	}
	Instance sc2 Of SReg {
		InputPort SI = sibSC2.toSI;
		Parameter Size = 1121;
	}
	/* Scan Register 3*/
	Instance sibSC3 Of SIB_mux_pre {
		InputPort SI = sibSC2.SO;
		InputPort fromSO = sc3.SO;
	}
	Instance sc3 Of SReg {
		InputPort SI = sibSC3.toSI;
		Parameter Size = 1297;
	}
}


/* Module 4 Level 1 Inputs 970 Outputs 1316 Bidirs 0 ScanChains 3 : 631 1121 1297*/
Module M4 {
	Attribute lic = 'h 40668282;
	Parameter inputs = 970;
	Parameter outputs = 1316;
	Parameter bidirs = 0;
	ScanInPort SI;
	ScanOutPort SO {
		Source sibSC3.SO;
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
	Instance sibIn Of SIB_mux_pre {
		InputPort SI = SI;
		InputPort fromSO = wrpIn.SO;
	}
	Instance wrpIn Of SReg {
		InputPort SI = sibIn.toSI;
		InputPort DI = DI;
		Parameter Size = $inputs+$bidirs;
	}
	Instance sibOut Of SIB_mux_pre {
		InputPort SI = sibIn.SO;
		InputPort fromSO = wrpOut.SO;
	}
	Instance wrpOut Of SReg {
		InputPort SI = sibOut.toSI;
		InputPort DI = toDO;
		Parameter Size = $outputs+$bidirs;
	}

	/*Scan Register 1*/
	Instance sibSC1 Of SIB_mux_pre {
		InputPort SI = sibOut.SO;
		InputPort fromSO = sc1.SO;
	}
	Instance sc1 Of SReg {
		InputPort SI = sibSC1.toSI;
		Parameter Size = 631;
	}

	/* Scan Register 2*/
	Instance sibSC2 Of SIB_mux_pre {
		InputPort SI = sibSC1.SO;
		InputPort fromSO = sc2.SO;
	}
	Instance sc2 Of SReg {
		InputPort SI = sibSC2.toSI;
		Parameter Size = 1121;
	}
	/* Scan Register 3*/
	Instance sibSC3 Of SIB_mux_pre {
		InputPort SI = sibSC2.SO;
		InputPort fromSO = sc3.SO;
	}
	Instance sc3 Of SReg {
		InputPort SI = sibSC3.toSI;
		Parameter Size = 1297;
	}
}
