module InstructionMemory(Address, Instruction, clk); 

    input       [31:0]  Address;        // Input Address 
    input clk;
    output reg  [31:0]  Instruction;    // Instruction at memory location Address
    
    reg [31:0] mem[0:1024];

	initial begin
		$readmemb("Inst.txt", mem);
	end
	
	always @(posedge clk) begin
		Instruction <= mem[Address>>2];
		//$display("Address=%h",Address);
		//$display("Instruction=%h",Instruction);
	end
	

endmodule