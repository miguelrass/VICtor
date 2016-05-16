`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/13/2016 04:36:46 PM
// Design Name: 
// Module Name: vic_registers
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
`define BUFF_WIDTH 32*4 

module vic_registers(
    input i_clk,
    input i_rst,
    input [4:0] i_VIC_regaddr,
    input [3:0] i_VIC_data,
    output [3:0] o_VIC_data,
    input i_VIC_we,
    input i_VIC_re,
    output reg [127:0] buffer// Configuration Registers
    );

    wire [127:0]buffer_store_data;
    
    assign buffer_store_data = ((buffer >> i_VIC_regaddr*4) & 8'h0000000f);    
    assign o_VIC_data = (i_VIC_re) ? buffer_store_data[4:0]  : 4'b0000; // output port assignment 
    
    integer count;
    
    always @(posedge i_clk)
        begin
            if(i_rst) begin
                   for (count = 0; count < 32; count = count + 1)
                    buffer <= 8'h00000000;
            end
            
            if(i_VIC_we && ~i_rst) begin
             buffer <= buffer | (i_VIC_data << i_VIC_regaddr*4);                
            end
        end
    
endmodule