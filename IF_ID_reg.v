module IF_ID_reg(clk,reset, instruction_in, PCNext4_in, PCNow_in, instruction_out, PCNext4_out, PCNow_out);

    input clk, reset;
	input [31:0] instruction_in,PCNext4_in,PCNow_in;
	output [31:0] instruction_out, PCNext4_out,PCNow_out;
	reg [31:0] instruction_out, PCNext4_out,PCNow_out;
	
	always @(posedge clk or negedge reset)
    begin
    	if (~reset)begin
    		instruction_out <= 32'b0;
			PCNext4_out <= 32'b0;
			PCNow_out <= 0;
    	end
    	else begin
			instruction_out <= instruction_in;
			PCNext4_out <= PCNext4_in;
			PCNow_out <= PCNow_in;
    	end
    end

endmodule