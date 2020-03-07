onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb/top/rst_n
add wave -noupdate /tb/top/rst
add wave -noupdate -divider VGA
add wave -noupdate /tb/top/px_clk
add wave -noupdate /tb/top/VGA_HS
add wave -noupdate /tb/top/VGA_VS
add wave -noupdate -radix hexadecimal /tb/top/h_addr
add wave -noupdate -radix hexadecimal /tb/top/v_addr
add wave -noupdate /tb/top/display/h_count
add wave -noupdate /tb/top/display/v_count
add wave -noupdate -divider Sprite
add wave -noupdate /tb/top/sprite_on
add wave -noupdate -radix decimal /tb/top/ball/x_N_loc
add wave -noupdate -radix decimal /tb/top/ball/y_N_loc
add wave -noupdate -radix hexadecimal /tb/top/ball/x_rel_addr
add wave -noupdate -radix hexadecimal /tb/top/ball/y_rel_addr
add wave -noupdate -radix hexadecimal /tb/top/ball/x_loc
add wave -noupdate -radix hexadecimal /tb/top/ball/y_loc
add wave -noupdate /tb/top/ball/screenbegin
add wave -noupdate /tb/top/ball/update_x
add wave -noupdate /tb/top/ball/update_y
add wave -noupdate /tb/top/ball/x_N_loc_en
add wave -noupdate /tb/top/ball/y_N_loc_en
add wave -noupdate -divider F18
add wave -noupdate /tb/top/j1/clk
add wave -noupdate -radix unsigned /tb/top/j1/pc
add wave -noupdate -radix hexadecimal /tb/top/j1/code_addr
add wave -noupdate -radix hexadecimal /tb/top/j1/insn
add wave -noupdate -radix hexadecimal /tb/top/j1/st0
add wave -noupdate -radix hexadecimal /tb/top/j1/st1
add wave -noupdate /tb/top/j1/io_wr
add wave -noupdate -radix hexadecimal /tb/top/j1/dout
add wave -noupdate -divider {New Divider}
add wave -noupdate -radix hexadecimal /tb/top/IO_Decode_Blk1/io_wr
add wave -noupdate -radix hexadecimal /tb/top/IO_Decode_Blk1/cpu_din
add wave -noupdate -radix hexadecimal /tb/top/IO_Decode_Blk1/cpu_addr
add wave -noupdate /tb/top/IO_Decode_Blk1/io_block_decode
add wave -noupdate /tb/top/IO_Decode_Blk1/io_decode_en
add wave -noupdate -radix hexadecimal /tb/top/IO_Decode_Blk1/delayed_strobe
add wave -noupdate -radix hexadecimal /tb/top/IO_Decode_Blk1/io_dout
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {13672 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 250
configure wave -valuecolwidth 40
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1000
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits us
update
WaveRestoreZoom {0 ps} {228344 ps}
