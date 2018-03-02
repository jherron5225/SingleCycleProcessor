`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Engineer - Jonathan Herron
// 
// Module - InstructionMemory.v
// Description - 32-Bit wide instruction memory.
//
// INPUT:-
// Address: 32-Bit address input port.
//
// OUTPUT:-
// Instruction: 32-Bit output port.
//
// FUNCTIONALITY:-
// Similar to the DataMemory, this module should also be byte-addressed
// (i.e., ignore bits 0 and 1 of 'Address'). All of the instructions will be 
// hard-coded into the instruction memory, so there is no need to write to the 
// InstructionMemory.  The contents of the InstructionMemory is the machine 
// language program to be run on your processor.
//
//
//we will store the machine code for a C function later. for now initialize 
//each entry to be its index * 4 (memory[i] = i * 4;)
//all you need to do is give an address as input and read the contents of the 
//address on your output port. 
// 
//Using a 32bit address you will index into the memory, output the contents of that specific 
//address. for data memory we are using 1K word of storage space. for the instruction memory 
//you may assume smaller size for practical purpose. you can use 128 words as the size and 
//hardcode the values.  in this case you need 7 bits to index into the memory. 
//
//be careful with the least two significant bits of the 32bit address. those help us index 
//into one of the 4 bytes in a word. therefore you will need to use bit [8-2] of the input address. 


////////////////////////////////////////////////////////////////////////////////

module InstructionMemory(Address, Instruction); 

    input [31:0] Address;        // Input Address 

    output reg [31:0] Instruction;    // Instruction at memory location Address
    
   //Create 2D array for memory with 128 32-bit elements here
        reg [31:0] memory [0:127];
        
        initial begin                   //need to iniitalize this for the code!!!
            memory[0] = 32'h34040000;	//	main:		ori	$a0, $zero, 0
            memory[1] = 32'h34050100;    //            ori    $a1, $zero, 256
            memory[2] = 32'h20110000;    //            addi    $s1, $zero, 0
            memory[3] = 32'h20120001;    //            addi    $s2, $zero, 1
            memory[4] = 32'h20080000;    //            addi    $t0, $zero, 0
            memory[5] = 32'h8ca50000;    //            lw    $a1, 0($a1)
            memory[6] = 32'h20080004;    //            addi    $t0, $zero, 4
            memory[7] = 32'h20100000;    //            addi    $s0, $zero, 0
            memory[8] = 32'h70a82802;    //            mul    $a1, $a1, $t0
            memory[9] = 32'h20a5fffc;    //            addi    $a1, $a1, -4
            memory[10] = 32'h00b08822;    //    outerloop:    sub    $s1, $a1, $s0
            memory[11] = 32'h20080000;    //            addi    $t0, $zero, 0
            memory[12] = 32'h01044820;    //    innerloop:    add    $t1, $t0, $a0
            memory[13] = 32'h8d2a0000;    //            lw    $t2, 0($t1)
            memory[14] = 32'h21290004;    //            addi    $t1, $t1, 4
            memory[15] = 32'h8d2b0000;    //            lw    $t3, 0($t1)
            memory[16] = 32'h016a602a;    //            slt    $t4, $t3, $t2
            memory[17] = 32'h15920003;    //            bne    $t4, $s2, noswap
            memory[18] = 32'had2a0000;    //            sw    $t2, 0($t1)
            memory[19] = 32'h2129fffc;    //            addi    $t1, $t1, -4
            memory[20] = 32'had2b0000;    //            sw    $t3, 0($t1)
            memory[21] = 32'h21080004;    //    noswap:        addi    $t0, $t0, 4
            memory[22] = 32'h0111602a;    //            slt    $t4, $t0, $s1
            memory[23] = 32'h1580fff4;    //            bne    $t4, $zero, innerloop
            memory[24] = 32'h22100004;    //            addi    $s0, $s0, 4
            memory[25] = 32'h0205602a;    //            slt    $t4, $s0, $a1
            memory[26] = 32'h1580ffef;    //            bne    $t4, $zero, outerloop
            memory[27] = 32'h20080000;    //            addi    $t0, $zero, 0
            memory[28] = 32'h20a50004;    //            addi    $a1, $a1, 4
            memory[29] = 32'h00808820;    //            add    $s1, $a0, $zero
            memory[30] = 32'h8e300000;    //    read_data:    lw    $s0, 0($s1)
            memory[31] = 32'h22310004;    //            addi    $s1, $s1, 4
            memory[32] = 32'h21080004;    //            addi    $t0, $t0, 4
            memory[33] = 32'h1505fffc;    //            bne    $t0, $a1, read_data
            memory[34] = 32'h1412ffff;    //    here:        bne    $zero, $s2, here
        end
        
        always @ * begin
            Instruction <= memory[Address[8:2]];    
        end
        
        
    endmodule
