module reg_file #(parameter W=8, D=4)(
	input		clk,
			write_en,
			reset,
	input	[D-1:0] raddrA,
			raddrB,
			waddr,
	input [W-1:0] data_in,
	output logic [W-1:0] data_outA,
	output logic [W-1:0] data_outB,
	output logic [W-1:0] data_reg13,
	output logic [W-1:0] data_reg14
);

logic [W-1:0] registers[2**D];

always_comb begin
	data_outA = registers[raddrA];
	data_outB = registers[raddrB];
	data_reg13 = registers[13];
	data_reg14 = registers[14];
end

always_ff @ (posedge clk) begin
	registers[15] <= 'd0;
	if (reset) begin
		for (int i = 0; i < 2**D; i++)
			registers[i] <= 'd0;
	end
	
	if (write_en) begin
		registers[waddr] <= data_in;
	end
end
	
endmodule
