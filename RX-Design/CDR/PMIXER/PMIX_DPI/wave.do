onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /PMIX_Tb/PMIX_DUT/CLK
add wave -noupdate /PMIX_Tb/PMIX_DUT/Code
add wave -noupdate /PMIX_Tb/PMIX_DUT/clk_index
add wave -noupdate -radix unsigned /PMIX_Tb/PMIX_DUT/index
add wave -noupdate -format Analog-Step -height 74 -max 32187.0 -min -31721.0 -radix decimal /PMIX_Tb/PMIX_DUT/sin_sum
add wave -noupdate /PMIX_Tb/PMIX_DUT/t1
add wave -noupdate /PMIX_Tb/PMIX_DUT/t2
add wave -noupdate /PMIX_Tb/PMIX_DUT/T1
add wave -noupdate /PMIX_Tb/PMIX_DUT/T_
add wave -noupdate /PMIX_Tb/PMIX_DUT/t3
add wave -noupdate /PMIX_Tb/PMIX_DUT/t4
add wave -noupdate /PMIX_Tb/PMIX_DUT/T1_P2
add wave -noupdate /PMIX_Tb/PMIX_DUT/t5
add wave -noupdate /PMIX_Tb/PMIX_DUT/t6
add wave -noupdate /PMIX_Tb/PMIX_DUT/RESULT_PERIOD
add wave -noupdate -color Magenta -format Analog-Step -height 74 -max 0.012800000000027012 /PMIX_Tb/PMIX_DUT/RESULT_PERIOD
add wave -noupdate /PMIX_Tb/PMIX_DUT/CLK_Out_i
add wave -noupdate /PMIX_Tb/PMIX_DUT/time_now
add wave -noupdate /PMIX_Tb/PMIX_DUT/clk_filter
add wave -noupdate /PMIX_Tb/PMIX_DUT/glitchR_found
add wave -noupdate /PMIX_Tb/PMIX_DUT/glitchF_found
add wave -noupdate /PMIX_Tb/PMIX_DUT/PPM
add wave -noupdate /PMIX_Tb/PMIX_DUT/CLK_Out
add wave -noupdate /PMIX_Tb/PMIX_DUT/i
add wave -noupdate /PMIX_Tb/PMIX_DUT/j
add wave -noupdate /PMIX_Tb/PMIX_DUT/k
add wave -noupdate /PMIX_Tb/PMIX_DUT/last_time
add wave -noupdate /PMIX_Tb/PMIX_DUT/temp
add wave -noupdate /PMIX_Tb/PMIX_DUT/temp2
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {4367540 fs} 0}
quietly wave cursor active 1
configure wave -namecolwidth 412
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
WaveRestoreZoom {0 fs} {21547776 fs}
