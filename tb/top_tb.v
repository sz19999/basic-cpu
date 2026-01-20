`timescale 1ns/1ps

module top_tb;

parameter word = 16;
parameter r = 8;

reg [word-1:0] Din;
reg clk, run, resetn;
wire done;
wire [word*r-1:0] registers;	// [R7, ..., R0]
wire [word-1:0] bus_out;
wire [1:0] counter_out;

// OP codes
localparam OP_NOP = 3'b000;
localparam OP_MV  = 3'b001;
localparam OP_ADD = 3'b010;
localparam OP_SUB = 3'b011;
localparam OP_MVI = 3'b100;

// operands
localparam R0 = 3'b000;
localparam R1 = 3'b001;
localparam R2 = 3'b010;
localparam R3 = 3'b011;
localparam R4 = 3'b100;
localparam R5 = 3'b101;
localparam R6 = 3'b110;
localparam R7 = 3'b111;
 
// setup clock 20ns
initial begin
	clk = 1'b0;
	forever
	#10 clk = ~clk;
end

initial begin
	$display("clk | run | resetn | done | Din              | bus              | R7               | R6               | R5               | R4               | R3               | R2               | R1               | R0               | counter");
	$monitor(" %b  | %b   | %b      | %b    | %b | %b | %b | %b | %b | %b | %b | %b | %b | %b | %b", clk, run, resetn, 
	done, Din, bus_out, 
	registers[word*r-1:word*(r-1)], registers[word*(r-1)-1:word*(r-2)], registers[word*(r-2)-1:word*(r-3)],
	registers[word*(r-3)-1:word*(r-4)], registers[word*(r-4)-1:word*(r-5)], registers[word*(r-5)-1:word*(r-6)], 
	registers[word*(r-6)-1:word*(r-7)], registers[word*(r-7)-1:word*(r-8)], counter_out);
end

// stimulus
initial begin
	#0  run = 0; resetn = 0; // reset system
	
	// mvi R0, $6;
	@(posedge clk);					  // t0 - fetch
	run = 1; resetn = 1; 			  // start
	Din = {7'b0 ,OP_MVI, R0, 3'b0}; // IR = [III XXX YYY] = [opcode destination source]
	@(posedge clk);					  // t1
	Din = 6; 							  
	@(posedge clk);					  // t2 - done
	
	// mvi R1, $1
	@(posedge clk);	// t0
	Din = {7'b0 ,OP_MVI, R1, 3'b0};
	@(posedge clk);	// t1
	Din = 1;
	@(posedge clk);	// t2
	
	// add R1, R0 : R1 <- R1 + R0
	@(posedge clk); // t0
	Din = {7'b0 ,OP_ADD, R1, R0};
	@(posedge clk); // t1
	@(posedge clk); // t2
	@(posedge clk); // t3 - done (the output register is updated on the next cycle)
	
	// mv R2, R1 : R2 <- R1
	@(posedge clk); // t0
	Din = {7'b0 ,OP_MV, R2, R1};
	@(posedge clk); // t1
	@(posedge clk); // t2 - done
	
	// mvi R3, $15
	@(posedge clk);	// t0
	Din = {7'b0 ,OP_MVI, R3, 3'b0};
	@(posedge clk);	// t1
	Din = 15;
	@(posedge clk);	// t2
	
	// sub R3, R0 : R3 <- R3 - R0
	@(posedge clk); // t0
	Din = {7'b0 ,OP_SUB, R3, R0};
	@(posedge clk); // t1
	@(posedge clk); // t2
	@(posedge clk); // t3 - done (the output register is updated on the next cycle)

	// mv R4, R0
	@(posedge clk); // t0
	Din = {7'b0 ,OP_MV, R4, R0};
	@(posedge clk); // t1
	@(posedge clk); // t2 - done
	
	// sub R4, R1
	@(posedge clk); // t0
	Din = {7'b0 ,OP_SUB, R4, R1};
	@(posedge clk); // t1
	@(posedge clk); // t2
	@(posedge clk); // t3 - done (the output register is updated on the next cycle)
	
	// mvi R5, $5
	@(posedge clk);	// t0
	Din = {7'b0 ,OP_MVI, R5, 3'b0};
	@(posedge clk);	// t1
	Din = 5;
	@(posedge clk);	// t2 - done
	
	// mvi R6, $3
	@(posedge clk);	// t0
	Din = {7'b0 ,OP_MVI, R6, 3'b0};
	@(posedge clk);	// t1
	Din = 3;
	@(posedge clk);	// t2 - done
	
	// add R6, R5
	@(posedge clk); // t0
	Din = {7'b0 ,OP_ADD, R6, R5};
	@(posedge clk); // t1
	@(posedge clk); // t2
	@(posedge clk); // t3 - done
	
	// nop
	@(posedge clk); // t0
	Din = {7'b0 ,OP_NOP, 6'b0};
	@(posedge clk); // t1 - done
	
	// mv R7, R6
	@(posedge clk); // t0
	Din = {7'b0 ,OP_MV, R7, R6};
	@(posedge clk); // t1
	@(posedge clk); // t2 - done
	
	@(posedge clk); 
	$stop();
	
end

// instantiate uut
top uut(clk, Din, run, resetn, done, bus_out, registers, counter_out);

endmodule 