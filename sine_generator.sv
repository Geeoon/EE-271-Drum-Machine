module sine_generator #(parameter BOUND=24'sb011111111111100000000000)(CLOCK_50, reset, volume, frequency, signal_out);
	input logic CLOCK_50, reset;
	input logic [7:0] volume;
	input logic [15:0] frequency;
	output logic [23:0] signal_out;
	
	logic unsigned [23:0] counter = 0;
	
	logic signed [23:0] signal_middle;
	
	sine_lookup lookup_table(counter[23:13], signal_middle);
	
	assign signal_out = (signal_middle / 9'sb011111111) * $signed(volume);
	always_ff @(posedge CLOCK_50) begin
		// reset
		if (reset | (volume == 0)) begin
			counter <= 0;
		end else if (counter >= BOUND) begin
			counter <= counter - BOUND;
		end else begin
			counter <= counter + (frequency / 6);
		end
	end
endmodule

module sine_generator_testbench();
	logic CLOCK_50, reset;
	logic [7:0] volume;
	logic [15:0] frequency;
	logic [23:0] signal_out;
	
	parameter CLOCK_PERIOD = 100;
	initial begin
		CLOCK_50 <= 0;
		forever #(CLOCK_PERIOD/2) CLOCK_50 <= ~CLOCK_50;
	end
	
	sine_generator dut (.*);
	
	initial begin
		volume <= 255;
		frequency <= 440;
		reset <= 1; @(posedge CLOCK_50);
		reset <= 0; @(posedge CLOCK_50);
		repeat(100000) @(posedge CLOCK_50);
		$stop;
	end
endmodule
