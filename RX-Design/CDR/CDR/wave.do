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
add wave -noupdate -format Analog-Step -height 100 -max 2047.0 -radix unsigned /CDR_Tb/Dut/DLF/code
add wave -noupdate -divider -height 40 DLF
add wave -noupdate /CDR_Tb/Dut/DLF/rst_n
add wave -noupdate /CDR_Tb/Dut/DLF/phase_integrator
add wave -noupdate /CDR_Tb/Dut/DLF/Up
add wave -noupdate /CDR_Tb/Dut/DLF/Dn
add wave -noupdate /CDR_Tb/Dut/DLF/clk
add wave -noupdate /CDR_Tb/clk_data
add wave -noupdate /CDR_Tb/Dut/phaseDetector/clk
add wave -noupdate -divider -height 50 freq_integrator
add wave -noupdate -color Magenta -format Analog-Step -height 74 -max 20552.0 -min 948.0 -radix decimal /CDR_Tb/Dut/DLF/freq_integrator
add wave -noupdate -divider -height 40 PI
add wave -noupdate /CDR_Tb/Dut/phase_interpolator/clk_filter_
add wave -noupdate /CDR_Tb/Dut/phase_interpolator/CLK_Out
add wave -noupdate /CDR_Tb/Dut/phase_interpolator/clk_filter
add wave -noupdate /CDR_Tb/Dut/phase_interpolator/glitchR_found
add wave -noupdate /CDR_Tb/Dut/phase_interpolator/glitchF_found
add wave -noupdate /CDR_Tb/Dut/phase_interpolator/j
add wave -noupdate /CDR_Tb/Dut/phase_interpolator/k
add wave -noupdate /CDR_Tb/Dut/phase_interpolator/THRESHOLD
add wave -noupdate /CDR_Tb/Dut/phase_interpolator/WIDTH
add wave -noupdate /CDR_Tb/Dut/phase_interpolator/CLK
add wave -noupdate /CDR_Tb/Dut/phase_interpolator/Code
add wave -noupdate /CDR_Tb/Dut/phase_interpolator/clk_index
add wave -noupdate /CDR_Tb/Dut/phase_interpolator/index
add wave -noupdate /CDR_Tb/Dut/phase_interpolator/sin_sum
add wave -noupdate /CDR_Tb/Dut/phase_interpolator/PHASE_SHIFT
add wave -noupdate /CDR_Tb/Dut/phase_interpolator/t1
add wave -noupdate /CDR_Tb/Dut/phase_interpolator/t2
add wave -noupdate /CDR_Tb/Dut/phase_interpolator/T1
add wave -noupdate /CDR_Tb/Dut/phase_interpolator/T_
add wave -noupdate /CDR_Tb/Dut/phase_interpolator/sin1
add wave -noupdate /CDR_Tb/Dut/phase_interpolator/t3
add wave -noupdate /CDR_Tb/Dut/phase_interpolator/t4
add wave -noupdate /CDR_Tb/Dut/phase_interpolator/T1_P2
add wave -noupdate /CDR_Tb/Dut/phase_interpolator/sin2
add wave -noupdate /CDR_Tb/Dut/phase_interpolator/t5
add wave -noupdate /CDR_Tb/Dut/phase_interpolator/t6
add wave -noupdate -format Analog-Step -height 74 -max 0.20399999999999996 /CDR_Tb/Dut/phase_interpolator/RESULT_PERIOD
add wave -noupdate /CDR_Tb/Dut/phase_interpolator/CLK_Out_i
add wave -noupdate /CDR_Tb/Dut/phase_interpolator/time_now
add wave -noupdate /CDR_Tb/Dut/phase_interpolator/preparation_flag
add wave -noupdate /CDR_Tb/Dut/phase_interpolator/sine
add wave -noupdate /CDR_Tb/Dut/phase_interpolator/i
add wave -noupdate /CDR_Tb/Dut/phase_interpolator/j
add wave -noupdate /CDR_Tb/Dut/phase_interpolator/k
add wave -noupdate /CDR_Tb/Dut/phase_interpolator/last_time
add wave -noupdate /CDR_Tb/Dut/phase_interpolator/sin_0
add wave -noupdate /CDR_Tb/Dut/phase_interpolator/sin_90
add wave -noupdate /CDR_Tb/Dut/phase_interpolator/sin_180
add wave -noupdate /CDR_Tb/Dut/phase_interpolator/sin_270
add wave -noupdate /CDR_Tb/Dut/phase_interpolator/sin_45
add wave -noupdate /CDR_Tb/Dut/phase_interpolator/sin_135
add wave -noupdate /CDR_Tb/Dut/phase_interpolator/sin_225
add wave -noupdate /CDR_Tb/Dut/phase_interpolator/sin_315
add wave -noupdate /CDR_Tb/Dut/phase_interpolator/sign_0
add wave -noupdate /CDR_Tb/Dut/phase_interpolator/sign_90
add wave -noupdate /CDR_Tb/Dut/phase_interpolator/sign_180
add wave -noupdate /CDR_Tb/Dut/phase_interpolator/sign_270
add wave -noupdate /CDR_Tb/Dut/phase_interpolator/sign_45
add wave -noupdate /CDR_Tb/Dut/phase_interpolator/sign_135
add wave -noupdate /CDR_Tb/Dut/phase_interpolator/sign_225
add wave -noupdate /CDR_Tb/Dut/phase_interpolator/sign_315
add wave -noupdate /CDR_Tb/Dut/phase_interpolator/clk_sin
add wave -noupdate -radix unsigned /CDR_Tb/Dut/phase_interpolator/PPM
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {254442002 fs} 1} {{Cursor 2} {98691872 fs} 1} {{Cursor 3} {239256345 fs} 0}
quietly wave cursor active 3
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
WaveRestoreZoom {0 fs} {1432045276 fs}
