module DataMemory(Address, rdata, wdata, wen, clk, reset); 

    input       [31:0]  Address, wdata;        // Input Address 
    input clk, reset, wen;
    output reg  [31:0]  rdata;    // Instruction at memory location Address
    
    reg [31:0] mem[0:1024];

	initial begin
		$readmemb("data.dat", mem);
	end
	
	always @(posedge clk) begin
		rdata <= mem[Address>>2];
	end
	
	always @(posedge clk) begin
		mem[Address>>2] <= wdata;
	end

endmodule