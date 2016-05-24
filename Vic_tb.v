`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/24/2016 09:29:42 AM
// Design Name: 
// Module Name: Vic_tb
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


module Vic_tb;
    reg clk;
    reg rst;
    reg [31:0] i_PC;    
    reg [3:0] i_VIC_data;   
    reg [4:0] i_VIC_regaddr;
    reg i_VIC_we;
    reg [30:0] i_ext;
    reg i_reti;
    reg [3:0] i_CCodes;

    wire [3:0] o_CCodes;
    wire [3:0] o_VIC_data;
    wire [31:0] o_VIC_iaddr;
    wire o_VIC_ctrl;
    Vic vic(
        .clk(clk),
        .rst(rst),
        .i_PC(i_PC),    
        .i_VIC_data(i_VIC_data),   
        .i_VIC_regaddr(i_VIC_regaddr),
        .i_VIC_we(i_VIC_we),
        .i_ext(i_ext),
        .i_reti(i_reti),
        .i_CCodes(i_CCodes),
        .o_CCodes(o_CCodes),
        .o_VIC_data(o_VIC_data),
        .o_VIC_iaddr(o_VIC_iaddr),
        .o_VIC_ctrl(o_VIC_ctrl)
    );
    initial
    begin
            clk=0;
            i_VIC_we=0;
            rst=1;
            i_PC=0;
            i_reti=0;
            i_ext=0;
            i_CCodes=0;
            i_VIC_regaddr=0;
            i_VIC_data=0;
        #10;
            i_PC=i_PC+4;
            rst=0;
        #10
            i_VIC_data = 4'b1100;
            i_VIC_regaddr = 1;
            i_VIC_we = 1;
        #10
            i_VIC_we = 0;
        #10
            i_VIC_data = 4'b1111;
            i_VIC_regaddr = 31;
            i_VIC_we = 1;
        #10
            i_VIC_we = 0;
        #10
            i_ext = 2;
        #10
            i_ext = 1;
        #20
            i_reti = 1;

        #100
        $finish;
    end
    

    always #5 clk=~clk;

endmodule
