// top module

module top(clk, Din, run, resetn, done);

parameter word = 16;

input [word-1:0] Din;
input clk, run, resetn;
output done;

wire clear;
wire IRin, Ain, Gin;
wire DINout, Gout;
wire [7:0] Rout, Rin;
wire [word-1:0] bus ,R_0, R_1, R_2, R_3, R_4, R_5, R_6, R_7, G_to_mux, alu_to_G, A_to_alu;
wire [8:0] IR;
wire [1:0] alu_op;
wire [1:0] counter;

// counter
counter counter1 (
	.clk(clk),
	.clear(clear),
	.count(counter) 
);

// control unit
control_unit control_unit1 (
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

// mux
mux4x16 mux1 (
	.din(Din),
	.registers_flat({G_to_mux, R_7, R_6, R_5, R_4, R_3, R_2, R_1, R_0}),
	.select({Rout, Gout, DINout}),
	.bus(bus)
);

// ALU
alu alu1 (
	.alu_op(alu_op),
	.A(A_to_alu),
	.bus(bus),
	.G(alu_to_G)
);

// registers
reg16 IR1 (
	.clk(clk),
	.load(IRin),
	.vecin(Din[8:0]),
	.vecout(IR)
);

reg16 R0 (
	.clk(clk),
	.load(Rin[0]),
	.vecin(bus),
	.vecout(R_0)
);

reg16 R1 (
	.clk(clk),
	.load(Rin[1]),
	.vecin(bus),
	.vecout(R_1)
);

reg16 R2 (
	.clk(clk),
	.load(Rin[2]),
	.vecin(bus),
	.vecout(R_2)
);

reg16 R3 (
	.clk(clk),
	.load(Rin[3]),
	.vecin(bus),
	.vecout(R_3)
);

reg16 R4 (
	.clk(clk),
	.load(Rin[4]),
	.vecin(bus),
	.vecout(R_4)
);

reg16 R5 (
	.clk(clk),
	.load(Rin[5]),
	.vecin(bus),
	.vecout(R_5)
);

reg16 R6 (
	.clk(clk),
	.load(Rin[6]),
	.vecin(bus),
	.vecout(R_6)
);

reg16 R7 (
	.clk(clk),
	.load(Rin[7]),
	.vecin(bus),
	.vecout(R_7)
);


reg16 A (
	.clk(clk),
	.load(Ain),
	.vecin(bus),
	.vecout(A_to_alu)
);

reg16 G (
	.clk(clk),
	.load(Gin),
	.vecin(alu_to_G),
	.vecout(G_to_mux)
);

endmodule