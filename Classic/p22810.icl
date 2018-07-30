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
* CLASSIC benchmark based on ITC'02 p22810 and Segment Insertion Bit (SIB) network 
* design strategy.
*
* Uses modules from files: 
* - Instruments.icl
* - EmptyModule.icl
*/

NameSpace p22810;

UseNameSpace root;
Module M0 {
 Attribute lic = 'h cc041fcb;
	Parameter inputs = 10;
	Parameter outputs = 67;
	Parameter bidirs = 96;

	ScanInPort SI;
	ScanOutPort SO {
		Source sibM28.SO;
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
	
	/* Module 1*/
	Instance sibM1 Of SIB_mux_pre {
		InputPort SI = sibOut.SO;
		InputPort fromSO = m1.SO;
	}
	Instance m1 Of p22810::M1 {
		InputPort SI = sibM1.toSI; 
	}
	/* Module 5*/
	Instance sibM5 Of SIB_mux_pre {
		InputPort SI = sibM1.SO;
		InputPort fromSO = m5.SO;
	}
	Instance m5 Of p22810::M5 {
		InputPort SI = sibM5.toSI;
	}
	/* Module 9*/
	Instance sibM9 Of SIB_mux_pre {
		InputPort SI = sibM5.SO;
		InputPort fromSO = m9.SO;
	}
	Instance m9 Of p22810::M9 {
		InputPort SI = sibM9.toSI;
	}
	/* Module 10*/
	Instance sibM10 Of SIB_mux_pre {
		InputPort SI = sibM9.SO;
		InputPort fromSO = m10.SO;
	}
	Instance m10 Of p22810::M10 {
		InputPort SI = sibM10.toSI;
	}
	/* Module 11*/
	Instance sibM11 Of SIB_mux_pre {
		InputPort SI = sibM10.SO;
		InputPort fromSO = m11.SO;
	}
	Instance m11 Of p22810::M11 {
		InputPort SI = sibM11.toSI;
	}
	/* Module 12*/
	Instance sibM12 Of SIB_mux_pre {
		InputPort SI = sibM11.SO;
		InputPort fromSO = m12.SO;
	}
	Instance m12 Of p22810::M12 {
		InputPort SI = sibM12.toSI;
	}
	/* Module 13*/
	Instance sibM13 Of SIB_mux_pre {
		InputPort SI = sibM12.SO;
		InputPort fromSO = m13.SO;
	}
	Instance m13 Of p22810::M13 {
		InputPort SI = sibM13.toSI;
	}
	/* Module 14*/
	Instance sibM14 Of SIB_mux_pre {
		InputPort SI = sibM13.SO;
		InputPort fromSO = m14.SO;
	}
	Instance m14 Of p22810::M14 {
		InputPort SI = sibM14.toSI;
	}
	/* Module 15*/
	Instance sibM15 Of SIB_mux_pre {
		InputPort SI = sibM14.SO;
		InputPort fromSO = m15.SO;
	}
	Instance m15 Of p22810::M15 {
		InputPort SI = sibM15.toSI;
	}
	/* Module 16*/
	Instance sibM16 Of SIB_mux_pre {
		InputPort SI = sibM15.SO;
		InputPort fromSO = m16.SO;
	}
	Instance m16 Of p22810::M16 {
		InputPort SI = sibM16.toSI;
	}
	/* Module 17*/
	Instance sibM17 Of SIB_mux_pre {
		InputPort SI = sibM16.SO;
		InputPort fromSO = m17.SO;
	}
	Instance m17 Of p22810::M17 {
		InputPort SI = sibM17.toSI;
	}
	/* Module 18*/
	Instance sibM18 Of SIB_mux_pre {
		InputPort SI = sibM17.SO;
		InputPort fromSO = m18.SO;
	}
	Instance m18 Of p22810::M18 {
		InputPort SI = sibM18.toSI;
	}
	/* Module 19*/
	Instance sibM19 Of SIB_mux_pre {
		InputPort SI = sibM18.SO;
		InputPort fromSO = m19.SO;
	}
	Instance m19 Of p22810::M19 {
		InputPort SI = sibM19.toSI;
	}
	/* Module 20*/
	Instance sibM20 Of SIB_mux_pre {
		InputPort SI = sibM19.SO;
		InputPort fromSO = m20.SO;
	}
	Instance m20 Of p22810::M20 {
		InputPort SI = sibM20.toSI;
	}
	/* Module 21*/
	Instance sibM21 Of SIB_mux_pre {
		InputPort SI = sibM20.SO;
		InputPort fromSO = m21.SO;
	}
	Instance m21 Of p22810::M21 {
		InputPort SI = sibM21.toSI;
	}
	/* Module 22*/
	Instance sibM22 Of SIB_mux_pre {
		InputPort SI = sibM21.SO;
		InputPort fromSO = m22.SO;
	}
	Instance m22 Of p22810::M22 {
		InputPort SI = sibM22.toSI;
	}
	/* Module 23*/
	Instance sibM23 Of SIB_mux_pre {
		InputPort SI = sibM22.SO;
		InputPort fromSO = m23.SO;
	}
	Instance m23 Of p22810::M23 {
		InputPort SI = sibM23.toSI;
	}
	/* Module 24*/
	Instance sibM24 Of SIB_mux_pre {
		InputPort SI = sibM23.SO;
		InputPort fromSO = m24.SO;
	}
	Instance m24 Of p22810::M24 {
		InputPort SI = sibM24.toSI;
	}
	/* Module 25*/
	Instance sibM25 Of SIB_mux_pre {
		InputPort SI = sibM24.SO;
		InputPort fromSO = m25.SO;
	}
	Instance m25 Of p22810::M25 {
		InputPort SI = sibM25.toSI;
	}
	/* Module 26*/
	Instance sibM26 Of SIB_mux_pre {
		InputPort SI = sibM25.SO;
		InputPort fromSO = m26.SO;
	}
	Instance m26 Of p22810::M26 {
		InputPort SI = sibM26.toSI;
	}
	/* Module 27*/
	Instance sibM27 Of SIB_mux_pre {
		InputPort SI = sibM26.SO;
		InputPort fromSO = m27.SO;
	}
	Instance m27 Of p22810::M27 {
		InputPort SI = sibM27.toSI;
	}
	/* Module 28*/
	Instance sibM28 Of SIB_mux_pre {
		InputPort SI = sibM27.SO;
		InputPort fromSO = m28.SO;
	}
	Instance m28 Of p22810::M28 {
		InputPort SI = sibM28.toSI;
	}
}

Module M1 {
 Attribute lic = 'h 8ed4b678;
	Parameter inputs = 28;
	Parameter outputs = 56;
	Parameter bidirs = 32;

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
	/*Scan Register 1*/
	Instance sibSC1 Of SIB_mux_pre {
		InputPort SI = sibOut.SO;
		InputPort fromSO = sc1.SO;
	}
	Instance sc1 Of SReg {
		InputPort SI = sibSC1.toSI;
		Parameter Size = 130;
	}
	/* Scan Register 2*/
	Instance sibSC2 Of SIB_mux_pre {
		InputPort SI = sibSC1.SO;
		InputPort fromSO = sc2.SO;
	}
	Instance sc2 Of SReg {
		InputPort SI = sibSC2.toSI;
		Parameter Size = 111;
	}
	/* Scan Register 3*/
	Instance sibSC3 Of SIB_mux_pre {
		InputPort SI = sibSC2.SO;
		InputPort fromSO = sc3.SO;
	}
	Instance sc3 Of SReg {
		InputPort SI = sibSC3.toSI;
		Parameter Size = 111;
	}
	/* Scan Register 4*/
	Instance sibSC4 Of SIB_mux_pre {
		InputPort SI = sibSC3.SO;
		InputPort fromSO = sc4.SO;
	}
	Instance sc4 Of SReg {
		InputPort SI = sibSC4.toSI;
		Parameter Size = 110;
	}
	/* Scan Register 5*/
	Instance sibSC5 Of SIB_mux_pre {
		InputPort SI = sibSC4.SO;
		InputPort fromSO = sc5.SO;
	}
	Instance sc5 Of SReg {
		InputPort SI = sibSC5.toSI;
		Parameter Size = 110;
	}
	/* Scan Register 6*/
	Instance sibSC6 Of SIB_mux_pre {
		InputPort SI = sibSC5.SO;
		InputPort fromSO = sc6.SO;
	}
	Instance sc6 Of SReg {
		InputPort SI = sibSC6.toSI;
		Parameter Size = 110;
	}
	/* Scan Register 7*/
	Instance sibSC7 Of SIB_mux_pre {
		InputPort SI = sibSC6.SO;
		InputPort fromSO = sc7.SO;
	}
	Instance sc7 Of SReg {
		InputPort SI = sibSC7.toSI;
		Parameter Size = 110;
	}
	/* Scan Register 8*/
	Instance sibSC8 Of SIB_mux_pre {
		InputPort SI = sibSC7.SO;
		InputPort fromSO = sc8.SO;
	}
	Instance sc8 Of SReg {
		InputPort SI = sibSC8.toSI;
		Parameter Size = 110;
	}
	/* Scan Register 9*/
	Instance sibSC9 Of SIB_mux_pre {
		InputPort SI = sibSC8.SO;
		InputPort fromSO = sc9.SO;
	}
	Instance sc9 Of SReg {
		InputPort SI = sibSC9.toSI;
		Parameter Size = 110;
	}
	/* Scan Register 10*/
	Instance sibSC10 Of SIB_mux_pre {
		InputPort SI = sibSC9.SO;
		InputPort fromSO = sc10.SO;
	}
	Instance sc10 Of SReg {
		InputPort SI = sibSC10.toSI;
		Parameter Size = 110;
	}

	/*Empty Module M2*/
	Instance sibM2 Of SIB_mux_pre {
        InputPort SI = sibSC10.SO;
        InputPort fromSO = m2.SO;
    }
    Instance m2 Of EmptyModule_NoBidirs  {
        InputPort SI = sibM2.toSI; 
        Parameter inputs = 47;
        Parameter outputs = 33;
    }
	
	/*Empty Module M3*/
	Instance sibM3 Of SIB_mux_pre {
        InputPort SI = sibM2.SO;
        InputPort fromSO = m3.SO;
    }
    Instance m3 Of EmptyModule_NoBidirs  {
        InputPort SI = sibM3.toSI; 
        Parameter inputs = 38;
        Parameter outputs = 26;
    }
	
	/*Empty Module M4*/
	Instance sibM4 Of SIB_mux_pre {
        InputPort SI = sibM3.SO;
        InputPort fromSO = m4.SO;
    }
    Instance m4 Of EmptyModule_NoBidirs  {
        InputPort SI = sibM4.toSI; 
        Parameter inputs = 48;
        Parameter outputs = 64;
    }
}


/* Module 5 Level 1 Inputs 90 Outputs 112 Bidirs 32 ScanChains 29 : 214 106 106 105 105 103 102 101 101 101 100 93 92 84 84 75 75 73 73 73 73 27 27 27 27 27 27 27 27*/
Module M5 {
	Attribute lic = 'h c30add8a;
	Parameter inputs = 90;
	Parameter outputs = 112;
	Parameter bidirs = 32;
	ScanInPort SI;
	ScanOutPort SO {
		Source sibM8.SO;
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
		Parameter Size = 214;
	}

	/* Scan Register 2*/
	Instance sibSC2 Of SIB_mux_pre {
		InputPort SI = sibSC1.SO;
		InputPort fromSO = sc2.SO;
	}
	Instance sc2 Of SReg {
		InputPort SI = sibSC2.toSI;
		Parameter Size = 106;
	}
	/* Scan Register 3*/
	Instance sibSC3 Of SIB_mux_pre {
		InputPort SI = sibSC2.SO;
		InputPort fromSO = sc3.SO;
	}
	Instance sc3 Of SReg {
		InputPort SI = sibSC3.toSI;
		Parameter Size = 106;
	}
	/* Scan Register 4*/
	Instance sibSC4 Of SIB_mux_pre {
		InputPort SI = sibSC3.SO;
		InputPort fromSO = sc4.SO;
	}
	Instance sc4 Of SReg {
		InputPort SI = sibSC4.toSI;
		Parameter Size = 105;
	}
	/* Scan Register 5*/
	Instance sibSC5 Of SIB_mux_pre {
		InputPort SI = sibSC4.SO;
		InputPort fromSO = sc5.SO;
	}
	Instance sc5 Of SReg {
		InputPort SI = sibSC5.toSI;
		Parameter Size = 105;
	}
	/* Scan Register 6*/
	Instance sibSC6 Of SIB_mux_pre {
		InputPort SI = sibSC5.SO;
		InputPort fromSO = sc6.SO;
	}
	Instance sc6 Of SReg {
		InputPort SI = sibSC6.toSI;
		Parameter Size = 103;
	}
	/* Scan Register 7*/
	Instance sibSC7 Of SIB_mux_pre {
		InputPort SI = sibSC6.SO;
		InputPort fromSO = sc7.SO;
	}
	Instance sc7 Of SReg {
		InputPort SI = sibSC7.toSI;
		Parameter Size = 102;
	}
	/* Scan Register 8*/
	Instance sibSC8 Of SIB_mux_pre {
		InputPort SI = sibSC7.SO;
		InputPort fromSO = sc8.SO;
	}
	Instance sc8 Of SReg {
		InputPort SI = sibSC8.toSI;
		Parameter Size = 101;
	}
	/* Scan Register 9*/
	Instance sibSC9 Of SIB_mux_pre {
		InputPort SI = sibSC8.SO;
		InputPort fromSO = sc9.SO;
	}
	Instance sc9 Of SReg {
		InputPort SI = sibSC9.toSI;
		Parameter Size = 101;
	}
	/* Scan Register 10*/
	Instance sibSC10 Of SIB_mux_pre {
		InputPort SI = sibSC9.SO;
		InputPort fromSO = sc10.SO;
	}
	Instance sc10 Of SReg {
		InputPort SI = sibSC10.toSI;
		Parameter Size = 101;
	}
	/* Scan Register 11*/
	Instance sibSC11 Of SIB_mux_pre {
		InputPort SI = sibSC10.SO;
		InputPort fromSO = sc11.SO;
	}
	Instance sc11 Of SReg {
		InputPort SI = sibSC11.toSI;
		Parameter Size = 100;
	}
	/* Scan Register 12*/
	Instance sibSC12 Of SIB_mux_pre {
		InputPort SI = sibSC11.SO;
		InputPort fromSO = sc12.SO;
	}
	Instance sc12 Of SReg {
		InputPort SI = sibSC12.toSI;
		Parameter Size = 93;
	}
	/* Scan Register 13*/
	Instance sibSC13 Of SIB_mux_pre {
		InputPort SI = sibSC12.SO;
		InputPort fromSO = sc13.SO;
	}
	Instance sc13 Of SReg {
		InputPort SI = sibSC13.toSI;
		Parameter Size = 92;
	}
	/* Scan Register 14*/
	Instance sibSC14 Of SIB_mux_pre {
		InputPort SI = sibSC13.SO;
		InputPort fromSO = sc14.SO;
	}
	Instance sc14 Of SReg {
		InputPort SI = sibSC14.toSI;
		Parameter Size = 84;
	}
	/* Scan Register 15*/
	Instance sibSC15 Of SIB_mux_pre {
		InputPort SI = sibSC14.SO;
		InputPort fromSO = sc15.SO;
	}
	Instance sc15 Of SReg {
		InputPort SI = sibSC15.toSI;
		Parameter Size = 84;
	}
	/* Scan Register 16*/
	Instance sibSC16 Of SIB_mux_pre {
		InputPort SI = sibSC15.SO;
		InputPort fromSO = sc16.SO;
	}
	Instance sc16 Of SReg {
		InputPort SI = sibSC16.toSI;
		Parameter Size = 75;
	}
	/* Scan Register 17*/
	Instance sibSC17 Of SIB_mux_pre {
		InputPort SI = sibSC16.SO;
		InputPort fromSO = sc17.SO;
	}
	Instance sc17 Of SReg {
		InputPort SI = sibSC17.toSI;
		Parameter Size = 75;
	}
	/* Scan Register 18*/
	Instance sibSC18 Of SIB_mux_pre {
		InputPort SI = sibSC17.SO;
		InputPort fromSO = sc18.SO;
	}
	Instance sc18 Of SReg {
		InputPort SI = sibSC18.toSI;
		Parameter Size = 73;
	}
	/* Scan Register 19*/
	Instance sibSC19 Of SIB_mux_pre {
		InputPort SI = sibSC18.SO;
		InputPort fromSO = sc19.SO;
	}
	Instance sc19 Of SReg {
		InputPort SI = sibSC19.toSI;
		Parameter Size = 73;
	}
	/* Scan Register 20*/
	Instance sibSC20 Of SIB_mux_pre {
		InputPort SI = sibSC19.SO;
		InputPort fromSO = sc20.SO;
	}
	Instance sc20 Of SReg {
		InputPort SI = sibSC20.toSI;
		Parameter Size = 73;
	}
	/* Scan Register 21*/
	Instance sibSC21 Of SIB_mux_pre {
		InputPort SI = sibSC20.SO;
		InputPort fromSO = sc21.SO;
	}
	Instance sc21 Of SReg {
		InputPort SI = sibSC21.toSI;
		Parameter Size = 73;
	}
	/* Scan Register 22*/
	Instance sibSC22 Of SIB_mux_pre {
		InputPort SI = sibSC21.SO;
		InputPort fromSO = sc22.SO;
	}
	Instance sc22 Of SReg {
		InputPort SI = sibSC22.toSI;
		Parameter Size = 27;
	}
	/* Scan Register 23*/
	Instance sibSC23 Of SIB_mux_pre {
		InputPort SI = sibSC22.SO;
		InputPort fromSO = sc23.SO;
	}
	Instance sc23 Of SReg {
		InputPort SI = sibSC23.toSI;
		Parameter Size = 27;
	}
	/* Scan Register 24*/
	Instance sibSC24 Of SIB_mux_pre {
		InputPort SI = sibSC23.SO;
		InputPort fromSO = sc24.SO;
	}
	Instance sc24 Of SReg {
		InputPort SI = sibSC24.toSI;
		Parameter Size = 27;
	}
	/* Scan Register 25*/
	Instance sibSC25 Of SIB_mux_pre {
		InputPort SI = sibSC24.SO;
		InputPort fromSO = sc25.SO;
	}
	Instance sc25 Of SReg {
		InputPort SI = sibSC25.toSI;
		Parameter Size = 27;
	}
	/* Scan Register 26*/
	Instance sibSC26 Of SIB_mux_pre {
		InputPort SI = sibSC25.SO;
		InputPort fromSO = sc26.SO;
	}
	Instance sc26 Of SReg {
		InputPort SI = sibSC26.toSI;
		Parameter Size = 27;
	}
	/* Scan Register 27*/
	Instance sibSC27 Of SIB_mux_pre {
		InputPort SI = sibSC26.SO;
		InputPort fromSO = sc27.SO;
	}
	Instance sc27 Of SReg {
		InputPort SI = sibSC27.toSI;
		Parameter Size = 27;
	}
	/* Scan Register 28*/
	Instance sibSC28 Of SIB_mux_pre {
		InputPort SI = sibSC27.SO;
		InputPort fromSO = sc28.SO;
	}
	Instance sc28 Of SReg {
		InputPort SI = sibSC28.toSI;
		Parameter Size = 27;
	}
	/* Scan Register 29*/
	Instance sibSC29 Of SIB_mux_pre {
		InputPort SI = sibSC28.SO;
		InputPort fromSO = sc29.SO;
	}
	Instance sc29 Of SReg {
		InputPort SI = sibSC29.toSI;
		Parameter Size = 27;
	}
	
	/*Empty Module M6*/
	Instance sibM6 Of SIB_mux_pre {
        InputPort SI = sibSC29.SO;
        InputPort fromSO = m6.SO;
    }
    Instance m6 Of EmptyModule_NoBidirs  {
        InputPort SI = sibM6.toSI; 
        Parameter inputs = 80;
        Parameter outputs = 64;
    }
	
	/*Empty Module M7*/
	Instance sibM7 Of SIB_mux_pre {
        InputPort SI = sibM6.SO;
        InputPort fromSO = m7.SO;
    }
    Instance m7 Of EmptyModule_NoBidirs  {
        InputPort SI = sibM7.toSI; 
        Parameter inputs = 84;
        Parameter outputs = 64;
    }
	
	/*Empty Module M8*/
	Instance sibM8 Of SIB_mux_pre {
        InputPort SI = sibM7.SO;
        InputPort fromSO = m8.SO;
    }
    Instance m8 Of EmptyModule_NoBidirs  {
        InputPort SI = sibM8.toSI; 
        Parameter inputs = 36;
        Parameter outputs = 16;
    }
}


/* Module 9 Level 1 Inputs 116 Outputs 123 Bidirs 32 ScanChains 24 : 122 105 100 100 100 100 100 100 100 100 100 99 96 96 95 95 95 95 95 95 95 95 32 24*/
Module M9 {
	Attribute lic = 'h b8dddcff;
	Parameter inputs = 116;
	Parameter outputs = 123;
	Parameter bidirs = 32;
	ScanInPort SI;
	ScanOutPort SO {
		Source sibSC24.SO;
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
		Parameter Size = 122;
	}

	/* Scan Register 2*/
	Instance sibSC2 Of SIB_mux_pre {
		InputPort SI = sibSC1.SO;
		InputPort fromSO = sc2.SO;
	}
	Instance sc2 Of SReg {
		InputPort SI = sibSC2.toSI;
		Parameter Size = 105;
	}
	/* Scan Register 3*/
	Instance sibSC3 Of SIB_mux_pre {
		InputPort SI = sibSC2.SO;
		InputPort fromSO = sc3.SO;
	}
	Instance sc3 Of SReg {
		InputPort SI = sibSC3.toSI;
		Parameter Size = 100;
	}
	/* Scan Register 4*/
	Instance sibSC4 Of SIB_mux_pre {
		InputPort SI = sibSC3.SO;
		InputPort fromSO = sc4.SO;
	}
	Instance sc4 Of SReg {
		InputPort SI = sibSC4.toSI;
		Parameter Size = 100;
	}
	/* Scan Register 5*/
	Instance sibSC5 Of SIB_mux_pre {
		InputPort SI = sibSC4.SO;
		InputPort fromSO = sc5.SO;
	}
	Instance sc5 Of SReg {
		InputPort SI = sibSC5.toSI;
		Parameter Size = 100;
	}
	/* Scan Register 6*/
	Instance sibSC6 Of SIB_mux_pre {
		InputPort SI = sibSC5.SO;
		InputPort fromSO = sc6.SO;
	}
	Instance sc6 Of SReg {
		InputPort SI = sibSC6.toSI;
		Parameter Size = 100;
	}
	/* Scan Register 7*/
	Instance sibSC7 Of SIB_mux_pre {
		InputPort SI = sibSC6.SO;
		InputPort fromSO = sc7.SO;
	}
	Instance sc7 Of SReg {
		InputPort SI = sibSC7.toSI;
		Parameter Size = 100;
	}
	/* Scan Register 8*/
	Instance sibSC8 Of SIB_mux_pre {
		InputPort SI = sibSC7.SO;
		InputPort fromSO = sc8.SO;
	}
	Instance sc8 Of SReg {
		InputPort SI = sibSC8.toSI;
		Parameter Size = 100;
	}
	/* Scan Register 9*/
	Instance sibSC9 Of SIB_mux_pre {
		InputPort SI = sibSC8.SO;
		InputPort fromSO = sc9.SO;
	}
	Instance sc9 Of SReg {
		InputPort SI = sibSC9.toSI;
		Parameter Size = 100;
	}
	/* Scan Register 10*/
	Instance sibSC10 Of SIB_mux_pre {
		InputPort SI = sibSC9.SO;
		InputPort fromSO = sc10.SO;
	}
	Instance sc10 Of SReg {
		InputPort SI = sibSC10.toSI;
		Parameter Size = 100;
	}
	/* Scan Register 11*/
	Instance sibSC11 Of SIB_mux_pre {
		InputPort SI = sibSC10.SO;
		InputPort fromSO = sc11.SO;
	}
	Instance sc11 Of SReg {
		InputPort SI = sibSC11.toSI;
		Parameter Size = 100;
	}
	/* Scan Register 12*/
	Instance sibSC12 Of SIB_mux_pre {
		InputPort SI = sibSC11.SO;
		InputPort fromSO = sc12.SO;
	}
	Instance sc12 Of SReg {
		InputPort SI = sibSC12.toSI;
		Parameter Size = 99;
	}
	/* Scan Register 13*/
	Instance sibSC13 Of SIB_mux_pre {
		InputPort SI = sibSC12.SO;
		InputPort fromSO = sc13.SO;
	}
	Instance sc13 Of SReg {
		InputPort SI = sibSC13.toSI;
		Parameter Size = 96;
	}
	/* Scan Register 14*/
	Instance sibSC14 Of SIB_mux_pre {
		InputPort SI = sibSC13.SO;
		InputPort fromSO = sc14.SO;
	}
	Instance sc14 Of SReg {
		InputPort SI = sibSC14.toSI;
		Parameter Size = 96;
	}
	/* Scan Register 15*/
	Instance sibSC15 Of SIB_mux_pre {
		InputPort SI = sibSC14.SO;
		InputPort fromSO = sc15.SO;
	}
	Instance sc15 Of SReg {
		InputPort SI = sibSC15.toSI;
		Parameter Size = 95;
	}
	/* Scan Register 16*/
	Instance sibSC16 Of SIB_mux_pre {
		InputPort SI = sibSC15.SO;
		InputPort fromSO = sc16.SO;
	}
	Instance sc16 Of SReg {
		InputPort SI = sibSC16.toSI;
		Parameter Size = 95;
	}
	/* Scan Register 17*/
	Instance sibSC17 Of SIB_mux_pre {
		InputPort SI = sibSC16.SO;
		InputPort fromSO = sc17.SO;
	}
	Instance sc17 Of SReg {
		InputPort SI = sibSC17.toSI;
		Parameter Size = 95;
	}
	/* Scan Register 18*/
	Instance sibSC18 Of SIB_mux_pre {
		InputPort SI = sibSC17.SO;
		InputPort fromSO = sc18.SO;
	}
	Instance sc18 Of SReg {
		InputPort SI = sibSC18.toSI;
		Parameter Size = 95;
	}
	/* Scan Register 19*/
	Instance sibSC19 Of SIB_mux_pre {
		InputPort SI = sibSC18.SO;
		InputPort fromSO = sc19.SO;
	}
	Instance sc19 Of SReg {
		InputPort SI = sibSC19.toSI;
		Parameter Size = 95;
	}
	/* Scan Register 20*/
	Instance sibSC20 Of SIB_mux_pre {
		InputPort SI = sibSC19.SO;
		InputPort fromSO = sc20.SO;
	}
	Instance sc20 Of SReg {
		InputPort SI = sibSC20.toSI;
		Parameter Size = 95;
	}
	/* Scan Register 21*/
	Instance sibSC21 Of SIB_mux_pre {
		InputPort SI = sibSC20.SO;
		InputPort fromSO = sc21.SO;
	}
	Instance sc21 Of SReg {
		InputPort SI = sibSC21.toSI;
		Parameter Size = 95;
	}
	/* Scan Register 22*/
	Instance sibSC22 Of SIB_mux_pre {
		InputPort SI = sibSC21.SO;
		InputPort fromSO = sc22.SO;
	}
	Instance sc22 Of SReg {
		InputPort SI = sibSC22.toSI;
		Parameter Size = 95;
	}
	/* Scan Register 23*/
	Instance sibSC23 Of SIB_mux_pre {
		InputPort SI = sibSC22.SO;
		InputPort fromSO = sc23.SO;
	}
	Instance sc23 Of SReg {
		InputPort SI = sibSC23.toSI;
		Parameter Size = 32;
	}
	/* Scan Register 24*/
	Instance sibSC24 Of SIB_mux_pre {
		InputPort SI = sibSC23.SO;
		InputPort fromSO = sc24.SO;
	}
	Instance sc24 Of SReg {
		InputPort SI = sibSC24.toSI;
		Parameter Size = 24;
	}
}


/* Module 10 Level 1 Inputs 50 Outputs 30 Bidirs 0 ScanChains 4 : 99 98 10 2*/
Module M10 {
	Attribute lic = 'h bbf34908;
	Parameter inputs = 50;
	Parameter outputs = 30;
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
		Parameter Size = 99;
	}

	/* Scan Register 2*/
	Instance sibSC2 Of SIB_mux_pre {
		InputPort SI = sibSC1.SO;
		InputPort fromSO = sc2.SO;
	}
	Instance sc2 Of SReg {
		InputPort SI = sibSC2.toSI;
		Parameter Size = 98;
	}
	/* Scan Register 3*/
	Instance sibSC3 Of SIB_mux_pre {
		InputPort SI = sibSC2.SO;
		InputPort fromSO = sc3.SO;
	}
	Instance sc3 Of SReg {
		InputPort SI = sibSC3.toSI;
		Parameter Size = 10;
	}
	/* Scan Register 4*/
	Instance sibSC4 Of SIB_mux_pre {
		InputPort SI = sibSC3.SO;
		InputPort fromSO = sc4.SO;
	}
	Instance sc4 Of SReg {
		InputPort SI = sibSC4.toSI;
		Parameter Size = 2;
	}
}


/* Module 11 Level 1 Inputs 56 Outputs 23 Bidirs 71 ScanChains 8 : 88 87 86 84 69 69 68 38*/
Module M11 {
	Attribute lic = 'h a295d122;
	Parameter inputs = 56;
	Parameter outputs = 23;
	Parameter bidirs = 71;
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
		Parameter Size = 88;
	}

	/* Scan Register 2*/
	Instance sibSC2 Of SIB_mux_pre {
		InputPort SI = sibSC1.SO;
		InputPort fromSO = sc2.SO;
	}
	Instance sc2 Of SReg {
		InputPort SI = sibSC2.toSI;
		Parameter Size = 87;
	}
	/* Scan Register 3*/
	Instance sibSC3 Of SIB_mux_pre {
		InputPort SI = sibSC2.SO;
		InputPort fromSO = sc3.SO;
	}
	Instance sc3 Of SReg {
		InputPort SI = sibSC3.toSI;
		Parameter Size = 86;
	}
	/* Scan Register 4*/
	Instance sibSC4 Of SIB_mux_pre {
		InputPort SI = sibSC3.SO;
		InputPort fromSO = sc4.SO;
	}
	Instance sc4 Of SReg {
		InputPort SI = sibSC4.toSI;
		Parameter Size = 84;
	}
	/* Scan Register 5*/
	Instance sibSC5 Of SIB_mux_pre {
		InputPort SI = sibSC4.SO;
		InputPort fromSO = sc5.SO;
	}
	Instance sc5 Of SReg {
		InputPort SI = sibSC5.toSI;
		Parameter Size = 69;
	}
	/* Scan Register 6*/
	Instance sibSC6 Of SIB_mux_pre {
		InputPort SI = sibSC5.SO;
		InputPort fromSO = sc6.SO;
	}
	Instance sc6 Of SReg {
		InputPort SI = sibSC6.toSI;
		Parameter Size = 69;
	}
	/* Scan Register 7*/
	Instance sibSC7 Of SIB_mux_pre {
		InputPort SI = sibSC6.SO;
		InputPort fromSO = sc7.SO;
	}
	Instance sc7 Of SReg {
		InputPort SI = sibSC7.toSI;
		Parameter Size = 68;
	}
	/* Scan Register 8*/
	Instance sibSC8 Of SIB_mux_pre {
		InputPort SI = sibSC7.SO;
		InputPort fromSO = sc8.SO;
	}
	Instance sc8 Of SReg {
		InputPort SI = sibSC8.toSI;
		Parameter Size = 38;
	}
}


/* Module 12 Level 1 Inputs 40 Outputs 23 Bidirs 71 ScanChains 11 : 82 82 64 64 64 64 64 63 63 62 42*/
Module M12 {
	Attribute lic = 'h e999e0d1;
	Parameter inputs = 40;
	Parameter outputs = 23;
	Parameter bidirs = 71;
	ScanInPort SI;
	ScanOutPort SO {
		Source sibSC11.SO;
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
		Parameter Size = 82;
	}

	/* Scan Register 2*/
	Instance sibSC2 Of SIB_mux_pre {
		InputPort SI = sibSC1.SO;
		InputPort fromSO = sc2.SO;
	}
	Instance sc2 Of SReg {
		InputPort SI = sibSC2.toSI;
		Parameter Size = 82;
	}
	/* Scan Register 3*/
	Instance sibSC3 Of SIB_mux_pre {
		InputPort SI = sibSC2.SO;
		InputPort fromSO = sc3.SO;
	}
	Instance sc3 Of SReg {
		InputPort SI = sibSC3.toSI;
		Parameter Size = 64;
	}
	/* Scan Register 4*/
	Instance sibSC4 Of SIB_mux_pre {
		InputPort SI = sibSC3.SO;
		InputPort fromSO = sc4.SO;
	}
	Instance sc4 Of SReg {
		InputPort SI = sibSC4.toSI;
		Parameter Size = 64;
	}
	/* Scan Register 5*/
	Instance sibSC5 Of SIB_mux_pre {
		InputPort SI = sibSC4.SO;
		InputPort fromSO = sc5.SO;
	}
	Instance sc5 Of SReg {
		InputPort SI = sibSC5.toSI;
		Parameter Size = 64;
	}
	/* Scan Register 6*/
	Instance sibSC6 Of SIB_mux_pre {
		InputPort SI = sibSC5.SO;
		InputPort fromSO = sc6.SO;
	}
	Instance sc6 Of SReg {
		InputPort SI = sibSC6.toSI;
		Parameter Size = 64;
	}
	/* Scan Register 7*/
	Instance sibSC7 Of SIB_mux_pre {
		InputPort SI = sibSC6.SO;
		InputPort fromSO = sc7.SO;
	}
	Instance sc7 Of SReg {
		InputPort SI = sibSC7.toSI;
		Parameter Size = 64;
	}
	/* Scan Register 8*/
	Instance sibSC8 Of SIB_mux_pre {
		InputPort SI = sibSC7.SO;
		InputPort fromSO = sc8.SO;
	}
	Instance sc8 Of SReg {
		InputPort SI = sibSC8.toSI;
		Parameter Size = 63;
	}
	/* Scan Register 9*/
	Instance sibSC9 Of SIB_mux_pre {
		InputPort SI = sibSC8.SO;
		InputPort fromSO = sc9.SO;
	}
	Instance sc9 Of SReg {
		InputPort SI = sibSC9.toSI;
		Parameter Size = 63;
	}
	/* Scan Register 10*/
	Instance sibSC10 Of SIB_mux_pre {
		InputPort SI = sibSC9.SO;
		InputPort fromSO = sc10.SO;
	}
	Instance sc10 Of SReg {
		InputPort SI = sibSC10.toSI;
		Parameter Size = 62;
	}
	/* Scan Register 11*/
	Instance sibSC11 Of SIB_mux_pre {
		InputPort SI = sibSC10.SO;
		InputPort fromSO = sc11.SO;
	}
	Instance sc11 Of SReg {
		InputPort SI = sibSC11.toSI;
		Parameter Size = 42;
	}
}


/* Module 13 Level 1 Inputs 68 Outputs 149 Bidirs 0 ScanChains 4 : 104 96 48 32*/
Module M13 {
	Attribute lic = 'h f46f2f85;
	Parameter inputs = 68;
	Parameter outputs = 149;
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
		Parameter Size = 104;
	}

	/* Scan Register 2*/
	Instance sibSC2 Of SIB_mux_pre {
		InputPort SI = sibSC1.SO;
		InputPort fromSO = sc2.SO;
	}
	Instance sc2 Of SReg {
		InputPort SI = sibSC2.toSI;
		Parameter Size = 96;
	}
	/* Scan Register 3*/
	Instance sibSC3 Of SIB_mux_pre {
		InputPort SI = sibSC2.SO;
		InputPort fromSO = sc3.SO;
	}
	Instance sc3 Of SReg {
		InputPort SI = sibSC3.toSI;
		Parameter Size = 48;
	}
	/* Scan Register 4*/
	Instance sibSC4 Of SIB_mux_pre {
		InputPort SI = sibSC3.SO;
		InputPort fromSO = sc4.SO;
	}
	Instance sc4 Of SReg {
		InputPort SI = sibSC4.toSI;
		Parameter Size = 32;
	}
}


/* Module 14 Level 1 Inputs 22 Outputs 15 Bidirs 0 ScanChains 3 : 73 4 1*/
Module M14 {
	Attribute lic = 'h d175abb6;
	Parameter inputs = 22;
	Parameter outputs = 15;
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
		Parameter Size = 73;
	}

	/* Scan Register 2*/
	Instance sibSC2 Of SIB_mux_pre {
		InputPort SI = sibSC1.SO;
		InputPort fromSO = sc2.SO;
	}
	Instance sc2 Of SReg {
		InputPort SI = sibSC2.toSI;
		Parameter Size = 4;
	}
	/* Scan Register 3*/
	Instance sibSC3 Of SIB_mux_pre {
		InputPort SI = sibSC2.SO;
		InputPort fromSO = sc3.SO;
	}
	Instance sc3 Of SReg {
		InputPort SI = sibSC3.toSI;
		Parameter Size = 1;
	}
}


/* Module 15 Level 1 Inputs 84 Outputs 42 Bidirs 32 ScanChains 6 : 80 80 80 73 73 36*/
Module M15 {
	Attribute lic = 'h c5f288fb;
	Parameter inputs = 84;
	Parameter outputs = 42;
	Parameter bidirs = 32;
	ScanInPort SI;
	ScanOutPort SO {
		Source sibSC6.SO;
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
		Parameter Size = 80;
	}

	/* Scan Register 2*/
	Instance sibSC2 Of SIB_mux_pre {
		InputPort SI = sibSC1.SO;
		InputPort fromSO = sc2.SO;
	}
	Instance sc2 Of SReg {
		InputPort SI = sibSC2.toSI;
		Parameter Size = 80;
	}
	/* Scan Register 3*/
	Instance sibSC3 Of SIB_mux_pre {
		InputPort SI = sibSC2.SO;
		InputPort fromSO = sc3.SO;
	}
	Instance sc3 Of SReg {
		InputPort SI = sibSC3.toSI;
		Parameter Size = 80;
	}
	/* Scan Register 4*/
	Instance sibSC4 Of SIB_mux_pre {
		InputPort SI = sibSC3.SO;
		InputPort fromSO = sc4.SO;
	}
	Instance sc4 Of SReg {
		InputPort SI = sibSC4.toSI;
		Parameter Size = 73;
	}
	/* Scan Register 5*/
	Instance sibSC5 Of SIB_mux_pre {
		InputPort SI = sibSC4.SO;
		InputPort fromSO = sc5.SO;
	}
	Instance sc5 Of SReg {
		InputPort SI = sibSC5.toSI;
		Parameter Size = 73;
	}
	/* Scan Register 6*/
	Instance sibSC6 Of SIB_mux_pre {
		InputPort SI = sibSC5.SO;
		InputPort fromSO = sc6.SO;
	}
	Instance sc6 Of SReg {
		InputPort SI = sibSC6.toSI;
		Parameter Size = 36;
	}
}


/* Module M16 Level 1 Inputs 13 Outputs 43 Bidirs 72 ScanChains 1 : 109*/
Module M16 {
	Attribute lic = 'h 870cbc6;
	Parameter inputs = 13;
	Parameter outputs = 43;
	Parameter bidirs = 72;
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
		Parameter Size = 109;
	}

}


/* Module M17 Level 1 Inputs 223 Outputs 69 Bidirs 32 ScanChains 4 : 89 19 6 4*/
Module M17 {
	Attribute lic = 'h 4d164d13;
	Parameter inputs = 223;
	Parameter outputs = 69;
	Parameter bidirs = 32;
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
		Parameter Size = 89;
	}

	/* Scan Register 2*/
	Instance sibSC2 Of SIB_mux_pre {
		InputPort SI = sibSC1.SO;
		InputPort fromSO = sc2.SO;
	}
	Instance sc2 Of SReg {
		InputPort SI = sibSC2.toSI;
		Parameter Size = 19;
	}
	/* Scan Register 3*/
	Instance sibSC3 Of SIB_mux_pre {
		InputPort SI = sibSC2.SO;
		InputPort fromSO = sc3.SO;
	}
	Instance sc3 Of SReg {
		InputPort SI = sibSC3.toSI;
		Parameter Size = 6;
	}
	/* Scan Register 4*/
	Instance sibSC4 Of SIB_mux_pre {
		InputPort SI = sibSC3.SO;
		InputPort fromSO = sc4.SO;
	}
	Instance sc4 Of SReg {
		InputPort SI = sibSC4.toSI;
		Parameter Size = 4;
	}
}


/* Module M18 Level 1 Inputs 53 Outputs 11 Bidirs 32 ScanChains 5 : 68 68 67 56 56*/
Module M18 {
	Attribute lic = 'h 491f69e2;
	Parameter inputs = 53;
	Parameter outputs = 11;
	Parameter bidirs = 32;
	ScanInPort SI;
	ScanOutPort SO {
		Source sibSC5.SO;
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

	/* Scan Register 2*/
	Instance sibSC2 Of SIB_mux_pre {
		InputPort SI = sibSC1.SO;
		InputPort fromSO = sc2.SO;
	}
	Instance sc2 Of SReg {
		InputPort SI = sibSC2.toSI;
		Parameter Size = 68;
	}
	/* Scan Register 3*/
	Instance sibSC3 Of SIB_mux_pre {
		InputPort SI = sibSC2.SO;
		InputPort fromSO = sc3.SO;
	}
	Instance sc3 Of SReg {
		InputPort SI = sibSC3.toSI;
		Parameter Size = 67;
	}
	/* Scan Register 4*/
	Instance sibSC4 Of SIB_mux_pre {
		InputPort SI = sibSC3.SO;
		InputPort fromSO = sc4.SO;
	}
	Instance sc4 Of SReg {
		InputPort SI = sibSC4.toSI;
		Parameter Size = 56;
	}
	/* Scan Register 5*/
	Instance sibSC5 Of SIB_mux_pre {
		InputPort SI = sibSC4.SO;
		InputPort fromSO = sc5.SO;
	}
	Instance sc5 Of SReg {
		InputPort SI = sibSC5.toSI;
		Parameter Size = 56;
	}
}


/* Module M19 Level 1 Inputs 38 Outputs 29 Bidirs 0 ScanChains 3 : 43 40 17*/
Module M19 {
	Attribute lic = 'h cc8ce4f4;
	Parameter inputs = 38;
	Parameter outputs = 29;
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
		Parameter Size = 43;
	}

	/* Scan Register 2*/
	Instance sibSC2 Of SIB_mux_pre {
		InputPort SI = sibSC1.SO;
		InputPort fromSO = sc2.SO;
	}
	Instance sc2 Of SReg {
		InputPort SI = sibSC2.toSI;
		Parameter Size = 40;
	}
	/* Scan Register 3*/
	Instance sibSC3 Of SIB_mux_pre {
		InputPort SI = sibSC2.SO;
		InputPort fromSO = sc3.SO;
	}
	Instance sc3 Of SReg {
		InputPort SI = sibSC3.toSI;
		Parameter Size = 17;
	}
}


/* Module M20 Level 1 Inputs 45 Outputs 40 Bidirs 2 ScanChains 4 : 77 77 76 1*/
Module M20 {
	Attribute lic = 'h b7da6868;
	Parameter inputs = 45;
	Parameter outputs = 40;
	Parameter bidirs = 2;
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
		Parameter Size = 77;
	}

	/* Scan Register 2*/
	Instance sibSC2 Of SIB_mux_pre {
		InputPort SI = sibSC1.SO;
		InputPort fromSO = sc2.SO;
	}
	Instance sc2 Of SReg {
		InputPort SI = sibSC2.toSI;
		Parameter Size = 77;
	}
	/* Scan Register 3*/
	Instance sibSC3 Of SIB_mux_pre {
		InputPort SI = sibSC2.SO;
		InputPort fromSO = sc3.SO;
	}
	Instance sc3 Of SReg {
		InputPort SI = sibSC3.toSI;
		Parameter Size = 76;
	}
	/* Scan Register 4*/
	Instance sibSC4 Of SIB_mux_pre {
		InputPort SI = sibSC3.SO;
		InputPort fromSO = sc4.SO;
	}
	Instance sc4 Of SReg {
		InputPort SI = sibSC4.toSI;
		Parameter Size = 1;
	}
}


/* Module M21 Level 1 Inputs 115 Outputs 76 Bidirs 64 ScanChains 10 : 186 108 104 94 94 94 94 94 93 93*/
Module M21 {
	Attribute lic = 'h 68e030a3;
	Parameter inputs = 115;
	Parameter outputs = 76;
	Parameter bidirs = 64;
	ScanInPort SI;
	ScanOutPort SO {
		Source sibSC10.SO;
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
		Parameter Size = 186;
	}

	/* Scan Register 2*/
	Instance sibSC2 Of SIB_mux_pre {
		InputPort SI = sibSC1.SO;
		InputPort fromSO = sc2.SO;
	}
	Instance sc2 Of SReg {
		InputPort SI = sibSC2.toSI;
		Parameter Size = 108;
	}
	/* Scan Register 3*/
	Instance sibSC3 Of SIB_mux_pre {
		InputPort SI = sibSC2.SO;
		InputPort fromSO = sc3.SO;
	}
	Instance sc3 Of SReg {
		InputPort SI = sibSC3.toSI;
		Parameter Size = 104;
	}
	/* Scan Register 4*/
	Instance sibSC4 Of SIB_mux_pre {
		InputPort SI = sibSC3.SO;
		InputPort fromSO = sc4.SO;
	}
	Instance sc4 Of SReg {
		InputPort SI = sibSC4.toSI;
		Parameter Size = 94;
	}
	/* Scan Register 5*/
	Instance sibSC5 Of SIB_mux_pre {
		InputPort SI = sibSC4.SO;
		InputPort fromSO = sc5.SO;
	}
	Instance sc5 Of SReg {
		InputPort SI = sibSC5.toSI;
		Parameter Size = 94;
	}
	/* Scan Register 6*/
	Instance sibSC6 Of SIB_mux_pre {
		InputPort SI = sibSC5.SO;
		InputPort fromSO = sc6.SO;
	}
	Instance sc6 Of SReg {
		InputPort SI = sibSC6.toSI;
		Parameter Size = 94;
	}
	/* Scan Register 7*/
	Instance sibSC7 Of SIB_mux_pre {
		InputPort SI = sibSC6.SO;
		InputPort fromSO = sc7.SO;
	}
	Instance sc7 Of SReg {
		InputPort SI = sibSC7.toSI;
		Parameter Size = 94;
	}
	/* Scan Register 8*/
	Instance sibSC8 Of SIB_mux_pre {
		InputPort SI = sibSC7.SO;
		InputPort fromSO = sc8.SO;
	}
	Instance sc8 Of SReg {
		InputPort SI = sibSC8.toSI;
		Parameter Size = 94;
	}
	/* Scan Register 9*/
	Instance sibSC9 Of SIB_mux_pre {
		InputPort SI = sibSC8.SO;
		InputPort fromSO = sc9.SO;
	}
	Instance sc9 Of SReg {
		InputPort SI = sibSC9.toSI;
		Parameter Size = 93;
	}
	/* Scan Register 10*/
	Instance sibSC10 Of SIB_mux_pre {
		InputPort SI = sibSC9.SO;
		InputPort fromSO = sc10.SO;
	}
	Instance sc10 Of SReg {
		InputPort SI = sibSC10.toSI;
		Parameter Size = 93;
	}
}


/* Module M22 Level 1 Inputs 54 Outputs 40 Bidirs 0 ScanChains 3 : 77 76 13*/
Module M22 {
	Attribute lic = 'h da3eeb56;
	Parameter inputs = 54;
	Parameter outputs = 40;
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
		Parameter Size = 77;
	}

	/* Scan Register 2*/
	Instance sibSC2 Of SIB_mux_pre {
		InputPort SI = sibSC1.SO;
		InputPort fromSO = sc2.SO;
	}
	Instance sc2 Of SReg {
		InputPort SI = sibSC2.toSI;
		Parameter Size = 76;
	}
	/* Scan Register 3*/
	Instance sibSC3 Of SIB_mux_pre {
		InputPort SI = sibSC2.SO;
		InputPort fromSO = sc3.SO;
	}
	Instance sc3 Of SReg {
		InputPort SI = sibSC3.toSI;
		Parameter Size = 13;
	}
}


/* Module M23 Level 1 Inputs 31 Outputs 8 Bidirs 35 ScanChains 7 : 115 92 18 16 16 16 16*/
Module M23 {
	Attribute lic = 'h 5d5c1c6d;
	Parameter inputs = 31;
	Parameter outputs = 8;
	Parameter bidirs = 35;
	ScanInPort SI;
	ScanOutPort SO {
		Source sibSC7.SO;
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
		Parameter Size = 115;
	}

	/* Scan Register 2*/
	Instance sibSC2 Of SIB_mux_pre {
		InputPort SI = sibSC1.SO;
		InputPort fromSO = sc2.SO;
	}
	Instance sc2 Of SReg {
		InputPort SI = sibSC2.toSI;
		Parameter Size = 92;
	}
	/* Scan Register 3*/
	Instance sibSC3 Of SIB_mux_pre {
		InputPort SI = sibSC2.SO;
		InputPort fromSO = sc3.SO;
	}
	Instance sc3 Of SReg {
		InputPort SI = sibSC3.toSI;
		Parameter Size = 18;
	}
	/* Scan Register 4*/
	Instance sibSC4 Of SIB_mux_pre {
		InputPort SI = sibSC3.SO;
		InputPort fromSO = sc4.SO;
	}
	Instance sc4 Of SReg {
		InputPort SI = sibSC4.toSI;
		Parameter Size = 16;
	}
	/* Scan Register 5*/
	Instance sibSC5 Of SIB_mux_pre {
		InputPort SI = sibSC4.SO;
		InputPort fromSO = sc5.SO;
	}
	Instance sc5 Of SReg {
		InputPort SI = sibSC5.toSI;
		Parameter Size = 16;
	}
	/* Scan Register 6*/
	Instance sibSC6 Of SIB_mux_pre {
		InputPort SI = sibSC5.SO;
		InputPort fromSO = sc6.SO;
	}
	Instance sc6 Of SReg {
		InputPort SI = sibSC6.toSI;
		Parameter Size = 16;
	}
	/* Scan Register 7*/
	Instance sibSC7 Of SIB_mux_pre {
		InputPort SI = sibSC6.SO;
		InputPort fromSO = sc7.SO;
	}
	Instance sc7 Of SReg {
		InputPort SI = sibSC7.toSI;
		Parameter Size = 16;
	}
}


/* Module M24 Level 1 Inputs 73 Outputs 23 Bidirs 35 ScanChains 5 : 101 69 6 2 2*/
Module M24 {
	Attribute lic = 'h 12644f01;
	Parameter inputs = 73;
	Parameter outputs = 23;
	Parameter bidirs = 35;
	ScanInPort SI;
	ScanOutPort SO {
		Source sibSC5.SO;
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
		Parameter Size = 101;
	}

	/* Scan Register 2*/
	Instance sibSC2 Of SIB_mux_pre {
		InputPort SI = sibSC1.SO;
		InputPort fromSO = sc2.SO;
	}
	Instance sc2 Of SReg {
		InputPort SI = sibSC2.toSI;
		Parameter Size = 69;
	}
	/* Scan Register 3*/
	Instance sibSC3 Of SIB_mux_pre {
		InputPort SI = sibSC2.SO;
		InputPort fromSO = sc3.SO;
	}
	Instance sc3 Of SReg {
		InputPort SI = sibSC3.toSI;
		Parameter Size = 6;
	}
	/* Scan Register 4*/
	Instance sibSC4 Of SIB_mux_pre {
		InputPort SI = sibSC3.SO;
		InputPort fromSO = sc4.SO;
	}
	Instance sc4 Of SReg {
		InputPort SI = sibSC4.toSI;
		Parameter Size = 2;
	}
	/* Scan Register 5*/
	Instance sibSC5 Of SIB_mux_pre {
		InputPort SI = sibSC4.SO;
		InputPort fromSO = sc5.SO;
	}
	Instance sc5 Of SReg {
		InputPort SI = sibSC5.toSI;
		Parameter Size = 2;
	}
}


/* Module M25 Level 1 Inputs 58 Outputs 46 Bidirs 86 ScanChains 18 : 181 139 139 139 139 138 138 138 138 138 138 109 108 108 108 108 108 108*/
Module M25 {
	Attribute lic = 'h c7717e98;
	Parameter inputs = 58;
	Parameter outputs = 46;
	Parameter bidirs = 86;
	ScanInPort SI;
	ScanOutPort SO {
		Source sibSC18.SO;
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
		Parameter Size = 181;
	}

	/* Scan Register 2*/
	Instance sibSC2 Of SIB_mux_pre {
		InputPort SI = sibSC1.SO;
		InputPort fromSO = sc2.SO;
	}
	Instance sc2 Of SReg {
		InputPort SI = sibSC2.toSI;
		Parameter Size = 139;
	}
	/* Scan Register 3*/
	Instance sibSC3 Of SIB_mux_pre {
		InputPort SI = sibSC2.SO;
		InputPort fromSO = sc3.SO;
	}
	Instance sc3 Of SReg {
		InputPort SI = sibSC3.toSI;
		Parameter Size = 139;
	}
	/* Scan Register 4*/
	Instance sibSC4 Of SIB_mux_pre {
		InputPort SI = sibSC3.SO;
		InputPort fromSO = sc4.SO;
	}
	Instance sc4 Of SReg {
		InputPort SI = sibSC4.toSI;
		Parameter Size = 139;
	}
	/* Scan Register 5*/
	Instance sibSC5 Of SIB_mux_pre {
		InputPort SI = sibSC4.SO;
		InputPort fromSO = sc5.SO;
	}
	Instance sc5 Of SReg {
		InputPort SI = sibSC5.toSI;
		Parameter Size = 139;
	}
	/* Scan Register 6*/
	Instance sibSC6 Of SIB_mux_pre {
		InputPort SI = sibSC5.SO;
		InputPort fromSO = sc6.SO;
	}
	Instance sc6 Of SReg {
		InputPort SI = sibSC6.toSI;
		Parameter Size = 138;
	}
	/* Scan Register 7*/
	Instance sibSC7 Of SIB_mux_pre {
		InputPort SI = sibSC6.SO;
		InputPort fromSO = sc7.SO;
	}
	Instance sc7 Of SReg {
		InputPort SI = sibSC7.toSI;
		Parameter Size = 138;
	}
	/* Scan Register 8*/
	Instance sibSC8 Of SIB_mux_pre {
		InputPort SI = sibSC7.SO;
		InputPort fromSO = sc8.SO;
	}
	Instance sc8 Of SReg {
		InputPort SI = sibSC8.toSI;
		Parameter Size = 138;
	}
	/* Scan Register 9*/
	Instance sibSC9 Of SIB_mux_pre {
		InputPort SI = sibSC8.SO;
		InputPort fromSO = sc9.SO;
	}
	Instance sc9 Of SReg {
		InputPort SI = sibSC9.toSI;
		Parameter Size = 138;
	}
	/* Scan Register 10*/
	Instance sibSC10 Of SIB_mux_pre {
		InputPort SI = sibSC9.SO;
		InputPort fromSO = sc10.SO;
	}
	Instance sc10 Of SReg {
		InputPort SI = sibSC10.toSI;
		Parameter Size = 138;
	}
	/* Scan Register 11*/
	Instance sibSC11 Of SIB_mux_pre {
		InputPort SI = sibSC10.SO;
		InputPort fromSO = sc11.SO;
	}
	Instance sc11 Of SReg {
		InputPort SI = sibSC11.toSI;
		Parameter Size = 138;
	}
	/* Scan Register 12*/
	Instance sibSC12 Of SIB_mux_pre {
		InputPort SI = sibSC11.SO;
		InputPort fromSO = sc12.SO;
	}
	Instance sc12 Of SReg {
		InputPort SI = sibSC12.toSI;
		Parameter Size = 109;
	}
	/* Scan Register 13*/
	Instance sibSC13 Of SIB_mux_pre {
		InputPort SI = sibSC12.SO;
		InputPort fromSO = sc13.SO;
	}
	Instance sc13 Of SReg {
		InputPort SI = sibSC13.toSI;
		Parameter Size = 108;
	}
	/* Scan Register 14*/
	Instance sibSC14 Of SIB_mux_pre {
		InputPort SI = sibSC13.SO;
		InputPort fromSO = sc14.SO;
	}
	Instance sc14 Of SReg {
		InputPort SI = sibSC14.toSI;
		Parameter Size = 108;
	}
	/* Scan Register 15*/
	Instance sibSC15 Of SIB_mux_pre {
		InputPort SI = sibSC14.SO;
		InputPort fromSO = sc15.SO;
	}
	Instance sc15 Of SReg {
		InputPort SI = sibSC15.toSI;
		Parameter Size = 108;
	}
	/* Scan Register 16*/
	Instance sibSC16 Of SIB_mux_pre {
		InputPort SI = sibSC15.SO;
		InputPort fromSO = sc16.SO;
	}
	Instance sc16 Of SReg {
		InputPort SI = sibSC16.toSI;
		Parameter Size = 108;
	}
	/* Scan Register 17*/
	Instance sibSC17 Of SIB_mux_pre {
		InputPort SI = sibSC16.SO;
		InputPort fromSO = sc17.SO;
	}
	Instance sc17 Of SReg {
		InputPort SI = sibSC17.toSI;
		Parameter Size = 108;
	}
	/* Scan Register 18*/
	Instance sibSC18 Of SIB_mux_pre {
		InputPort SI = sibSC17.SO;
		InputPort fromSO = sc18.SO;
	}
	Instance sc18 Of SReg {
		InputPort SI = sibSC18.toSI;
		Parameter Size = 108;
	}
}


/* Module M26 Level 1 Inputs 66 Outputs 33 Bidirs 98 ScanChains 31 : 400 400 400 400 400 400 399 399 399 399 399 399 399 399 399 399 399 399 399 399 399 399 334 334 333 333 333 279 279 278 198*/
Module M26 {
	Attribute lic = 'h 68b749fb;
	Parameter inputs = 66;
	Parameter outputs = 33;
	Parameter bidirs = 98;
	ScanInPort SI;
	ScanOutPort SO {
		Source sibSC31.SO;
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
		Parameter Size = 400;
	}

	/* Scan Register 2*/
	Instance sibSC2 Of SIB_mux_pre {
		InputPort SI = sibSC1.SO;
		InputPort fromSO = sc2.SO;
	}
	Instance sc2 Of SReg {
		InputPort SI = sibSC2.toSI;
		Parameter Size = 400;
	}
	/* Scan Register 3*/
	Instance sibSC3 Of SIB_mux_pre {
		InputPort SI = sibSC2.SO;
		InputPort fromSO = sc3.SO;
	}
	Instance sc3 Of SReg {
		InputPort SI = sibSC3.toSI;
		Parameter Size = 400;
	}
	/* Scan Register 4*/
	Instance sibSC4 Of SIB_mux_pre {
		InputPort SI = sibSC3.SO;
		InputPort fromSO = sc4.SO;
	}
	Instance sc4 Of SReg {
		InputPort SI = sibSC4.toSI;
		Parameter Size = 400;
	}
	/* Scan Register 5*/
	Instance sibSC5 Of SIB_mux_pre {
		InputPort SI = sibSC4.SO;
		InputPort fromSO = sc5.SO;
	}
	Instance sc5 Of SReg {
		InputPort SI = sibSC5.toSI;
		Parameter Size = 400;
	}
	/* Scan Register 6*/
	Instance sibSC6 Of SIB_mux_pre {
		InputPort SI = sibSC5.SO;
		InputPort fromSO = sc6.SO;
	}
	Instance sc6 Of SReg {
		InputPort SI = sibSC6.toSI;
		Parameter Size = 400;
	}
	/* Scan Register 7*/
	Instance sibSC7 Of SIB_mux_pre {
		InputPort SI = sibSC6.SO;
		InputPort fromSO = sc7.SO;
	}
	Instance sc7 Of SReg {
		InputPort SI = sibSC7.toSI;
		Parameter Size = 399;
	}
	/* Scan Register 8*/
	Instance sibSC8 Of SIB_mux_pre {
		InputPort SI = sibSC7.SO;
		InputPort fromSO = sc8.SO;
	}
	Instance sc8 Of SReg {
		InputPort SI = sibSC8.toSI;
		Parameter Size = 399;
	}
	/* Scan Register 9*/
	Instance sibSC9 Of SIB_mux_pre {
		InputPort SI = sibSC8.SO;
		InputPort fromSO = sc9.SO;
	}
	Instance sc9 Of SReg {
		InputPort SI = sibSC9.toSI;
		Parameter Size = 399;
	}
	/* Scan Register 10*/
	Instance sibSC10 Of SIB_mux_pre {
		InputPort SI = sibSC9.SO;
		InputPort fromSO = sc10.SO;
	}
	Instance sc10 Of SReg {
		InputPort SI = sibSC10.toSI;
		Parameter Size = 399;
	}
	/* Scan Register 11*/
	Instance sibSC11 Of SIB_mux_pre {
		InputPort SI = sibSC10.SO;
		InputPort fromSO = sc11.SO;
	}
	Instance sc11 Of SReg {
		InputPort SI = sibSC11.toSI;
		Parameter Size = 399;
	}
	/* Scan Register 12*/
	Instance sibSC12 Of SIB_mux_pre {
		InputPort SI = sibSC11.SO;
		InputPort fromSO = sc12.SO;
	}
	Instance sc12 Of SReg {
		InputPort SI = sibSC12.toSI;
		Parameter Size = 399;
	}
	/* Scan Register 13*/
	Instance sibSC13 Of SIB_mux_pre {
		InputPort SI = sibSC12.SO;
		InputPort fromSO = sc13.SO;
	}
	Instance sc13 Of SReg {
		InputPort SI = sibSC13.toSI;
		Parameter Size = 399;
	}
	/* Scan Register 14*/
	Instance sibSC14 Of SIB_mux_pre {
		InputPort SI = sibSC13.SO;
		InputPort fromSO = sc14.SO;
	}
	Instance sc14 Of SReg {
		InputPort SI = sibSC14.toSI;
		Parameter Size = 399;
	}
	/* Scan Register 15*/
	Instance sibSC15 Of SIB_mux_pre {
		InputPort SI = sibSC14.SO;
		InputPort fromSO = sc15.SO;
	}
	Instance sc15 Of SReg {
		InputPort SI = sibSC15.toSI;
		Parameter Size = 399;
	}
	/* Scan Register 16*/
	Instance sibSC16 Of SIB_mux_pre {
		InputPort SI = sibSC15.SO;
		InputPort fromSO = sc16.SO;
	}
	Instance sc16 Of SReg {
		InputPort SI = sibSC16.toSI;
		Parameter Size = 399;
	}
	/* Scan Register 17*/
	Instance sibSC17 Of SIB_mux_pre {
		InputPort SI = sibSC16.SO;
		InputPort fromSO = sc17.SO;
	}
	Instance sc17 Of SReg {
		InputPort SI = sibSC17.toSI;
		Parameter Size = 399;
	}
	/* Scan Register 18*/
	Instance sibSC18 Of SIB_mux_pre {
		InputPort SI = sibSC17.SO;
		InputPort fromSO = sc18.SO;
	}
	Instance sc18 Of SReg {
		InputPort SI = sibSC18.toSI;
		Parameter Size = 399;
	}
	/* Scan Register 19*/
	Instance sibSC19 Of SIB_mux_pre {
		InputPort SI = sibSC18.SO;
		InputPort fromSO = sc19.SO;
	}
	Instance sc19 Of SReg {
		InputPort SI = sibSC19.toSI;
		Parameter Size = 399;
	}
	/* Scan Register 20*/
	Instance sibSC20 Of SIB_mux_pre {
		InputPort SI = sibSC19.SO;
		InputPort fromSO = sc20.SO;
	}
	Instance sc20 Of SReg {
		InputPort SI = sibSC20.toSI;
		Parameter Size = 399;
	}
	/* Scan Register 21*/
	Instance sibSC21 Of SIB_mux_pre {
		InputPort SI = sibSC20.SO;
		InputPort fromSO = sc21.SO;
	}
	Instance sc21 Of SReg {
		InputPort SI = sibSC21.toSI;
		Parameter Size = 399;
	}
	/* Scan Register 22*/
	Instance sibSC22 Of SIB_mux_pre {
		InputPort SI = sibSC21.SO;
		InputPort fromSO = sc22.SO;
	}
	Instance sc22 Of SReg {
		InputPort SI = sibSC22.toSI;
		Parameter Size = 399;
	}
	/* Scan Register 23*/
	Instance sibSC23 Of SIB_mux_pre {
		InputPort SI = sibSC22.SO;
		InputPort fromSO = sc23.SO;
	}
	Instance sc23 Of SReg {
		InputPort SI = sibSC23.toSI;
		Parameter Size = 334;
	}
	/* Scan Register 24*/
	Instance sibSC24 Of SIB_mux_pre {
		InputPort SI = sibSC23.SO;
		InputPort fromSO = sc24.SO;
	}
	Instance sc24 Of SReg {
		InputPort SI = sibSC24.toSI;
		Parameter Size = 334;
	}
	/* Scan Register 25*/
	Instance sibSC25 Of SIB_mux_pre {
		InputPort SI = sibSC24.SO;
		InputPort fromSO = sc25.SO;
	}
	Instance sc25 Of SReg {
		InputPort SI = sibSC25.toSI;
		Parameter Size = 333;
	}
	/* Scan Register 26*/
	Instance sibSC26 Of SIB_mux_pre {
		InputPort SI = sibSC25.SO;
		InputPort fromSO = sc26.SO;
	}
	Instance sc26 Of SReg {
		InputPort SI = sibSC26.toSI;
		Parameter Size = 333;
	}
	/* Scan Register 27*/
	Instance sibSC27 Of SIB_mux_pre {
		InputPort SI = sibSC26.SO;
		InputPort fromSO = sc27.SO;
	}
	Instance sc27 Of SReg {
		InputPort SI = sibSC27.toSI;
		Parameter Size = 333;
	}
	/* Scan Register 28*/
	Instance sibSC28 Of SIB_mux_pre {
		InputPort SI = sibSC27.SO;
		InputPort fromSO = sc28.SO;
	}
	Instance sc28 Of SReg {
		InputPort SI = sibSC28.toSI;
		Parameter Size = 279;
	}
	/* Scan Register 29*/
	Instance sibSC29 Of SIB_mux_pre {
		InputPort SI = sibSC28.SO;
		InputPort fromSO = sc29.SO;
	}
	Instance sc29 Of SReg {
		InputPort SI = sibSC29.toSI;
		Parameter Size = 279;
	}
	/* Scan Register 30*/
	Instance sibSC30 Of SIB_mux_pre {
		InputPort SI = sibSC29.SO;
		InputPort fromSO = sc30.SO;
	}
	Instance sc30 Of SReg {
		InputPort SI = sibSC30.toSI;
		Parameter Size = 278;
	}
	/* Scan Register 31*/
	Instance sibSC31 Of SIB_mux_pre {
		InputPort SI = sibSC30.SO;
		InputPort fromSO = sc31.SO;
	}
	Instance sc31 Of SReg {
		InputPort SI = sibSC31.toSI;
		Parameter Size = 198;
	}
}


/* Module M27 Level 1 Inputs 285 Outputs 94 Bidirs 0 ScanChains 1 : 34*/
Module M27 {
	Attribute lic = 'h 9fd4e8e3;
	Parameter inputs = 285;
	Parameter outputs = 94;
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
		Parameter Size = 34;
	}

}


/* Module M28 Level 1 Inputs 48 Outputs 43 Bidirs 0 ScanChains 5 : 100 99 99 79 40*/
Module M28 {
	Attribute lic = 'h 2906dca8;
	Parameter inputs = 48;
	Parameter outputs = 43;
	Parameter bidirs = 0;
	ScanInPort SI;
	ScanOutPort SO {
		Source sibSC5.SO;
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
		Parameter Size = 100;
	}

	/* Scan Register 2*/
	Instance sibSC2 Of SIB_mux_pre {
		InputPort SI = sibSC1.SO;
		InputPort fromSO = sc2.SO;
	}
	Instance sc2 Of SReg {
		InputPort SI = sibSC2.toSI;
		Parameter Size = 99;
	}
	/* Scan Register 3*/
	Instance sibSC3 Of SIB_mux_pre {
		InputPort SI = sibSC2.SO;
		InputPort fromSO = sc3.SO;
	}
	Instance sc3 Of SReg {
		InputPort SI = sibSC3.toSI;
		Parameter Size = 99;
	}
	/* Scan Register 4*/
	Instance sibSC4 Of SIB_mux_pre {
		InputPort SI = sibSC3.SO;
		InputPort fromSO = sc4.SO;
	}
	Instance sc4 Of SReg {
		InputPort SI = sibSC4.toSI;
		Parameter Size = 79;
	}
	/* Scan Register 5*/
	Instance sibSC5 Of SIB_mux_pre {
		InputPort SI = sibSC4.SO;
		InputPort fromSO = sc5.SO;
	}
	Instance sc5 Of SReg {
		InputPort SI = sibSC5.toSI;
		Parameter Size = 40;
	}
}
