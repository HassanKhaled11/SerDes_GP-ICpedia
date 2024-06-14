onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /SSC_Generator_tb/clk
add wave -noupdate /SSC_Generator_tb/jitterd_clk
add wave -noupdate /SSC_Generator_tb/DUT/clk
add wave -noupdate /SSC_Generator_tb/DUT/ssc_iteration
add wave -noupdate /SSC_Generator_tb/DUT/clk_ssc
add wave -noupdate -color Magenta -format Analog-Step -height 74 -max 0.0010050300000000001 /SSC_Generator_tb/DUT/jitter_value
add wave -noupdate -color Cyan /SSC_Generator_tb/DUT/jitterd_clk
add wave -noupdate -format Analog-Step -height 74 -max 0.20100599999999999 /SSC_Generator_tb/DUT/Jittered_clk_period
add wave -noupdate /SSC_Generator_tb/DUT/PPM
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 fs} 1} {{Cursor 2} {16651665000 fs} 1} {{Cursor 3} {5668619679 fs} 0} {{Cursor 4} {10413883379509 fs} 0}
quietly wave cursor active 4
configure wave -namecolwidth 283
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
WaveRestoreZoom {0 fs} {27319087398912 fs}
