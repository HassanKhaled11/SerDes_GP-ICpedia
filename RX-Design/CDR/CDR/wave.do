onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -color Yellow -radix binary /PMIX_Tb/Code
add wave -noupdate /PMIX_Tb/CLK
add wave -noupdate /PMIX_Tb/CLK_90
add wave -noupdate /PMIX_Tb/CLK_180
add wave -noupdate /PMIX_Tb/CLK_270
add wave -noupdate /PMIX_Tb/PMIX_DUT/sign_sin1
add wave -noupdate /PMIX_Tb/PMIX_DUT/sign_sin2
add wave -noupdate -color Magenta /PMIX_Tb/CLK_Out
add wave -noupdate -divider {New Divider}
add wave -noupdate -format Analog-Step -height 74 -max 50.0 /PMIX_Tb/PMIX_DUT/sin1
add wave -noupdate -divider {New Divider}
add wave -noupdate -format Analog-Step -height 74 -max 50.0 /PMIX_Tb/PMIX_DUT/sin2
add wave -noupdate -color Magenta -format Analog-Step -height 74 -max 50.0 /PMIX_Tb/PMIX_DUT/sin_sum
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 3} {2929750 fs} 0}
quietly wave cursor active 1
configure wave -namecolwidth 205
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
WaveRestoreZoom {1752744 fs} {3346152 fs}
