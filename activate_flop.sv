module activate_flop(CLOCK_50, reset, in, activate, out);
	input logic CLOCK_50, reset, activate;
	input logic [23:0] in;
	output logic [23:0] out;

	always_ff @(posedge CLOCK_50) begin
		if (reset) out <= 0;
		else if (activate) out <= in;
	end

endmodule
