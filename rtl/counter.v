// n-bit counter

module counter(clk, clear, count);

parameter N = 2;

input clk, clear;
output [N-1:0] count;

reg count;

always @(posedge clk, posedge clear)
	if (clear)
		count <= {N{1'b0}};
	else
		count = count + 1;

endmodule