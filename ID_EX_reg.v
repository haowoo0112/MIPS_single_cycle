module ID_EX_reg(
	clk,
	reset,
	PCNext_in,
	ReadData1_in,
	ReadData2_in,
	state_of_type_in,
	ALU_control_in,
	data_mem_en_in,
	im_in,
	ReadData1_sel_in,
	ReadData2_sel_in,
	wb_data_sel_in,
	PC_sel_in,
	wb_addr_sel_in,
	wb_write_en_in,
	wb_addr1_in,
	wb_addr2_in,
	PCNext_out,
	ReadData1_out,
	ReadData2_out,
	state_of_type_out,
	ALU_control_out,
	data_mem_en_out,
	im_out,
	ReadData1_sel_out,
	ReadData2_sel_out,
	wb_data_sel_out,
	PC_sel_out,
	wb_addr_sel_out,
	wb_write_en_out,
	wb_addr1_out,
	wb_addr2_out
	);
	
	input clk, reset;
	input [31:0] PCNext_in;
	input [31:0] ReadData1_in, ReadData2_in, im_in;
	input [1:0] state_of_type_in;
	input [3:0] ALU_control_in;
	input data_mem_en_in;
	input ReadData1_sel_in;
	input ReadData2_sel_in;
	input wb_data_sel_in;
	input PC_sel_in;
	input wb_addr_sel_in;
	input wb_write_en_in;
	input [4:0] wb_addr1_in;
	input [4:0] wb_addr2_in;

	output [31:0] PCNext_out;
	output [31:0] ReadData1_out, ReadData2_out, im_out;
	output [1:0] state_of_type_out;
	output [3:0] ALU_control_out;
	output data_mem_en_out;
	output ReadData1_sel_out;
	output ReadData2_sel_out;
	output wb_data_sel_out;
	output PC_sel_out;
	output wb_addr_sel_out;
	output wb_write_en_out;
	output [4:0] wb_addr1_out;
	output [4:0] wb_addr2_out;

	reg [31:0] PCNext_out;
	reg [31:0] ReadData1_out, ReadData2_out, im_out;
	reg [1:0] state_of_type_out;
	reg [3:0] ALU_control_out;
	reg data_mem_en_out;
	reg ReadData1_sel_out;
	reg ReadData2_sel_out;
	reg wb_data_sel_out;
	reg PC_sel_out;
	reg wb_addr_sel_out;
	reg wb_write_en_out;
	reg [4:0] wb_addr1_out;
	reg [4:0] wb_addr2_out;


	always @(posedge clk or negedge reset)
    begin
    	if (~reset)begin
    		PCNext_out <= 32'd0;
			ReadData1_out <= 32'd0;
			ReadData2_out <= 32'd0;
			im_out <= 32'd0;
			state_of_type_out <= 2'd0;
			ALU_control_out <= 4'd0;
			data_mem_en_out <= 1'd0;
			ReadData1_sel_out <= 1'b0;
			ReadData2_sel_out <= 1'b0;
			wb_data_sel_out <= 1'b0;
			PC_sel_out <= 1'b0;
			wb_addr_sel_out <= 1'b0;
			wb_write_en_out <= 1'b0;
			wb_addr1_out <= 5'd0;
			wb_addr2_out <= 5'd0;
    	end
    	else begin
			PCNext_out <= PCNext_in;
			ReadData1_out <= ReadData1_in;
			ReadData2_out <= ReadData2_in;
			im_out <= im_in;
			state_of_type_out <= state_of_type_in;
			ALU_control_out <= ALU_control_in;
			data_mem_en_out <= data_mem_en_in;
    		ReadData1_sel_out <= ReadData1_sel_in;
			ReadData2_sel_out <= ReadData2_sel_in;
    		wb_data_sel_out <= wb_data_sel_in;
			PC_sel_out <= PC_sel_in;
			wb_addr_sel_out <= wb_addr_sel_in;
			wb_write_en_out <= wb_write_en_in;
			wb_addr1_out <= wb_addr1_in;
			wb_addr2_out <= wb_addr2_in;
    	end
    end


endmodule