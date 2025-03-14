`timescale 1 ps / 1 ps

// Top-level module that defines the I/Os for the DE-1 SoC board

module DE1_SoC (CLOCK_50, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW, FPGA_I2C_SCLK, FPGA_I2C_SDAT, AUD_XCK, AUD_DACLRCK, AUD_ADCLRCK, AUD_BCLK, AUD_ADCDAT, AUD_DACDAT);
	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output logic [9:0] LEDR;
	input logic [3:0] KEY;
	input logic [9:0] SW;
	input logic CLOCK_50;
	
	// I2C Audio/Video config interface
	output FPGA_I2C_SCLK;
	inout FPGA_I2C_SDAT;
	// Audio CODEC
	output AUD_XCK;
	input AUD_DACLRCK, AUD_ADCLRCK, AUD_BCLK;
	input AUD_ADCDAT;
	output AUD_DACDAT;
	
	logic reset, advance;
	assign reset = SW[9] & SW[8] & SW[7] & SW[6] & ~KEY[3] & ~KEY[2];

	logic [23:0] dac_left, dac_right;
	logic [23:0] kick_signal, snare_signal, synth_signal, synth_signal2, out_signal;
	logic [9:0] position, current_beat, pos_ones, pos_tens, pos_hundreds;
	logic [3:0] safe_keys;
	logic [2:0] octave = 4;
	logic [3:0] note = 0;
	
	logic [2:0] octave_playing [1:0];
	logic [3:0] note_playing [1:0];
	logic down_key, up_key;
	
//   triangle_generator triangle(.CLOCK_50, .reset, .volume(8'd25 * (SW[8])), .frequency(16'd440), .signal_out(triangle_signal));
//	sawtooth_generator sawtooth(.CLOCK_50, .reset, .volume(8'd25 * (SW[7])), .frequency(16'd440), .signal_out(sawtooth_signal));
//	square_generator square(.CLOCK_50, .reset, .volume(8'd25 * (SW[6])), .frequency(16'd440), .signal_out(square_signal));
//	sine_generator sine(.CLOCK_50, .reset, .volume(8'd25 * (SW[5])), .frequency(16'd440), .signal_out(sine_signal));
	
	// instruments
	kick_hit kick(.CLOCK_50, .reset, .volume(), .hit(LEDR[0]), .signal_out(kick_signal));
	snare_hit snare(.CLOCK_50, .reset, .volume(), .hit(LEDR[1]), .signal_out(snare_signal));
	square_generator synth(.CLOCK_50, .reset, .volume(), .octave(octave_playing[0]), .note(note_playing[0]), .signal_out(synth_signal));
	square_generator synth2(.CLOCK_50, .reset, .volume(), .octave(octave_playing[1]), .note(note_playing[1]), .signal_out(synth_signal2));

	seg7 position_inbeat(current_beat, HEX0);
	seg7 position_ones(pos_ones, HEX1);
	seg7 position_tens(pos_tens, HEX2);
	seg7 position_hundreds(pos_hundreds, HEX3);
	
	input_sanitize key0_sanitizer(CLOCK_50, reset, ~KEY[0], safe_keys[0]);
	input_sanitize key1_sanitizer(CLOCK_50, reset, ~KEY[1], safe_keys[1]);
	input_sanitize key2_sanitizer(CLOCK_50, reset, ~KEY[2], safe_keys[2]);
	input_sanitize key3_sanitizer(CLOCK_50, reset, ~KEY[3], safe_keys[3]);
	
	input_airlock down_key_lock(CLOCK_50, reset, safe_keys[3], down_key);
	input_airlock up_key_lock(CLOCK_50, reset, safe_keys[2], up_key);
	
	assign HEX4 = 7'b1111111;
	assign HEX5 = 7'b1111111;
	
//	mgmt_kids_lead lead(.CLOCK_50, .reset, .frequency(16'd440), .volume(8'd25), .hit(~KEY[0]), .signal_out(lead_signal));

	// CLOCK_50, reset, enabled, mode, instrument, left_in, right_in, play_pause_in, stop_in, place_remove_in, instruments_out, position
	controller instrument_controller(.CLOCK_50, .reset, .enabled(1), .mode({SW[1], SW[0]}), .instrument(SW[3:2]), .left_in(safe_keys[3] & ~SW[4]), .right_in(safe_keys[2] & ~SW[4]), .play_pause_in(safe_keys[1]), .stop_in(safe_keys[0]), .place_remove_in(safe_keys[1]), .instruments_out(LEDR[3:0]), .position, .reached_end(LEDR[9]), .mark_end(SW[9] & ~SW[0]), .octave_in(octave), .note_in(note), .octave_out(octave_playing), .note_out(note_playing));

	activate_flop activate_logic(.CLOCK_50, .reset, .in(out_signal), .activate(1), .out(dac_left));
//	activate_flop activate_logic(.CLOCK_50, .reset, .in(triangle_signal + sawtooth_signal + square_signal + sine_signal + kick_signal + snare_signal + lead_signal), .activate(advance), .out(dac_left));
	assign dac_right = dac_left;  // mono
	audio_driver wolfson(.CLOCK_50, .reset,  .dac_left, .dac_right, .adc_left(), .adc_right(), .advance, .FPGA_I2C_SCLK, .FPGA_I2C_SDAT, .AUD_XCK, .AUD_DACLRCK, .AUD_ADCLRCK, .AUD_BCLK, .AUD_ADCDAT, .AUD_DACDAT);
	
	always_comb begin
		if (SW[4]) begin  // changing frequency
			pos_hundreds = 5'b11111;
			pos_tens = 5'b11111;
			if (SW[5]) begin  // changing octave
				pos_ones = 5'b11111;
				current_beat = octave;
			end else begin  // changing note
				case (note)
					0: begin
						pos_ones = 5'b01010;
						current_beat = 5'b11111;
					end
					1: begin
						pos_ones = 5'b01010;
						current_beat = 5'b10001;
					end
					2: begin
						pos_ones = 5'b01011;
						current_beat = 5'b11111;
					end
					3: begin
						pos_ones = 5'b01100;
						current_beat = 5'b11111;
					end
					4: begin
						pos_ones = 5'b01100;
						current_beat = 5'b10001;
					end
					5: begin
						pos_ones = 5'b01101;
						current_beat = 5'b11111;
					end
					6: begin
						pos_ones = 5'b01101;
						current_beat = 5'b10001;
					end
					7: begin
						pos_ones = 5'b01110;
						current_beat = 5'b11111;
					end
					8: begin
						pos_ones = 5'b01111;
						current_beat = 5'b11111;
					end
					9: begin
						pos_ones = 5'b01111;
						current_beat = 5'b10001;
					end
					10: begin
						pos_ones = 5'b10000;
						current_beat = 5'b11111;
					end
					11: begin
						pos_ones = 5'b10000;
						current_beat = 5'b10001;
					end
					default: begin
						pos_ones = 5'b11111;
						current_beat = 5'b11111;
					end
				endcase
			end
		end else begin
			if (SW[1]) begin  // show the current 16th note in the measure
				current_beat = ((position % 16) + 1) % 10;
				pos_ones = (((position % 16) + 1) / 10) % 10;
				pos_tens = 5'b11111;
				pos_hundreds = 5'b11111;
			end else begin
				current_beat = 1 + (position / 4) % 4;
				pos_ones = ((position) / 16) % 10;
				pos_tens = ((position) / 160) % 10;
				pos_hundreds = ((position) / 1600) % 10;
			end
		end

		// the mixing is done here!
		if (LEDR[2] & LEDR[3]) begin
			out_signal = kick_signal + snare_signal + synth_signal + synth_signal2;
		end else if (LEDR[2]) begin
			out_signal = kick_signal + snare_signal + synth_signal;
		end else if (LEDR[3]) begin
			out_signal = kick_signal + snare_signal + synth_signal2;
		end else begin
			out_signal = kick_signal + snare_signal;
		end
	end
		
	always_ff @(posedge CLOCK_50) begin
		if (reset) begin
			octave <= 4;
			note <= 0;
		end else if (SW[4]) begin  // changing frequency
			if (SW[5]) begin  // changing octave
				if (down_key) begin
					if (octave > 0) begin
						octave <= octave - 1;
					end
				end else if (up_key) begin
					if (octave < 7) begin
						octave <= octave + 1;
					end
				end
			end else begin  // changing note
				if (down_key) begin
					if (note > 0) begin
						note <= note - 1;
					end
				end else if (up_key) begin
					if (note < 11) begin
						note <= note + 1;
					end
				end
			end
		end
	end
	
endmodule

module DE1_SoC_testbench();
	logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	logic [9:0] LEDR;
	logic [3:0] KEY;
	logic [9:0] SW;
	logic CLOCK_50;

	parameter CLOCK_PERIOD = 100;
	initial begin
		CLOCK_50 <= 0;
		forever #(CLOCK_PERIOD/2) CLOCK_50 <= ~CLOCK_50;
	end

	DE1_SoC dut (.CLOCK_50, .HEX0, .HEX1, .HEX2, .HEX3, .HEX4, .HEX5, .KEY, .LEDR, .SW, .FPGA_I2C_SCLK(), .FPGA_I2C_SDAT(), .AUD_XCK(), .AUD_DACLRCK(), .AUD_ADCLRCK(), .AUD_BCLK(), .AUD_ADCDAT(), .AUD_DACDAT());
	initial begin
		SW = 10'b1111111111;
		KEY = 4'b0000; @(posedge CLOCK_50);
		SW = 0;
		KEY = 4'b1111; @(posedge CLOCK_50);
		SW = 0; repeat(8) @(posedge CLOCK_50);
		
		// synths
//		SW = 10'b0000001000; @(posedge CLOCK_50);
//		KEY[1] = 0; repeat(8) @(posedge CLOCK_50);
//		KEY[1] = 1; repeat(8) @(posedge CLOCK_50);
//		SW = 10'b0000001100; @(posedge CLOCK_50);
//		KEY[1] = 0; repeat(8) @(posedge CLOCK_50);
//		KEY[1] = 1; repeat(8) @(posedge CLOCK_50);
		
		// drums
		SW = 0; @(posedge CLOCK_50);
		KEY[1] = 0; repeat(8) @(posedge CLOCK_50);
		KEY[1] = 1; repeat(8) @(posedge CLOCK_50);
		SW = 10'b0000000100 ;@(posedge CLOCK_50);
		KEY[1] = 0; repeat(8) @(posedge CLOCK_50);
		KEY[1] = 1; repeat(8) @(posedge CLOCK_50);
		repeat(1000000) @(posedge CLOCK_50);
		
		$stop;
	end
endmodule
