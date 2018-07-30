/*
* Copyright Testonica Lab (C) 2016
*
* History:
* -------------+------------+-------------------------+------------------------
*   Version    |  Date      | Author                  | Organization
* -------------+------------+-------------------------+------------------------
*          1.0 | 08.04.2016  | Anton Tsertov           | Testonica Lab
*--------------+------------+-------------------------+------------------------
* Uses modules from files: E30.icl
*
*/

Module MultiCoreAccessLink {
    Attribute lic = 'h 7cb02edd;
    ClockPort CLKA;
    ClockPort CLKB;
    DataInPort P1;
    DataInPort P2;
    Instance PLLA_I1 Of PLLA { InputPort ref = CLKA;}
    Instance PLLB_I1 Of PLLB { InputPort ref = CLKB;}
    Instance COREA_I1 Of CoreA {
        InputPort P = P1;
        InputPort CLK = PLLA_I1.vco;
        InputPort SWIR = Tap1.toSWIR;
    }
    Instance COREA_I2 Of CoreA {
        InputPort P = P2;
        InputPort CLK = PLLB_I1.vco;
    }

	Instance CLK_CTL Of ClockController {
		InputPort CLK_A = CLKA;
		InputPort CLK_B = CLKB;
	}
	
    AccessLink Tap1 Of STD_1149_1_2001 {
        BSDLEntity Mychip;
        wir_select {
    	    ScanInterface {
    		    COREA_I1.SP1;
                COREA_I2.SP1;
    		}
            ActiveSignals { toSWIR ;}
        }
        wdr_select { 
    	    ScanInterface {
    		    COREA_I1;
                COREA_I2;
    		}
    // Because CoreA only has one scan port, explicitly listing the ScanInterface (ā€�.SP1ā€¯) is optional
    // Also note that since ā€�toSWIRā€¯ is not listed as an ActiveSignal, so it is INACTIVE here.
        }
		clk_select {
			ScanInterface {
				CLK_CTL.SC;
			}
		}
    }
}

Module ClockController {
    Attribute lic = 'h 648a63cd;
	ClockPort CLK_A;
	ClockPort CLK_B;
	ToClockPort CLK_OA {
		Source CLK_MUX_A;
	}

	ToClockPort CLK_OB {
		Source CLK_MUX_B;
	}
    ScanInPort WSI;
    ScanOutPort WSO {Source SR[0]; }
    ShiftEnPort shiftWR;
    CaptureEnPort captureWR;
    UpdateEnPort updateWR;
    ResetPort WRST;
    TCKPort WRCK;
	SelectPort SEL;
    ScanInterface SC {
		Port WSI; 
		Port WSO;
		Port SEL;
        Port shiftWR;
		Port captureWR;
		Port updateWR;
	}
	
	ScanRegister SR[1:0] {
		ScanInSource WSI;
		CaptureSource SR;
		ResetValue 'b0;
	}
	
	ClockMux CLK_MUX_A SelectedBy SR[0] {
		0: CLK_A;
		1: CLK_B;
	}
	ClockMux CLK_MUX_B SelectedBy SR[1] {
		0: CLK_B;
		1: CLK_A;
	}
}
