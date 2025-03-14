module seg7two (SW0, SW1, HEX0, HEX1);
	input logic [3:0] SW0, SW1;
	output logic [6:0] HEX0, HEX1;
	logic [6:0] mid0, mid1;
	
	seg7 segegment0(SW0, mid0);
	seg7 segment1(SW1, mid1);
	
	assign HEX0 = ~mid0;
	assign HEX1 = ~mid1;
endmodule

module seg7two_testbench();
	logic [3:0] SW0, SW1;
	logic [6:0] HEX0, HEX1;
	seg7two dut(SW0, SW1, HEX0, HEX1);
	integer i;
	initial begin
		SW0[3:0] = 0;
		SW1[3:0] = 0;
		for (i = 0; i < 4'b1010; i++) begin
			SW0[3:0] = i; #10;
		end
		for (i = 0; i < 4'b1010; i++) begin
			SW1[3:0] = i; #10;
		end
	end
endmodule
