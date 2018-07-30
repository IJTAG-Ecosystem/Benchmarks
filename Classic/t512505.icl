/*
* Copyright Testonica Lab (C) 2016
*
*
* History:
* -------------+------------+-------------------------+------------------------
*   Version    |  Date      | Author                  | Organization
* -------------+------------+-------------------------+------------------------
*          1.0 | 11.05.2016 | Anton Tsertov           | Testonica Lab
*--------------+------------+-------------------------+------------------------
*
* CLASSIC benchmark based on ITC'02 t512505 and Segment Insertion Bit (SIB) network 
* design strategy.
*
* Uses modules from files: 
* - Instruments.icl
* - EmptyModule.icl
*/

NameSpace t512505;

UseNameSpace root;
/* Module 0 Level 0 Inputs 15 Outputs 13 Bidirs 132 ScanChains 0 :*/
Module M0 {
	Attribute lic = 'h 6d93fe2;
	Parameter inputs = 15;
	Parameter outputs = 13;
	Parameter bidirs = 132;
	ScanInPort SI;
	ScanOutPort SO {
		Source sibM31.SO;
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
	Instance m1 Of t512505::M1 {
		InputPort SI = sibM1.toSI;
	}
	/* Module M2*/
	Instance sibM2 Of SIB_mux_pre {
		InputPort SI = sibM1.SO;
		InputPort fromSO = m2.SO;
	}
	Instance m2 Of t512505::M2 {
		InputPort SI = sibM2.toSI;
	}
	/* Module M3*/
	Instance sibM3 Of SIB_mux_pre {
		InputPort SI = sibM2.SO;
		InputPort fromSO = m3.SO;
	}
	Instance m3 Of t512505::M3 {
		InputPort SI = sibM3.toSI;
	}
	/* Module M4*/
	Instance sibM4 Of SIB_mux_pre {
		InputPort SI = sibM3.SO;
		InputPort fromSO = m4.SO;
	}
	Instance m4 Of t512505::M4 {
		InputPort SI = sibM4.toSI;
	}
	/* Module M5*/
	Instance sibM5 Of SIB_mux_pre {
		InputPort SI = sibM4.SO;
		InputPort fromSO = m5.SO;
	}
	Instance m5 Of t512505::M5 {
		InputPort SI = sibM5.toSI;
	}
	/* Module M6*/
	Instance sibM6 Of SIB_mux_pre {
		InputPort SI = sibM5.SO;
		InputPort fromSO = m6.SO;
	}
	Instance m6 Of t512505::M6 {
		InputPort SI = sibM6.toSI;
	}
	/* Module M7*/
	Instance sibM7 Of SIB_mux_pre {
		InputPort SI = sibM6.SO;
		InputPort fromSO = m7.SO;
	}
	Instance m7 Of t512505::M7 {
		InputPort SI = sibM7.toSI;
	}
	/* Module M8*/
	Instance sibM8 Of SIB_mux_pre {
		InputPort SI = sibM7.SO;
		InputPort fromSO = m8.SO;
	}
	Instance m8 Of t512505::M8 {
		InputPort SI = sibM8.toSI;
	}
	/* Module M9*/
	Instance sibM9 Of SIB_mux_pre {
		InputPort SI = sibM8.SO;
		InputPort fromSO = m9.SO;
	}
	Instance m9 Of t512505::M9 {
		InputPort SI = sibM9.toSI;
	}
	/* Module M10*/
	Instance sibM10 Of SIB_mux_pre {
		InputPort SI = sibM9.SO;
		InputPort fromSO = m10.SO;
	}
	Instance m10 Of t512505::M10 {
		InputPort SI = sibM10.toSI;
	}
	/* Module M11*/
	Instance sibM11 Of SIB_mux_pre {
		InputPort SI = sibM10.SO;
		InputPort fromSO = m11.SO;
	}
	Instance m11 Of t512505::M11 {
		InputPort SI = sibM11.toSI;
	}
	/* Module M12*/
	Instance sibM12 Of SIB_mux_pre {
		InputPort SI = sibM11.SO;
		InputPort fromSO = m12.SO;
	}
	Instance m12 Of t512505::M12 {
		InputPort SI = sibM12.toSI;
	}
	/* Module M13*/
	Instance sibM13 Of SIB_mux_pre {
		InputPort SI = sibM12.SO;
		InputPort fromSO = m13.SO;
	}
	Instance m13 Of t512505::M13 {
		InputPort SI = sibM13.toSI;
	}
	/* Module M14*/
	Instance sibM14 Of SIB_mux_pre {
		InputPort SI = sibM13.SO;
		InputPort fromSO = m14.SO;
	}
	Instance m14 Of t512505::M14 {
		InputPort SI = sibM14.toSI;
	}
	/* Module M15*/
	Instance sibM15 Of SIB_mux_pre {
		InputPort SI = sibM14.SO;
		InputPort fromSO = m15.SO;
	}
	Instance m15 Of t512505::M15 {
		InputPort SI = sibM15.toSI;
	}
	/* Module M16*/
	Instance sibM16 Of SIB_mux_pre {
		InputPort SI = sibM15.SO;
		InputPort fromSO = m16.SO;
	}
	Instance m16 Of t512505::M16 {
		InputPort SI = sibM16.toSI;
	}
	/* Module M17*/
	Instance sibM17 Of SIB_mux_pre {
		InputPort SI = sibM16.SO;
		InputPort fromSO = m17.SO;
	}
	Instance m17 Of t512505::M17 {
		InputPort SI = sibM17.toSI;
	}
	/* Module M18*/
	Instance sibM18 Of SIB_mux_pre {
		InputPort SI = sibM17.SO;
		InputPort fromSO = m18.SO;
	}
	Instance m18 Of t512505::M18 {
		InputPort SI = sibM18.toSI;
	}
	/* Module M19*/
	Instance sibM19 Of SIB_mux_pre {
		InputPort SI = sibM18.SO;
		InputPort fromSO = m19.SO;
	}
	Instance m19 Of t512505::M19 {
		InputPort SI = sibM19.toSI;
	}
	/* Module M20*/
	Instance sibM20 Of SIB_mux_pre {
		InputPort SI = sibM19.SO;
		InputPort fromSO = m20.SO;
	}
	Instance m20 Of t512505::M20 {
		InputPort SI = sibM20.toSI;
	}
	/* Module M21*/
	Instance sibM21 Of SIB_mux_pre {
		InputPort SI = sibM20.SO;
		InputPort fromSO = m21.SO;
	}
	Instance m21 Of t512505::M21 {
		InputPort SI = sibM21.toSI;
	}
	/* Module M22*/
	Instance sibM22 Of SIB_mux_pre {
		InputPort SI = sibM21.SO;
		InputPort fromSO = m22.SO;
	}
	Instance m22 Of t512505::M22 {
		InputPort SI = sibM22.toSI;
	}
	/* Module M23*/
	Instance sibM23 Of SIB_mux_pre {
		InputPort SI = sibM22.SO;
		InputPort fromSO = m23.SO;
	}
	Instance m23 Of t512505::M23 {
		InputPort SI = sibM23.toSI;
	}
	/* Module M24*/
	Instance sibM24 Of SIB_mux_pre {
		InputPort SI = sibM23.SO;
		InputPort fromSO = m24.SO;
	}
	Instance m24 Of t512505::M24 {
		InputPort SI = sibM24.toSI;
	}
	/* Module M25*/
	Instance sibM25 Of SIB_mux_pre {
		InputPort SI = sibM24.SO;
		InputPort fromSO = m25.SO;
	}
	Instance m25 Of t512505::M25 {
		InputPort SI = sibM25.toSI;
	}
	/* Module M26*/
	Instance sibM26 Of SIB_mux_pre {
		InputPort SI = sibM25.SO;
		InputPort fromSO = m26.SO;
	}
	Instance m26 Of t512505::M26 {
		InputPort SI = sibM26.toSI;
	}
	/* Module M27*/
	Instance sibM27 Of SIB_mux_pre {
		InputPort SI = sibM26.SO;
		InputPort fromSO = m27.SO;
	}
	Instance m27 Of t512505::M27 {
		InputPort SI = sibM27.toSI;
	}
	/* Module M28*/
	Instance sibM28 Of SIB_mux_pre {
		InputPort SI = sibM27.SO;
		InputPort fromSO = m28.SO;
	}
	Instance m28 Of t512505::M28 {
		InputPort SI = sibM28.toSI;
	}
	/* Module M29*/
	Instance sibM29 Of SIB_mux_pre {
		InputPort SI = sibM28.SO;
		InputPort fromSO = m29.SO;
	}
	Instance m29 Of t512505::M29 {
		InputPort SI = sibM29.toSI;
	}
	/* Module M30*/
	Instance sibM30 Of SIB_mux_pre {
		InputPort SI = sibM29.SO;
		InputPort fromSO = m30.SO;
	}
	Instance m30 Of t512505::M30 {
		InputPort SI = sibM30.toSI;
	}
	/* Module M31*/
	Instance sibM31 Of SIB_mux_pre {
		InputPort SI = sibM30.SO;
		InputPort fromSO = m31.SO;
	}
	Instance m31 Of t512505::M31 {
		InputPort SI = sibM31.toSI;
	}

}


/* Module 1 Level 1 Inputs 206 Outputs 151 Bidirs 0 ScanChains 1 : 389*/
Module M1 {
	Attribute lic = 'h a713759b;
	Parameter inputs = 206;
	Parameter outputs = 151;
	Parameter bidirs = 0;
	ScanInPort SI;
	ScanOutPort SO {
		Source sibSC1.SO;
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
		Parameter Size = 389;
	}

}


/* Module 2 Level 1 Inputs 199 Outputs 89 Bidirs 0 ScanChains 1 : 104*/
Module M2 {
	Attribute lic = 'h 824d409f;
	Parameter inputs = 199;
	Parameter outputs = 89;
	Parameter bidirs = 0;
	ScanInPort SI;
	ScanOutPort SO {
		Source sibSC1.SO;
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
		Parameter Size = 104;
	}

}


/* Module 3 Level 1 Inputs 61 Outputs 38 Bidirs 0 ScanChains 1 : 904*/
Module M3 {
	Attribute lic = 'h 24ffc4e9;
	Parameter inputs = 61;
	Parameter outputs = 38;
	Parameter bidirs = 0;
	ScanInPort SI;
	ScanOutPort SO {
		Source sibSC1.SO;
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
		Parameter Size = 904;
	}

}


/* Module 4 Level 1 Inputs 114 Outputs 92 Bidirs 0 ScanChains 1 : 740*/
Module M4 {
	Attribute lic = 'h 468fa457;
	Parameter inputs = 114;
	Parameter outputs = 92;
	Parameter bidirs = 0;
	ScanInPort SI;
	ScanOutPort SO {
		Source sibSC1.SO;
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
		Parameter Size = 740;
	}

}


/* Module 5 Level 1 Inputs 9 Outputs 6 Bidirs 0 ScanChains 1 : 10*/
Module M5 {
	Attribute lic = 'h 7ddc0eb4;
	Parameter inputs = 9;
	Parameter outputs = 6;
	Parameter bidirs = 0;
	ScanInPort SI;
	ScanOutPort SO {
		Source sibSC1.SO;
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
		Parameter Size = 10;
	}

}


/* Module 6 Level 1 Inputs 28 Outputs 22 Bidirs 0 ScanChains 1 : 154*/
Module M6 {
	Attribute lic = 'h b5ad8112;
	Parameter inputs = 28;
	Parameter outputs = 22;
	Parameter bidirs = 0;
	ScanInPort SI;
	ScanOutPort SO {
		Source sibSC1.SO;
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
		Parameter Size = 154;
	}

}


/* Module 7 Level 1 Inputs 122 Outputs 36 Bidirs 0 ScanChains 1 : 514*/
Module M7 {
	Attribute lic = 'h 916d6241;
	Parameter inputs = 122;
	Parameter outputs = 36;
	Parameter bidirs = 0;
	ScanInPort SI;
	ScanOutPort SO {
		Source sibSC1.SO;
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
		Parameter Size = 514;
	}

}


/* Module 8 Level 1 Inputs 106 Outputs 147 Bidirs 0 ScanChains 3 : 1472 1473 1473*/
Module M8 {
	Attribute lic = 'h 5bdfa951;
	Parameter inputs = 106;
	Parameter outputs = 147;
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
		Parameter Size = 1472;
	}

	/* Scan Register 2*/
	Instance sibSC2 Of SIB_mux_pre {
		InputPort SI = sibSC1.SO;
		InputPort fromSO = sc2.SO;
	}
	Instance sc2 Of SReg {
		InputPort SI = sibSC2.toSI;
		Parameter Size = 1473;
	}
	/* Scan Register 3*/
	Instance sibSC3 Of SIB_mux_pre {
		InputPort SI = sibSC2.SO;
		InputPort fromSO = sc3.SO;
	}
	Instance sc3 Of SReg {
		InputPort SI = sibSC3.toSI;
		Parameter Size = 1473;
	}
}


/* Module 9 Level 1 Inputs 82 Outputs 122 Bidirs 0 ScanChains 1 : 530*/
Module M9 {
	Attribute lic = 'h 3c4349de;
	Parameter inputs = 82;
	Parameter outputs = 122;
	Parameter bidirs = 0;
	ScanInPort SI;
	ScanOutPort SO {
		Source sibSC1.SO;
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
		Parameter Size = 530;
	}

}


/* Module 10 Level 1 Inputs 64 Outputs 113 Bidirs 0 ScanChains 8 : 332 1264 1264 1264 1264 1263 1263 213*/
Module M10 {
	Attribute lic = 'h 9d2a957f;
	Parameter inputs = 64;
	Parameter outputs = 113;
	Parameter bidirs = 0;
	ScanInPort SI;
	ScanOutPort SO {
		Source sibSC8.SO;
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
		Parameter Size = 332;
	}

	/* Scan Register 2*/
	Instance sibSC2 Of SIB_mux_pre {
		InputPort SI = sibSC1.SO;
		InputPort fromSO = sc2.SO;
	}
	Instance sc2 Of SReg {
		InputPort SI = sibSC2.toSI;
		Parameter Size = 1264;
	}
	/* Scan Register 3*/
	Instance sibSC3 Of SIB_mux_pre {
		InputPort SI = sibSC2.SO;
		InputPort fromSO = sc3.SO;
	}
	Instance sc3 Of SReg {
		InputPort SI = sibSC3.toSI;
		Parameter Size = 1264;
	}
	/* Scan Register 4*/
	Instance sibSC4 Of SIB_mux_pre {
		InputPort SI = sibSC3.SO;
		InputPort fromSO = sc4.SO;
	}
	Instance sc4 Of SReg {
		InputPort SI = sibSC4.toSI;
		Parameter Size = 1264;
	}
	/* Scan Register 5*/
	Instance sibSC5 Of SIB_mux_pre {
		InputPort SI = sibSC4.SO;
		InputPort fromSO = sc5.SO;
	}
	Instance sc5 Of SReg {
		InputPort SI = sibSC5.toSI;
		Parameter Size = 1264;
	}
	/* Scan Register 6*/
	Instance sibSC6 Of SIB_mux_pre {
		InputPort SI = sibSC5.SO;
		InputPort fromSO = sc6.SO;
	}
	Instance sc6 Of SReg {
		InputPort SI = sibSC6.toSI;
		Parameter Size = 1263;
	}
	/* Scan Register 7*/
	Instance sibSC7 Of SIB_mux_pre {
		InputPort SI = sibSC6.SO;
		InputPort fromSO = sc7.SO;
	}
	Instance sc7 Of SReg {
		InputPort SI = sibSC7.toSI;
		Parameter Size = 1263;
	}
	/* Scan Register 8*/
	Instance sibSC8 Of SIB_mux_pre {
		InputPort SI = sibSC7.SO;
		InputPort fromSO = sc8.SO;
	}
	Instance sc8 Of SReg {
		InputPort SI = sibSC8.toSI;
		Parameter Size = 213;
	}
}


/* Module 11 Level 1 Inputs 75 Outputs 34 Bidirs 0 ScanChains 1 : 530*/
Module M11 {
	Attribute lic = 'h d988e92d;
	Parameter inputs = 75;
	Parameter outputs = 34;
	Parameter bidirs = 0;
	ScanInPort SI;
	ScanOutPort SO {
		Source sibSC1.SO;
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
		Parameter Size = 530;
	}

}


/* Module 12 Level 1 Inputs 46 Outputs 74 Bidirs 0 ScanChains 1 : 53*/
Module M12 {
	Attribute lic = 'h 60b3f9ba;
	Parameter inputs = 46;
	Parameter outputs = 74;
	Parameter bidirs = 0;
	ScanInPort SI;
	ScanOutPort SO {
		Source sibSC1.SO;
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
		Parameter Size = 53;
	}

}


/* Module 13 Level 1 Inputs 56 Outputs 37 Bidirs 0 ScanChains 1 : 94*/
Module M13 {
	Attribute lic = 'h fda6e343;
	Parameter inputs = 56;
	Parameter outputs = 37;
	Parameter bidirs = 0;
	ScanInPort SI;
	ScanOutPort SO {
		Source sibSC1.SO;
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
		Parameter Size = 94;
	}

}


/* Module 14 Level 1 Inputs 751 Outputs 381 Bidirs 0 ScanChains 1 : 1225*/
Module M14 {
	Attribute lic = 'h 51c66fc6;
	Parameter inputs = 751;
	Parameter outputs = 381;
	Parameter bidirs = 0;
	ScanInPort SI;
	ScanOutPort SO {
		Source sibSC1.SO;
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
		Parameter Size = 1225;
	}

}


/* Module 15 Level 1 Inputs 406 Outputs 132 Bidirs 0 ScanChains 1 : 386*/
Module M15 {
	Attribute lic = 'h a9db8cf5;
	Parameter inputs = 406;
	Parameter outputs = 132;
	Parameter bidirs = 0;
	ScanInPort SI;
	ScanOutPort SO {
		Source sibSC1.SO;
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
		Parameter Size = 386;
	}

}


/* Module 16 Level 1 Inputs 850 Outputs 897 Bidirs 0 ScanChains 1 : 154*/
Module M16 {
	Attribute lic = 'h 870cbc6;
	Parameter inputs = 850;
	Parameter outputs = 897;
	Parameter bidirs = 0;
	ScanInPort SI;
	ScanOutPort SO {
		Source sibSC1.SO;
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
		Parameter Size = 154;
	}

}


/* Module 17 Level 1 Inputs 303 Outputs 134 Bidirs 0 ScanChains 1 : 131*/
Module M17 {
	Attribute lic = 'h 1bfa11e6;
	Parameter inputs = 303;
	Parameter outputs = 134;
	Parameter bidirs = 0;
	ScanInPort SI;
	ScanOutPort SO {
		Source sibSC1.SO;
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
		Parameter Size = 131;
	}

}


/* Module 18 Level 1 Inputs 30 Outputs 20 Bidirs 0 ScanChains 1 : 73*/
Module M18 {
	Attribute lic = 'h 9a123906;
	Parameter inputs = 30;
	Parameter outputs = 20;
	Parameter bidirs = 0;
	ScanInPort SI;
	ScanOutPort SO {
		Source sibSC1.SO;
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
		Parameter Size = 73;
	}

}


/* Module 19 Level 1 Inputs 29 Outputs 21 Bidirs 0 ScanChains 1 : 68*/
Module M19 {
	Attribute lic = 'h 9e959d5b;
	Parameter inputs = 29;
	Parameter outputs = 21;
	Parameter bidirs = 0;
	ScanInPort SI;
	ScanOutPort SO {
		Source sibSC1.SO;
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
		Parameter Size = 68;
	}

}


/* Module 20 Level 1 Inputs 29 Outputs 21 Bidirs 0 ScanChains 1 : 68*/
Module M20 {
	Attribute lic = 'h 542ebfd5;
	Parameter inputs = 29;
	Parameter outputs = 21;
	Parameter bidirs = 0;
	ScanInPort SI;
	ScanOutPort SO {
		Source sibSC1.SO;
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
		Parameter Size = 68;
	}

}


/* Module 21 Level 1 Inputs 23 Outputs 19 Bidirs 0 ScanChains 1 : 540*/
Module M21 {
	Attribute lic = 'h 5f5200a8;
	Parameter inputs = 23;
	Parameter outputs = 19;
	Parameter bidirs = 0;
	ScanInPort SI;
	ScanOutPort SO {
		Source sibSC1.SO;
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
		Parameter Size = 540;
	}

}


/* Module 22 Level 1 Inputs 23 Outputs 19 Bidirs 0 ScanChains 1 : 540*/
Module M22 {
	Attribute lic = 'h 29f2301c;
	Parameter inputs = 23;
	Parameter outputs = 19;
	Parameter bidirs = 0;
	ScanInPort SI;
	ScanOutPort SO {
		Source sibSC1.SO;
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
		Parameter Size = 540;
	}

}


/* Module 23 Level 1 Inputs 99 Outputs 124 Bidirs 0 ScanChains 2 : 1371 1372*/
Module M23 {
	Attribute lic = 'h a16875c;
	Parameter inputs = 99;
	Parameter outputs = 124;
	Parameter bidirs = 0;
	ScanInPort SI;
	ScanOutPort SO {
		Source sibSC2.SO;
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
		Parameter Size = 1371;
	}

	/* Scan Register 2*/
	Instance sibSC2 Of SIB_mux_pre {
		InputPort SI = sibSC1.SO;
		InputPort fromSO = sc2.SO;
	}
	Instance sc2 Of SReg {
		InputPort SI = sibSC2.toSI;
		Parameter Size = 1372;
	}
}


/* Module 24 Level 1 Inputs 182 Outputs 129 Bidirs 0 ScanChains 1 : 1669*/
Module M24 {
	Attribute lic = 'h 5187b359;
	Parameter inputs = 182;
	Parameter outputs = 129;
	Parameter bidirs = 0;
	ScanInPort SI;
	ScanOutPort SO {
		Source sibSC1.SO;
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
		Parameter Size = 1669;
	}

}


/* Module 25 Level 1 Inputs 352 Outputs 136 Bidirs 0 ScanChains 1 : 190*/
Module M25 {
	Attribute lic = 'h a055e2be;
	Parameter inputs = 352;
	Parameter outputs = 136;
	Parameter bidirs = 0;
	ScanInPort SI;
	ScanOutPort SO {
		Source sibSC1.SO;
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
		Parameter Size = 190;
	}

}


/* Module 26 Level 1 Inputs 89 Outputs 127 Bidirs 0 ScanChains 0 :*/
Module M26 {
	Attribute lic = 'h 568d85a7;
	Parameter inputs = 89;
	Parameter outputs = 127;
	Parameter bidirs = 0;
	ScanInPort SI;
	ScanOutPort SO {
		Source sibOut.SO;
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

}


/* Module 27 Level 1 Inputs 46 Outputs 53 Bidirs 0 ScanChains 0 :*/
Module M27 {
	Attribute lic = 'h af73571d;
	Parameter inputs = 46;
	Parameter outputs = 53;
	Parameter bidirs = 0;
	ScanInPort SI;
	ScanOutPort SO {
		Source sibOut.SO;
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
}


/* Module 28 Level 1 Inputs 5 Outputs 2 Bidirs 0 ScanChains 0 :*/
Module M28 {
	Attribute lic = 'h d86a169b;
	Parameter inputs = 5;
	Parameter outputs = 2;
	Parameter bidirs = 0;
	ScanInPort SI;
	ScanOutPort SO {
		Source sibOut.SO;
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

}


/* Module 29 Level 1 Inputs 150 Outputs 157 Bidirs 0 ScanChains 0 :*/
Module M29 {
	Attribute lic = 'h 3d96742b;
	Parameter inputs = 150;
	Parameter outputs = 157;
	Parameter bidirs = 0;
	ScanInPort SI;
	ScanOutPort SO {
		Source sibOut.SO;
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

}


/* Module 30 Level 1 Inputs 51 Outputs 57 Bidirs 0 ScanChains 1 : 302*/
Module M30 {
	Attribute lic = 'h 250cc109;
	Parameter inputs = 51;
	Parameter outputs = 57;
	Parameter bidirs = 0;
	ScanInPort SI;
	ScanOutPort SO {
		Source sibSC1.SO;
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
		Parameter Size = 302;
	}

}


/* Module 31 Level 1 Inputs 211 Outputs 316 Bidirs 0 ScanChains 28 : 1549 1550 1550 1550 1550 1550 1550 1550 1550 1550 1550 1550 1550 1550 1550 1550 1550 1550 1550 1550 1549 1550 1550 1550 1550 1549 1549 1549*/
Module M31 {
	Attribute lic = 'h 7511993f;
	Parameter inputs = 211;
	Parameter outputs = 316;
	Parameter bidirs = 0;
	ScanInPort SI;
	ScanOutPort SO {
		Source sibSC28.SO;
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
		Parameter Size = 1549;
	}

	/* Scan Register 2*/
	Instance sibSC2 Of SIB_mux_pre {
		InputPort SI = sibSC1.SO;
		InputPort fromSO = sc2.SO;
	}
	Instance sc2 Of SReg {
		InputPort SI = sibSC2.toSI;
		Parameter Size = 1550;
	}
	/* Scan Register 3*/
	Instance sibSC3 Of SIB_mux_pre {
		InputPort SI = sibSC2.SO;
		InputPort fromSO = sc3.SO;
	}
	Instance sc3 Of SReg {
		InputPort SI = sibSC3.toSI;
		Parameter Size = 1550;
	}
	/* Scan Register 4*/
	Instance sibSC4 Of SIB_mux_pre {
		InputPort SI = sibSC3.SO;
		InputPort fromSO = sc4.SO;
	}
	Instance sc4 Of SReg {
		InputPort SI = sibSC4.toSI;
		Parameter Size = 1550;
	}
	/* Scan Register 5*/
	Instance sibSC5 Of SIB_mux_pre {
		InputPort SI = sibSC4.SO;
		InputPort fromSO = sc5.SO;
	}
	Instance sc5 Of SReg {
		InputPort SI = sibSC5.toSI;
		Parameter Size = 1550;
	}
	/* Scan Register 6*/
	Instance sibSC6 Of SIB_mux_pre {
		InputPort SI = sibSC5.SO;
		InputPort fromSO = sc6.SO;
	}
	Instance sc6 Of SReg {
		InputPort SI = sibSC6.toSI;
		Parameter Size = 1550;
	}
	/* Scan Register 7*/
	Instance sibSC7 Of SIB_mux_pre {
		InputPort SI = sibSC6.SO;
		InputPort fromSO = sc7.SO;
	}
	Instance sc7 Of SReg {
		InputPort SI = sibSC7.toSI;
		Parameter Size = 1550;
	}
	/* Scan Register 8*/
	Instance sibSC8 Of SIB_mux_pre {
		InputPort SI = sibSC7.SO;
		InputPort fromSO = sc8.SO;
	}
	Instance sc8 Of SReg {
		InputPort SI = sibSC8.toSI;
		Parameter Size = 1550;
	}
	/* Scan Register 9*/
	Instance sibSC9 Of SIB_mux_pre {
		InputPort SI = sibSC8.SO;
		InputPort fromSO = sc9.SO;
	}
	Instance sc9 Of SReg {
		InputPort SI = sibSC9.toSI;
		Parameter Size = 1550;
	}
	/* Scan Register 10*/
	Instance sibSC10 Of SIB_mux_pre {
		InputPort SI = sibSC9.SO;
		InputPort fromSO = sc10.SO;
	}
	Instance sc10 Of SReg {
		InputPort SI = sibSC10.toSI;
		Parameter Size = 1550;
	}
	/* Scan Register 11*/
	Instance sibSC11 Of SIB_mux_pre {
		InputPort SI = sibSC10.SO;
		InputPort fromSO = sc11.SO;
	}
	Instance sc11 Of SReg {
		InputPort SI = sibSC11.toSI;
		Parameter Size = 1550;
	}
	/* Scan Register 12*/
	Instance sibSC12 Of SIB_mux_pre {
		InputPort SI = sibSC11.SO;
		InputPort fromSO = sc12.SO;
	}
	Instance sc12 Of SReg {
		InputPort SI = sibSC12.toSI;
		Parameter Size = 1550;
	}
	/* Scan Register 13*/
	Instance sibSC13 Of SIB_mux_pre {
		InputPort SI = sibSC12.SO;
		InputPort fromSO = sc13.SO;
	}
	Instance sc13 Of SReg {
		InputPort SI = sibSC13.toSI;
		Parameter Size = 1550;
	}
	/* Scan Register 14*/
	Instance sibSC14 Of SIB_mux_pre {
		InputPort SI = sibSC13.SO;
		InputPort fromSO = sc14.SO;
	}
	Instance sc14 Of SReg {
		InputPort SI = sibSC14.toSI;
		Parameter Size = 1550;
	}
	/* Scan Register 15*/
	Instance sibSC15 Of SIB_mux_pre {
		InputPort SI = sibSC14.SO;
		InputPort fromSO = sc15.SO;
	}
	Instance sc15 Of SReg {
		InputPort SI = sibSC15.toSI;
		Parameter Size = 1550;
	}
	/* Scan Register 16*/
	Instance sibSC16 Of SIB_mux_pre {
		InputPort SI = sibSC15.SO;
		InputPort fromSO = sc16.SO;
	}
	Instance sc16 Of SReg {
		InputPort SI = sibSC16.toSI;
		Parameter Size = 1550;
	}
	/* Scan Register 17*/
	Instance sibSC17 Of SIB_mux_pre {
		InputPort SI = sibSC16.SO;
		InputPort fromSO = sc17.SO;
	}
	Instance sc17 Of SReg {
		InputPort SI = sibSC17.toSI;
		Parameter Size = 1550;
	}
	/* Scan Register 18*/
	Instance sibSC18 Of SIB_mux_pre {
		InputPort SI = sibSC17.SO;
		InputPort fromSO = sc18.SO;
	}
	Instance sc18 Of SReg {
		InputPort SI = sibSC18.toSI;
		Parameter Size = 1550;
	}
	/* Scan Register 19*/
	Instance sibSC19 Of SIB_mux_pre {
		InputPort SI = sibSC18.SO;
		InputPort fromSO = sc19.SO;
	}
	Instance sc19 Of SReg {
		InputPort SI = sibSC19.toSI;
		Parameter Size = 1550;
	}
	/* Scan Register 20*/
	Instance sibSC20 Of SIB_mux_pre {
		InputPort SI = sibSC19.SO;
		InputPort fromSO = sc20.SO;
	}
	Instance sc20 Of SReg {
		InputPort SI = sibSC20.toSI;
		Parameter Size = 1550;
	}
	/* Scan Register 21*/
	Instance sibSC21 Of SIB_mux_pre {
		InputPort SI = sibSC20.SO;
		InputPort fromSO = sc21.SO;
	}
	Instance sc21 Of SReg {
		InputPort SI = sibSC21.toSI;
		Parameter Size = 1549;
	}
	/* Scan Register 22*/
	Instance sibSC22 Of SIB_mux_pre {
		InputPort SI = sibSC21.SO;
		InputPort fromSO = sc22.SO;
	}
	Instance sc22 Of SReg {
		InputPort SI = sibSC22.toSI;
		Parameter Size = 1550;
	}
	/* Scan Register 23*/
	Instance sibSC23 Of SIB_mux_pre {
		InputPort SI = sibSC22.SO;
		InputPort fromSO = sc23.SO;
	}
	Instance sc23 Of SReg {
		InputPort SI = sibSC23.toSI;
		Parameter Size = 1550;
	}
	/* Scan Register 24*/
	Instance sibSC24 Of SIB_mux_pre {
		InputPort SI = sibSC23.SO;
		InputPort fromSO = sc24.SO;
	}
	Instance sc24 Of SReg {
		InputPort SI = sibSC24.toSI;
		Parameter Size = 1550;
	}
	/* Scan Register 25*/
	Instance sibSC25 Of SIB_mux_pre {
		InputPort SI = sibSC24.SO;
		InputPort fromSO = sc25.SO;
	}
	Instance sc25 Of SReg {
		InputPort SI = sibSC25.toSI;
		Parameter Size = 1550;
	}
	/* Scan Register 26*/
	Instance sibSC26 Of SIB_mux_pre {
		InputPort SI = sibSC25.SO;
		InputPort fromSO = sc26.SO;
	}
	Instance sc26 Of SReg {
		InputPort SI = sibSC26.toSI;
		Parameter Size = 1549;
	}
	/* Scan Register 27*/
	Instance sibSC27 Of SIB_mux_pre {
		InputPort SI = sibSC26.SO;
		InputPort fromSO = sc27.SO;
	}
	Instance sc27 Of SReg {
		InputPort SI = sibSC27.toSI;
		Parameter Size = 1549;
	}
	/* Scan Register 28*/
	Instance sibSC28 Of SIB_mux_pre {
		InputPort SI = sibSC27.SO;
		InputPort fromSO = sc28.SO;
	}
	Instance sc28 Of SReg {
		InputPort SI = sibSC28.toSI;
		Parameter Size = 1549;
	}
}
