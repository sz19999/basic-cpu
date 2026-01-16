// control unit
module control_unit(run, resetn, IR, counter, clear, IRin,
						  DINout, Rout, Gout, Rin, Gin, Ain, alu_op, done);
						  
input  run, resetn;
input  [1:0] counter;
input  [8:0] IR;
output [7:0] Rout;
output [7:0] Rin;
output clear, IRin, DINout, Gout, Gin, Ain, done;
output [1:0] alu_op;

reg Ain, Gin, Gout, clear, done, IRin, DINout;
reg [7:0] Rin;
reg [7:0] Rout;
reg [1:0] alu_op;

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

// instruction fields
wire [2:0] opcode, Rx, y;
assign opcode = IR[8:6];
assign     Rx = IR[5:3];
assign      y = IR[2:0];

always @(*) begin
	// defaults outputs
   Rout   = 3'b000;
	Rin    = 8'b0000_0000;
	Ain    = 1'b0;
   Gin    = 1'b0;
	Gout   = 1'b0;
	IRin   = 1'b0;
	DINout = 1'b0;
	clear  = 1'b0;
	done   = 1'b0;
	alu_op = ALU_NOP;
	
	if(run && resetn)
		// fetch
		if (counter == 2'b00)
			IRin   = 1'b1;  // IR  <- Din
			
		// decode + execute	
		else begin
			case(opcode)
				OP_NOP:
					if (counter == 2'b01)
						begin
							clear = 1'b1;
							done  = 1'b1;
						end
				
				OP_MV:
					case(counter)
						2'b01:
							begin
								Rout = y;	 			// Bus <- y (forward to mux for handling)
								Rin  = (8'b1 << Rx);	// Rx  <- Bus
							end
						2'b10:
							begin
								clear = 1'b1;	// reset counter
								done  = 1'b1;	// signal done
							end
					endcase
				
				OP_ADD:
					case(counter)
						2'b01: begin
							Rout = Rx;	 // Bus <- Rx
							Ain  = 1'b1; // A   <- Bus
						end
						2'b10: begin		
							Rout   = y;	 		// Bus <- Ry
							alu_op = ALU_ADD; // A + Bus
							Gin	 = 1'b1;		// G <- A + Bus
						end
						2'b11: begin		
							Gout = 1'b1;			// Bus <- G
							Rin  = (8'b1 << Rx); // select output register
							clear = 1'b1;
							done  = 1'b1;
						end
					endcase
				
				OP_SUB:
					case(counter)
						2'b01: begin
							Rout = Rx;	 // Bus <- Rx
							Ain  = 1'b1; // A   <- Bus
						end
						2'b10: begin		
							Rout   = y;	 		// Bus <- Ry
							alu_op = ALU_SUB; // A - Bus
							Gin	 = 1'b1;		// G <- A - Bus
						end
						2'b11: begin		
							Gout = 1'b1;			// Bus <- G
							Rin  = (8'b1 << Rx); // Rx  <- Bus
							clear = 1'b1;
							done  = 1'b1;
						end
					endcase
				
				OP_MVI:
					case(counter)
						2'b01:
							begin
								DINout = 1'b1;			// Bus <- Din
								Rin  = (8'b1 << Rx); // Rx  <- Bus
							end
						2'b10:
							begin
								clear = 1'b1;
								done  = 1'b1;
							end
					endcase
			endcase
		end
	end

endmodule