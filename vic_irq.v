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
    //output o_pending, //outra interrupcao alem da atual
    output reg [4:0] o_irq_addr //num. interr atual
    );
    
reg  [30:0] irq_x;
    
genvar i;

generate //verificar a necessidade de generate
    for (i=0; i<31; i=i+1 ) begin
        always@(i_ext[i]) begin 
            irq_x[i] = (irq_x[i] && i_reg[4*i+2])?                        1 : 
                       (~irq_x[i] && i_reg[4*i+1])?                        1 : 
                       (i_reg[4*i+2:4*i+1]==0 && i_reg[4*i+3]==irq_x[i])?  1 : 
                                                                           irq_x[i];
        end 
    end
endgenerate

always@(rst) begin 
    irq_x <= 31'b0; 
    //ver mais registos pa fazer reset
end 

integer j;

always@(negedge io_IRQ) begin
    irq_x[o_irq_addr] = 0;
    
    if(irq_x != 0 && i_en == 1) begin
        for (j=30; j>=0; j=j-1 ) begin
            if(irq_x[j])
                o_irq_addr = j;
        end        
        io_IRQ = 1;
    end
end

always@(irq_x) begin
    if(io_IRQ == 0 && i_en == 1) begin
        for (j=30; j>=0; j=j-1 ) begin
            if(irq_x[j])
                o_irq_addr = j;
        end
        io_IRQ = 1;
    end
end
 

    
    
endmodule
