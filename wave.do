onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /DE1_SoC_testbench/CLOCK_50
add wave -noupdate /DE1_SoC_testbench/SW
add wave -noupdate /DE1_SoC_testbench/HEX0
add wave -noupdate /DE1_SoC_testbench/HEX1
add wave -noupdate /DE1_SoC_testbench/HEX2
add wave -noupdate /DE1_SoC_testbench/HEX3
add wave -noupdate /DE1_SoC_testbench/HEX4
add wave -noupdate /DE1_SoC_testbench/HEX5
add wave -noupdate /DE1_SoC_testbench/LEDR
add wave -noupdate /DE1_SoC_testbench/KEY
add wave -noupdate /DE1_SoC_testbench/SW
add wave -noupdate /DE1_SoC_testbench/dut/dac_left
add wave -noupdate /DE1_SoC_testbench/dut/kick/volume
add wave -noupdate -radix decimal /DE1_SoC_testbench/dut/kick/signal_out
add wave -noupdate /DE1_SoC_testbench/dut/kick/is_playing
add wave -noupdate /DE1_SoC_testbench/dut/kick/done
add wave -noupdate /DE1_SoC_testbench/dut/kick/short_hit
add wave -noupdate /DE1_SoC_testbench/dut/kick/index
add wave -noupdate /DE1_SoC_testbench/dut/snare/volume
add wave -noupdate -radix decimal -childformat {{{/DE1_SoC_testbench/dut/snare/signal_out[23]} -radix decimal} {{/DE1_SoC_testbench/dut/snare/signal_out[22]} -radix decimal} {{/DE1_SoC_testbench/dut/snare/signal_out[21]} -radix decimal} {{/DE1_SoC_testbench/dut/snare/signal_out[20]} -radix decimal} {{/DE1_SoC_testbench/dut/snare/signal_out[19]} -radix decimal} {{/DE1_SoC_testbench/dut/snare/signal_out[18]} -radix decimal} {{/DE1_SoC_testbench/dut/snare/signal_out[17]} -radix decimal} {{/DE1_SoC_testbench/dut/snare/signal_out[16]} -radix decimal} {{/DE1_SoC_testbench/dut/snare/signal_out[15]} -radix decimal} {{/DE1_SoC_testbench/dut/snare/signal_out[14]} -radix decimal} {{/DE1_SoC_testbench/dut/snare/signal_out[13]} -radix decimal} {{/DE1_SoC_testbench/dut/snare/signal_out[12]} -radix decimal} {{/DE1_SoC_testbench/dut/snare/signal_out[11]} -radix decimal} {{/DE1_SoC_testbench/dut/snare/signal_out[10]} -radix decimal} {{/DE1_SoC_testbench/dut/snare/signal_out[9]} -radix decimal} {{/DE1_SoC_testbench/dut/snare/signal_out[8]} -radix decimal} {{/DE1_SoC_testbench/dut/snare/signal_out[7]} -radix decimal} {{/DE1_SoC_testbench/dut/snare/signal_out[6]} -radix decimal} {{/DE1_SoC_testbench/dut/snare/signal_out[5]} -radix decimal} {{/DE1_SoC_testbench/dut/snare/signal_out[4]} -radix decimal} {{/DE1_SoC_testbench/dut/snare/signal_out[3]} -radix decimal} {{/DE1_SoC_testbench/dut/snare/signal_out[2]} -radix decimal} {{/DE1_SoC_testbench/dut/snare/signal_out[1]} -radix decimal} {{/DE1_SoC_testbench/dut/snare/signal_out[0]} -radix decimal}} -subitemconfig {{/DE1_SoC_testbench/dut/snare/signal_out[23]} {-height 15 -radix decimal} {/DE1_SoC_testbench/dut/snare/signal_out[22]} {-height 15 -radix decimal} {/DE1_SoC_testbench/dut/snare/signal_out[21]} {-height 15 -radix decimal} {/DE1_SoC_testbench/dut/snare/signal_out[20]} {-height 15 -radix decimal} {/DE1_SoC_testbench/dut/snare/signal_out[19]} {-height 15 -radix decimal} {/DE1_SoC_testbench/dut/snare/signal_out[18]} {-height 15 -radix decimal} {/DE1_SoC_testbench/dut/snare/signal_out[17]} {-height 15 -radix decimal} {/DE1_SoC_testbench/dut/snare/signal_out[16]} {-height 15 -radix decimal} {/DE1_SoC_testbench/dut/snare/signal_out[15]} {-height 15 -radix decimal} {/DE1_SoC_testbench/dut/snare/signal_out[14]} {-height 15 -radix decimal} {/DE1_SoC_testbench/dut/snare/signal_out[13]} {-height 15 -radix decimal} {/DE1_SoC_testbench/dut/snare/signal_out[12]} {-height 15 -radix decimal} {/DE1_SoC_testbench/dut/snare/signal_out[11]} {-height 15 -radix decimal} {/DE1_SoC_testbench/dut/snare/signal_out[10]} {-height 15 -radix decimal} {/DE1_SoC_testbench/dut/snare/signal_out[9]} {-height 15 -radix decimal} {/DE1_SoC_testbench/dut/snare/signal_out[8]} {-height 15 -radix decimal} {/DE1_SoC_testbench/dut/snare/signal_out[7]} {-height 15 -radix decimal} {/DE1_SoC_testbench/dut/snare/signal_out[6]} {-height 15 -radix decimal} {/DE1_SoC_testbench/dut/snare/signal_out[5]} {-height 15 -radix decimal} {/DE1_SoC_testbench/dut/snare/signal_out[4]} {-height 15 -radix decimal} {/DE1_SoC_testbench/dut/snare/signal_out[3]} {-height 15 -radix decimal} {/DE1_SoC_testbench/dut/snare/signal_out[2]} {-height 15 -radix decimal} {/DE1_SoC_testbench/dut/snare/signal_out[1]} {-height 15 -radix decimal} {/DE1_SoC_testbench/dut/snare/signal_out[0]} {-height 15 -radix decimal}} /DE1_SoC_testbench/dut/snare/signal_out
add wave -noupdate /DE1_SoC_testbench/dut/snare/done
add wave -noupdate /DE1_SoC_testbench/dut/snare/short_hit
add wave -noupdate /DE1_SoC_testbench/dut/snare/is_playing
add wave -noupdate /DE1_SoC_testbench/dut/snare/index
add wave -noupdate /DE1_SoC_testbench/dut/kick/reset
add wave -noupdate /DE1_SoC_testbench/dut/kick/kick_counter/soft_count_register
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {26136 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {262973 ps}
