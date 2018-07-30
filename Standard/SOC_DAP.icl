/*
* Copyright Testonica Lab (C) 2016
*
* History:
* -------------+------------+-------------------------+------------------------
*   Version    |  Date      | Author                  | Organization
* -------------+------------+-------------------------+------------------------
*          1.0 | 22.03.2016  | Anton Tsertov           | Testonica Lab
*--------------+------------+-------------------------+------------------------
*
* Uses modules from files: CAD.icl
*
*/


Module SOC_DAP_3D {
    Attribute lic = 'h 1331d3d2;
    ScanInPort SI;
    CaptureEnPort CE;
    ShiftEnPort SE;
    UpdateEnPort UE;
    SelectPort SEL;
    ResetPort RST;
    TCKPort TCK;
    ScanOutPort SO {
        Source M1;
    }
    
    OneHotScanGroup M1 {
        Port level1.SO;
        Port level2.SO;
    }
    
    Instance level1 Of SOC_DAP_3DLevel {
        InputPort SI = SI;
    }
    
    Instance level2 Of SOC_DAP_3DLevel {
        InputPort SI = SI;
    }

}

Module SOC_DAP_3DLevel {
    Attribute lic = 'h 8423ef44;
    ScanInPort SI;
    CaptureEnPort CE;
    ShiftEnPort SE;
    UpdateEnPort UE;
    SelectPort SEL;
    ResetPort RST;
    TCKPort TCK;
    ScanOutPort SO {
        Source M1;
    }
    
    OneHotScanGroup M1 {
        Port die1.SO;
        Port die2.SO;
    }
    
    Instance die1 Of CAD {
        InputPort SI = SI;
    }
    
    Instance die2 Of CAD {
        InputPort SI = SI;
    }

}
