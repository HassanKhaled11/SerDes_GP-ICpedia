onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /channel_Tb/clk
add wave -noupdate /channel_Tb/rst_n
add wave -noupdate /channel_Tb/in
add wave -noupdate /channel_Tb/out
add wave -noupdate /channel_Tb/inputVal
add wave -noupdate -divider -height 30 Channel
add wave -noupdate /channel_Tb/channel_inst/FASTER_CLK_PERIOD
add wave -noupdate /channel_Tb/channel_inst/NUMBER_OF_LEVELS
add wave -noupdate /channel_Tb/channel_inst/THRESHOLD
add wave -noupdate /channel_Tb/channel_inst/clk
add wave -noupdate /channel_Tb/channel_inst/rst_n
add wave -noupdate /channel_Tb/channel_inst/in
add wave -noupdate /channel_Tb/channel_inst/out
add wave -noupdate /channel_Tb/channel_inst/faster_clk
add wave -noupdate -format Analog-Step -height 74 -max 260.0 -min -128.0 /channel_Tb/channel_inst/out_fading
add wave -noupdate -divider -height 30 threshold
add wave -noupdate /channel_Tb/channel_inst/Thres_inst/NUMBER_OF_LEVELS
add wave -noupdate /channel_Tb/channel_inst/Thres_inst/input_fading
add wave -noupdate /channel_Tb/channel_inst/Thres_inst/threshold
add wave -noupdate /channel_Tb/channel_inst/Thres_inst/value
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {23973250 fs} 0}
quietly wave cursor active 1
configure wave -namecolwidth 254
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
WaveRestoreZoom {0 fs} {227640 ps}
