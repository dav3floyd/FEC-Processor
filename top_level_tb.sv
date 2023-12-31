module top_level_tb;

timeunit 1ns;

timeprecision 1ps;

bit reset = 'b1;
bit start, clk;
wire done;

top_level dut (
	.reset(reset),
	.start(start),
	.clk(clk),
	.done(done)
);

always begin
	#5 clk = 1;
	#5 clk = 0;
end

initial begin
	#10 $displayh("Starting Test Bench");
	#10 reset = 'b0;
	#10 start = 'b1;
	
	force dut.dm1.core[0] = 'b10011111;
	force dut.dm1.core[1] = 'b00000110;
	
	#10 start = 0;
	
	wait (done);
	#10 $display("-----------------");
	#10 $display("Testbench Results");
	if (dut.dm1.core[30] != 'b11101110 || dut.dm1.core[31] != 'b11010010) begin
		$display("INCORRECT: mem[30] = %b,  %b", dut.dm1.core[30], 8'b11101110);
		$display("INCORRECT: mem[31] = %b,  %b", dut.dm1.core[31], 8'b11010010);
	end else begin 
		$display("DONE");
	end
	
	$stop;
	
end
endmodule