`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Engineer: Jonathan Herron

// Module - register_file.v
// Description - Implements a register file with 32 32-Bit wide registers.
//                          (a 32x32 regsiter file with two read ports and one write port)
// INPUTS:-
// ReadRegister1: 5-Bit address to select a register to be read through 32-Bit 
//                output port 'ReadRegister1'.
// ReadRegister2: 5-Bit address to select a register to be read through 32-Bit 
//                output port 'ReadRegister2'.
// WriteRegister: 5-Bit address to select a register to be written through 32-Bit
//                input port 'WriteRegister'.
// WriteData: 32-Bit write input port.
// RegWrite: 1-Bit control input signal.
//
// OUTPUTS:-
// ReadData1: 32-Bit registered output. 
// ReadData2: 32-Bit registered output. 
//
// FUNCTIONALITY:-
// 'ReadRegister1' and 'ReadRegister2' are two 5-bit addresses to read two 
// registers simultaneously. The two 32-bit data sets are available on ports 
// 'ReadData1' and 'ReadData2', respectively. 'ReadData1' and 'ReadData2' are 
// registered outputs (output of register file is written into these registers 
// at the falling edge of the clock). You can view it as if outputs of registers
// specified by ReadRegister1 and ReadRegister2 are written into output 
// registers ReadData1 and ReadData2 at the falling edge of the clock. 
//
// 'RegWrite' signal is high during the rising edge of the clock if the input 
// data is to be written into the register file. The contents of the register 
// specified by address 'WriteRegister' in the register file are modified at the 
// rising edge of the clock if 'RegWrite' signal is high. The D-flip flops in 
// the register file are positive-edge (rising-edge) triggered. (You have to use 
// this information to generate the write-clock properly.) 
//
// NOTE:-
// We will design the register file such that the contents of registers do not 
// change for a pre-specified time before the falling edge of the clock arrives 
// to allow for data multiplexing and setup time.
////////////////////////////////////////////////////////////////////////////////

module RegisterFile(ReadRegister1, ReadRegister2, WriteRegister, WriteData, RegWrite, Clk, ReadData1, ReadData2, debug_Reg8, debug_Reg16, debug_Reg17, debug_Reg18, debug_Reg19);

    input [4:0] ReadRegister1;
    input [4:0] ReadRegister2;
    input [4:0] WriteRegister;
    input [31:0] WriteData;
    input RegWrite, Clk;
    output reg [31:0] ReadData1, ReadData2;
    //reg [31:0] memory [0:31];
    
    reg [4:0] index;
    
    //--// below is for post-synthesis simulation //--//
    
    output [31:0] debug_Reg8, debug_Reg16, debug_Reg17,    
    debug_Reg18, debug_Reg19;
    
    (* mark_debug = "true" *) reg [31:0] memory [0:31];

    
    initial begin
        memory[0] <= 0;
        memory[1] <= 0;
        memory[2] <= 0;
        memory[3] <= 0;
        memory[4] <= 0;
        memory[5] <= 0;
        memory[6] <= 0;
        memory[7] <= 0;
        memory[8] <= 0;
        memory[9] <= 0;
        memory[10] <= 0;
        memory[11] <= 0;
        memory[12] <= 0;
        memory[13] <= 0;
        memory[14] <= 0;
        memory[15] <= 0;
        memory[16] <= 0;
        memory[17] <= 0;
        memory[18] <= 0;
        memory[19] <= 0;
        memory[20] <= 0;
        memory[21] <= 0;
        memory[22] <= 0;
        memory[23] <= 0;
        memory[24] <= 0;
        memory[25] <= 0;
        memory[26] <= 0;
        memory[27] <= 0;
        memory[28] <= 0;
        memory[29] <= 0;
        memory[30] <= 0;
        memory[31] <= 0;
        
    end

    always @(negedge Clk) begin
        ReadData1 <= memory[ReadRegister1];
        ReadData2 <= memory[ReadRegister2];
    end
    
    always @(posedge Clk) begin
        if (RegWrite == 1) begin
            memory[WriteRegister] <= WriteData;
        end
    end
    
    //below is for post-synthesis simulation
    assign debug_Reg8 = memory[8];
    assign debug_Reg16 = memory[16];
    assign debug_Reg17 = memory[17];
    assign debug_Reg18 = memory[18];
    assign debug_Reg19 = memory[19];

endmodule
