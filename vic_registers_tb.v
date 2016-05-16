`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/13/2016 05:35:09 PM
// Design Name: 
// Module Name: vic_registers_tb
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


module vic_registers_tb(

    );
    
    reg Clk;
    reg Rst;
    reg [4:0]index;
    reg [3:0]i_data;
    wire [3:0]o_data;
    reg we;
    reg re;
    wire [127:0] buffer;
    
    
    vic_registers vr(       
        .i_clk(Clk),
        .i_rst(Rst),
        .i_VIC_regaddr(index),
        .i_VIC_data(i_data),
        .o_VIC_data(o_data),
        .i_VIC_we(we),
        .i_VIC_re(re),
        .buffer(buffer)
    );
    
    integer i;
    
    initial begin
        we = 1'b0;
        Clk=0;
        Rst=0;
        #5
        Rst=1;
        #10
        Rst = 0;
        
        for (i = 0 ; i < 32 ; i = i + 1)
            begin    
                index = i;
                re = 1'b0;
                i_data = $random;
                #10
                we = 1'b1;
                #10
                we = 1'b0;
                re = 1'b1;
                #10;
            end
                     
        #1000
        $finish;
        
    end
        
       always #5 Clk=~Clk;
    
endmodule
