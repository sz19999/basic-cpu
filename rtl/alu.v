// ALU module

module alu(alu_op, A, bus, G);

parameter word = 16;

input [1:0] alu_op;
input [word-1:0] A, bus;
output [word-1:0] G;

reg [word-1:0] G;

// ALU ops
localparam ALU_NOP = 2'b00;	// no operation
localparam ALU_ADD = 2'b01;	// add
localparam ALU_SUB = 2'b10;   // sub

always @(*) begin
	case(alu_op)
		ALU_ADD:
			G = A + bus;
		ALU_SUB:
			G = A - bus;
		default:
			// NOP is included here
			G = {word{1'b0}};
	endcase
end

endmodule