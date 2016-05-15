`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/15/2016 09:28:48 AM
// Design Name: 
// Module Name: vic_irc_tb
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


module vic_irc_tb;
wire o_IRQ;
reg i_IRQ;
reg [123:0] i_reg; //en/fall/rise/level
reg i_clk;
reg i_rst;
reg [30:0] i_ext;
reg i_en;
wire [4:0] o_irq_addr;
wire [30:0] irq_x;

vic_irq vic(
    .i_IRQ(i_IRQ),
    .o_IRQ(o_IRQ),
    .i_reg(i_reg), //en/fall/rise/level
    .i_clk(i_clk),
    .i_rst(i_rst),
    .i_ext(i_ext),
    .i_en(i_en),
    .o_irq_addr(o_irq_addr)
    );
    
initial
begin
i_rst=0;
#10
i_reg=16'b1000_1001_1010_1100;
i_IRQ =0;
#100
$finish; 
end

always #5 i_clk=~i_clk;

endmodule
