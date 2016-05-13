`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/13/2016 04:00:23 PM
// Design Name: 
// Module Name: vic_irq
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module vic_irq(
    inout io_IRQ,
    input [123:0] i_reg,
    input i_clk,
    input i_rst,
    input [30:0] i_ext,
    input i_en,
    output [4:0] o_irq_addr
    );
endmodule
