onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb/clk
add wave -noupdate /tb/rst
add wave -noupdate -radix hexadecimal -childformat {{{/tb/delta[1]} -radix hexadecimal} {{/tb/delta[0]} -radix hexadecimal}} -expand -subitemconfig {{/tb/delta[1]} {-height 17 -radix hexadecimal} {/tb/delta[0]} {-height 17 -radix hexadecimal}} /tb/delta
add wave -noupdate -radix hexadecimal /tb/wd
add wave -noupdate /tb/we
add wave -noupdate -divider {register stack}
add wave -noupdate -radix hexadecimal /tb/stack2/tail
add wave -noupdate -radix hexadecimal /tb/stack2/rd
add wave -noupdate -divider ram
add wave -noupdate -radix hexadecimal /tb/ramstack_rd
add wave -noupdate -radix hexadecimal /tb/ram_stack3/ram_wdata
add wave -noupdate /tb/ram_stack3/ram_write
add wave -noupdate -radix hexadecimal /tb/ram_stack3/ram_rdata
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {133313 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 207
configure wave -valuecolwidth 100
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
WaveRestoreZoom {0 ps} {1050 ns}
