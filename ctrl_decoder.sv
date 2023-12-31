module ctrl_decoder(
	input [8:0] INSTRUCTION,
	output logic reg_write,
		     reg_dest,
		     branch_en,
		     mem_write,
		     mem_read,
		     done,
	output logic [3:0] funct,
	output logic op
);

always_comb begin
	op = 1'bx;
	funct = 4'bxxxx;
	reg_write = 1'bx;
	reg_dest = 1'bx;
	branch_en = 1'bx;
	mem_write = 1'bx;
	mem_read = 1'bx;
	done = 1'b0;
	if (INSTRUCTION[8:4] == 5'b00000) begin // xor
			op = 1'b0;
			funct = 4'b0000;
			reg_write = 1'b1;
			reg_dest = 1'b0;
			branch_en = 1'b0;
			mem_write = 1'b0;
			mem_read = 1'b0;	
	end else if (INSTRUCTION[8:4] == 5'b00001) begin // lw
			op = 1'b0;
			funct = 4'b0001;
			reg_write = 1'b1;
			reg_dest = 1'b0;
			branch_en = 1'b0;
			mem_write = 1'b0;
			mem_read = 1'b1;
	end else if (INSTRUCTION[8:4] == 5'b00010) begin // sw
			op = 1'b0;
			funct = 4'b0010;
			reg_write = 1'b1;
			reg_dest = 1'b1;
			branch_en = 1'b0;
			mem_write = 1'b1;
			mem_read = 1'b0;
	end else if (INSTRUCTION[8:4] == 5'b00011) begin // mov
			op = 1'b0;
			funct = 4'b0011;
			reg_write = 1'b1;
			reg_dest = 1'b0;
			branch_en = 1'b0;
			mem_write = 1'b0;
			mem_read = 1'b0;
	end else if (INSTRUCTION[8:4] == 5'b00100) begin // put
			op = 1'b0;
			funct = 4'b0100;
			reg_write = 1'b1;
			reg_dest = 1'b1;
			branch_en = 1'b0;
			mem_write = 1'b0;
			mem_read = 1'b0;
	end else if (INSTRUCTION[8:4] == 5'b00101) begin // add
			op = 1'b0;
			funct = 4'b0101;
			reg_write = 1'b1;
			reg_dest = 1'b0;
			branch_en = 1'b0;
			mem_write = 1'b0;
			mem_read = 1'b0;
	end else if (INSTRUCTION[8:4] == 5'b00110) begin // sub
			op = 1'b0;
			funct = 4'b0110;
			reg_write = 1'b1;
			reg_dest = 1'b0;
			branch_en = 1'b0;
			mem_write = 1'b0;
			mem_read = 1'b0;
	end else if (INSTRUCTION[8:4] == 5'b00111) begin // sl
			op = 1'b0;
			funct = 4'b0111;
			reg_write = 1'b1;
			reg_dest = 1'b0;
			branch_en = 1'b0;
			mem_write = 1'b0;
			mem_read = 1'b0;
	end else if (INSTRUCTION[8:4] == 5'b01000) begin // sr
			op = 1'b0;
			funct = 4'b1000;
			reg_write = 1'b1;
			reg_dest = 1'b0;
			branch_en = 1'b0;
			mem_write = 1'b0;
			mem_read = 1'b0;
	end else if (INSTRUCTION[8:4] == 5'b01001) begin // inc
			op = 1'b0;
			funct = 4'b1001;
			reg_write = 1'b1;
			reg_dest = 1'b1;
			branch_en = 1'b0;
			mem_write = 1'b0;
			mem_read = 1'b0;
	end else if (INSTRUCTION[8:4] == 5'b01010) begin // dec
			op = 1'b0;
			funct = 4'b1010;
			reg_write = 1'b1;
			reg_dest = 1'b1;
			branch_en = 1'b0;
			mem_write = 1'b0;
			mem_read = 1'b0;
	end else if (INSTRUCTION[8:4] == 5'b01011) begin // and
			op = 1'b0;
			funct = 4'b1011;
			reg_write = 1'b1;
			reg_dest = 1'b0;
			branch_en = 1'b0;
			mem_write = 1'b0;
			mem_read = 1'b0;
	end else if (INSTRUCTION[8] == 1'b1) begin // bne
			op = 1'b1;
			funct = 4'bxxxx;
			reg_write = 1'b0;
			reg_dest = 1'b0;
			branch_en = 1'b1;
			mem_write = 1'b0;
			mem_read = 1'b0;
	end else if (INSTRUCTION[8:4] == 5'b01111) begin // done
			done = 1'b1;
	end
end

endmodule
