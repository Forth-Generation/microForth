onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb/top/rst_n
add wave -noupdate /tb/top/rst
add wave -noupdate -divider VGA
add wave -noupdate /tb/top/px_clk
add wave -noupdate -radix hexadecimal /tb/top/h_addr
add wave -noupdate -radix hexadecimal /tb/top/v_addr
add wave -noupdate -radix hexadecimal /tb/top/display/h_count
add wave -noupdate -radix hexadecimal /tb/top/display/v_count
add wave -noupdate -divider Sprite
add wave -noupdate /tb/top/sprite_on
add wave -noupdate -radix hexadecimal /tb/top/ball/x_rel_addr
add wave -noupdate -radix hexadecimal /tb/top/ball/y_rel_addr
add wave -noupdate -radix hexadecimal /tb/top/ball/x_loc
add wave -noupdate -radix hexadecimal /tb/top/ball/y_loc
add wave -noupdate -radix hexadecimal /tb/top/ball/mem_addr
add wave -noupdate -radix hexadecimal /tb/top/ball/sprite_mem_start
add wave -noupdate -radix hexadecimal /tb/top/ball/sprite_data_y_sel
add wave -noupdate -radix hexadecimal /tb/top/ball/line
add wave -noupdate /tb/top/ball/inBox
add wave -noupdate /tb/top/ball/sprite_on
add wave -noupdate /tb/top/paddle_left/sprite_on
add wave -noupdate /tb/top/paddle_left/inY
add wave -noupdate -radix hexadecimal /tb/top/paddle_left/mem_addr
add wave -noupdate -radix hexadecimal /tb/top/paddle_left/line
add wave -noupdate -radix hexadecimal /tb/top/paddle_left/x_rel_addr
add wave -noupdate -radix hexadecimal /tb/top/paddle_left/y_rel_addr
add wave -noupdate -radix hexadecimal /tb/top/paddle_left/sprite_data_y_sel
add wave -noupdate -radix hexadecimal /tb/top/paddle_left/sprite_data_x_sel
add wave -noupdate -radix hexadecimal /tb/top/paddle_left/y_scale_cnt
add wave -noupdate /tb/top/paddle_left/inc_y
add wave -noupdate -divider {Image Loader}
add wave -noupdate /tb/top/image_loader/state_reg
add wave -noupdate -radix hexadecimal /tb/top/image_loader/mem_addr_out
add wave -noupdate /tb/top/image_loader/load_en
add wave -noupdate /tb/top/image_loader/img_load_done
add wave -noupdate -divider {VGA Interface}
add wave -noupdate -radix hexadecimal /tb/top/interface/cpu_addr
add wave -noupdate -radix hexadecimal /tb/top/interface/cpu_din
add wave -noupdate /tb/top/interface/io_wr
add wave -noupdate /tb/top/interface/en
add wave -noupdate /tb/top/interface/clr_sem
add wave -noupdate -radix hexadecimal /tb/top/interface/addr_b
add wave -noupdate /tb/top/interface/wren_a
add wave -noupdate /tb/top/interface/state_reg
add wave -noupdate -radix hexadecimal /tb/top/interface/reg_data
add wave -noupdate /tb/top/interface/cnt
add wave -noupdate /tb/top/interface/c_en
add wave -noupdate /tb/top/interface/addr_sel
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1526181 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 262
configure wave -valuecolwidth 50
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
WaveRestoreZoom {17537557 ps} {17585504 ps}
