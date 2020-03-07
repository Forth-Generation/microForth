onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb/top/clk
add wave -noupdate /tb/top/rst_n
add wave -noupdate /tb/top/rst
add wave -noupdate -divider {ram port a}
add wave -noupdate -radix hexadecimal /tb/top/sram/addr_a
add wave -noupdate -radix hexadecimal /tb/top/sram/wdata_a
add wave -noupdate -radix hexadecimal /tb/top/sram/write_en_a
add wave -noupdate -radix hexadecimal /tb/top/sram/rdata_a
add wave -noupdate -divider {ram port b}
add wave -noupdate -radix hexadecimal /tb/top/sram/addr_b
add wave -noupdate -radix hexadecimal /tb/top/sram/rdata_b
add wave -noupdate -divider j1
add wave -noupdate -radix hexadecimal /tb/top/j1_code_addr
add wave -noupdate -radix hexadecimal /tb/top/j1_dout
add wave -noupdate -radix hexadecimal /tb/top/j1_insn
add wave -noupdate -radix hexadecimal /tb/top/j1_io_din
add wave -noupdate -radix hexadecimal /tb/top/j1_io_rd
add wave -noupdate -radix hexadecimal /tb/top/j1_io_wr
add wave -noupdate -radix hexadecimal /tb/top/j1_mem_addr
add wave -noupdate -radix hexadecimal /tb/top/j1_mem_wr
add wave -noupdate -divider gpio
add wave -noupdate -radix hexadecimal /tb/top/gpio_in
add wave -noupdate -radix hexadecimal /tb/top/gpio_oe
add wave -noupdate -radix hexadecimal /tb/top/gpio_out
add wave -noupdate -radix hexadecimal /tb/top/gpio
add wave -noupdate -divider uart_tx
add wave -noupdate -radix hexadecimal /tb/top/uart_tr_top/CO
add wave -noupdate -radix hexadecimal /tb/top/uart_tr_top/Clear_Valid
add wave -noupdate -radix hexadecimal /tb/top/uart_tr_top/Counter_Val
add wave -noupdate -radix hexadecimal /tb/top/uart_tr_top/Data_in
add wave -noupdate -radix hexadecimal /tb/top/uart_tr_top/LC
add wave -noupdate -radix hexadecimal /tb/top/uart_tr_top/LoadSR
add wave -noupdate -radix hexadecimal /tb/top/uart_tr_top/ROMaddr
add wave -noupdate -radix hexadecimal /tb/top/uart_tr_top/SetSR
add wave -noupdate -radix hexadecimal /tb/top/uart_tr_top/Shift
add wave -noupdate -radix hexadecimal /tb/top/uart_tr_top/TBR_Valid
add wave -noupdate -radix hexadecimal /tb/top/uart_tr_top/TBR_en
add wave -noupdate -radix hexadecimal /tb/top/uart_tr_top/Tx
add wave -noupdate -radix hexadecimal /tb/top/uart_tr_top/clk
add wave -noupdate -radix hexadecimal /tb/top/uart_tr_top/reset
add wave -noupdate -radix hexadecimal /tb/top/uart_tr_top/FSM1/state
add wave -noupdate -divider VGA
add wave -noupdate /tb/top/px_clk
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {15211670 ps} 0}
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
WaveRestoreZoom {0 ps} {15750 ns}
