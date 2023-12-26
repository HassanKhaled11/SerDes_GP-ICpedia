onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /top/dut_if/write_clk
add wave -noupdate /top/dut_if/read_clk
add wave -noupdate /top/dut_if/rst_n
add wave -noupdate /top/dut_if/skp_added
add wave -noupdate /top/dut_if/Skp_Removed
add wave -noupdate /top/dut_if/buffer_mode
add wave -noupdate /top/dut_if/write_enable
add wave -noupdate -color Salmon /top/dut_if/read_enable
add wave -noupdate -color {Medium Spring Green} /top/dut_if/overflow
add wave -noupdate -color {Medium Spring Green} /top/dut_if/underflow
add wave -noupdate -color Magenta /top/dut_if/data_in
add wave -noupdate -color Magenta -radix hexadecimal /top/internal_if/write_address
add wave -noupdate -color Magenta -radix binary /top/internal_if/gray_write_pointer
add wave -noupdate -color Yellow /top/dut_if/data_out
add wave -noupdate -color Yellow /top/internal_if/read_address
add wave -noupdate -color Yellow -radix binary -childformat {{{/top/internal_if/gray_read_pointer[4]} -radix binary} {{/top/internal_if/gray_read_pointer[3]} -radix binary} {{/top/internal_if/gray_read_pointer[2]} -radix binary} {{/top/internal_if/gray_read_pointer[1]} -radix binary} {{/top/internal_if/gray_read_pointer[0]} -radix binary}} -subitemconfig {{/top/internal_if/gray_read_pointer[4]} {-color Yellow -height 15 -radix binary} {/top/internal_if/gray_read_pointer[3]} {-color Yellow -height 15 -radix binary} {/top/internal_if/gray_read_pointer[2]} {-color Yellow -height 15 -radix binary} {/top/internal_if/gray_read_pointer[1]} {-color Yellow -height 15 -radix binary} {/top/internal_if/gray_read_pointer[0]} {-color Yellow -height 15 -radix binary}} /top/internal_if/gray_read_pointer
add wave -noupdate -expand /top/DUT/elastic_mem_inst/buffer
add wave -noupdate /top/DUT/write_clk
add wave -noupdate /top/DUT/read_clk
add wave -noupdate /top/DUT/buffer_mode
add wave -noupdate /top/DUT/write_enable
add wave -noupdate /top/DUT/read_enable
add wave -noupdate /top/DUT/rst_n
add wave -noupdate /top/DUT/skp_added
add wave -noupdate /top/DUT/Skp_Removed
add wave -noupdate /top/DUT/data_in
add wave -noupdate /top/DUT/overflow
add wave -noupdate /top/DUT/underflow
add wave -noupdate /top/DUT/data_out
add wave -noupdate /top/DUT/gray_write_pointer
add wave -noupdate /top/DUT/gray_read_pointer
add wave -noupdate /top/DUT/write_address
add wave -noupdate /top/DUT/read_address
add wave -noupdate /top/DUT/sync_gray_read_out
add wave -noupdate /top/DUT/sync_gray_write_out
add wave -noupdate /top/DUT/delete_req
add wave -noupdate /top/DUT/insert
add wave -noupdate /top/DUT/add_req
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {231 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 240
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
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {832 ns}
