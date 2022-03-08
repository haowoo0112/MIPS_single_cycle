module Execution( 
	PCNext_in, 
	ReadData1_in, 
	ReadData2_in, 
	state_of_type_in, 
	ALU_control_in, 
	data_mem_en_in,
	im_in,
	ALU_result,
	ReadData1_sel_in,
	ReadData2_sel_in
	);

	input [31:0] PCNext_in;
	input [31:0] ReadData1_in, ReadData2_in, im_in;
	input [1:0] state_of_type_in;
	input [3:0] ALU_control_in;
	input data_mem_en_in;
	input ReadData1_sel_in;
	input ReadData2_sel_in;

	wire [31:0] ReadData1_final;
	wire [31:0] ReadData2_final;

	output [31:0] ALU_result;
				
	mux_2to1_32bit ReadData1_src(.out(ReadData1_final), .inA(ReadData1_in), .inB(PCNext_in), .sel(ReadData1_sel_in));
	mux_2to1_32bit ReadData2_src(.out(ReadData2_final), .inA(ReadData2_in), .inB(im_in), .sel(ReadData2_sel_in));
	ALU ALU(.ALU_control(ALU_control_in), .A(ReadData1_final), .B(ReadData2_final), .ALU_result(ALU_result));

endmodule