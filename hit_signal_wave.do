onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /hit_signal_testbench/reset
add wave -noupdate /hit_signal_testbench/hit
add wave -noupdate -radix unsigned /hit_signal_testbench/freq_out
add wave -noupdate -radix unsigned /hit_signal_testbench/vol_out
add wave -noupdate -radix unsigned /hit_signal_testbench/start_f
add wave -noupdate -radix unsigned /hit_signal_testbench/end_f
add wave -noupdate -radix unsigned /hit_signal_testbench/sweep_t
add wave -noupdate -radix unsigned /hit_signal_testbench/attack_t
add wave -noupdate -radix unsigned /hit_signal_testbench/decay_t
add wave -noupdate -radix unsigned /hit_signal_testbench/release_t
add wave -noupdate -radix unsigned /hit_signal_testbench/attack_v
add wave -noupdate -radix unsigned /hit_signal_testbench/decay_v
add wave -noupdate -radix decimal /hit_signal_testbench/dut/counter
add wave -noupdate -radix unsigned /hit_signal_testbench/dut/sweep_counter
add wave -noupdate /hit_signal_testbench/dut/phase
add wave -noupdate /hit_signal_testbench/dut/next_phase
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {56744374 ps} 0}
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
WaveRestoreZoom {0 ps} {210212111 ps}
