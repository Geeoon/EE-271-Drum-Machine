module counter(CLOCK_50, reset, limit, hard_limit, out, hard_out);
	// @param limit the limit at which to increment \p out
	// @param hard_limit the limit at which to set \p hard_out to 1
	// @param out the number of times the \p limit has been reached
	// @param hard_out whether the \p hard_limit has been reached
	input logic CLOCK_50, reset;
	input logic [31:0] limit, hard_limit;
	output logic [31:0] out = 0;
	output logic hard_out;
	
	logic [31:0] hard_count_register, soft_count_register = 0;
	
	always_ff @(posedge CLOCK_50) begin
		if (reset) begin 
			hard_count_register <= 0;
			soft_count_register <= 0;
			out <= 0;
		end else if (hard_count_register < hard_limit) begin
			hard_count_register <= hard_count_register + 1;
			if (soft_count_register < limit) begin
				soft_count_register <= soft_count_register + 1;
			end else begin
				out <= out + 1;
				soft_count_register <= 0;
			end
		end
	end
	
	assign hard_out = hard_count_register >= hard_limit;
	
endmodule

module counter_testbench();
	logic CLOCK_50, reset;
	logic [31:0] limit, hard_limit;
	logic [31:0] out;
	logic hard_out;
	
	counter dut(.*);
	
	parameter CLOCK_PERIOD = 10;
	initial begin
		CLOCK_50 <= 0;
		forever #(CLOCK_PERIOD/2) CLOCK_50 <= ~CLOCK_50;
	end
	
	initial begin
		limit = 1;
		hard_limit = 50000;
		reset = 1; @(posedge CLOCK_50);
		reset = 0; @(posedge CLOCK_50);
		repeat(60000) @(posedge CLOCK_50);
		reset = 1; @(posedge CLOCK_50);
		reset = 0; @(posedge CLOCK_50);
		repeat(60000) @(posedge CLOCK_50);
		$stop;
	end
endmodule
