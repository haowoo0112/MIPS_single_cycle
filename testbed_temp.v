`timescale 1ns/100ps
`define CYCLE       10.0
`define HCYCLE      (`CYCLE/2)
`define MAX_CYCLE   120000


module testbed;

	reg clk, rst_n;
	wire [ 31 : 0 ] imem_addr;
	wire [ 31 : 0 ] imem_inst;
	wire            dmem_wen;
	wire [ 31 : 0 ] dmem_addr;
	wire [ 31 : 0 ] dmem_wdata;
	wire [ 31 : 0 ] dmem_rdata;
	wire [  1 : 0 ] mips_status;
	wire            mips_status_valid;

	//initial $readmemb (`Inst, u_inst_mem.mem_r); // Don't modify
	always
  		#10 clk = ~clk;
  	initial
  		begin
  		rst_n = 0;
  		clk = 0;
  		#30 rst_n = 1;
  		#5400 
  		$finish;
  		end
	core u_core (
		.i_clk(clk),
		.i_rst_n(rst_n),
		.o_i_addr(imem_addr),
		.i_i_inst(imem_inst),
		.o_d_wen(dmem_wen),
		.o_d_addr(dmem_addr),
		.o_d_wdata(dmem_wdata),
		.i_d_rdata(dmem_rdata),
		.o_status(mips_status),
		.o_status_valid(mips_status_valid)
	);

	InstructionMemory  u_inst_mem (
		.clk(clk),
		.Address(imem_addr),
		.Instruction(imem_inst)
	);
	
	DataMemory  u_data_mem (
		.clk(clk),
		.reset(rst_n),
		.wen(dmem_wen),
		.Address(dmem_addr),
		.wdata(dmem_wdata),
		.rdata(dmem_rdata)
	);
	




endmodule



