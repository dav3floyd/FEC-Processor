module top_level(
	input reset,
	      start,
	      clk,
	output logic done
);

// PC
wire [9:0] pc_out;

// instr_rom
wire [8:0] instr_op_out;
logic [8:0] curr_instr_out;

// control_decoder
logic reg_write;
logic reg_dest;
logic branch_en;
logic mem_write;
logic mem_read;
logic control_done;
logic [3:0] funct;
logic op;

// reg_file
logic [7:0] regA_out;
logic [7:0] regB_out;
logic [7:0] reg13_out;
logic [7:0] reg14_out;
logic [3:0] reg_accum = 'b000;

// ALU
logic [7:0] ALU_out;
logic ALU_ZERO_out;

// data_mem
logic [7:0] data_mem_out;

// MUX
logic [7:0] mem_reg_out;
logic [3:0] reg_dest_out;
logic [7:0] mem_branch_out;

logic [15:0] cycle_count;

PC p_c(
	.clk (clk),
	.reset (reset),
	.start (start),
	.branch_en (branch_en),
	.alu_en (ALU_ZERO_out),
	.offset (instr_op_out[7:0]),
	.pc (pc_out)
);
	
instr_rom ir(
	.instr_address (pc_out),
	.instr_out (instr_op_out)
);
	
logic run_processor;
logic delay_start;

always_ff @(posedge clk) begin
	if (reset)
		delay_start <= '0;
	else if (start) 
		delay_start <= '1;
end

always_comb begin
	run_processor = delay_start & ~start;
	curr_instr_out = run_processor ? instr_op_out : 9'b111111111;
end
	
ctrl_decoder cd(
	.INSTRUCTION(curr_instr_out),
	.reg_write (reg_write),
	.reg_dest (reg_dest),
	.branch_en (branch_en),
	.mem_write (mem_write),
	.mem_read (mem_read),
	.funct (funct),
	.op (op),
	.done(control_done)
);
	
reg_file #(.W(8), .D(4)) rgf(
	.clk (clk),
	.write_en (reg_write),
	.reset (reset),
	.raddrA (reg_accum),
	.raddrB (curr_instr_out[3:0]),
	.waddr (reg_dest_out),
	.data_in (mem_reg_out),
	.data_outA (regA_out),
	.data_outB (regB_out),
	.data_reg13(reg13_out),
	.data_reg14(reg14_out)
);

assign done = run_processor & control_done;
assign reg_dest_out = reg_dest ? curr_instr_out[3:0] : reg_accum;

logic [7:0] ALU_input_A, ALU_input_B;
assign ALU_input_A = regA_out;
assign ALU_input_B = regB_out;
	
ALU alu(
	.OP(op),
	.FUNCT(funct),
	.INPUT_A(ALU_input_A),
	.INPUT_B(ALU_input_B),
	.INPUT_REG13(reg13_out),
	.INPUT_REG14(reg14_out),
	.OUT(ALU_out),
	.ZERO(ALU_ZERO_out)
);
	
data_mem dm1(
	.clk(clk),
	.mem_write_en(mem_write),
	.mem_read_en(mem_read),
	.mem_address(ALU_out),
	.data_in(regA_out),
	.data_out(data_mem_out)
);

assign mem_reg_out = mem_read ? data_mem_out : ALU_out;

always_ff @(posedge clk) begin
	if (reset)
		cycle_count <= 0;
	else if (control_done == 0)
		cycle_count <= cycle_count + 'b1;
end
		
endmodule