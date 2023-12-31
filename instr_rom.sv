module instr_rom #(parameter A=10, W=9)(
	input [A-1:0] instr_address,
	output logic [W-1:0] instr_out
);

	logic [W-1:0] inst_rom[2**(A)];

	always_comb instr_out = inst_rom[instr_address];

	initial begin	
		$readmemb("machine_code.txt",inst_rom);
	end

endmodule