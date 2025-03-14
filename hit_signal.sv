module hit_signal(CLOCK_50, reset, hit, start_f, end_f, sweep_t, attack_t, attack_v, decay_t, decay_v, release_t, freq_out, vol_out);
	// when hit goes high, that means start the attack phase
	// time in ms
	// frequency in hz
	// CLOCK_50: 50Hz clock, 20ns period
	// start_f: the frequency at the start of the signal
	// end_f: the frequency at the end of the signal
	// sweep_t: time it takes for frequency to go from start_f to end_f.  Linear
	// attacK_t: the time it takes the attack phase to end
	// attack_v: the volume at the end of the attack phase
	// decay_t: the time it takes to reach the end of the decay phase
	// decay_v: the volume at the end of the decay phase
	// release_t: the time it takes for the release phase to end and reach 0 volume
	
	// it is implied that the sustain will continue at the decay_v volume
	
	// to convert counter to ms: (2^32) * 20 * 1e-6
	
	input logic CLOCK_50, reset, hit;  // dynamic
	input logic [15:0] start_f, end_f, sweep_t, attack_t, decay_t, release_t;  // should be held constant, undefined behavior for changes
	input logic [7:0] attack_v, decay_v;  // should be held constant
	output logic [15:0] freq_out;
	output logic [7:0] vol_out;
	
	enum {idle, attack, decay, sustain, release_phase} phase, next_phase = idle;
	
	logic [31:0] volume_counter_limit, volume_counter_out, sweep_counter_out;
	logic volume_counter_done, sweep_counter_done;
	logic volume_reset, sweep_reset;

	// @param limit the limit at which to increment \p out
	// @param hard_limit the limit at which to set \p hard_out to 1
	// @param out the number of times the \p limit has been reached
	// @param hard_out whether the \p hard_limit has been reached
	counter volume_counter(CLOCK_50, reset | volume_reset, 32'd50000, volume_counter_limit, volume_counter_out, volume_counter_done);
	counter sweep_counter(CLOCK_50, reset | sweep_reset, 32'd50000, sweep_t, sweep_counter_out, sweep_counter_done);
	
	always_ff @(posedge CLOCK_50) begin
		if (reset) begin
			vol_out <= 0;
			phase <= idle;
			volume_reset <= 1;
			sweep_reset <= 1;
		end else begin
			phase <= next_phase;
			if (phase == idle) begin
				vol_out <= 0;
				volume_reset <= 1;
				sweep_reset <= 1;
			end else begin
				if (~(phase == next_phase)) begin
					volume_reset <= 1;
				end else begin
					volume_reset <= 0;
				end
				
				if (phase == attack) begin
					vol_out <= ((volume_counter_out * attack_v) / attack_t);
				end else if (phase == decay) begin
					vol_out <= ((volume_counter_out * decay_v) / decay_t) + attack_v - ((volume_counter_out * attack_v) / decay_t);
				end else if (phase == sustain) begin
					vol_out <= decay_v;
				end else if (phase == release_phase) begin
					vol_out <= decay_v - ((volume_counter_out * decay_v) / release_t);
				end
			end
		end
	end
	
	always_comb begin
		freq_out = (((sweep_counter_out * end_f)) / sweep_t) + start_f - (((volume_counter_out * start_f)) / sweep_t);
		case (phase)
			idle: begin
				volume_counter_limit = 0;  // doesn't matter what it is here
				if (hit) begin
					next_phase = attack;
				end else begin 
					next_phase = idle;
				end
			end
			
			attack: begin
				volume_counter_limit = attack_t * 50000;
				if (volume_counter_done) begin
					next_phase = decay;
				end else begin 
					next_phase = attack;
				end
			end
			
			decay: begin
				volume_counter_limit = decay_t * 50000;
				if (volume_counter_done) next_phase = sustain;
				else next_phase = decay;
			end
			
			sustain: begin
				volume_counter_limit = 0;  // doesn't matter what it is here
				if (~hit) next_phase = release_phase;
				else next_phase = sustain;
			end
			
			release_phase: begin
				volume_counter_limit = release_t * 50000;
				if (volume_counter_done) next_phase = idle;
				else next_phase = release_phase;
			end
			default: begin
				volume_counter_limit = 0;
				next_phase = idle;
			end
		endcase
	end
endmodule

module hit_signal_testbench();
	logic CLOCK_50, reset, hit;
	logic [15:0] start_f, end_f, sweep_t, attack_t, decay_t, release_t;
	logic [7:0] attack_v, decay_v;
	logic [15:0] freq_out;
	logic [7:0] vol_out;
	
	hit_signal dut(.*);
	parameter CLOCK_PERIOD = 20;
	initial begin
		CLOCK_50 <= 0;
		forever #(CLOCK_PERIOD/2) CLOCK_50 <= ~CLOCK_50;
	end
	
	initial begin
		reset = 1;
		hit = 0;
		start_f = 1000;
		end_f = 500;
		sweep_t = 30;
		attack_t = 10;
		attack_v = 255;
		decay_t = 10;
		decay_v = 210;
		release_t = 50; @(posedge CLOCK_50);
		reset = 0; repeat(100) @(posedge CLOCK_50);
		hit = 1; repeat(10000) @(posedge CLOCK_50);
		hit = 1; repeat(5000000) @(posedge CLOCK_50);
		hit = 0; repeat(5000000) @(posedge CLOCK_50);
		$stop;
	end
	
endmodule
