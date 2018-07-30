/*
* Copyright Testonica Lab (C) 2016
*
*
* History:
* -------------+------------+-------------------------+------------------------
*   Version    |  Date      | Author                  | Organization
* -------------+------------+-------------------------+------------------------
*          1.0 | 08.04.2016  | Anton Tsertov           | Testonica Lab
*--------------+------------+-------------------------+------------------------
* Uses modules from files: 
* - E30.icl
* - NetworkStructs.icl
* - A586710.icl
* - Instruments.icl
* - EmptyModule.icl
*
*/

Module Kernel {
	Attribute lic = 'h 600b71b;
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
    // Because CoreA only has one scan port, explicitly listing the ScanInterface (".SP1") is optional
    // Also note that since "toSWIR" is not listed as an ActiveSignal, so it is INACTIVE here.
        }
		clk_select {
			ScanInterface {
				CLK_CTL.SC;
			}
		}
    }
////////////////////////////////
//starting the second TAP
////////////////////////////////
    Parameter iBoundary = 1;
    Parameter iM1 = 2;
    
    Parameter inputs = 31;
    Parameter outputs = 59;
    Parameter bidirs = 111;
    
    ScanInPort TDI;
    ScanOutPort TDO {
        Source eTAP.eTDO;
    }
    TCKPort TCK;
    TMSPort TMS;
    ScanInterface TOP_TAP_client {
        Port TCK;
        Port TMS;
        Port TDI;
    }
    
    Instance topTAP Of TAP_Host {
        InputPort eTDI = TDI;
        InputPort eTMS = TMS;
        InputPort eTCK = TCK;
        InputPort fromSO = muxBoudary;
        Parameter irBitWidth = 3;
    }
    
    Instance eTAP Of TAP_Client {
        InputPort eTDI = topTAP.eTDO;
        InputPort eTMS = TMS;
        InputPort eTCK = TCK;
        InputPort SELECT = topTAP.toSELECT;
        InputPort fromSO = sibM7.SO;
    }
    
    LogicSignal selBoundary {
        topTAP.IR[$irBitWidth-1:1] == iBoundary;
    }
    LogicSignal selScan {
        topTAP.IR[$irBitWidth-1:1] == iM1;
    }


    ScanMux muxBoudary SelectedBy selBoundary {
        0 : muxScan;
        1 : sibWrp.SO;
    }
    ScanMux muxScan SelectedBy selScan {
        0 : bypass;
        1 : sibM1.SO;
    }
    
    ScanRegister bypass {
        ScanInSource topTAP.toSI;
        ResetValue 1'b1;    
        CaptureSource bypass;
    }
    
    Instance sibM1 Of SIB_mux_post {
        InputPort SI = topTAP.toSI;
        InputPort fromSO = socDap.SO;
    }
    Instance socDap Of SOC_DAP_3D {
        InputPort SI = sibM1.toSI; 
    }
	DataInPort DI[$inputs+$bidirs-1 : 0];
    DataInPort toDO[$outputs+$bidirs-1 : 0];
    DataOutPort DO[$outputs+$bidirs-1 : 0] {
        Source wrpOut; 
    }
    
    Instance sibWrp Of SIB_mux_pre {
        InputPort SI = topTAP.toSI;
        InputPort fromSO = wrpOut.SO;
    }
    Instance wrpIn Of SReg {
        InputPort SI = sibWrp.toSI;
        InputPort DI = DI; 
        Parameter Size = $inputs+$bidirs;
    }
    Instance wrpCntrl Of WrappedScan {
        InputPort SI = wrpIn.SO;
        Parameter dataWidth = $bidirs;
    }
    Instance wrpOut Of SReg {
        InputPort SI = wrpCntrl.SO;
        InputPort DI = toDO; 
        Parameter Size = $outputs+$bidirs;
    }
	
	Instance sibM5 Of SIB_mux_pre {
        InputPort SI = eTAP.toSI;
        InputPort fromSO = m5.SO;
    }
    Instance m5 Of A586710::M5 {
        InputPort SI = sibM5.toSI; 
    }
    Instance sibM6 Of SIB_mux_pre {
        InputPort SI = sibM5.SO;
        InputPort fromSO = m6.SO;
    }
    Instance m6 Of EmptyModule {
        InputPort SI = sibM6.toSI; 
        Parameter inputs = 34;
        Parameter outputs = 35;
        Parameter bidirs = 0;
    }
    Instance sibM7 Of SIB_mux_pre {
        InputPort SI = sibM6.SO;
        InputPort fromSO = m7.SO;
    }
    Instance m7 Of EmptyModule {
        InputPort SI = sibM7.toSI; 
        Parameter inputs = 226;
        Parameter outputs = 100;
        Parameter bidirs = 0;
    }
}
