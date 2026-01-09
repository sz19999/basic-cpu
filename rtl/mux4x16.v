// bus multiplexer module

module mux4x16(din, registers_flat, select, bus);
	
parameter word = 16;
parameter k = 9;							// number of registers connected to the mux
	
input  [word-1:0] din;
input  [word*k-1:0] registers_flat; // flattened array: [G, R7, ..., R0]
input  [3:0] select;						// [R7-R0, G, din]		
output [word-1:0] bus;

reg [word-1:0] bus;
reg [word-1:0] registers [0:k-1]; 	// internal array [R0, ..., R7, G]
integer i;

always @(*) begin
	// unpack flattened input into array
   for (i = 0; i < k; i = i + 1)
		registers[i] = registers_flat[i*word +: word]; // vector[start +: width] = vector[start + width -1 : start]
	
	case (select)
		4'd0: bus = registers[0]; 		// R0
      4'd1: bus = registers[1]; 		// R1
      4'd2: bus = registers[2]; 		// R2
      4'd3: bus = registers[3]; 		// R3
      4'd4: bus = registers[4]; 		// R4
      4'd5: bus = registers[5]; 		// R5
      4'd6: bus = registers[6]; 		// R6
      4'd7: bus = registers[7]; 		// R7
      4'd8: bus = registers[8]; 		// G
      4'd9: bus = din;          		// DIN
      default: bus = {word{1'b0}};	// otherwise clear the bus
	endcase
end
endmodule
