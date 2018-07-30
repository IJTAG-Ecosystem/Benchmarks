/*
* Copyright Testonica Lab (C) 2016
*
*
* History:
* -------------+------------+-------------------------+------------------------
*   Version    |  Date      | Author                  | Organization
* -------------+------------+-------------------------+------------------------
*          1.0 | 08.03.2016 | Anton Tsertov           | Testonica Lab
*--------------+------------+-------------------------+------------------------
*          2.0 | 03.05.2016 | Anton Tsertov           | Testonica Lab
*--------------+------------+-------------------------+------------------------
*          2.1 | 22.12.2016 | Dmitri Mihhailov        | Testonica Lab
*--------------+------------+-------------------------+------------------------
*          2.5 | 26.06.2018 | Jan Burchard		      | Mentor A Siemens Business
*              |            | Anton Tsertov		      | Testonica Lab
*--------------+------------+-------------------------+------------------------
*
* Uses modules from files: 
* - Instruments.icl
* - NetworkStructs.icl
* - EmptyModule.icl
* - G1023.icl
*/


Module TreeFlat_Ex {
    Attribute lic = 'h c8c6c73a;
    ScanInPort SI;
    CaptureEnPort CE;
    ShiftEnPort SE;
    UpdateEnPort UE; 
    SelectPort SEL;
    ResetPort RST;
    TCKPort TCK;
    ScanOutPort SO {
        Source sibM14.SO;
    }
    
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
    
	Instance m1 Of G1023_Basic::M1 {
        InputPort SI = SI;
        InputPort DI = DIm1;	
		InputPort toDO = toDOm1;
    }
	Instance m2 Of G1023_Basic::M2 {
        InputPort SI = m1.SO;
        InputPort DI = DIm2;	
		InputPort toDO = toDOm2;
    }
	Instance m3 Of G1023_Basic::M3 {
        InputPort SI = m2.SO;
        InputPort DI = DIm3;	
		InputPort toDO = toDOm3;
    }
	Instance m4 Of G1023_Basic::M4 {
        InputPort SI = m3.SO;
        InputPort DI = DIm4;	
		InputPort toDO = toDOm4;
    }
	Instance m5 Of G1023_Basic::M5 {
        InputPort SI = m4.SO;
        InputPort DI = DIm5;	
		InputPort toDO = toDOm5;
    }
	Instance m6 Of G1023_Basic::M6 {
        InputPort SI = m5.SO;
        InputPort DI = DIm6;	
		InputPort toDO = toDOm6;
    }
	Instance m7 Of G1023_Basic::M7 {
        InputPort SI = m6.SO;
        InputPort DI = DIm7;	
		InputPort toDO = toDOm7;
    }
	Instance m8 Of G1023_Basic::M8 {
        InputPort SI = m7.SO;
        InputPort DI = DIm8;	
		InputPort toDO = toDOm8;
    }
	Instance m9 Of G1023_Basic::M9 {
        InputPort SI = m8.SO;
        InputPort DI = DIm9;	
		InputPort toDO = toDOm9;
    }
	Instance m10 Of G1023_Basic::M10 {
        InputPort SI = m9.SO;
        InputPort DI = DIm10;	
		InputPort toDO = toDOm10;
    }
	Instance m11 Of G1023_Basic::M11 {
        InputPort SI = m10.SO;
        InputPort DI = DIm11;	
		InputPort toDO = toDOm11;
    }
	Instance m12 Of G1023_Basic::M12 {
        InputPort SI = m11.SO;
        InputPort DI = DIm12;	
		InputPort toDO = toDOm12;
    }
	Instance sibM13 Of SIB_mux_pre {
		InputPort SI = m12.SO;
		InputPort fromSO = m13.SO;
	}
	Instance m13 Of EmptyModule_NoBidirs  {
		InputPort SI = sibM13.toSI; 
		Parameter inputs = 58;
		Parameter outputs = 64;
	}
	Instance sibM14 Of SIB_mux_pre {
		InputPort SI = sibM13.SO;
		InputPort fromSO = m14.SO;
	}
	Instance m14 Of EmptyModule_NoBidirs  {
		InputPort SI = sibM14.toSI; 
		Parameter inputs = 140;
		Parameter outputs = 114;
	}
}
