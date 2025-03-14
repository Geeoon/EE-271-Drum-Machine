onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /counter_testbench/CLOCK_50
add wave -noupdate /counter_testbench/reset
add wave -noupdate -radix decimal /counter_testbench/limit
add wave -noupdate -radix decimal /counter_testbench/hard_limit
add wave -noupdate -radix decimal /counter_testbench/out
add wave -noupdate /counter_testbench/hard_out
add wave -noupdate -radix unsigned /counter_testbench/dut/hard_count_register
add wave -noupdate -radix unsigned /counter_testbench/dut/soft_count_register
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {661 ps} 0}
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
WaveRestoreZoom {0 ps} {2564 ps}
