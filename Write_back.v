module Write_back(
					ALU_result_in,
					mem_data_in,
					wb_data_sel_in,
					wb_addr1_in,
					wb_addr2_in,
					wb_addr_sel_in,
					wb_addr,
					wb_data
					);
	input [31:0] ALU_result_in;
	input [31:0] mem_data_in;
	input wb_data_sel_in;
	input [4:0] wb_addr1_in;
	input [4:0] wb_addr2_in;
	input wb_addr_sel_in;

	output [31:0] wb_data;
	output [4:0] wb_addr;

	mux_2to1_32bit wb_data_src(.out(wb_data), .inA(ALU_result_in), .inB(mem_data_in), .sel(wb_data_sel_in));
	mux_2to1_5bit wb_addr_src(.out(wb_addr), .inA(wb_addr1_in), .inB(wb_addr2_in), .sel(wb_addr_sel_in));
endmodule