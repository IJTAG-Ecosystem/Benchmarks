/*
* This file contains code snippets from IEEE Standard 1687-2014 Appendix E
*
* -------------+------------+-------------------------+------------------------
*   Version    |  Date      | Author                  | Organization
* -------------+------------+-------------------------+------------------------
*          1.0 | 8.03.2016  | Anton Tsertov           | Testonica Lab
*--------------+------------+-------------------------+------------------------
*          2.1 | 2.11.2016  | Dmitri Mihhailov        | Testonica Lab
*--------------+------------+-------------------------+------------------------
* 
*/
Module Instrument {
   Attribute lic = 'h ef931832;
	Parameter size = 8;
	DataInPort DI[$size-1:0];
	DataOutPort DO[$size-1:0] {
		Source dr[$size-1:0];
	}
	
	Alias enable = DI[$size-1] {
		RefEnum YesNo;
	}
	Alias mode[3:0] = DI[6:5],DI[3:2] {
		RefEnum Modes;
	}
	Alias data[2:0] = DI[4],DI[1:0];
	Alias okay = DO[0] {
		RefEnum PassFail;
	}
	Alias done = DO[1] {
		RefEnum YesNo;
	}
	Alias count[5:0] = DO[7:2];
	Enum PassFail {
		Pass = 1'b1;
		Fail = 1'b0;
	}
	Enum YesNo {
		Yes = 1'b1;
		No = 1'b0;
	}
	Enum Modes {
		red = 4'b0011;
		blue = 4'b1000;
		green = 4'b0100;
	}
	
	DataRegister dr[$size-1:0] {
		WriteDataSource DI[$size-1:0];
		WriteEnSource enable;
	}
}

Module LoopDIDO {
	Attribute lic = 'h e281323e;
	Parameter width = 1;
	DataInPort DI[$width-1 : 0];
	DataOutPort DO[$width-1 : 0] {
		Source DI [$width-1 : 0];
	}
}

Module SReg {
	Attribute lic = 'h 748d74c9;
	Parameter Size = 7;
	Parameter MSB = $Size-1;
	ScanInPort SI;
	ScanOutPort SO { 
		Source SR[0];
	}
	ShiftEnPort SE;
	CaptureEnPort CE;
	UpdateEnPort UE;
	SelectPort SEL;
	ResetPort RST;
	TCKPort TCK;
	DataInPort DI[$MSB:0];
	DataOutPort DO[$MSB:0] {
		Source SR; 
	}
	ScanInterface scan_client { 
		Port SI; 
		Port SO; 
		Port SEL; 
	}
	ScanRegister SR[$MSB:0] { 
		ScanInSource SI;
		CaptureSource DI;
		ResetValue 'b0; 
	}
}


Module SBit {
	Attribute lic = 'h 18534558;
	Parameter Size = 1;
	Parameter MSB = $Size-1;
	ScanInPort SI;
	ScanOutPort SO { 
		Source SR[0];
	}
	ShiftEnPort SE;
	CaptureEnPort CE;
	UpdateEnPort UE;
	SelectPort SEL;
	ResetPort RST;
	TCKPort TCK;
	DataOutPort DO[$MSB:0] {
		Source SR; 
	}
	ScanInterface scan_client { 
		Port SI; 
		Port SO; 
		Port SEL; 
	}
	ScanRegister SR[$MSB:0] { 
		ScanInSource SI;
		ResetValue 'b0; 
	}
}

Module WrappedInstr {
	Attribute lic = 'h 16a33867;
	Parameter Size = 8;
	ScanInPort SI;
	ShiftEnPort SE;
	CaptureEnPort CE;
	UpdateEnPort UE;
	SelectPort SEL;
	ResetPort RST;
	TCKPort TCK;
	ScanOutPort SO { 
		Source reg8.SO;
	}
	
	ScanInterface scan_client { 
		Port SI; 
		Port SO; 
		Port SEL; 
	}
	Instance I1 Of Instrument { 
		InputPort DI = reg8.DO; 
		Parameter size = $Size;
	}
	Instance reg8 Of SReg {
		InputPort SI = SI; 
		InputPort DI = I1.DO; 
		Parameter Size = $Size;
	}
}

Module WrappedScan {
	Attribute lic = 'h e790dea8;
	Parameter dataWidth = 1;
	ScanInPort SI;
	ShiftEnPort SE;
	CaptureEnPort CE;
	UpdateEnPort UE;
	SelectPort SEL;
	ResetPort RST;
	TCKPort TCK;
	ScanOutPort SO { 
		Source reg.SO;
	}
	
	ScanInterface scan_client { 
		Port SI; 
		Port SO; 
		Port SEL; 
	}
	Instance I1 Of LoopDIDO { 
		InputPort DI = reg.DO;
		Parameter width = $dataWidth;
	}
	Instance reg Of SReg {
		InputPort SI = SI; 
		InputPort DI = I1.DO; 
		Parameter Size = $dataWidth;
	}
}
