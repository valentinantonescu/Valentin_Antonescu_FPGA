onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -height 35 /testbench_PS2/SCL
add wave -noupdate -height 35 /testbench_PS2/SDA
add wave -noupdate -height 35 /testbench_PS2/clk
add wave -noupdate -height 35 /testbench_PS2/data_ack
add wave -noupdate -height 35 -radix hexadecimal /testbench_PS2/data_out
add wave -noupdate -height 35 /testbench_PS2/data_out_reg
add wave -noupdate -height 35 /testbench_PS2/data_valid
add wave -noupdate -height 35 /testbench_PS2/direction
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1048 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 194
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
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
WaveRestoreZoom {30 ps} {1033 ps}
