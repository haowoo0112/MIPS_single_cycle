module mux_2to1_5bit(out, inA, inB, sel);

    output  [4:0] out;
    
    input   [4:0] inA;
    input   [4:0] inB;
    input          sel;
	reg [4:0]out;

	always@(inA,inB,sel)
	begin
		out <= (sel == 0)? inA : inB;
	end

endmodule