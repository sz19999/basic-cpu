// top module

module top(clk, Din, run, resetn, done, bus);

wire clear, counter;
wire IRin, IR;
wire [7:0] Rout;
wire DINout, Gout,


counter counter1 (
	.clk(clk),
	.clear(clear),
	.count(counter) 
);

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
	 .Rin(),
	 .Gin(),
	 .Ain(),
	 .alu_op(), 
	 .done(done)
);

mux4x16 mux1 (
	.din(Din),
	.registers_flat({G, R7, R6, ..., R0}),
	.select({Rout, Gout, DINout}),
	.bus(bus)
);


// registers
register IR1 (
	.clk(clk),
	.load(IRin),
	.vecin(Din[8:0]),
	.vecout(IR)
);

register R0 (
	.clk(clk),
	.load(),
	.vecin(),
	.vecout()
);

register R1 (
	.clk(clk),
	.load(),
	.vecin(),
	.vecout()
);

register R2 (
	.clk(clk),
	.load(),
	.vecin(),
	.vecout()
);

register R3 (
	.clk(clk),
	.load(),
	.vecin(),
	.vecout()
);

register R4 (
	.clk(clk),
	.load(),
	.vecin(),
	.vecout()
);

register R5 (
	.clk(clk),
	.load(),
	.vecin(),
	.vecout()
);

register R6 (
	.clk(clk),
	.load(),
	.vecin(),
	.vecout()
);

register R7 (
	.clk(clk),
	.load(),
	.vecin(),
	.vecout()
);


register A (
	.clk(clk),
	.load(),
	.vecin(),
	.vecout()
);

register G (
	.clk(clk),
	.load(),
	.vecin(),
	.vecout()
);

endmodule