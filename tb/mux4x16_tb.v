`timescale 1ns/1ps

module mux4x16_tb;

parameter word = 16;
parameter k = 9;

reg  [word-1:0] din;
reg  [word*k-1:0] registers;   // array: [G, R7, ..., R0]
reg  [9:0] select;				 // [R7,...,R0, G, din]		
wire [word-1:0] bus;

initial begin
	$display("  select    |  bus             | G                | R7               |  R6              |  R5              |  R4              |  R3              |  R2              |  R1              |  R0              | din ");
	$monitor(" %b | %b | %b | %b | %b | %b | %b | %b | %b | %b | %b | %b  ", 
	select, bus, 
	registers[word*k-1:word*(k-1)], registers[word*(k-1)-1:word*(k-2)], 
	registers[word*(k-2)-1:word*(k-3)], registers[word*(k-3)-1:word*(k-4)],
	registers[word*(k-4)-1:word*(k-5)], registers[word*(k-5)-1:word*(k-6)], 
	registers[word*(k-6)-1:word*(k-7)], registers[word*(k-7)-1:word*(k-8)],
	registers[word*(k-8)-1:word*(k-9)], din);
end

// stimulus
initial begin
	#0  select = 10'b00_0000_0000; registers = 0; din = 16'b0;
	
	#20 select = 10'b00_0000_0001; din = 16'b0000_0000_0000_0111;
	
	#20 select = 10'b10_0000_0000; registers[word*(k-8)-1 : word*(k-9)] = 16'b0000_0000_1111_0000; // R0
	
	#20 select = 10'b01_0000_0000; registers[word*(k-7)-1 : word*(k-8)] = 16'b0000_1111_0000_0000; // R1
	
	#20 select = 10'b00_1000_0000; registers[word*(k-6)-1 : word*(k-7)] = 16'b1111_0000_0000_0000; // R2
	
	#20 select = 10'b00_0100_0000; registers[word*(k-5)-1 : word*(k-6)] = 16'b1111_0000_0000_1111; // R3
	
	#20 select = 10'b00_0010_0000; registers[word*(k-4)-1 : word*(k-5)] = 16'b1111_0000_1111_0000; // R4
	
	#20 select = 10'b00_0001_0000; registers[word*(k-3)-1 : word*(k-4)] = 16'b1111_1111_0000_0000; // R5
	
	#20 select = 10'b00_0000_1000; registers[word*(k-2)-1 : word*(k-3)] = 16'b1111_0011_0000_1100; // R6
	
	#20 select = 10'b00_0000_0100; registers[word*(k-1)-1 : word*(k-2)] = 16'b1100_0000_0000_0011; // R7
	
	#20 select = 10'b00_0000_0010; registers[word*k-1 : word*(k-1)] = 16'b1000_0010_1001_1001; // G
	
	#20 $stop();
end

// uut instantation
mux4x16 uut(din, registers, select, bus);

endmodule