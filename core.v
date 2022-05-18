module core #(                             //Don't modify interface
	parameter ADDR_W = 32,
	parameter INST_W = 32,
	parameter DATA_W = 32
)(
	input                   i_clk,
	input                   i_rst_n,
	output [ ADDR_W-1 : 0 ] o_i_addr,
	input  [ INST_W-1 : 0 ] i_i_inst,
	output                  o_d_wen,
	output [ ADDR_W-1 : 0 ] o_d_addr,
	output [ DATA_W-1 : 0 ] o_d_wdata,
	input  [ DATA_W-1 : 0 ] i_d_rdata,
	output [        1 : 0 ] o_status,
	output                  o_status_valid
);

// ---------------------------------------------------------------------------
// Wires and Registers
// ---------------------------------------------------------------------------
// ---- Add your own wires and registers here if needed ---- //
//IF
wire [31:0] PCnow_IF;
wire [31:0] Instruction_IF;
wire [31:0] PCNext_IF;
wire [31:0] PCadd4_IF;
//ID
wire [31:0] Instruction_ID;
wire [31:0] PCnow_ID;
wire [31:0] PCNext_ID;
wire [31:0] ReadData1_ID;
wire [31:0] ReadData2_ID;
wire [1:0] state_of_type_ID;
wire [3:0] ALU_control_ID;
wire data_mem_en_ID;
wire [31:0] im_ID;
wire ReadData1_sel_ID;
wire ReadData2_sel_ID;
wire wb_data_sel_ID;
wire PC_sel_ID;
wire wb_addr_sel_ID;
wire wb_write_en_ID;
wire [4:0] wb_addr1_ID;
wire [4:0] wb_addr2_ID;
//EX
wire [31:0] PCNext_EX;
wire [31:0] ReadData1_EX;
wire [31:0] ReadData2_EX;
wire [1:0] state_of_type_EX;
wire [3:0] ALU_control_EX;
wire data_mem_en_EX;
wire [31:0] im_EX;
wire ReadData1_sel_EX;
wire ReadData2_sel_EX;
wire [31:0] ALU_result_EX;
wire wb_data_sel_EX;
wire PC_sel_EX;
wire wb_addr_sel_EX;
wire wb_write_en_EX;
wire [4:0] wb_addr1_EX;
wire [4:0] wb_addr2_EX;
//MEM
wire [31:0] PCNext_MEM;
wire [31:0] ReadData2_MEM;
wire [1:0] state_of_type_MEM;
wire data_mem_en_MEM;
wire [31:0] ALU_result_MEM;
wire wb_data_sel_MEM;
wire PC_sel_MEM;
wire wb_addr_sel_MEM;
wire wb_write_en_MEM;
wire [4:0] wb_addr1_MEM;
wire [4:0] wb_addr2_MEM;
wire [31:0] mem_data_MEM;
wire [31:0] PCNext_final_MEM;
//WB
wire [31:0] ALU_result_WB;
wire [31:0] mem_data_WB;
wire wb_write_en_WB;
wire wb_addr_sel_WB;
wire wb_data_sel_WB;
wire [4:0] wb_addr1_WB;
wire [4:0] wb_addr2_WB;
wire [4:0] wb_addr_final_WB;
wire [31:0] wb_data_final_WB;

// ---------------------------------------------------------------------------
// Continuous Assignment
// ---------------------------------------------------------------------------
// ---- Add your own wire data assignments here if needed ---- //
//IF
assign o_i_addr = PCnow_IF;
assign Instruction_IF = i_i_inst;
//MEM
assign o_d_wen = data_mem_en_MEM;
assign o_d_addr = ALU_result_MEM;
assign o_d_wdata = ReadData2_MEM;
assign mem_data_MEM = i_d_rdata;

// ---------------------------------------------------------------------------
// Combinational Blocks
// ---------------------------------------------------------------------------
// ---- Write your conbinational block design here ---- //

assign PCNext_IF = PCNext_final_MEM;
// ---------------------------------------------------------------------------
// Sequential Block
// ---------------------------------------------------------------------------
// ---- Write your sequential block design here ---- //
//IF
//TODO PCNext
ProgramCounter PC(.PCNext(PCNext_IF), .PCResult(PCnow_IF), .reset(i_rst_n), .clk(i_clk));
InstructionFetch IF(.PC_now(PCnow_IF), .PC_add4(PCadd4_IF), .clk(i_clk), .reset(i_rst_n));
IF_ID_reg IF_ID_reg(.clk(i_clk), .reset(i_rst_n), .instruction_in(Instruction_IF), .PCNext4_in(PCadd4_IF), .PCNow_in(PCnow_IF), .instruction_out(Instruction_ID), .PCNext4_out(PCNext_ID), .PCNow_out(PCnow_ID));
InstructionDecode ID(.reset(i_rst_n), 
					.Instruction_in(Instruction_ID), 
					.WriteRegister(wb_addr_final_WB), 
					.WriteData(wb_data_final_WB), 
					.RegWrite(wb_write_en_WB), 
					.PCNext_in(PCNext_ID), 
					.ReadData1(ReadData1_ID), 
					.ReadData2(ReadData2_ID), 
					.state_of_type(state_of_type_ID),
					.ALU_control(ALU_control_ID),
					.data_mem_en(data_mem_en_ID),
					.im(im_ID),
					.ReadData1_sel(ReadData1_sel_ID),
					.ReadData2_sel(ReadData2_sel_ID),
					.wb_data_sel(wb_data_sel_ID),
					.PC_sel(PC_sel_ID),
					.wb_addr_sel(wb_addr_sel_ID),
					.wb_write_en(wb_write_en_ID),
					.wb_addr1(wb_addr1_ID),
					.wb_addr2(wb_addr2_ID)
					);
ID_EX_reg ID_EX_reg(.clk(i_clk),
					.reset(i_rst_n),
					.PCNext_in(PCNext_ID),
					.ReadData1_in(ReadData1_ID),
					.ReadData2_in(ReadData2_ID),
					.state_of_type_in(state_of_type_ID),
					.ALU_control_in(ALU_control_ID),
					.data_mem_en_in(data_mem_en_ID),
					.im_in(im_ID),
					.ReadData1_sel_in(ReadData1_sel_ID),
					.ReadData2_sel_in(ReadData2_sel_ID),
					.wb_data_sel_in(wb_data_sel_ID),
					.PC_sel_in(PC_sel_ID),
					.wb_addr_sel_in(wb_addr_sel_ID),
					.wb_write_en_in(wb_write_en_ID),
					.wb_addr1_in(wb_addr1_ID),
					.wb_addr2_in(wb_addr2_ID),
					.PCNext_out(PCNext_EX),
					.ReadData1_out(ReadData1_EX),
					.ReadData2_out(ReadData2_EX),
					.state_of_type_out(state_of_type_EX),
					.ALU_control_out(ALU_control_EX),
					.data_mem_en_out(data_mem_en_EX),
					.im_out(im_EX),
					.ReadData1_sel_out(ReadData1_sel_EX),
					.ReadData2_sel_out(ReadData2_sel_EX),
					.wb_data_sel_out(wb_data_sel_EX),
					.PC_sel_out(PC_sel_EX),
					.wb_addr_sel_out(wb_addr_sel_EX),
					.wb_write_en_out(wb_write_en_EX),
					.wb_addr1_out(wb_addr1_EX),
					.wb_addr2_out(wb_addr2_EX)
					);
Execution Execution(
					.PCNext_in(PCNext_EX), 
					.ReadData1_in(ReadData1_EX), 
					.ReadData2_in(ReadData2_EX), 
					.state_of_type_in(state_of_type_EX), 
					.ALU_control_in(ALU_control_EX), 
					.data_mem_en_in(data_mem_en_EX),
					.im_in(im_EX),
					.ALU_result(ALU_result_EX),
					.ReadData1_sel_in(ReadData1_sel_EX),
					.ReadData2_sel_in(ReadData2_sel_EX)
					);
EX_MEM_reg EX_MEM_reg(.clk(i_clk), 
					.reset(i_rst_n), 
					.PCNext_in(PCNext_EX), 
					.ReadData2_in(ReadData2_EX),
					.state_of_type_in(state_of_type_EX),
					.data_mem_en_in(data_mem_en_EX),
					.ALU_result_in(ALU_result_EX),
					.wb_data_sel_in(wb_data_sel_EX),
					.PC_sel_in(PC_sel_EX),
					.wb_addr_sel_in(wb_addr_sel_EX),
					.wb_write_en_in(wb_write_en_EX),
					.wb_addr1_in(wb_addr1_EX),
					.wb_addr2_in(wb_addr2_EX),
					.PCNext_out(PCNext_MEM), 
					.ReadData2_out(ReadData2_MEM),
					.state_of_type_out(state_of_type_MEM),
					.data_mem_en_out(data_mem_en_MEM),
					.ALU_result_out(ALU_result_MEM),
					.wb_data_sel_out(wb_data_sel_MEM),
					.PC_sel_out(PC_sel_MEM),
					.wb_addr_sel_out(wb_addr_sel_MEM),
					.wb_write_en_out(wb_write_en_MEM),
					.wb_addr1_out(wb_addr1_MEM),
					.wb_addr2_out(wb_addr2_MEM)
					);
Memory_access Memory_access(.PCNext(PCNext_MEM),
					.ALU_result(ALU_result_MEM),
					.PC_sel(PC_sel_MEM),
					.PCNext_final(PCNext_final_MEM)
					);
MEM_WB_reg MEM_WB_reg(.clk(i_clk), 
					.reset(i_rst_n), 
					.ALU_result_in(ALU_result_MEM),
					.mem_data_in(mem_data_MEM),
					.wb_write_en_in(wb_write_en_MEM),
					.wb_addr_sel_in(wb_addr_sel_MEM),
					.wb_data_sel_in(wb_data_sel_MEM),
					.wb_addr1_in(wb_addr1_MEM),
					.wb_addr2_in(wb_addr2_MEM),
					.ALU_result_out(ALU_result_WB),
					.mem_data_out(mem_data_WB),
					.wb_write_en_out(wb_write_en_WB),
					.wb_addr_sel_out(wb_addr_sel_WB),
					.wb_data_sel_out(wb_data_sel_WB),
					.wb_addr1_out(wb_addr1_WB),
					.wb_addr2_out(wb_addr2_WB)
					);
Write_back Write_back(
					.ALU_result_in(ALU_result_WB),
					.mem_data_in(mem_data_WB),
					.wb_data_sel_in(wb_data_sel_WB),
					.wb_addr1_in(wb_addr1_WB),
					.wb_addr2_in(wb_addr2_WB),
					.wb_addr_sel_in(wb_addr_sel_WB),
					.wb_addr(wb_addr_final_WB),
					.wb_data(wb_data_final_WB)
					);

endmodule