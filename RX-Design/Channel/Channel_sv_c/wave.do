onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /Channel_TB/ATTENUATION
add wave -noupdate /Channel_TB/F
add wave -noupdate /Channel_TB/N
add wave -noupdate /Channel_TB/Sample_CLK
add wave -noupdate /Channel_TB/Data_in
add wave -noupdate /Channel_TB/Data_out
add wave -noupdate /Channel_TB/CLK
add wave -noupdate /Channel_TB/fd
add wave -noupdate -format Analog-Step -height 74 -max 0.99992162382321848 /Channel_TB/DUT/Ynew
add wave -noupdate /Channel_TB/DUT/Ynew
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {45488599 fs} 0}
quietly wave cursor active 1
configure wave -namecolwidth 264
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
WaveRestoreZoom {0 fs} {210 ns}
