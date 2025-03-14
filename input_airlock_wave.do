onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /input_airlock_testbench/dut/CLOCK_50
add wave -noupdate /input_airlock_testbench/dut/reset
add wave -noupdate /input_airlock_testbench/dut/in
add wave -noupdate /input_airlock_testbench/dut/out
add wave -noupdate /input_airlock_testbench/dut/down
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 2} {1300 ps} 0}
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
WaveRestoreZoom {0 ps} {2783 ps}
