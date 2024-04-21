onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /top/DUTA/cover_Bit_CLK_period
add wave -noupdate /top/DUTA/cover_WORD_CLK_period
add wave -noupdate /top/DUTA/cover_PCLK32_period
add wave -noupdate /top/DUTA/cover_PCLK16_period
add wave -noupdate /top/DUTA/cover_PCLK8_period
add wave -noupdate -divider -height 70 WATCH_SIGNALS
add wave -noupdate /top/dut_if/Reset_n
add wave -noupdate /top/dut_if/Ref_CLK
add wave -noupdate -color Magenta /top/dut_if/PCLK
add wave -noupdate -color Magenta /top/internals_if/Word_CLK
add wave -noupdate -color Magenta /top/internals_if/Bit_CLK
add wave -noupdate /top/internals_if/DataBusWidth
add wave -noupdate /top/dut_if/MAC_Data_En
add wave -noupdate /top/dut_if/MAC_TX_DataK
add wave -noupdate /top/DUT/PCS_U/PCS_TX_U/GasKet_U/TxData
add wave -noupdate /top/DUT/PCS_U/PCS_TX_U/GasKet_U/TxDataK
add wave -noupdate -color Yellow -radix hexadecimal /top/DUT/Data_In_PMA
add wave -noupdate -radix binary /top/DUT/Data_In_PMA
add wave -noupdate /top/internals_if/TX_Out_P
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/buffer/overflow
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/buffer/underflow
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/buffer/delete_req
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/buffer/add_req
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/buffer/elastic_mem_inst/read_pointer
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/buffer/elastic_mem_inst/write_pointer
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/buffer/elastic_mem_inst/data_out
add wave -noupdate -color Magenta /top/dut_if/MAC_TX_Data
add wave -noupdate -color Magenta /top/DUT/RX_Data
add wave -noupdate -expand /top/DUT/PCS_U/PCS_RX_U/buffer/elastic_mem_inst/buffer
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/buffer/Threshold_Monitor_Inst/num_elements
add wave -noupdate /top/dut_if/MAC_TX_Data
add wave -noupdate -color Magenta /top/dut_if/PCLK
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/buffer/elastic_mem_inst/data_out
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/decode/Data_out
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/decode/RxDataK
add wave -noupdate /top/dut_if/Rx_Data
add wave -noupdate /top/dut_if/Rx_DataK
add wave -noupdate -radix binary /top/dut_if/Rx_Status
add wave -noupdate /top/dut_if/Rx_Valid
add wave -noupdate -divider -height 70 BFM
add wave -noupdate /top/dut_if/Ref_CLK
add wave -noupdate /top/dut_if/Reset_n
add wave -noupdate /top/dut_if/DataBusWidth
add wave -noupdate /top/dut_if/MAC_TX_Data
add wave -noupdate /top/dut_if/MAC_TX_DataK
add wave -noupdate /top/dut_if/MAC_Data_En
add wave -noupdate /top/dut_if/RxPolarity
add wave -noupdate /top/dut_if/Rx_Data
add wave -noupdate /top/dut_if/Rx_DataK
add wave -noupdate -radix binary /top/dut_if/Rx_Status
add wave -noupdate /top/dut_if/Rx_Valid
add wave -noupdate -divider -height 50 INTERNALS
add wave -noupdate /top/dut_if/PCLK
add wave -noupdate /top/internals_if/Word_CLK
add wave -noupdate /top/internals_if/Bit_CLK
add wave -noupdate /top/internals_if/DataBusWidth
add wave -noupdate /top/dut_if/MAC_TX_Data
add wave -noupdate -radix binary /top/DUT/Data_In_PMA
add wave -noupdate -radix hexadecimal /top/DUT/Data_In_PMA
add wave -noupdate /top/DUT/PCS_U/PCS_TX_U/GasKet_U/TxData
add wave -noupdate /top/DUT/PCS_U/PCS_TX_U/GasKet_U/TxDataK
add wave -noupdate /top/internals_if/TX_Out_P
add wave -noupdate -divider -height 50 DUT
add wave -noupdate /top/dut_if/MAC_TX_Data
add wave -noupdate /top/DUT/PCLK
add wave -noupdate /top/DUT/Bit_Rate_CLK_10
add wave -noupdate /top/DUT/Bit_Rate_Clk
add wave -noupdate /top/internals_if/TX_Out_P
add wave -noupdate -radix binary /top/DUT/Data_In_PMA
add wave -noupdate /top/DUT/Data_Out_PMA
add wave -noupdate /top/DUT/DataBusWidth
add wave -noupdate /top/DUT/MAC_Data_En
add wave -noupdate /top/DUT/MAC_TX_Data
add wave -noupdate -radix binary /top/DUT/MAC_TX_DataK
add wave -noupdate /top/DUT/Ref_CLK
add wave -noupdate /top/DUT/Reset_n
add wave -noupdate -color Magenta /top/DUT/RX_Data
add wave -noupdate /top/DUT/RX_DataK
add wave -noupdate /top/DUT/RX_Status
add wave -noupdate /top/DUT/RX_Valid
add wave -noupdate /top/DUT/RxPolarity
add wave -noupdate /top/DUT/Common_Block_U/Ref_Clk
add wave -noupdate /top/DUT/Common_Block_U/Rst_n
add wave -noupdate /top/DUT/Common_Block_U/DataBusWidth
add wave -noupdate /top/DUT/Common_Block_U/Bit_Rate_Clk
add wave -noupdate /top/DUT/Common_Block_U/Bit_Rate_CLK_10
add wave -noupdate /top/DUT/Common_Block_U/PCLK
add wave -noupdate /top/DUT/Common_Block_U/ratio
add wave -noupdate /top/DUT/PMA_U/PM_RX_U/serialToparallel/Recovered_Bit_Clk
add wave -noupdate /top/DUT/PMA_U/PM_RX_U/serialToparallel/Ser_in
add wave -noupdate /top/DUT/PMA_U/PM_RX_U/serialToparallel/Rst_n
add wave -noupdate /top/DUT/PMA_U/PM_RX_U/serialToparallel/RxPolarity
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/buffer/write_clk
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/buffer/read_clk
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/buffer/data_in
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/buffer/rst_n
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/buffer/Skp_Removed
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/buffer/overflow
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/buffer/underflow
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/buffer/data_out
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/buffer/gray_write_pointer
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/buffer/gray_read_pointer
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/buffer/write_address
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/buffer/read_address
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/buffer/sync_gray_read_out
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/buffer/sync_gray_write_out
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/buffer/delete_req
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/buffer/elastic_mem_inst/read_clk
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/buffer/elastic_mem_inst/write_clk
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/buffer/elastic_mem_inst/full
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/buffer/elastic_mem_inst/empty
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/buffer/elastic_mem_inst/data_in
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/buffer/add_req
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/buffer/elastic_mem_inst/read_pointer
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/buffer/elastic_mem_inst/write_pointer
add wave -noupdate -radix hexadecimal /top/DUT/Data_In_PMA
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/buffer/elastic_mem_inst/data_out
add wave -noupdate -expand /top/DUT/PCS_U/PCS_RX_U/buffer/elastic_mem_inst/buffer
add wave -noupdate /top/DUT/PCS_U/PCS_TX_U/GasKet_U/Temp_Reg
add wave -noupdate -divider -height 50 Decoder
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/decode/CLK
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/decode/Rst_n
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/decode/Data_in
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/decode/Data_out
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/decode/DecodeError
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/decode/DisparityError
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/decode/RxDataK
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/decode/temp
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/decode/encoded_data_N
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/decode/encoded_data_P
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/decode/DecodeError_N
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/decode/DecodeError_P
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/decode/RxDataK_N
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/decode/RxDataK_P
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/decode/flag
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/decode/flag_n
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/decode/flag_p
add wave -noupdate -divider -height 50 RX_GASKET
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/rx_gasket/clk_to_get
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/rx_gasket/PCLK
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/rx_gasket/Rst_n
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/rx_gasket/Rx_Datak
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/rx_gasket/width
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/rx_gasket/Data_in
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/rx_gasket/Data_out
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/rx_gasket/data_out
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/rx_gasket/count
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/rx_gasket/flag
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/rx_gasket/temp_reg
add wave -noupdate -divider -height 30 {Comma Detection}
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/Comma_Detection_U/COMMA_NUMBER
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/Comma_Detection_U/IDLE
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/Comma_Detection_U/COMMA
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/Comma_Detection_U/DATA
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/Comma_Detection_U/clk
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/Comma_Detection_U/rst_n
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/Comma_Detection_U/Data_Collected
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/Comma_Detection_U/RxValid
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/Comma_Detection_U/Comma_Pulse
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/Comma_Detection_U/cs
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/Comma_Detection_U/ns
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/Comma_Detection_U/CP1
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/Comma_Detection_U/CP2
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/Comma_Detection_U/count
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/Comma_Detection_U/count_reset
add wave -noupdate -divider -height 30 Serial_To_Parallel
add wave -noupdate /top/DUT/PMA_U/PM_RX_U/serialToparallel/DATA_WIDTH
add wave -noupdate /top/DUT/PMA_U/PM_RX_U/serialToparallel/Recovered_Bit_Clk
add wave -noupdate /top/internals_if/Bit_CLK
add wave -noupdate /top/DUT/PMA_U/PM_RX_U/serialToparallel/Ser_in
add wave -noupdate /top/DUT/PMA_U/PM_RX_U/serialToparallel/Rst_n
add wave -noupdate /top/DUT/PMA_U/PM_RX_U/serialToparallel/RxPolarity
add wave -noupdate /top/DUT/PMA_U/PM_RX_U/serialToparallel/Data_Collected
add wave -noupdate /top/DUT/PMA_U/PM_RX_U/serialToparallel/serial
add wave -noupdate -divider -height 30 {CDR important signals}
add wave -noupdate -format Analog-Step -height 74 -max 123.99999999999999 -radix unsigned /top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/Code
add wave -noupdate /top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/CLK_Out_i
add wave -noupdate -radix unsigned /top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/sin_sum
add wave -noupdate -format Analog-Step -height 74 -max 17000.0 /top/DUT/PMA_U/PM_RX_U/CDRLoopInst/DLF/freq_integrator
add wave -noupdate -format Analog-Step -height 74 -max 3000.0 /top/DUT/PMA_U/PM_RX_U/CDRLoopInst/DLF/phase_integrator
add wave -noupdate -divider -height 30 Sine
add wave -noupdate /top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/sin_0
add wave -noupdate /top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/sin_90
add wave -noupdate /top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/sin_180
add wave -noupdate /top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/sin_270
add wave -noupdate /top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/sin_45
add wave -noupdate /top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/sin_135
add wave -noupdate /top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/sin_225
add wave -noupdate /top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/sin_315
add wave -noupdate /top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/index
TreeUpdate [SetDefaultTree]
quietly WaveActivateNextPane
add wave -noupdate /top/DUT/PMA_U/PM_RX_U/CDRLoopInst/rst_n
add wave -noupdate /top/DUT/PMA_U/PM_RX_U/CDRLoopInst/clk_0
add wave -noupdate /top/DUT/PMA_U/PM_RX_U/CDRLoopInst/clk_data
add wave -noupdate -color Magenta /top/DUT/PMA_U/Bit_Rate_Clk
add wave -noupdate /top/dut_if/Bit_CLK_Offset
add wave -noupdate -color Magenta /top/DUT/PMA_U/Bit_Rate_Clk_offset
add wave -noupdate -color Cyan /top/DUT/PMA_U/PM_RX_U/CDRLoopInst/Din
add wave -noupdate -color Cyan /top/DUT/PMA_U/PM_RX_U/CDRLoopInst/PI_Clk
add wave -noupdate /top/DUT/PMA_U/PM_RX_U/CDRLoopInst/Dout
add wave -noupdate /top/DUT/PMA_U/PM_RX_U/CDRLoopInst/t1
add wave -noupdate /top/DUT/PMA_U/PM_RX_U/CDRLoopInst/t2
add wave -noupdate /top/DUT/PMA_U/PM_RX_U/CDRLoopInst/T1_in_CDRLOOP
add wave -noupdate /top/DUT/PMA_U/PM_RX_U/CDRLoopInst/up
add wave -noupdate /top/DUT/PMA_U/PM_RX_U/CDRLoopInst/dn
add wave -noupdate /top/DUT/PMA_U/PM_RX_U/CDRLoopInst/code
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {18900000 fs} 1} {{Cursor 2} {27068000 fs} 1 Magenta default} {{Cursor 3} {110979000 fs} 1 Magenta default} {{Cursor 4} {37443710000 fs} 1} {{Cursor 5} {3370198000 fs} 1} {{Cursor 6} {7797566964 fs} 0}
quietly wave cursor active 6
configure wave -namecolwidth 419
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
WaveRestoreZoom {7797426326 fs} {7797809926 fs}
