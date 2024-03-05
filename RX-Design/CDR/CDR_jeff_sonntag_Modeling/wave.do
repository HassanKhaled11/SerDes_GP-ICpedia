onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider -height 40 BBPD
add wave -noupdate /CDR_Tb/Dut/phaseDetector/rst_n
add wave -noupdate -color {Violet Red} /CDR_Tb/Dut/phaseDetector/Up
add wave -noupdate /CDR_Tb/clk_data
add wave -noupdate -color Gold -format Literal /CDR_Tb/Dut/phaseDetector/Din
add wave -noupdate -color Gold /CDR_Tb/Dut/phaseDetector/Din
add wave -noupdate /CDR_Tb/Dut/phaseDetector/clk
add wave -noupdate -color {Violet Red} /CDR_Tb/Dut/phaseDetector/Dn
add wave -noupdate -color White /CDR_Tb/Dut/phaseDetector/A
add wave -noupdate -format Literal /CDR_Tb/Dut/phaseDetector/A
add wave -noupdate /CDR_Tb/Dut/phaseDetector/B
add wave -noupdate /CDR_Tb/Dut/phaseDetector/T_
add wave -noupdate /CDR_Tb/Dut/phaseDetector/T
add wave -noupdate -divider -height 40 DLF
add wave -noupdate /CDR_Tb/Dut/DLF/Up
add wave -noupdate /CDR_Tb/Dut/DLF/Dn
add wave -noupdate /CDR_Tb/Dut/DLF/clk
add wave -noupdate /CDR_Tb/Dut/DLF/rst_n
add wave -noupdate /CDR_Tb/Dut/DLF/code
add wave -noupdate /CDR_Tb/Dut/DLF/phase_integrator
add wave -noupdate /CDR_Tb/Dut/DLF/freq_integrator
add wave -noupdate -divider -height 40 PI
add wave -noupdate /CDR_Tb/Dut/phase_interpolator/rst_n
add wave -noupdate /CDR_Tb/Dut/phase_interpolator/clk_0
add wave -noupdate /CDR_Tb/Dut/phase_interpolator/clk_90
add wave -noupdate /CDR_Tb/Dut/phase_interpolator/clk_180
add wave -noupdate /CDR_Tb/Dut/phase_interpolator/clk_270
add wave -noupdate /CDR_Tb/Dut/phase_interpolator/code
add wave -noupdate /CDR_Tb/Dut/phase_interpolator/PI_clk
add wave -noupdate /CDR_Tb/Dut/phase_interpolator/use_clk
add wave -noupdate /CDR_Tb/Dut/phase_interpolator/ph_step
add wave -noupdate /CDR_Tb/Dut/phase_interpolator/deg_step
add wave -noupdate /CDR_Tb/Dut/phase_interpolator/t_step
add wave -noupdate /CDR_Tb/Dut/phase_interpolator/delay_
add wave -noupdate /CDR_Tb/Dut/phase_interpolator/UI
add wave -noupdate /CDR_Tb/Dut/phase_interpolator/j
add wave -noupdate /CDR_Tb/Dut/phase_interpolator/k
add wave -noupdate /CDR_Tb/Dut/phase_interpolator/freq_ch
add wave -noupdate /CDR_Tb/Dut/phase_interpolator/freq_def
add wave -noupdate /CDR_Tb/Dut/phase_interpolator/positive_
add wave -noupdate /CDR_Tb/Dut/phase_interpolator/negative_
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1891 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 312
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
WaveRestoreZoom {0 ns} {6592 ns}
