`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: University of Arizona
// Engineer: Jonathan Herron
// 
// Create Date: 11/16/2017 10:23:10 AM
// Design Name: Sources
// Module Name: Controller
// Project Name: Single Cycle Processor
// Target Devices: FPGA Board
// Tool Versions: 
// Description: Performs desired operations on memory
// 
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Controller(op, func, RegDst, RegWrite, ALUSrc, ALUOp, MemRead, MemWrite, MemtoReg, PCSrc);

    input [5:0] op;
    input [5:0] func;
    
    output reg RegDst, RegWrite, ALUSrc, MemRead, MemWrite, MemtoReg, PCSrc;
    output reg [3:0] ALUOp;
    
    
    always @(*) begin
        case(op)
            6'b000000: begin
                ALUSrc <= 0;
                RegDst <= 1;
                RegWrite <= 1;
                MemRead <= 0;
                MemWrite <= 0;
                MemtoReg <= 0;
                PCSrc <= 0;
                if (func == 6'b100000) ALUOp <= 4'b0000;
                if (func == 6'b100010) ALUOp <= 4'b0001;
                if (func == 6'b100100) ALUOp <= 4'b0011;
                if (func == 6'b100101) ALUOp <= 4'b0100;
                if (func == 6'b101010) ALUOp <= 4'b0101;
                if (func == 6'b000000) ALUOp <= 4'b1000;
                if (func == 6'b000010) ALUOp <= 4'b1001;
                if (func == 6'b000110) ALUOp <= 4'b1010;
            end
            6'b011100: begin        //clo, clz, mul
                ALUSrc <= 0;
                RegDst <= 1;
                RegWrite <= 1;
                MemRead <= 0;
                MemWrite <= 0;
                MemtoReg <= 0;
                PCSrc <= 0;
                if (func == 6'b100001) ALUOp <= 4'b1011;
                if (func == 6'b100000) ALUOp <= 4'b1100;
                if (func == 6'b000010) ALUOp <= 4'b0010;
            end            
            6'b001000: begin    //addi
                ALUSrc <= 1;
                RegDst <= 0;
                RegWrite <= 1;
                MemRead <= 0;
                MemWrite <= 0;
                MemtoReg <= 0;
                PCSrc <= 0;
                ALUOp <= 4'b0000;
            end
            6'b001101: begin    //ori
                ALUSrc <= 1;
                RegDst <= 0;
                RegWrite <= 1;
                MemRead <= 0;
                MemWrite <= 0;
                MemtoReg <= 0;
                PCSrc <= 0;
                ALUOp <= 4'b0100;
            end
            6'b100011: begin //lw
                ALUSrc <= 1;
                RegDst <= 0;
                RegWrite <= 1;
                MemRead <= 1;
                MemWrite <= 0;
                MemtoReg <= 1;
                PCSrc <= 0;
                ALUOp <= 4'b0000;
            end
            6'b101011: begin //sw
                ALUSrc <= 1;
                RegDst <= 0;
                RegWrite <= 0;
                MemRead <= 0;
                MemWrite <= 1;
                MemtoReg <= 0;
                PCSrc <= 0;
                ALUOp <= 4'b0000;
            end
            6'b000101: begin //bne
                ALUSrc <= 0;
                RegDst <= 0;
                RegWrite <= 0;
                MemRead <= 0;
                MemWrite <= 0;
                MemtoReg <= 0;
                PCSrc <= 1;
                ALUOp <= 4'b0111;
            end
        endcase  
    end   
endmodule
