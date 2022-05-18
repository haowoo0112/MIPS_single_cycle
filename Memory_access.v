module Memory_access(PCNext,
					ALU_result,
					PC_sel,
					PCNext_final
					);
	input [31:0] PCNext;
	input [31:0] ALU_result;
	input PC_sel;
	output [31:0] PCNext_final;

	mux_2to1_32bit PC_sec(.out(PCNext_final), 
						.inA(PCNext), 
						.inB(ALU_result), 
						.sel(PC_sel)
						);

endmodule