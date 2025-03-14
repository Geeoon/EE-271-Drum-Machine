module mgmt_kids_lead(CLOCK_50, reset, frequency, volume, hit, signal_out);
	input logic CLOCK_50, reset, hit;
	input logic [15:0] frequency;
	input logic [7:0] volume;
	output logic [23:0] signal_out;
	
	logic [15:0] square_freq, square_vol;
	
	// hit signal: CLOCK_50, reset, hit, start_f, end_f, sweep_t, attack_t, attack_v, decay_t, decay_v, release_t, freq_out, vol_out
	hit_signal square_hit(CLOCK_50, reset, hit, frequency + 10, frequency, 5, 75, 255, 50, 220, 250, square_freq, square_vol);
	
	square_generator crack_square(CLOCK_50, reset, (volume * square_vol) / 255, square_freq, signal_out);
endmodule
