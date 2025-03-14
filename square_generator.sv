module square_generator #(parameter BOUND=24'sb011111111111111111111111)(CLOCK_50, octave, note, reset, volume, frequency, signal_out);
	input CLOCK_50, reset;
	input logic [7:0] volume;
	input logic [15:0] frequency;
	input logic [2:0] octave;
	input logic [3:0] note;
	output logic [23:0] signal_out;
	logic [31:0] count;
	logic hard_out;
	
	logic [23:0] period;
	period_table period_lookup(octave, note, period);
	counter square_counter(CLOCK_50, reset | hard_out, period, period * 4, count, hard_out);
	
	always_comb begin
		if (count % 2 == 0) begin
			signal_out = 24'(100000);
		end else begin
			signal_out = 24'(-100000);
		end
	end
endmodule

 module square_generator_testbench();
	logic CLOCK_50, reset;
	logic [7:0] volume;
	logic [15:0] frequency;
	logic [23:0] signal_out;
	logic [2:0] octave;
	logic [3:0] note;
	
	parameter CLOCK_PERIOD = 100;
	initial begin
		CLOCK_50 <= 0;
		forever #(CLOCK_PERIOD/2) CLOCK_50 <= ~CLOCK_50;
	end
	
	square_generator dut (.*);
	
	initial begin
		volume <= 255;
		frequency <= 440;
		reset <= 1; @(posedge CLOCK_50);
		reset <= 0; @(posedge CLOCK_50);
		repeat(100000) @(posedge CLOCK_50);
		$stop;
	end
endmodule
