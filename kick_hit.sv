module kick_hit(CLOCK_50, reset, volume, hit, signal_out);
	input logic CLOCK_50, reset, hit;
	input logic [7:0] volume;
	output logic [23:0] signal_out;
	
	logic [31:0] index;
	logic done, short_hit;
	logic is_playing = 0;
	
	// snare: 4535, 13314760
	// kick: 4535, 24697610
	input_airlock input_airlock_1(CLOCK_50, reset, hit, short_hit);
	counter kick_counter(CLOCK_50, reset | ~is_playing | short_hit, 1133, 24683538, index, done);
	kick_lookup lookup_table(index[14:0], signal_out);
	
	always_ff @(posedge CLOCK_50) begin
		if (reset) begin
			is_playing <= 0;
		end else begin
			if (short_hit) begin
				is_playing <= 1;
			end else if (done) begin
				is_playing <= 0;
			end
		end
	end
	
//	logic short_hit;
	
//	logic [15:0] sub_bass_freq, punch_body_freq, click_freq;
//	logic [7:0] sub_bass_vol, punch_body_vol, click_vol;
//	logic [23:0] sub_bass_out, punch_body_out, click_out;
	
//	input_airlock input_airlock_1(CLOCK_50, reset, hit, short_hit);
	
	
	
	
	// hit signal: CLOCK_50, reset, hit, start_f, end_f, sweep_t, attack_t, attack_v, decay_t, decay_v, release_t, freq_out, vol_out
//	hit_signal sub_bass_thump(CLOCK_50, reset, short_hit, 125, 40, 20, 5, 255, 100, 20, 30, sub_bass_freq, sub_bass_vol);
//	hit_signal punch_and_body(CLOCK_50, reset, short_hit, 100, 50, 30, 5, 230, 115, 0, 0, punch_body_freq, punch_body_vol);
//	hit_signal click(CLOCK_50, reset, short_hit, 3000, 3000, 0, 0, 20, 8, 0, 0, click_freq, click_vol);
	// generators: CLOCK_50, reset, volume, frequency, signal_out
//	sine_generator sub_bass_sine(CLOCK_50, reset, (volume * sub_bass_vol) / 255, sub_bass_freq, sub_bass_out);
//	triangle_generator punch_body_square(CLOCK_50, reset, (volume * punch_body_vol) / 255, punch_body_freq, punch_body_out);
//	sawtooth_generator click_saw(CLOCK_50, reset, (volume * click_vol) / 255, click_freq, click_out);
	
//	assign signal_out = sub_bass_out + punch_body_out + click_out;
endmodule

module kick_hit_testbench();
	logic CLOCK_50, reset, hit;
	logic [7:0] volume;
	logic [23:0] signal_out;
	
	kick_hit dut(.*);
	
	parameter CLOCK_PERIOD = 10;
	initial begin
		CLOCK_50 <= 0;
		forever #(CLOCK_PERIOD/2) CLOCK_50 <= ~CLOCK_50;
	end
	
	initial begin
		reset = 1;
		hit = 0;
		volume = 255; @(posedge CLOCK_50);
		reset = 0;
		hit = 1; repeat(100) @(posedge CLOCK_50);
		hit = 0; repeat(1000000) @(posedge CLOCK_50);
		$stop;
	end

endmodule

