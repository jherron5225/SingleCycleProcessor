`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: University of Arizona
// Engineer: Jonathan Herron
// 
// Create Date: 11/16/2017 10:23:10 AM
// Design Name: Sources
// Module Name: Mux5BitTo1
// Project Name: Single Cycle Processor
// Target Devices: FPGA Board
// Tool Versions: 
// Description: Converts 5 bit signal to 1 bit
// 
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////



module Mux5Bit2To1(out, inA, inB, sel);

    output reg [4:0] out;
    
    input [4:0] inA;
    input [4:0] inB;
    input sel;
    
    always @(sel, inA, inB) begin
        if (sel == 1) 
            out <= inA;
        if (sel == 0)
            out <= inB;
    end
endmodule
