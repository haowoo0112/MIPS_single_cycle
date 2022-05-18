module InstructionDecode(reset, 
						Instruction_in, 
						WriteRegister, 
						WriteData, 
						RegWrite, 
						PCNext_in, 
						ReadData1, 
						ReadData2, 
						state_of_type,
						ALU_control,
						data_mem_en,
						im,
						ReadData1_sel,
						ReadData2_sel,
						wb_data_sel,
						PC_sel,
						wb_addr_sel,
						wb_write_en,
						wb_addr1,
						wb_addr2
						);
	
	input reset, RegWrite;
	input [31:0] Instruction_in, WriteData;
	input [4:0] WriteRegister;
	input [31:0] PCNext_in;
	output [31:0] ReadData1, ReadData2;
	output [1:0] state_of_type;
	reg [1:0] state_of_type;
	output [3:0] ALU_control;
	reg [3:0] ALU_control;
	output data_mem_en;
	reg data_mem_en;
	output ReadData1_sel;
	reg ReadData1_sel;
	output ReadData2_sel;
	reg ReadData2_sel;
	output [31:0] im;
	output wb_data_sel;
	output PC_sel;
	output wb_addr_sel;
	output wb_write_en;
	reg wb_data_sel;
	reg wb_addr_sel;
	reg PC_sel;
	reg wb_write_en;
	
	output [4:0] wb_addr1;
	output [4:0] wb_addr2;

	wire [4:0] ReadRegister1, ReadRegister2;
	wire [5:0] opcode;
	
	assign ReadRegister1 = Instruction_in[25:21];
	assign ReadRegister2 = Instruction_in[20:16];
	assign im = {16'd0, Instruction_in[15:0]};
	assign opcode = Instruction_in[31:26];
	assign wb_addr1 = Instruction_in[15:11];
	assign wb_addr2 = Instruction_in[20:16];


	RegisterFile RF(.ReadRegister1(ReadRegister1), .ReadRegister2(ReadRegister2), .WriteRegister(WriteRegister), .WriteData(WriteData), .RegWrite(RegWrite), .reset(reset), .ReadData1(ReadData1), .ReadData2(ReadData2));



	always @(Instruction_in) begin
		if(Instruction_in != 0)begin
			$monitor("opcode=%h",opcode);
			case (opcode) 
				6'd1:begin//add
					state_of_type <= 2'd0;
					ALU_control <= 4'd0;
					data_mem_en <= 1'd0;
					ReadData1_sel <= 1'b0;
					ReadData2_sel <= 1'b0;
					PC_sel <= 1'b0;
					wb_data_sel <= 1'b0;
					wb_addr_sel <= 1'b0;
					wb_write_en <= 1'b1;
				end
				6'd2:begin//sub
					state_of_type <= 2'd0;
					ALU_control <= 4'd1;
					data_mem_en <= 1'd0;
					ReadData1_sel <= 1'b0;
					ReadData2_sel <= 1'b0;
					PC_sel <= 1'b0;
					wb_data_sel <= 1'b0;
					wb_addr_sel <= 1'b0;
					wb_write_en <= 1'b1;
				end
				6'd3:begin//addi
					state_of_type <= 2'd1;
					ALU_control <= 4'd0;
					data_mem_en <= 1'd0;
					ReadData1_sel <= 1'b0;
					ReadData2_sel <= 1'b1;
					PC_sel <= 1'b0;
					wb_data_sel <= 1'b0;
					wb_addr_sel <= 1'b1;
					wb_write_en <= 1'b1;
				end
				6'd4:begin//lw
					state_of_type <= 2'd1;
					ALU_control <= 4'd0;
					data_mem_en <= 1'd0;
					ReadData1_sel <= 1'b0;
					ReadData2_sel <= 1'b1;
					PC_sel <= 1'b0;
					wb_data_sel <= 1'b1;
					wb_addr_sel <= 1'b1;
					wb_write_en <= 1'b1;
				end
				6'd5:begin//sw
					state_of_type <= 2'd1;
					ALU_control <= 4'd0;
					data_mem_en <= 1'd1;
					ReadData1_sel <= 1'b0;
					ReadData2_sel <= 1'b1;
					PC_sel <= 1'b0;
					wb_data_sel <= 1'b0;
					wb_addr_sel <= 1'b0;
					wb_write_en <= 1'b0;
				end
				6'd6:begin//and
					state_of_type <= 2'd0;
					ALU_control <= 4'd2;
					data_mem_en <= 1'd0;
					ReadData1_sel <= 1'b0;
					ReadData2_sel <= 1'b0;
					PC_sel <= 1'b0;
					wb_data_sel <= 1'b0;
					wb_addr_sel <= 1'b0;
					wb_write_en <= 1'b1;
				end
				6'd7:begin//or
					state_of_type <= 2'd0;
					ALU_control <= 4'd3;
					data_mem_en <= 1'd0;
					ReadData1_sel <= 1'b0;
					ReadData2_sel <= 1'b0;
					PC_sel <= 1'b0;
					wb_data_sel <= 1'b0;
					wb_addr_sel <= 1'b0;
					wb_write_en <= 1'b1;

				end
				6'd8:begin//nor
					state_of_type <= 2'd0;
					ALU_control <= 4'd4;
					data_mem_en <= 1'd0;
					ReadData1_sel <= 1'b0;
					ReadData2_sel <= 1'b0;
					PC_sel <= 1'b0;
					wb_data_sel <= 1'b0;
					wb_addr_sel <= 1'b0;
					wb_write_en <= 1'b1;
				end
				6'd11:begin//slt
					state_of_type <= 2'd0;
					ALU_control <= 4'd5;
					data_mem_en <= 1'd0;
					ReadData1_sel <= 1'b0;
					ReadData2_sel <= 1'b0;
					PC_sel <= 1'b0;
					wb_data_sel <= 1'b0;
					wb_addr_sel <= 1'b0;
					wb_write_en <= 1'b1;
				end
				6'd9:begin//beq
					state_of_type <= 2'd1;
					data_mem_en <= 1'd0;
					ReadData1_sel <= 1'b1;
					ReadData2_sel <= 1'b1;
					PC_sel <= (ReadData1==ReadData2)? 1'b1:1'b0;
					wb_data_sel <= 1'b0;
					wb_addr_sel <= 1'b0;
					wb_write_en <= 1'b0;
				end
				6'd10:begin//bne
					state_of_type <= 2'd1;
					data_mem_en <= 1'd0;
					ReadData1_sel <= 1'b1;
					ReadData2_sel <= 1'b1;
					PC_sel <= (ReadData1!=ReadData2)? 1'b1:1'b0;
					wb_data_sel <= 1'b0;
					wb_addr_sel <= 1'b0;
					wb_write_en <= 1'b0;
				end
				6'd12:begin//eof
					state_of_type <= 2'd3;
					data_mem_en <= 1'd0;
					wb_addr_sel <= 1'b0;
					wb_write_en <= 1'b0;
				end
				default:begin
					state_of_type <= 2'd0;
					ALU_control <= 4'd0;
					data_mem_en <= 1'd0;
					ReadData1_sel <= 1'b0;
					ReadData2_sel <= 1'b0;
					PC_sel <= 1'b0;
					wb_data_sel <= 1'b0;
					wb_addr_sel <= 1'b0;
					wb_write_en <= 1'b0;
				end
			endcase
		end
	end
endmodule