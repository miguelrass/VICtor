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
    input i_IRQ,
    output reg o_IRQ,
    input [123:0] i_reg, //en/rise/fall/level
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
            irq_x[i] = (i_reg[4*i+3]==1 && i_ext[i] && i_reg[4*i+2])?           1 : 
                       (i_reg[4*i+3]==1 && ~i_ext[i] && i_reg[4*i+1])?          1 : 
                       (i_reg[4*i+3:4*i+1]==3'b100 && i_reg[4*i]==i_ext[i])?    1 : 
                                                                           irq_x[i];
        end 
    end
endgenerate

//No reset as interrupcoes ativas ao nivel sao ignoradas até acontecer uma transicao
//isto acontece porque os perifericos devem ser configurados antes de poderem interromper o CPU
always@(i_rst) begin 
    irq_x <= 31'b0; 
    o_IRQ = 0;
    o_irq_addr = 0;
end 

integer j;

always@(negedge i_IRQ) begin
    if(i_reg[4*o_irq_addr]!=i_ext[o_irq_addr])
        irq_x[o_irq_addr] = 0;
    
    if(irq_x != 0 && i_en == 1) begin
        for (j=30; j>=0; j=j-1 ) begin
            if(irq_x[j])
                o_irq_addr = j;
        end        
        o_IRQ = 1;
        o_IRQ = 0;
    end
end

integer k;

always@(irq_x) begin
    if(i_IRQ == 0 && i_en == 1) begin
        for (k=30; k>=0; k=k-1 ) begin
            if(irq_x[k])
                o_irq_addr = k;
        end
        o_IRQ = 1;
        o_IRQ = 0;
    end
end
 

    
    
endmodule
