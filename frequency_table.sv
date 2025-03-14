module frequency_table(octave, note, frequency_out);
	input logic [2:0] octave;
	input logic [3:0] note;
	output logic [15:0] frequency_out;
	always_comb begin
		case (octave)
			0: begin
				case (note)
					0: frequency_out = 28;
					1: frequency_out = 29;
					2: frequency_out = 31;
					3: frequency_out = 33;
					4: frequency_out = 35;
					5: frequency_out = 37;
					6: frequency_out = 39;
					7: frequency_out = 41;
					8: frequency_out = 44;
					9: frequency_out = 46;
					10: frequency_out = 49;
					11: frequency_out = 52;
					default: frequency_out = 16'bX;
				endcase
			end
			1: begin
				case (note)
					0: frequency_out = 55;
					1: frequency_out = 58;
					2: frequency_out = 62;
					3: frequency_out = 65;
					4: frequency_out = 69;
					5: frequency_out = 73;
					6: frequency_out = 78;
					7: frequency_out = 82;
					8: frequency_out = 87;
					9: frequency_out = 92;
					10: frequency_out = 98;
					11: frequency_out = 104;
					default: frequency_out = 16'bX;
				endcase
			end
			2: begin
				case (note)
					0: frequency_out = 110;
					1: frequency_out = 117;
					2: frequency_out = 123;
					3: frequency_out = 131;
					4: frequency_out = 139;
					5: frequency_out = 147;
					6: frequency_out = 156;
					7: frequency_out = 165;
					8: frequency_out = 175;
					9: frequency_out = 185;
					10: frequency_out = 196;
					11: frequency_out = 208;
					default: frequency_out = 16'bX;
				endcase
			end
			3: begin
				case (note)
					0: frequency_out = 220;
					1: frequency_out = 233;
					2: frequency_out = 247;
					3: frequency_out = 262;
					4: frequency_out = 277;
					5: frequency_out = 294;
					6: frequency_out = 311;
					7: frequency_out = 330;
					8: frequency_out = 349;
					9: frequency_out = 370;
					10: frequency_out = 392;
					11: frequency_out = 415;
					default: frequency_out = 16'bX;
				endcase
			end
			4: begin
				case (note)
					0: frequency_out = 440;
					1: frequency_out = 466;
					2: frequency_out = 494;
					3: frequency_out = 523;
					4: frequency_out = 554;
					5: frequency_out = 587;
					6: frequency_out = 622;
					7: frequency_out = 659;
					8: frequency_out = 698;
					9: frequency_out = 740;
					10: frequency_out = 784;
					11: frequency_out = 831;
					default: frequency_out = 16'bX;
				endcase
			end
			5: begin
				case (note)
					0: frequency_out = 880;
					1: frequency_out = 932;
					2: frequency_out = 988;
					3: frequency_out = 1047;
					4: frequency_out = 1109;
					5: frequency_out = 1175;
					6: frequency_out = 1245;
					7: frequency_out = 1319;
					8: frequency_out = 1397;
					9: frequency_out = 1480;
					10: frequency_out = 1568;
					11: frequency_out = 1661;
					default: frequency_out = 16'bX;
				endcase
			end
			6: begin
				case (note)
					0: frequency_out = 1760;
					1: frequency_out = 1865;
					2: frequency_out = 1976;
					3: frequency_out = 2093;
					4: frequency_out = 2217;
					5: frequency_out = 2349;
					6: frequency_out = 2489;
					7: frequency_out = 2637;
					8: frequency_out = 2794;
					9: frequency_out = 2960;
					10: frequency_out = 3136;
					11: frequency_out = 3322;
					default: frequency_out = 16'bX;
				endcase
			end
			7: begin
				case (note)
					0: frequency_out = 3520;
					1: frequency_out = 3729;
					2: frequency_out = 3951;
					3: frequency_out = 4186;
					4: frequency_out = 4435;
					5: frequency_out = 4699;
					6: frequency_out = 4978;
					7: frequency_out = 5274;
					8: frequency_out = 5588;
					9: frequency_out = 5920;
					10: frequency_out = 6272;
					11: frequency_out = 6645;
					default: frequency_out = 16'bX;
				endcase
			end
			default: frequency_out = 16'bX;
		endcase
	end
endmodule
