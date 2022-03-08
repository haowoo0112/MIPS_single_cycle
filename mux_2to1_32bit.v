module mux_2to1_32bit(out, inA, inB, sel);

    output  [31:0] out;
    
    input   [31:0] inA;
    input   [31:0] inB;
    input          sel;
	reg [31:0]out;

	always@(inA,inB,sel)
	begin
		out <= (sel == 0)? inA : inB;
	end

endmodule