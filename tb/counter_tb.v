`timescale 1ns/1ps

module counter_tb;

parameter N = 2;

reg clk, clear;
wire [N-1:0] count;

// setup clock 20ns
initial begin
	clk = 1'b0;
	forever
	#10 clk = ~clk;
end

initial begin
	$display("clk | count");
	$monitor(" %b  |   %b", clk, count);
end

// stimulus
initial begin
	#0  clear = 1'b1;
	
	#20 clear = 1'b1;
	
	#20 clear = 1'b0;
	
	#80 $stop();
end

// uut instantation
counter uut(clk, clear, count);

endmodule