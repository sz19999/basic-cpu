// bus multiplexer module

module mux4x16(din, registers, select, bus);
	
parameter word = 16;
parameter k = 9;							// number of registers connected to the mux
	
input  [word-1:0] din;
input  [word*k-1:0] registers;      // registers array: [G, R7, ..., R0]
input  [9:0] select;						// [R7,...,R0, G, din]		
output [word-1:0] bus;

reg [word-1:0] bus;

always @(*) begin
	case (select)
		10'b00_0000_0001: bus = din;          								  // DIN
		10'b00_0000_0010: bus = registers[word*k-1 : word*(k-1)]; 	  // G
		10'b10_0000_0000: bus = registers[word*(k-1)-1 : word*(k-2)]; // R7
      10'b01_0000_0000: bus = registers[word*(k-2)-1 : word*(k-3)]; // R6
      10'b00_1000_0000: bus = registers[word*(k-3)-1 : word*(k-4)]; // R5
      10'b00_0100_0000: bus = registers[word*(k-4)-1 : word*(k-5)]; // R4
      10'b00_0010_0000: bus = registers[word*(k-5)-1 : word*(k-6)]; // R3
      10'b00_0001_0000: bus = registers[word*(k-6)-1 : word*(k-7)]; // R2
      10'b00_0000_1000: bus = registers[word*(k-7)-1 : word*(k-8)]; // R1
      10'b00_0000_0100: bus = registers[word*(k-8)-1 : word*(k-9)]; // R0
      default: bus = {word{1'b0}};	// otherwise clear the bus
	endcase
end
endmodule
