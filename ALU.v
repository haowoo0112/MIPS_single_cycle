module ALU(ALU_control, A, B, ALU_result);

	input [3:0] ALU_control;
	input [31:0] A, B;
	output [31:0] ALU_result;
	reg [31:0] ALU_result;

 	always @(ALU_control, A, B) begin
 		case (ALU_control)
 			0://add
 				ALU_result <= A + B;
 			1://sub
 				ALU_result <= A - (~B + 1);
 			2://and
 				ALU_result <= A & B;
 			3://or
 				ALU_result <= A | B;
 			4://nor
 				ALU_result <= ~(A | B);
 			5://slt
 				ALU_result <= (A < B)? 32'd1 : 32'd0;
 		endcase
 	end
endmodule