// register module

module reg16(clk, load, vecin, vecout);

input clk, load;
input [15:0] vecin;
output [15:0] vecout;

reg [15:0] vecout;

always @(posedge clk)
	if (load)
		vecout <= vecin;

endmodule