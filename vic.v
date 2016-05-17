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


module Vic(
    input clk,
    input rst,
    input [31:0] i_PC,
    output [31:0] o_VIC_iaddr,
    output o_VIC_PC_ctrl,
    input [3:0] i_VIC_data,
    output [3:0] o_VIC_data,
    input [4:0] i_VIC_regaddr,
    input i_VIC_we,
    input [30:0] i_ext,
    input i_reti,
    input i_PC_stall,
    input [3:0] i_CCodes,
    output o_IRQ_Flush_ctrl 
    );
  
    vic_ctrl vcu (
       .clk(clk),
       .rst(rst),
       .i_PC(i_PC),
       .o_IRQ_VIC(),
       .i_IRQ(),
       .i_reti(i_reti),
       .i_PC_stall(i_PC_stall),
       .i_ISR_addr(),
       .o_VIC_iaddr(o_VIC_iaddr),
       .o_IRQ_PC(o_VIC_PC_ctrl),
       .i_CCodes(i_CCodes),
       .o_IRQ_Flush_ctrl(o_IRQ_Flush_ctrl)
    );

    vic_registers vr (
       .clk(clk),
       .rst(rst),
       .i_VIC_regaddr(i_VIC_regaddr),
       .i_VIC_data(i_VIC_data),
       .o_VIC_data(o_VIC_data),
       .i_VIC_we(i_VIC_we),
       .o_buffer()
    );
    
        
endmodule
