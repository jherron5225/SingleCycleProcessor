`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: University of Arizona
// Engineer: Jonathan Herron
// 
// Create Date: 11/16/2017 10:23:10 AM
// Design Name: Sources
// Module Name: datapath
// Project Name: Single Cycle Processor
// Target Devices: FPGA Board
// Tool Versions: 
// Description: Top Module that instatntiates and connects other files
// 
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module datapath(Clk, Reset, WriteData, out7, en_out);
    input Clk, Reset;
    output out7, en_out;
    output [31:0] WriteData;
    
        //--// Add below for post synthesis simulation //--//
    (* mark_debug = "true" *) wire [31:0] debug_Reg8, debug_Reg16, debug_Reg17, debug_Reg18, debug_Reg19;
    
    wire [31:0] WriteDataWire;
    
    //instruction memory
    wire [31:0] instruction;
    
    //controller
    wire RegDst, RegWrite, ALUSrc, MemRead, MemWrite, MemtoReg, PCSrc;
    wire [3:0] ALUOp;
    
    //sign extension
    wire [31:0] rdExtended;
    
    //register
    wire [31:0] ReadData1, ReadData2;
    wire [4:0] WriteRegister;
    
    //ALU
    wire [31:0] ALUResult, dediAddiResult, rdExtShft;
    wire Zero;
    wire Zero2;
    wire Zero3;
   
    
    //ALUMux
    wire [31:0] B;
    
    //data memory 
    wire [31:0] ReadData;
    
    //PC
    wire [31:0] PCResult;
    
    //PCSrcMux
    wire [31:0] PCMuxResult;
    
    //PCAdder
    wire [31:0] PCAddResult;
    
    wire clkout;
    
    assign WriteDataWire = WriteData;
    
    ClkDiv clock(Clk, Reset, clkout);
    TwoDigitDisplay disp(clkout, debug_Reg16, out7, en_out);
    
    ProgramCounter PC(PCMuxResult, PCResult, Reset, Clk); 
    PCAdder add4(PCResult, PCAddResult);
    ALU32Bit dedicatedAdder(4'b0000, PCAddResult, rdExtShft, dediAddiResult, Zero2);
    Mux32Bit2To1 PCSrcMux(PCMuxResult, dediAddiResult, PCAddResult, ALUResult * PCSrc);
    
    InstructionMemory instructions(PCResult, instruction);
    Controller ctrlsigs(instruction[31:26], instruction[5:0], RegDst, RegWrite, ALUSrc, ALUOp, MemRead, MemWrite, MemtoReg, PCSrc);
    
    Mux5Bit2To1 RegDstMux(WriteRegister, instruction[15:11], instruction[20:16], RegDst);
    RegisterFile register(instruction[25:21], instruction[20:16], WriteRegister, WriteDataWire, RegWrite, Clk, ReadData1, ReadData2, debug_Reg8, debug_Reg16, debug_Reg17, debug_Reg18, debug_Reg19);   //reg file
    
    SignExtension extendedRD(instruction[15:0], rdExtended);
    ALU32Bit shiftLeft2(4'b1000, rdExtended, 32'd2, rdExtShft, Zero3);
    Mux32Bit2To1 ALUSrcMux(B, rdExtended, ReadData2, ALUSrc);
    ALU32Bit ALUMain(ALUOp, ReadData1, B, ALUResult, Zero);
    
    DataMemory dataMem(ALUResult, ReadData2, Clk, MemWrite, MemRead, ReadData); 
    
    Mux32Bit2To1 M2Rmux(WriteData, ReadData, ALUResult, MemtoReg); //final mux
    
    
    
    
endmodule
