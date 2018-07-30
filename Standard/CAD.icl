/*
* Copyright Testonica Lab (C) 2016
*
* History:
* -------------+------------+-------------------------+------------------------
*   Version    |  Date      | Author                  | Organization
* -------------+------------+-------------------------+------------------------
*          1.0 | 18.03.2016  | Anton Tsertov           | Testonica Lab
*--------------+------------+-------------------------+------------------------
*
* This ICL design encompasses the DataRegister and OneHotDataGroup primitives.
* Functionally design emulates the debug port attached to the 4-core processor
* Via Address and Command ports the user can access one of the 16 debug registers 
* for every core as well as a multiple identification registers:
* - Module ID
* - DebugPort ID
* - Core ID
*
*/

Module CAD {
    Attribute lic = 'h f408052b;
	ScanInPort SI;
	CaptureEnPort CE;
	ShiftEnPort SE;
	UpdateEnPort UE;
	SelectPort SEL;
	ResetPort RST;
	TCKPort TCK;
	ScanOutPort SO {
		Source DATA_SR[31];
		Enable dap.VALID;
	}
	
	ScanRegister ADDR_SR [17:0] {
		ScanInSource SI;
		CaptureSource ADDR_SR;
		ResetValue 18'h00000;
	}
	
	ScanRegister CMD_SR [3:0] {
		ScanInSource ADDR_SR;
		CaptureSource CMD_SR;
		ResetValue 4'b0000;
	}
	
	ScanRegister DATA_SR [31:0] {
		ScanInSource CMD_SR;
		CaptureSource dap.DATAOUT_port;
		ResetValue 32'h00000000;
	}
	
	Instance dap Of DAP {
		InputPort CMD_port = CMD_SR;
		InputPort ADDR_port = ADDR_SR[15:0];
		InputPort we = ADDR_SR[17];
		InputPort re = ADDR_SR[16];
	}
}

Module CoreAP {
    Attribute lic = 'h a0097923;
	AddressPort ADDR_port[15:0];
	DataOutPort DATAOUT_port[31:0] {
		Source M_Core;
	}
	ReadEnPort re;
	WriteEnPort we;
	
	Enum Identification {
		CORE_ID = 32'h1E5107CA;
	}
	
	// 16 general purpose and 1 ID register
	OneHotDataGroup M_Core[31:0] {
		DataRegister R_id {
			RefEnum Identification;
			ResetValue CORE_ID;
			AddressValue 'h0000; 
		}
		DataRegister R0 { AddressValue 'h010; }
		DataRegister R1 { AddressValue 'h014; }
		DataRegister R2 { AddressValue 'h018; }
		DataRegister R3 { AddressValue 'h01C; }
		DataRegister R4 { AddressValue 'h020; }
		DataRegister R5 { AddressValue 'h024; }
		DataRegister R6 { AddressValue 'h028; }
		DataRegister R7 { AddressValue 'h02C; }
		DataRegister R8 { AddressValue 'h030; }
		DataRegister R9 { AddressValue 'h034; }
		DataRegister RA { AddressValue 'h038; }
		DataRegister RB { AddressValue 'h03C; }
		DataRegister RC { AddressValue 'h040; }
		DataRegister RD { AddressValue 'h054; }
		DataRegister RE { AddressValue 'h048; }
		DataRegister RF { AddressValue 'h04C; }
	}
}

Module DAP {
    Attribute lic = 'h b77f33;
	DataInPort CMD_port[3:0];
	AddressPort ADDR_port[15:0];
	DataOutPort DATAOUT_port[31:0] {
		Source dataMux;
	}
	
	DataOutPort VALID {
		Source isDataValidSignal; 
	}
	
	ReadEnPort re;
	WriteEnPort we;
	
	DataMux dataMux SelectedBy IdSelectSignal, ReadSignal {
		2'b01 : M1[31:0];
		2'b10 : ID_sys_reg;
	}
	
	LogicSignal isDataValidSignal {
		IdSelectSignal ^ ReadSignal == 1;
	}
	
	LogicSignal IdSelectSignal {
		CMD_reg == 3'b111;
	}
	
	LogicSignal ReadSignal {
		CMD_reg == 3'b000;
	}
	
	DataRegister ID_sys_reg[31:0] {
		RefEnum Identification;
		ResetValue CAD_ID;
		DefaultLoadValue CAD_ID;
	}
	
	DataRegister CMD_reg[2:0] {
		WriteDataSource cmd;
		ResetValue 3'b111;
	}
	
	OneHotDataGroup M1[31:0] {
		DataRegister R_id { 
			RefEnum Identification;
			ResetValue DEBUG_ID;
			AddressValue 'h0000; 
		}
		Instance I1 Of CoreAP { AddressValue 'h1000; }
		Instance I2 Of CoreAP { AddressValue 'h2000; }
		Instance I3 Of CoreAP { AddressValue 'h3000; }
		Instance I4 Of CoreAP { AddressValue 'h4000; }
	}
	
	Alias cmd = CMD_port[2:0] {
		RefEnum Commands;
	}
	Alias cmdEn = CMD_port[3] {
		RefEnum EnDis;
	}
	Enum  Commands {
		read = 3'b000;
		write = 3'b001;
		clear = 3'b010;
		set = 3'b011;
		or_bitw = 3'b100;
		and_bitw = 3'b101;
		xor_bitw = 3'b110;
		id = 3'b111;
	}
	
	Enum EnDis {
		EnableHigh = 1'b1;
		DisableLow = 1'b0;
	}
	
	Enum Identification {
		CAD_ID = 32'hBEEF51EA;
		DEBUG_ID = 32'hBADDEBCA;
	}
}
