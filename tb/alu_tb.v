`timescale 1ns/1ps

module alu_tb;

parameter word = 16;

// ALU ops
localparam ALU_NOP = 2'b00;	// no operation
localparam ALU_ADD = 2'b01;	// add
localparam ALU_SUB = 2'b10;   // sub

reg [1:0] alu_op;
reg [word-1:0] A, bus;
wire [word-1:0] G;

initial begin
	$display("alu_op |  A               |  bus             |  G");
	$monitor(" %b    | %b | %b | %b", alu_op, A, bus, G);
end

// stimulus
initial begin
	#0  alu_op = ALU_ADD; A = 16'b0000_0000_0000_0001; bus = 16'b0000_0000_0000_1110;
	
	#20 alu_op = ALU_NOP; A = 16'b0000_0000_0000_0001; bus = 16'b0000_0000_0000_1110;
	
	#20 alu_op = ALU_SUB; A = 16'b0000_0000_0000_1111; bus = 16'b0000_0000_0000_1110;
	
	#20 alu_op = ALU_SUB; A = 16'b0000_0000_0000_0001; bus = 16'b0000_0000_0000_1110;
	
	#20 $stop();
	
end

// instantiate uut
alu uut(alu_op, A, bus, G);

endmodule