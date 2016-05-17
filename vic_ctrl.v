`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: RassIndustries & BL(B�ias Lindo) LDA
// Engineers: Grupo 2/4
// 
// Create Date: 05/13/2016 03:46:15 PM
// Design Name: VICtor Borges
// Module Name: vic
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Vectored Interrupt Controller
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module vic_ctrl(
   input clk,
   input rst,
   input [31:0] i_PC,
   input i_PC_stall,
   input i_reti,
   input [31:0] i_ISR_addr,
   input i_IRQ,
   input [3:0] i_CCodes,
   output reg o_IRQ_PC,
   output reg [31:0] o_VIC_iaddr,
   output reg [3:0] o_VIC_CCodes,
   output reg o_IRQ_VIC,
   output reg o_IRQ_Flush_ctrl 
    );

    reg [31:0]saved_PC; // stores the PC value   
    reg [3:0] saved_CC;
    
    always @(posedge i_IRQ) begin     
        o_IRQ_VIC = 1'b1;    //rises the flag to externalVIC
        o_IRQ_Flush_ctrl = 1'b1;    //sets signal to flush fetch and decode stage     
        o_IRQ_PC = 1'b1;       //signal to fetch?
        
        if(~i_reti) //In case of sequencial interrupts we don't need to resave the program counter
        begin
            saved_PC = i_PC;
            saved_CC = i_CCodes;
        end   
        else        //safety implementation, keeps the saved_PC
        begin
            saved_PC = saved_PC;  
            saved_CC = saved_CC;  
        end
        
        
        o_VIC_iaddr = i_ISR_addr;   //addr of ISR to fetch
    end
    
    always @(posedge clk) begin
    o_IRQ_Flush_ctrl = 1'b0;    //clears signal to flush fetch and decode stage     
    if(~i_PC_stall)
        o_IRQ_PC = 1'b0;     
    end
    
    //When a ISR is finished
    always @(posedge i_reti) begin
        o_VIC_iaddr = saved_PC;
        o_VIC_CCodes = saved_CC;
        o_IRQ_VIC   = 1'b0;
        o_IRQ_PC    = 1'b1;

    end

endmodule
