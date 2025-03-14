module triangle_generator #(parameter BOUND=24'sb011111111111100000000000)(CLOCK_50, reset, volume, frequency, signal_out);
	input logic CLOCK_50, reset;
	input logic [7:0] volume;
	input logic [15:0] frequency;
	output logic [23:0] signal_out;
	
	logic signed [23:0] signal_middle;
	logic going_up = 1;
	
	assign signal_out = (signal_middle / 9'sb011111111) * $signed(volume);
	always_ff @(posedge CLOCK_50) begin
		// reset
		if (reset | (volume == 0)) begin
			signal_middle <= 0;
			going_up <= 1;
		end else if (going_up) begin  // triangle up
			signal_middle <= signal_middle + ((2 * frequency) / 3);
		end else begin
			signal_middle <= signal_middle - ((2 * frequency) / 3);
		end
		
		if ($signed(signal_middle) < ~BOUND) begin
			going_up <= 1;
		end else if ($signed(signal_middle) > BOUND) begin
			going_up <= 0;
		end
	end
endmodule

module triangle_generator_testbench();
	logic CLOCK_50, reset;
	logic [7:0] volume;
	logic [15:0] frequency;
	logic [23:0] signal_out;
	
	parameter CLOCK_PERIOD = 100;
	initial begin
		CLOCK_50 <= 0;
		forever #(CLOCK_PERIOD/2) CLOCK_50 <= ~CLOCK_50;
	end
	
	triangle_generator dut (.*);
	
	initial begin
		volume <= 255;
		frequency <= 440;
		reset <= 1; @(posedge CLOCK_50);
		reset <= 0; @(posedge CLOCK_50);
		repeat(100000) @(posedge CLOCK_50);
		$stop;
	end
endmodule
