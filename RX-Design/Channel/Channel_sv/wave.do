onerror {resume}
quietly virtual signal -install /Channel_TB/DUT { (context /Channel_TB/DUT )&{Ynew , Ynewn }} EYE_DIAGRAM
quietly WaveActivateNextPane {} 0
add wave -noupdate /Channel_TB/Sample_CLK
add wave -noupdate /Channel_TB/Data_in
add wave -noupdate /Channel_TB/Data_out
add wave -noupdate /Channel_TB/CLK
add wave -noupdate /Channel_TB/DUT/Sample_CLK
add wave -noupdate /Channel_TB/DUT/Data_in
add wave -noupdate /Channel_TB/DUT/Data_out
add wave -noupdate /Channel_TB/DUT/Unew
add wave -noupdate /Channel_TB/DUT/Uold
add wave -noupdate -format Analog-Step -height 74 -max 1.0 /Channel_TB/DUT/Ynew
add wave -noupdate /Channel_TB/DUT/Yold
add wave -noupdate /Channel_TB/DUT/A
add wave -noupdate /Channel_TB/DUT/x1
add wave -noupdate /Channel_TB/DUT/x2
add wave -noupdate /Channel_TB/DUT/Wc
add wave -noupdate /Channel_TB/DUT/alpha
add wave -noupdate /Channel_TB/DUT/beta
add wave -noupdate -radix decimal /Channel_TB/ATTENUATION
TreeUpdate [SetDefaultTree]
quietly WaveActivateNextPane
WaveRestoreCursors {{Cursor 1} {14835938 fs} 0} {{Cursor 2} {8090000 fs} 0} {{Cursor 3} {4147054 fs} 0}
quietly wave cursor active 3
configure wave -namecolwidth 256
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
WaveRestoreZoom {0 fs} {17055488 fs}
