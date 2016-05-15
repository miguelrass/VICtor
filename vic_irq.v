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
    input [123:0] i_reg, //en/fall/rise/level
    input i_clk,
    input i_rst,
    input [30:0] i_ext,
    input i_en,
    output [4:0] o_irq_addr,
    output reg  [30:0] irq_x //meter isto fora daqui
    );
    
//reg  [30:0] irq_x;
    
genvar i;

generate //verificar a necessidade de generate
    for (i=0; i<31; i=i+1 ) begin
        always@(i_ext[i]) begin 
            irq_x[i] <= (irq_x[i] && i_reg[4*i+2])?                         1 : 
                       (~irq_x[i] && i_reg[4*i+1])?                        1 : 
                       (i_reg[4*i+2:4*i+1]==0 && i_reg[4*i+3]==irq_x[i])?  1 : 
                                                                            irq_x[i];
        end 
    end
endgenerate

always@(negedge rst) begin 
    irq_x <= 31'b0; 
    //ver mais registos pa fazer reset
end 
 

    
    
endmodule
