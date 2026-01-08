// control unit

module control-unit(run, resetn, IR, counter, clear, IRin,
						  DINout, Rout, Gout, Rin, Gin, Ain, AddSub, done);
						  
input run, resetn;
output [0:8] IR;
output [0:1] counter;
output [0:7] Rout, Rin;
output clear, IRin, DINout, Gout, Gin, Ain, done, AddSub;


always @(*)
	case(IR[9:7])
		3'b001: // mv 
	   3'b010: begin 				// mvi
			case(counter)
				0'b00: 
			endcase
			end
		3'b011: AddSub = 0'b0 // add
		3'b100: AddSub = 0'b1 // sub
		default: // do nothing
	endcase

endmodule