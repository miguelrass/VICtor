`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: RassIndustries
// Engineer: Grupo 2/4
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


module vic(
    input i_clk,
    input i_rst,
    inout io_IRQ,
    input [31:0] i_PC,
    output [31:0] o_VIC_iaddr,
    output o_VIC_PC_ctrl,
    input [3:0] i_VIC_data,
    input [4:0] i_VIC_regaddr,
    input i_VIC_we,
    input [30:0] i_ext
    );
endmodule
