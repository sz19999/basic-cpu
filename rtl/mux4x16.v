// bus multiplexer module

module mux4x16(din, registers_flat, select, bus);
	
parameter word = 16;
parameter k = 9;							// number of registers connected to the mux
	
input  [word-1:0] din;
input  [word*k-1:0] registers_flat; // flattened array: [G, R7, ..., R0]
input  [9:0] select;						// [R7,...,R0, G, din]		
output [word-1:0] bus;

reg [word-1:0] bus;
reg [word-1:0] registers [0:k-1]; 	// internal array [R0, ..., R7, G]
integer i;

always @(*) begin
	// unpack flattened input into array
   for (i = 0; i < k; i = i + 1)
		registers[i] = registers_flat[i*word +: word]; // vector[start +: width] = vector[start + width -1 : start]
	
	case (select)
		10'b00_0000_0100: bus = registers[0]; 		// R0
      10'b00_0000_1000: bus = registers[1]; 		// R1
      10'b00_0001_0000: bus = registers[2]; 		// R2
      10'b00_0010_0000: bus = registers[3]; 		// R3
      10'b00_0100_0000: bus = registers[4]; 		// R4
      10'b00_1000_0000: bus = registers[5]; 		// R5
      10'b01_0000_0000: bus = registers[6]; 		// R6
      10'b10_0000_0000: bus = registers[7]; 		// R7
      10'b00_0000_0010: bus = registers[8]; 		// G
      10'b00_0000_0001: bus = din;          		// DIN
      default: bus = {word{1'b0}};	// otherwise clear the bus
	endcase
end
endmodule
