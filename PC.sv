module PC #(parameter A=10)(
	input clk,
	      reset,
	      start,
	      branch_en,
	      alu_en,
	input [A-3:0] offset,
	output logic [A-1:0] pc
);

	logic [9:0] sign_offset;
	logic [1:0] starts_num;
	logic true_start;

	assign sign_offset = {{3{offset[7]}}, offset[7:0]};

	always_ff @(posedge clk) begin
		if(reset) 
			pc <= 0;
		else if(branch_en && alu_en) 
			pc <= pc + sign_offset;
		else begin
			pc <= pc + 1'b1;  
		end
		
		if (reset) begin
			true_start <= '0;
			starts_num <= '0;
		end 
		else begin
			true_start <= start;
			
			if ((true_start == '1) && (start == '0)) begin
				starts_num <= starts_num + 1'b1;
			end
			
			if ((true_start == '1) && (start == '0)) begin
				if (starts_num == 1)
					pc <= 'd000;
				else
					pc <= pc;
			end
			
			if (starts_num == '0)
				pc <= pc;
		end
	end
	
endmodule