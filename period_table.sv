module period_table(octave, note, out);
	input logic [2:0] octave;
	input logic [3:0] note;
	output logic signed [23:0] out;
	always_comb begin
		case(octave)
			0: begin
				case (note)
					0: out = 24'(909091);
					1: out = 24'(858068);
					2: out = 24'(809908);
					3: out = 24'(764451);
					4: out = 24'(721546);
					5: out = 24'(681049);
					6: out = 24'(642824);
					7: out = 24'(606745);
					8: out = 24'(572691);
					9: out = 24'(540549);
					10: out = 24'(510210);
					11: out = 24'(481574);
					default: out = 24'bX;
				endcase
			end
			1: begin
				case (note)
					0: out = 24'(454545);
					1: out = 24'(429034);
					2: out = 24'(404954);
					3: out = 24'(382226);
					4: out = 24'(360773);
					5: out = 24'(340524);
					6: out = 24'(321412);
					7: out = 24'(303373);
					8: out = 24'(286346);
					9: out = 24'(270274);
					10: out = 24'(255105);
					11: out = 24'(240787);
					default: out = 24'bX;
				endcase
			end
			2: begin
				case (note)
					0: out = 24'(227273);
					1: out = 24'(214517);
					2: out = 24'(202477);
					3: out = 24'(191113);
					4: out = 24'(180386);
					5: out = 24'(170262);
					6: out = 24'(160706);
					7: out = 24'(151686);
					8: out = 24'(143173);
					9: out = 24'(135137);
					10: out = 24'(127553);
					11: out = 24'(120394);
					default: out = 24'bX;
				endcase
			end
			3: begin
				case (note)
					0: out = 24'(113636);
					1: out = 24'(107258);
					2: out = 24'(101238);
					3: out = 24'(95556);
					4: out = 24'(90193);
					5: out = 24'(85131);
					6: out = 24'(80353);
					7: out = 24'(75843);
					8: out = 24'(71586);
					9: out = 24'(67569);
					10: out = 24'(63776);
					11: out = 24'(60197);
					default: out = 24'bX;
				endcase
			end
			4: begin
				case (note)
					0: out = 24'(56818);
					1: out = 24'(53629);
					2: out = 24'(50619);
					3: out = 24'(47778);
					4: out = 24'(45097);
					5: out = 24'(42566);
					6: out = 24'(40177);
					7: out = 24'(37922);
					8: out = 24'(35793);
					9: out = 24'(33784);
					10: out = 24'(31888);
					11: out = 24'(30098);
					default: out = 24'bX;
				endcase
			end
			5: begin
				case (note)
					0: out = 24'(28409);
					1: out = 24'(26815);
					2: out = 24'(25310);
					3: out = 24'(23889);
					4: out = 24'(22548);
					5: out = 24'(21283);
					6: out = 24'(20088);
					7: out = 24'(18961);
					8: out = 24'(17897);
					9: out = 24'(16892);
					10: out = 24'(15944);
					11: out = 24'(15049);
					default: out = 24'bX;
				endcase
			end
			6: begin
				case (note)
					0: out = 24'(14205);
					1: out = 24'(13407);
					2: out = 24'(12655);
					3: out = 24'(11945);
					4: out = 24'(11274);
					5: out = 24'(10641);
					6: out = 24'(10044);
					7: out = 24'(9480);
					8: out = 24'(8948);
					9: out = 24'(8446);
					10: out = 24'(7972);
					11: out = 24'(7525);
					default: out = 24'bX;
				endcase
			end
			7: begin
				case (note)
					0: out = 24'(7102);
					1: out = 24'(6704);
					2: out = 24'(6327);
					3: out = 24'(5972);
					4: out = 24'(5637);
					5: out = 24'(5321);
					6: out = 24'(5022);
					7: out = 24'(4740);
					8: out = 24'(4474);
					9: out = 24'(4223);
					10: out = 24'(3986);
					11: out = 24'(3762);
					default: out = 24'bX;
				endcase
			end
			default: out = 24'bX;
		endcase
	end
endmodule
