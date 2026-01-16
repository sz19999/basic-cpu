
`timescale 1ns/1ps

module reg16_tb;

reg clk, load;
reg [15:0] vecin;
wire [15:0] vecout;

// setup clock 20ns
initial begin
	clk = 1'b0;
	forever
	#10 clk = ~clk;
end

initial begin
	$display("clk | load |      vecin          |     vecout");
	$monitor(" %b  |   %b  |   %b  |  %b", clk, load, vecin, vecout);
end

// stimulus
initial begin
	#0 vecin = 16'b0000_0000_0000_1111;
		load = 1'b0;
	
	#20 vecin = 16'b0000_0000_0000_1111;
		 load = 1'b1;
	
	#20 vecin = 16'b0000_0000_0000_0000;
	    load = 1'b1;
	
	#20 vecin = 16'b0000_0000_0000_1111;
	    load = 1'b0;
	
	#20 $stop();
end

// uut instantation
reg16 uut(clk, load, vecin, vecout);

endmodule