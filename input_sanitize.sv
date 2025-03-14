// prevents metastability of inputs
module input_sanitize(CLOCK_50, reset, in, out);
	input logic CLOCK_50, reset, in;
	logic [1:0] ffs;
	output logic out;
	
	always_ff @(posedge CLOCK_50) begin
		if (reset) ffs <= 2'b00;
		else begin
			ffs[1] <= in;
			ffs[0] <= ffs[1];
			out <= ffs[0];
		end
	end
endmodule
