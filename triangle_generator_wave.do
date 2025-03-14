onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /triangle_generator_testbench/dut/CLKS_PER_SECOND
add wave -noupdate /triangle_generator_testbench/dut/CLOCK_50
add wave -noupdate /triangle_generator_testbench/dut/reset
add wave -noupdate /triangle_generator_testbench/dut/volume
add wave -noupdate /triangle_generator_testbench/dut/frequency
add wave -noupdate -expand /triangle_generator_testbench/dut/signal_out
add wave -noupdate /triangle_generator_testbench/dut/signal_middle
add wave -noupdate /triangle_generator_testbench/dut/going_up
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1081089 ps} 0}
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
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {5988068 ps}
