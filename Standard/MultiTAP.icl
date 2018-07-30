/*
* Copyright Testonica Lab (C) 2016
*
* History:
* -------------+------------+-------------------------+------------------------
*   Version    |  Date      | Author                  | Organization
* -------------+------------+-------------------------+------------------------
*          1.0 | 29.03.2016 | Anton Tsertov           | Testonica Lab
*--------------+------------+-------------------------+------------------------
*          2.2 | 22.11.2016 | Anton Tsertov           | Testonica Lab
*--------------+------------+-------------------------+------------------------
*
* Uses modules from files: NetworkStructs.icl, A586710.icl, Instruments.icl, EmptyModule.icl
* 
*/

Module MultiTap {
    Attribute lic = 'h d17f6946;
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
    
    Instance sibM1 Of SIB_mux_pre {
        InputPort SI = topTAP.toSI;
        InputPort fromSO = m1.SO;
    }
    Instance m1 Of A586710::M1 {
        InputPort SI = sibM1.toSI; 
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
}

Module TAP_Host {
    Attribute lic = 'h ec5f4409;
    Parameter irBitWidth = 3;

    ScanInPort eTDI;
    TMSPort eTMS;
    TCKPort eTCK;
    ScanOutPort eTDO {
        Source IRMux;
    }
    ScanInPort fromSO;
    ScanOutPort toSI {
        Source eTDI;
    }
    ToSelectPort toSELECT {
        Source enTapClient;
    }
    
    DataOutPort instruction [$irBitWidth-1:0] {
        Source IR;
    }
    
    ScanInterface TAP_host {
        Port eTCK;
        Port eTMS;
        Port eTDO;
        Port toSELECT;
    }
    
    ToResetPort toRST {
        Source FSM.tlr;
    }
    ToCaptureEnPort toCE {
        Source FSM.CE;
    }
    ToShiftEnPort toSE {
        Source FSM.SE;
    }
    ToUpdateEnPort toUE {
        Source FSM.UE;
    }
    ToTCKPort toTCK;
    ToSelectPort toSEL {
        Source enScanClient;
    }
    LogicSignal enScanClient {
        IR[0] == 1'b1;
    }
    LogicSignal enTapClient {
        IR[2] == 1'b0;
    }
    
    ScanInterface host {
        Port fromSO;
        Port toCE;
        Port toSE;
        Port toUE;
        Port toSEL;
        Port toRST;
        Port toTCK;
        Port toSI;
    }
    
    Instance FSM Of TapStates {
        InputPort tms = eTMS;
        InputPort tck = eTCK;
    }
    ScanRegister IR[$irBitWidth-1:0] {
        ScanInSource eTDI;
        ResetValue $irBitWidth'b111;    
        CaptureSource IR;
    }
    
    ScanMux IRMux SelectedBy FSM.IRSel {
        1'b0 : fromSO;
        1'b1 : IR[0];
    }
}

Module TAP_Client {
    Attribute lic = 'h 2ef09608;
    ScanInPort eTDI;
    SelectPort SELECT;
    TMSPort eTMS;
    TCKPort eTCK;
    ScanOutPort eTDO {
        Source sMux;
    }
    ScanInPort fromSO;
    ScanOutPort toSI {
        Source eTDI;
    }

    ScanInterface TAP_Client {
        Port eTCK;
        Port eTMS;
        Port eTDI;
        Port eTDO;
        Port SELECT;
    }
    
    ToResetPort toRST {
        Source FSM.tlr;
    }
    ToCaptureEnPort toCE {
        Source FSM.CE;
    }
    ToShiftEnPort toSE {
        Source FSM.SE;
    }
    ToUpdateEnPort toUE {
        Source FSM.UE;
    }
    ToTCKPort toTCK;
    
    ToSelectPort toSEL {
        Source enScanClient;
    }
    LogicSignal enScanClient {
        IR[0] == 1'b0;
    }
    ScanInterface host {
        Port fromSO;
        Port toCE;
        Port toSE;
        Port toUE;
        Port toSEL;
        Port toRST;
        Port toTCK;
        Port toSI;
    }
    
    Instance FSM Of TapStates {
        InputPort tms = eTMS;
        InputPort tck = eTCK;
    }
    ScanRegister IR[1:0] {
        ScanInSource eTDI;
        ResetValue 2'b11;       // BYPASS Instructions in 1149.1
        CaptureSource IR;
    }
    ScanRegister Bypass {
        ScanInSource eTDI;
        CaptureSource 1;
    }
    ScanMux sMux SelectedBy SELECT {
        1'b1 : IRMux;
        1'b0 : eTDI;
    }
    
    ScanMux IRMux SelectedBy FSM.IRSel {
        1'b0 : DRMux;
        1'b1 : IR[0];
    }
    ScanMux DRMux SelectedBy IR[0] {
        1'b0 : fromSO;
        1'b1 : Bypass;
    }
}

Module TapStates {
    Attribute lic = 'h 3d332ce4;
    TMSPort tms;
    TCKPort tck;
    ToResetPort tlr;
    ToIRSelectPort IRSel;
    ToCaptureEnPort CE;
    ToShiftEnPort SE;
    ToUpdateEnPort UE;
}
