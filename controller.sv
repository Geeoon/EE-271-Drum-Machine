module controller #(parameter SIZE=512)(CLOCK_50, reset, enabled, mode, instrument, left_in, right_in, play_pause_in, stop_in, place_remove_in, instruments_out, position, reached_end, mark_end, octave_in, note_in, octave_out, note_out);
	input logic CLOCK_50, reset, enabled;
	
	// ASSUMED TO BE A 4/4 COMPOSITION
	
	// 0 for composition
	// 1 for playback
	// mode[1] == 1 moves by 32nd notes
	input logic [1:0] mode;
	
	// ----------- exclusively composition mode -----------
	// 0 == kick
	// 1 == snare
	// 5-2 == square synth
	// 6-3 == square synth 2
	// completely ignored when not in composition mode
	
	input logic [1:0] instrument;
	input logic place_remove_in, mark_end;
	logic place_remove;
	input logic [2:0] octave_in;
	input logic [3:0] note_in;
	
	input_airlock place_remove_airlock(CLOCK_50, reset, place_remove_in, place_remove);
	
	// ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
	
	// -------- both composition and playback mode --------
	
	output logic [9:0] position;
	logic [9:0] end_position = SIZE - 1;
	logic [9:0] pause_position;
//	logic [7:0] tempo = 120;
//	logic [7:0] volume = 255;
	input logic left_in, right_in;
	logic left, right;
	output logic reached_end;
	
	input_airlock left_airlock(CLOCK_50, reset, left_in, left);
	input_airlock right_airlock(CLOCK_50, reset, right_in, right);
	
	// same as defined above in `instrument`
	output logic [3:0] instruments_out;
	
	// ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
	
	
	// ------------ exclusively playback mode ------------
	
	input logic play_pause_in, stop_in;
	logic play_pause, stop;
	logic is_playing = 0;
	logic [31:0] beat_counter_position;
	output logic [2:0] octave_out [1:0];
	output logic [3:0] note_out [1:0];
	input_airlock play_pause_airlock(CLOCK_50, reset, play_pause_in, play_pause);
	input_airlock is_playing_airlock(CLOCK_50, reset, stop_in, stop);
	// every ((50000000 / (tempo / 60)) / 4) clock ticks should be half a beat beat (8th note).
	// SIMPLIFIED 750000000 / tempo
//	counter beat_counter(.CLOCK_50, .reset(reset | ~is_playing | position >= (end_position - 1)), .limit(750000000 / tempo), .hard_limit((750000000 / tempo) * SIZE), .out(beat_counter_position), .hard_out());
	counter beat_counter(.CLOCK_50, .reset(reset | ~is_playing | position >= (end_position - 1)), .limit(6250000), .hard_limit(3200000000), .out(beat_counter_position), .hard_out());
	
	// ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
	
	
	// (31:24) indicate hits.  If 0, rest, otherwise, hit.  When looping, it indicates the # of loops, 0 meaning infinite loops
	// (23:8) indicates the position to loop to.
	// all other bits are reserved and should not be used
	logic [31:0] tracks [0:SIZE - 1][3:0];
	integer i, j;
	always_ff @(posedge CLOCK_50) begin
		if (reset) begin
			for (i = 0; i < SIZE; i++) begin
				for (j = 0; j < 4; j++) begin
					tracks[i][j] <= 0;
				end
			end
			is_playing <= 0;
			position <= 0;
//			tempo <= 120;
//			volume <= 255;
			pause_position <= 0;
		end else if (enabled) begin
			if (stop) begin
				position <= 0;
				is_playing <= 0;
				pause_position <= 0;
			end
			
			if (~is_playing) begin
				if (left) begin
					if (mode[1] == 0) begin
						if (position > 3) begin
							position <= position - 10'd4;
						end else begin
							position <= 0;
						end
					end else begin
						if (position > 0) begin
							position <= position - 10'd1;
						end
					end 
				end else if (right) begin
					if (mode[1] == 0) begin
						if (position < SIZE - 4) begin
							if (place_remove_in) begin
								tracks[position][instrument][31:24] <= 255;
								tracks[position + 1][instrument][31:24] <= 255;
								tracks[position + 2][instrument][31:24] <= 255;
								tracks[position + 3][instrument][31:24] <= 255;
								if (instrument > 1) begin  // if synth
									tracks[position][instrument][23:21] <= octave_in;
									tracks[position + 1][instrument][23:21] <= octave_in;
									tracks[position + 2][instrument][23:21] <= octave_in;
									tracks[position + 3][instrument][23:21] <= octave_in;
									
									tracks[position][instrument][20:17] <=  note_in;
									tracks[position + 1][instrument][20:17] <=  note_in;
									tracks[position + 2][instrument][20:17] <=  note_in;
									tracks[position + 3][instrument][20:17] <=  note_in;
								end
							end
							position <= position + 10'd4;
						end else begin
							position <= SIZE - 1;
						end
					end else begin
						if (position < SIZE - 1) begin
							position <= position + 10'd1;
						end
					end
				end
			end
			
			if (mode[0] == 0) begin  // composition mode
				is_playing <= 0;
				if (mark_end) begin
					end_position <= position;
				end
				if (place_remove) begin
					if (tracks[position][instrument][31:24] == 0) begin
						tracks[position][instrument][31:24] <= 255;
						tracks[position][instrument][23:21] <= octave_in;
						tracks[position][instrument][20:17] <= note_in;
					end else begin
						tracks[position][instrument][31:24] <= 0;
					end
				end
				
			end else if (mode[0] == 1) begin  // playback mode
				if (play_pause) begin
					is_playing <= ~is_playing;
					pause_position <= position;
				end
				if (~stop & is_playing) begin
					if (position >= SIZE - 1) begin
						is_playing <= 0;
						position <= SIZE - 1;
					end else begin
						if (position < end_position - 1) begin
							position <= beat_counter_position + pause_position;
						end else begin
							pause_position <= 0;
							position <= 0;
						end
					end
				end
			end
		end
	end
	
	integer k;
	always_comb begin
		for (k = 0; k < 4; k++) begin
			instruments_out[k] = tracks[position][k][31:24] != 0;
		end
		
		if (tracks[position][2][31:24] != 0) begin
			octave_out[0] = tracks[position][2][23:21];
			note_out[0] = tracks[position][2][20:17];
		end else begin
			octave_out[0] = 0;
			note_out[0] = 13;
		end
		if (tracks[position][3][31:24] != 0) begin
			octave_out[1] = tracks[position][3][23:21];
			note_out[1] = tracks[position][3][20:17];
		end else begin
			octave_out[1] = 0;
			note_out[1] = 13;
		end
		reached_end = position == end_position;
	end
endmodule

module controller_testbench();
	logic CLOCK_50, reset, enabled;
	logic [1:0] mode;
	logic [2:0] instrument;
	logic place_remove_in;
	logic play_pause_in, stop_in;
	logic left_in, right_in;
	
	logic [9:0] position;
	logic mark_end, reached_end;
	logic [7:0] instruments_out;
	logic [2:0] octave_in;
	logic [2:0] octave_out [1:0];
	logic [3:0] note_in;
	logic [3:0] note_out [1:0];
	
	parameter CLOCK_PERIOD = 100;
	initial begin
		CLOCK_50 <= 0;
		forever #(CLOCK_PERIOD/2) CLOCK_50 <= ~CLOCK_50;
	end
	
	controller dut (.*);
	
	integer i;
	initial begin
		play_pause_in = 0;
		stop_in = 0;
		left_in = 0;
		right_in = 0;
		place_remove_in = 0;
		instrument = 0;
		mode = 2'b10;
		mark_end = 0;
		enabled = 1;
		reset = 1; @(posedge CLOCK_50);
		reset = 0; @(posedge CLOCK_50);
		repeat(100) @(posedge CLOCK_50);
		
		// MOVEMENT
		for (i = 0; i < 2000; i++) begin
			right_in = 1; @(posedge CLOCK_50);
			right_in = 0; @(posedge CLOCK_50);
		end
		for (i = 0; i < 2000; i++) begin
			left_in = 1; @(posedge CLOCK_50);
			left_in = 0; @(posedge CLOCK_50);
		end
		for (i = 0; i < 500; i++) begin
			right_in = 1; @(posedge CLOCK_50);
			right_in = 0; @(posedge CLOCK_50);
		end
		stop_in = 1; @(posedge CLOCK_50);
		stop_in = 0; @(posedge CLOCK_50);
		
		// PLACING NOTES
		repeat(100) @(posedge CLOCK_50);
		mode = 2'b10;
		// kicks
		instrument = 0; @(posedge CLOCK_50);
		for (i = 0; i < 100; i++) begin
			place_remove_in = 1; @(posedge CLOCK_50);
			place_remove_in = 0; @(posedge CLOCK_50);
			right_in = 1; @(posedge CLOCK_50);
			right_in = 0; @(posedge CLOCK_50);
		end
		// snare
		stop_in = 1; @(posedge CLOCK_50);
		stop_in = 0; @(posedge CLOCK_50);
		instrument = 1; @(posedge CLOCK_50);
		for (i = 0; i < 100; i++) begin
			place_remove_in = 1; @(posedge CLOCK_50);
			place_remove_in = 0; @(posedge CLOCK_50);
			right_in = 1; @(posedge CLOCK_50);
			right_in = 0; @(posedge CLOCK_50);
		end
		
		// REMOVING NOTES
		stop_in = 1; @(posedge CLOCK_50);
		stop_in = 0; @(posedge CLOCK_50);
		instrument = 0; @(posedge CLOCK_50);
		right_in = 1; @(posedge CLOCK_50);
		right_in = 0; @(posedge CLOCK_50);
		place_remove_in = 1; @(posedge CLOCK_50);
		place_remove_in = 0; @(posedge CLOCK_50);
		
		
		stop_in = 1; @(posedge CLOCK_50);
		stop_in = 0; @(posedge CLOCK_50);
		instrument = 1; @(posedge CLOCK_50);
		right_in = 1; @(posedge CLOCK_50);
		right_in = 0; @(posedge CLOCK_50);
		place_remove_in = 1; @(posedge CLOCK_50);
		place_remove_in = 0; @(posedge CLOCK_50);
		
		// ADD STOP ON 3rd 32nd note
		stop_in = 1; @(posedge CLOCK_50);
		stop_in = 0; @(posedge CLOCK_50);
		mark_end = 1; @(posedge CLOCK_50);
		right_in = 1; @(posedge CLOCK_50);
		right_in = 0; @(posedge CLOCK_50);
		right_in = 1; @(posedge CLOCK_50);
		right_in = 0; @(posedge CLOCK_50);
		right_in = 1; @(posedge CLOCK_50);
		right_in = 0; @(posedge CLOCK_50);
		mark_end = 0;
		
		
		// PLAY FROM START
		stop_in = 1;
		mode = 1; @(posedge CLOCK_50);
		stop_in = 0; @(posedge CLOCK_50);
		
		play_pause_in = 1; @(posedge CLOCK_50);
		repeat(10000000) @(posedge CLOCK_50);
		
		
		$stop;
	end
endmodule
