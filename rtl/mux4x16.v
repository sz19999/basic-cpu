// bus multiplexer module

module mux4x16(din, registers_flat, select, bus);
	
parameter word = 16;
parameter k = 9;	// number of registers connected to the mux
	
input  [word-1:0] din;
input  [word*k-1:0] registers_flat; // flattened array: [G, R7, ..., R0]
input  [3:0] select;	// [R7-R0, G, din]		
output [word-1:0] bus;

reg [word-1:0] bus;
reg [word-1:0] registers [0:k-1]; // internal array [R0, ..., R7, G]
integer i;

always @(*) begin
	// unpack flattened input into array
   for (i = 0; i < k; i = i + 1)
		registers[i] = registers_flat[i*word +: word]; // vector[start +: width] = vector[start + width -1 : start]
	
	// select
		if (select < k)					// k = 0...8 -> R0...R7,G
			bus = registers[select];
		else if (select == k)
			bus = din;
		else
			bus = {word{1'b0}};			// otherwise clear bus
	end
endmodule
