module MEM_WB_reg(
					clk, 
					reset, 
					ALU_result_in,
					mem_data_in,
					wb_write_en_in,
					wb_addr_sel_in,
					wb_data_sel_in,
					wb_addr1_in,
					wb_addr2_in,
					ALU_result_out,
					mem_data_out,
					wb_write_en_out,
					wb_addr_sel_out,
					wb_data_sel_out,
					wb_addr1_out,
					wb_addr2_out
					);
	input clk, reset;
	input [31:0] ALU_result_in;
	input [31:0] mem_data_in;
	input wb_write_en_in;
	input wb_addr_sel_in;
	input wb_data_sel_in;
	input [4:0] wb_addr1_in;
	input [4:0] wb_addr2_in;

	output [31:0] ALU_result_out;
	output [31:0] mem_data_out;
	output wb_write_en_out;
	output wb_addr_sel_out;
	output wb_data_sel_out;
	output [4:0] wb_addr1_out;
	output [4:0] wb_addr2_out;

	reg [31:0] ALU_result_out;
	reg [31:0] mem_data_out;
	reg wb_write_en_out;
	reg wb_addr_sel_out;
	reg wb_data_sel_out;
	reg [4:0] wb_addr1_out;
	reg [4:0] wb_addr2_out;

	always @(posedge clk or negedge reset)
    begin
    	if (~reset)begin
    		ALU_result_out <= 32'd0;
			mem_data_out< <= 32'd0;
			wb_write_en_out <= 1'd0;
			wb_addr_sel_out <= 1'b0;
			wb_data_sel_out <= 1'b0;
			wb_addr1_out <= 5'd0;
			wb_addr2_out <=5'd0;
    	end
    	else begin
    		ALU_result_out <= ALU_result_in;
			mem_data_out< <= mem_data_in;
			wb_write_en_out <= wb_write_en_in;
			wb_addr_sel_out <= wb_addr_sel_in;
			wb_data_sel_out <= wb_data_sel_in;
			wb_addr1_out <= wb_addr1_in;
			wb_addr2_out <= wb_addr2_in;
    	end
    end




endmodule