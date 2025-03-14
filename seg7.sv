module seg7 (bcd, leds);
	input logic [4:0] bcd;
	output logic [6:0] leds;

	always_comb begin
		case (bcd)
			// Light: 6543210
			5'b00000: leds = ~7'b0111111; // 0
			5'b00001: leds = ~7'b0000110; // 1
			5'b00010: leds = ~7'b1011011; // 2
			5'b00011: leds = ~7'b1001111; // 3
			5'b00100: leds = ~7'b1100110; // 4
			5'b00101: leds = ~7'b1101101; // 5
			5'b00110: leds = ~7'b1111101; // 6
			5'b00111: leds = ~7'b0000111; // 7
			5'b01000: leds = ~7'b1111111; // 8
			5'b01001: leds = ~7'b1101111; // 9
			5'b01010: leds = 7'b0001000;// A
			5'b01011: leds = 7'b0000011;// B
			5'b01100: leds = 7'b1000110;// C
			5'b01101: leds = 7'b0100001;// D
			5'b01110: leds = 7'b0000110;// E
			5'b01111: leds = 7'b0001110;// F
			5'b10000: leds = 7'b1000010;// G
			5'b10001: leds = 7'b0010010;// S
			5'b11111: leds = ~7'b0000000;
			default: leds = 7'bX;
		endcase
	end
endmodule

module seg7_testbench();
	logic [3:0] bcd;
	logic [6:0] leds;
	seg7 dut(bcd, leds);
	integer i;
	initial begin
		for (i = 0; i < 4'b1010; i++) begin
			bcd = i; #10;
		end
	end
endmodule
