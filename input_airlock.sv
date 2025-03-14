module input_airlock(CLOCK_50, reset, in, out);
	input logic CLOCK_50, reset, in;
	output logic out;
	logic down = 0;
	assign out = ~down & in;
	always_ff @(posedge CLOCK_50) begin
		if (reset) begin
			down <= 0;
		end else if (in == 1) begin
			down <= 1;
		end else begin
			down <= 0;
		end
	end
	
endmodule

module input_airlock_testbench();
	logic CLOCK_50, reset, in, out;
	parameter CLOCK_PERIOD = 100;
	initial begin
		CLOCK_50 <= 0;
		forever #(CLOCK_PERIOD/2) CLOCK_50 <= ~CLOCK_50;
	end
	input_airlock dut(CLOCK_50, reset, in, out);
	
	initial begin
		reset = 1;
		in = 0; @(posedge CLOCK_50);
		reset = 0; @(posedge CLOCK_50);
		
		in = 1; @(posedge CLOCK_50);
		in = 0; @(posedge CLOCK_50);
		in = 1; repeat(2) @(posedge CLOCK_50);
		in = 0; repeat(2) @(posedge CLOCK_50);
		in = 1; repeat(10) @(posedge CLOCK_50);
		in = 0; repeat(10) @(posedge CLOCK_50);
		$stop;
	end
endmodule
