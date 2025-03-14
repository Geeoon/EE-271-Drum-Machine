module clock_divider (clk, reset, div_clk);
	input logic clk, reset;
	output logic [19:0] div_clk;
	
	always_ff @(posedge clk) begin
		if (reset) div_clk <= 0;
		else div_clk <= div_clk + 1'b1;
	end
endmodule
