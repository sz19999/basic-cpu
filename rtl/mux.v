// bus multiplexer module

module mux(din, registers, select, bus);
	
parameter word = 16;
parameter k = 9;	// number of registers connected to the mux
	
input [word-1:0] din;
input [word-1:0] registers [k-1:0];	// vector of regs -> vecreg = [R0, R1, ... R7, G]
input [3:0] select;	// select = [R0...R7 (3-bit), din(1-bit)]		
output [word-1:0] bus;

reg [word-1:0] bus;

always @(*)
	case(select)
		4'b0000:	bus = registers[0];	// bus <- R0
		4'b0001:	bus = registers[1];	// R1
		4'b0010:	bus = registers[2];	// R2
		4'b0011:	bus = registers[3];  // R3
		4'b0100:	bus = registers[4];  // R4
		4'b0101:	bus = registers[5];  // R5
		4'b0110:	bus = registers[6];  // R6
		4'b0111:	bus = registers[7];  // R7
		4'b1000:	bus = registers[8];  // G
		4'b1001: bus = din;				// din
		default: bus = {word{1'b0}};	// otherwise clear bus
	endcase
endmodule
