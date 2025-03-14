onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /controller_testbench/CLOCK_50
add wave -noupdate /controller_testbench/enabled
add wave -noupdate /controller_testbench/reset
add wave -noupdate /controller_testbench/mode
add wave -noupdate /controller_testbench/instrument
add wave -noupdate /controller_testbench/place_remove_in
add wave -noupdate /controller_testbench/play_pause_in
add wave -noupdate /controller_testbench/stop_in
add wave -noupdate /controller_testbench/left_in
add wave -noupdate /controller_testbench/right_in
add wave -noupdate /controller_testbench/position
add wave -noupdate /controller_testbench/instruments_out
add wave -noupdate /controller_testbench/dut/tempo
add wave -noupdate /controller_testbench/dut/is_playing
add wave -noupdate /controller_testbench/dut/tracks
add wave -noupdate -radix decimal /controller_testbench/dut/beat_counter_position
add wave -noupdate /controller_testbench/mark_end
add wave -noupdate /controller_testbench/reached_end
add wave -noupdate -radix decimal /controller_testbench/dut/beat_counter/soft_count_register
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {891138627 ps} 0}
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
WaveRestoreZoom {0 ps} {1051053518 ps}
