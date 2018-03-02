`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Engineer - Jonathan Herron
// 
// Module - Mux32Bit2To1.v
// Description - Use the sel input signal to choose which 32-bit inputs should be at the output
//              - sel = 1, out = inA
//              - sel = 0, out = inB
////////////////////////////////////////////////////////////////////////////////

module Mux32Bit2To1(out, inA, inB, sel);

    output reg [31:0] out;
    
    input [31:0] inA;
    input [31:0] inB;
    input sel;
    
    always @(sel, inA, inB) begin
        if (sel == 1) 
            out <= inA;
        if (sel == 0)
            out <= inB;
    end

endmodule
