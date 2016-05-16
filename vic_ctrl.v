`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: RassIndustries & BL(Bóias Lindo) LDA
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
    input i_clk,
    input i_rst,
    input [31:0] i_PC,
    input i_PC_stall,
    input i_reti,
    input [31:0] i_ISR_addr,
    input i_IRQ,
    output reg o_IRQ,
    output reg [31:0] o_VIC_iaddr,
    output reg o_VIC_PC_ctrl  
    );

    reg [31:0]saved_PC; // stores the PC value   
    
    always @(posedge i_IRQ) begin     
        o_IRQ = 1'b1;
        
        //in case of sequencial interrupts we don't need to resave the program counter
        if(~i_reti) begin
            //@(posedge i_clk);
            saved_PC = i_PC;
        end
        
        o_VIC_PC_ctrl = 1'b1;
        o_VIC_iaddr = i_ISR_addr;
    end
    
    always @(posedge i_clk) begin
    if(~i_PC_stall)
        o_VIC_PC_ctrl = 1'b0;     
    end
    
    //When a ISR is finished
    always @(posedge i_reti) begin
        o_VIC_iaddr = saved_PC;
        o_IRQ = 1'b0;
        o_VIC_PC_ctrl = 1'b1;
    end

endmodule
