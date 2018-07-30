/*
* This file contains code snippets from IEEE Standard 1687-2014 Appendix E
*
* -------------+------------+-------------------------+------------------------
*   Version    |  Date      | Author                  | Organization
* -------------+------------+-------------------------+------------------------
*          1.0 | 8.03.2016  | Anton Tsertov           | Testonica Lab
*--------------+------------+-------------------------+------------------------
*          1.1 | 17.19.2016 | Dmitri Mihhailov        | Testonica Lab
*--------------+------------+-------------------------+------------------------
*
*/

Module SIB_mux_pre {
    Attribute lic = 'h a077802c;
    ScanInPort SI;
    CaptureEnPort CE;
    ShiftEnPort SE;
    UpdateEnPort UE;
    SelectPort SEL;
    ResetPort RST;
    TCKPort TCK;
    ScanOutPort SO {
        Source SR;
    }
    ScanInterface client {
        Port SI;
        Port CE;
        Port SE;
        Port UE;
        Port SEL;
        Port RST;
        Port TCK;
        Port SO;
    }
    
    LogicSignal toSel_SR_SEL { 
       SR[0] & SEL;
    }
    ScanInPort fromSO;
    ToCaptureEnPort toCE;
    ToShiftEnPort toSE;
    ToUpdateEnPort toUE;
    ToSelectPort toSEL {
       Source toSel_SR_SEL; 
    }
    ToResetPort toRST;
    ToTCKPort toTCK;
    ScanOutPort toSI {
        Source SI;
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
    ScanRegister SR {
        ScanInSource SIBmux;
        CaptureSource SR;
        ResetValue 1'b0;
    }
    ScanMux SIBmux SelectedBy SR {
        1'b0 : SI;
        1'b1 : fromSO;
    }
}


Module SIB_mux_post {
   Attribute lic = 'h 8ca989b2;
    ScanInPort SI;
    CaptureEnPort CE;
    ShiftEnPort SE;
    UpdateEnPort UE;
    SelectPort SEL;
    ResetPort RST;
    TCKPort TCK;
    ScanOutPort SO {
        Source SIBmux;
    }
    ScanInterface client {
        Port SI;
        Port CE;
        Port SE;
        Port UE;
        Port SEL;
        Port RST;
        Port TCK;
        Port SO;
    }
    
    LogicSignal toSel_SR_SEL {
       SR[0] & SEL;
    }
    ScanInPort fromSO;
    ToCaptureEnPort toCE;
    ToShiftEnPort toSE;
    ToUpdateEnPort toUE;
    ToSelectPort toSEL {
       Source toSel_SR_SEL; 
    }
    ToResetPort toRST;
    ToTCKPort toTCK;
    ScanOutPort toSI {
        Source SR;
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
    ScanRegister SR {
        ScanInSource SI;
        CaptureSource SR;
        ResetValue 1'b0;
    }
    ScanMux SIBmux SelectedBy SR {
        1'b0 : SR;
        1'b1 : fromSO;
    }
}


Module SCB {
    Attribute lic = 'h 94bbab03;
    ScanInPort SI;
    CaptureEnPort CE;
    ShiftEnPort SE;
    UpdateEnPort UE;
    SelectPort SEL;
    ResetPort RST;
    TCKPort TCK;
    ToSelectPort toSEL {
        Source SR;
    }
    ScanOutPort SO {
        Source SR;
    }  
    ScanInterface client {
        Port SI;
        Port SE;
        Port UE;
        Port CE;
        Port SEL;
        Port RST;
        Port TCK;
        Port SO;
    }
   
    DataOutPort DO[0:0] {
        Source SR;
    }
    ScanRegister SR [0:0] {
        ScanInSource SI;
        CaptureSource SR;
        ResetValue 1'b0;
    }
}

// SCR - ScanMux Control Register
Module SCR {
    Attribute lic = 'h 581871b4;
    Parameter size = 2;
    ScanInPort SI;
    CaptureEnPort CE;
    ShiftEnPort SE;
    UpdateEnPort UE;
    SelectPort SEL;
    ResetPort RST;
    TCKPort TCK;

    ScanOutPort SO {
        Source SR[0];
    }  
    ScanInterface client {
        Port SI;
        Port SE;
        Port UE;
        Port CE;
        Port SEL;
        Port RST;
        Port TCK;
        Port SO;
    }
   
    DataOutPort DO[$size-1:0] {
        Source SR;
    }
    ScanRegister SR [$size-1:0] {
        ScanInSource SI;
        CaptureSource SR;
        ResetValue 'b0;
    }
}

Module BypassReg {
    Attribute lic = 'h b0de05e8;
    ScanInPort SI;
    CaptureEnPort CE;
    ShiftEnPort SE;
    UpdateEnPort UE;
    SelectPort SEL;
    ResetPort RST;
    TCKPort TCK;
    ScanOutPort SO {
        Source SR;
    }  
    ScanInterface client {
        Port SI;
        Port SE;
        Port UE;
        Port CE;
        Port SEL;
        Port RST;
        Port TCK;
        Port SO;
    }
   
    ScanRegister SR [0:0] {
        ScanInSource SI;
        CaptureSource SR;
        ResetValue 1'b1;
    }
}
