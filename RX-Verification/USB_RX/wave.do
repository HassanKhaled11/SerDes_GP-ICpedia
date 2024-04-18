onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /top/dut_if/Ref_CLK
add wave -noupdate /top/dut_if/Reset_n
add wave -noupdate /top/dut_if/DataBusWidth
add wave -noupdate -color Cyan /top/dut_if/TX_P
add wave -noupdate -color Cyan /top/DUT/PMA_U/PM_RX_U/CDRLoopInst/clk_0
add wave -noupdate -color Magenta /top/internals_if/CDR_OUT
add wave -noupdate -color Magenta /top/internals_if/PI_CLK
add wave -noupdate /top/internals_if/PCLK
add wave -noupdate /top/dut_if/Rx_Status
add wave -noupdate /top/internals_if/DataBusWidth
add wave -noupdate /top/internals_if/Bit_CLK
add wave -noupdate /top/dut_if/RxPolarity
add wave -noupdate /top/dut_if/Rx_Data
add wave -noupdate /top/dut_if/Rx_DataK
add wave -noupdate /top/dut_if/Rx_Valid
add wave -noupdate /top/dut_if/PCLK
add wave -noupdate /top/internals_if/Word_CLK
add wave -noupdate /top/DUT/Ref_CLK
add wave -noupdate /top/DUT/Reset_n
add wave -noupdate /top/DUT/DataBusWidth
add wave -noupdate /top/DUT/TX_P
add wave -noupdate /top/DUT/RxPolarity
add wave -noupdate /top/DUT/RX_Data
add wave -noupdate /top/DUT/RX_DataK
add wave -noupdate /top/DUT/RX_Status
add wave -noupdate /top/DUT/RX_Valid
add wave -noupdate /top/DUT/PCLK
add wave -noupdate /top/DUT/recovered_clk_5G
add wave -noupdate /top/DUT/Data_Out_PMA
add wave -noupdate /top/DUT/Bit_Rate_Clk
add wave -noupdate /top/DUT/Bit_Rate_CLK_10
add wave -noupdate -divider -height 50 DLF
add wave -noupdate /top/DUT/PMA_U/PM_RX_U/CDRLoopInst/DLF/Up
add wave -noupdate /top/DUT/PMA_U/PM_RX_U/CDRLoopInst/DLF/Dn
add wave -noupdate /top/DUT/PMA_U/PM_RX_U/CDRLoopInst/DLF/clk
add wave -noupdate /top/DUT/PMA_U/PM_RX_U/CDRLoopInst/DLF/rst_n
add wave -noupdate /top/DUT/PMA_U/PM_RX_U/CDRLoopInst/DLF/code
add wave -noupdate -color Magenta -format Analog-Step -height 74 -max 65528.0 -radix unsigned /top/DUT/PMA_U/PM_RX_U/CDRLoopInst/DLF/freq_integrator
add wave -noupdate /top/DUT/PMA_U/PM_RX_U/CDRLoopInst/DLF/phase_integrator
add wave -noupdate -divider -height 50 PMIX
add wave -noupdate /top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/CLK
add wave -noupdate /top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/Code
add wave -noupdate /top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/clk_filter_
add wave -noupdate /top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/clk_index
add wave -noupdate /top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/index
add wave -noupdate /top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/sin_sum
add wave -noupdate /top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/t1
add wave -noupdate /top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/t2
add wave -noupdate /top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/T1
add wave -noupdate /top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/T_
add wave -noupdate /top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/t3
add wave -noupdate /top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/t4
add wave -noupdate /top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/T1_P2
add wave -noupdate /top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/t5
add wave -noupdate /top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/t6
add wave -noupdate /top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/RESULT_PERIOD
add wave -noupdate /top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/CLK_Out_i
add wave -noupdate /top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/time_now
add wave -noupdate /top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/preparation_flag
add wave -noupdate /top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/clk_filter
add wave -noupdate /top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/glitchR_found
add wave -noupdate /top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/glitchF_found
add wave -noupdate /top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/PPM
add wave -noupdate /top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/CLK_Out
add wave -noupdate /top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/i
add wave -noupdate /top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/j
add wave -noupdate /top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/k
add wave -noupdate /top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/last_time
add wave -noupdate /top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/sign_0
add wave -noupdate /top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/sign_90
add wave -noupdate /top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/sign_180
add wave -noupdate /top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/sign_270
add wave -noupdate /top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/sign_45
add wave -noupdate /top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/sign_135
add wave -noupdate /top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/sign_225
add wave -noupdate /top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/sign_315
add wave -noupdate /top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/clk_sin
add wave -noupdate -divider -height 50 PD
add wave -noupdate /top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phaseDetector/clk
add wave -noupdate /top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phaseDetector/Din
add wave -noupdate /top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phaseDetector/rst_n
add wave -noupdate /top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phaseDetector/Up
add wave -noupdate /top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phaseDetector/Dn
add wave -noupdate /top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phaseDetector/A
add wave -noupdate /top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phaseDetector/B
add wave -noupdate /top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phaseDetector/T_
add wave -noupdate /top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phaseDetector/T
add wave -noupdate -divider -height 50 {CDR LOOP}
add wave -noupdate /top/DUT/PMA_U/PM_RX_U/CDRLoopInst/rst_n
add wave -noupdate /top/DUT/PMA_U/PM_RX_U/CDRLoopInst/clk_0
add wave -noupdate /top/DUT/PMA_U/PM_RX_U/CDRLoopInst/clk_data
add wave -noupdate /top/DUT/PMA_U/PM_RX_U/CDRLoopInst/Din
add wave -noupdate /top/DUT/PMA_U/PM_RX_U/CDRLoopInst/PI_Clk
add wave -noupdate /top/DUT/PMA_U/PM_RX_U/CDRLoopInst/Dout
add wave -noupdate /top/DUT/PMA_U/PM_RX_U/CDRLoopInst/t1
add wave -noupdate /top/DUT/PMA_U/PM_RX_U/CDRLoopInst/t2
add wave -noupdate /top/DUT/PMA_U/PM_RX_U/CDRLoopInst/T1_in_CDRLOOP
add wave -noupdate /top/DUT/PMA_U/PM_RX_U/CDRLoopInst/up
add wave -noupdate /top/DUT/PMA_U/PM_RX_U/CDRLoopInst/dn
add wave -noupdate /top/DUT/PMA_U/PM_RX_U/CDRLoopInst/code
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {902190210 fs} 0}
quietly wave cursor active 1
configure wave -namecolwidth 410
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
WaveRestoreZoom {0 fs} {12165793500 fs}
