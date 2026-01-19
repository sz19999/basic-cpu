`timescale 1ns/1ps

module control_unit_tb;

reg  run, resetn;
reg  [1:0] counter;
reg  [8:0] IR;
wire [7:0] Rout;
wire [7:0] Rin;
wire clear, IRin, DINout, Gout, Gin, Ain, done;
wire [1:0] alu_op;

// ALU ops
localparam ALU_NOP = 2'b00;	// no operation
localparam ALU_ADD = 2'b01;	// add
localparam ALU_SUB = 2'b10;   // sub

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

// IR: [III YYY XXX] = [opcode destination source]

initial begin
	$display("run | resetn | clear | counter | IR        | opcode | Rx  | Ry  | Rout     | Gout | DINout | Rin      | IRin | Gin | Ain | done | alu_op");
	$monitor(" %b  | %b      | %b     | %b      | %b | %b    | %b | %b | %b | %b    | %b      | %b | %b    | %b   | %b   | %b    | %b", run, resetn,
	clear,counter, IR, IR[8:6], IR[5:3], IR[2:0], Rout, Gout, DINout, Rin, IRin, Gin, Ain, done, alu_op);
end

// stimulus
initial begin
	#0  run = 0; resetn = 1; counter = 0; IR = {OP_MV, R0, R1};	

	// R0 <- R1 (MV)
	#20 run = 1; counter = 0;
	#20 counter = 1;
	#20 counter = 2;
	
	// reset control unit
	#20 resetn = 0; counter = 0;
	
	// R0 <- R1
	#20 resetn = 1;
	#20 counter = 1;
	#20 counter = 2;
	
	// R2 <- Din (MVI)
	#20 counter = 0; IR = {OP_MVI, R2, 3'bxxx};	// [opcode dest source]
	#20 counter = 1;
	#20 counter = 2;
	
	// (NOP)
	#20 counter = 0; IR = {OP_NOP, 6'bxxx};
	#20 counter = 1;
	
	// R3 <- R3 + R4 (ADD)
	#20 counter = 0; IR = {OP_ADD, R3, R4};
	#20 counter = 1;
	#20 counter = 2;
	#20 counter = 3;
	
	// R5 <- R5 - R6 (SUB)
	#20 counter = 0; IR = {OP_ADD, R5, R6};
	#20 counter = 1;
	#20 counter = 2;
	#20 counter = 3;
	
	// R6 <- R6 + R7 (ADD)
	#20 counter = 0; IR = {OP_ADD, R6, R7};
	#20 counter = 1;
	#20 counter = 2;
	#20 counter = 3;
	
	#20 $stop();
end

// instantiate uut
control_unit uut(
	 .run(run),
	 .resetn(resetn),
	 .IR(IR),
	 .counter(counter),
	 .clear(clear),
	 .IRin(IRin),
	 .DINout(DINout),
	 .Rout(Rout),
	 .Gout(Gout),
	 .Rin(Rin),
	 .Gin(Gin),
	 .Ain(Ain),
	 .alu_op(alu_op), 
	 .done(done)
);

endmodule