module snare_hit(CLOCK_50, reset, volume, hit, signal_out);
	input logic CLOCK_50, reset, hit;
	input logic [7:0] volume;
	output logic [23:0] signal_out;
	
	logic [31:0] index;
	logic done, short_hit;
	logic is_playing = 0;
	
	input_airlock input_airlock_1(CLOCK_50, reset, hit, short_hit);
	counter snare_counter(CLOCK_50, reset | ~is_playing | short_hit, 1133, 13307085, index, done);
	snare_lookup lookup_table(index[13:0], signal_out);
	
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
//	logic [15:0] body_freq, crack_freq;
//	logic [7:0] body_vol, crack_vol;
//	logic [23:0] body_out, crack_out;
//	
//	logic [15:0] rattle_freqs [4:0];
//	logic [7:0] rattle_vols [4:0];
//	logic [23:0] rattle_outs [4:0];
//	
//	input_airlock input_airlock_1(CLOCK_50, reset, hit, short_hit);
//	
//	// hit signal: CLOCK_50, reset, hit, start_f, end_f, sweep_t, attack_t, attack_v, decay_t, decay_v, release_t, freq_out, vol_out
//	hit_signal body(CLOCK_50, reset, short_hit, 260, 170, 15, 5, 255, 100, 25, 100, body_freq, body_vol);
//	hit_signal rattle1(CLOCK_50, reset, short_hit, 2134, 2134, 0, 5, 10, 175, 0, 0, rattle_freqs[0], rattle_vols[0]);
//	hit_signal rattle2(CLOCK_50, reset, short_hit, 2556, 2556, 0, 4, 10, 175, 0, 0, rattle_freqs[1], rattle_vols[1]);
//	hit_signal rattle3(CLOCK_50, reset, short_hit, 2713, 2713, 0, 3, 10, 175, 0, 0, rattle_freqs[2], rattle_vols[2]);
//	hit_signal rattle4(CLOCK_50, reset, short_hit, 3172, 3172, 0, 2, 10, 175, 0, 0, rattle_freqs[3], rattle_vols[3]);
//	hit_signal rattle5(CLOCK_50, reset, short_hit, 3645, 3645, 0, 1, 10, 175, 0, 0, rattle_freqs[4], rattle_vols[4]);
//	hit_signal crack(CLOCK_50, reset, short_hit, 5000, 5000, 0, 0, 125, 10, 0, 0, crack_freq, crack_vol);
//	
//	// generators: CLOCK_50, reset, volume, frequency, signal_out
//	sine_generator body_sine(CLOCK_50, reset, (volume * body_vol) / 255, body_freq, body_out);
//	sawtooth_generator rattle_saw1(CLOCK_50, reset, (volume * rattle_vols[0]) / 255, rattle_freqs[0], rattle_outs[0]);
//	sawtooth_generator rattle_saw2(CLOCK_50, reset, (volume * rattle_vols[1]) / 255, rattle_freqs[1], rattle_outs[1]);
//	sawtooth_generator rattle_saw3(CLOCK_50, reset, (volume * rattle_vols[2]) / 255, rattle_freqs[2], rattle_outs[2]);
//	sawtooth_generator rattle_saw4(CLOCK_50, reset, (volume * rattle_vols[3]) / 255, rattle_freqs[3], rattle_outs[3]);
//	sawtooth_generator rattle_saw5(CLOCK_50, reset, (volume * rattle_vols[4]) / 255, rattle_freqs[4], rattle_outs[4]);
//	square_generator crack_square(CLOCK_50, reset, (volume * crack_vol) / 255, crack_freq, crack_out);
//	
//	assign signal_out = body_out + rattle_outs[0] + rattle_outs[1] + rattle_outs[2] + rattle_outs[3] + rattle_outs[4] + crack_out;
endmodule
