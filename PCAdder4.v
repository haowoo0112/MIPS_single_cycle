module PCAdder4(PCResult, PCAddResult, clk, reset);

    input   [31:0]  PCResult;
    input reset, clk;

    output reg  [31:0]  PCAddResult;

    always @(posedge clk or negedge reset)
    begin
    	if (~reset)begin
    		PCAddResult <= 32'h00000000;
    	end
    	else begin
			PCAddResult <= PCResult + 32'h00000004;
    	end
    	
    end

endmodule