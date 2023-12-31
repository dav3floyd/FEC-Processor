module data_mem(
	input clk,
	      mem_write_en,
	      mem_read_en,
	input [7:0] mem_address,
	input [7:0] data_in,
	output logic [7:0] data_out
);

	logic [7:0] core[256];
	
	initial begin
		$readmemh("memory_data.txt", core);
	end
	
	always_comb begin
		if(mem_read_en) 
			data_out = core[mem_address];
		else
			data_out = 8'bZ;
	end
	
	always_ff @ (posedge clk) begin
		if(mem_write_en) 
			core[mem_address] <= data_in;
	end
	
endmodule
