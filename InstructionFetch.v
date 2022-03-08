module InstructionFetch(PC_now, PC_add4, clk, reset);
	
	// PCAdder4
	input [31:0] PC_now;
	input clk, reset;
	output [31:0] PC_add4;
	
	PCAdder4 PCAdder(.PCResult(PC_now), .PCAddResult(PC_add4), .clk(clk), .reset(reset));
endmodule
