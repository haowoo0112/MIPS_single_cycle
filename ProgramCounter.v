module ProgramCounter(PCNext, PCResult, reset, clk);

	input       [31:0]  PCNext;
	input               reset, clk;

	output reg  [31:0]  PCResult;

    always @(posedge clk or negedge reset)
    begin
    	if (~reset)begin
    		PCResult <= 32'h00000000;
    	end
    	else begin
			PCResult <= PCNext;
    	end

		$monitor("PC=%h",PCResult);
    end

endmodule