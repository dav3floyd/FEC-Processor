module ALU(
	input OP,
	input [3:0] FUNCT,
	input [7:0] INPUT_A, INPUT_B,
	input [7:0] INPUT_REG13,
	input [7:0] INPUT_REG14,
	output logic [7:0] OUT,
	output logic ZERO
);

always_comb begin
	OUT = 0;

	if(OP == 1'b0) begin
		case(FUNCT)
			4'b0000: OUT = INPUT_A ^ INPUT_B; // xor
			4'b0101: OUT = INPUT_A + INPUT_B; // add
			4'b0110: OUT = INPUT_A - INPUT_B; // sub
			4'b0111: OUT = {INPUT_B[6:0], 1'b0}; // sl
			4'b1000: OUT = {1'b0, INPUT_B[7:1]}; // sr
			4'b1001: OUT = INPUT_B + 1'b1; // inc
			4'b1010: OUT = INPUT_B - 1'b1; // (~(8'b00000001) + 1); dec
			4'b1011: OUT = INPUT_A & INPUT_B; // and
			4'b0011: OUT = INPUT_B; // mov
			4'b0100: OUT = INPUT_A; // put
			4'b0010: OUT = INPUT_B; // sw
			4'b0001: OUT = INPUT_B; // lw
			default: OUT = 8'bxxxx_xxxx;
		endcase
	end
end

assign ZERO = INPUT_REG13 == INPUT_REG14 ? 1'b0 : 1'b1;

endmodule
