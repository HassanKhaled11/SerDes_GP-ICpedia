onerror {resume}
quietly set dataset_list [list sim vsim]
if {[catch {datasetcheck $dataset_list}]} {abort}
quietly WaveActivateNextPane {} 0
add wave -noupdate vsim:/top/PPM_checker_PI_clk_U/assert_no_glitch
add wave -noupdate vsim:/top/PPM_checker_PI_clk_U/assert_PPM
add wave -noupdate vsim:/top/PPM_checker_PI_clk_U/assert_PI_PPM
add wave -noupdate vsim:/top/PPM_checker_PI_clk_U/assert_no_PI_glitch
add wave -noupdate vsim:/top/PPM_checker_PI_clk_U/PPM_value
add wave -noupdate vsim:/top/PPM_checker_PI_clk_U/PI_PPM_value
add wave -noupdate -divider -height 30 {Watched Signals}
add wave -noupdate -color Magenta vsim:/top/internals_if/Bit_CLK
add wave -noupdate vsim:/top/DUT/PMA_U/PM_RX_U/serialToparallel/Recovered_Bit_Clk
add wave -noupdate -color Magenta vsim:/top/dut_if/MAC_TX_Data
add wave -noupdate -color Magenta vsim:/top/DUT/RX_Data
add wave -noupdate -childformat {{{/top/DUT/PCS_U/PCS_RX_U/buffer/elastic_mem_inst/buffer[14]} -radix hexadecimal}} -subitemconfig {{/top/DUT/PCS_U/PCS_RX_U/buffer/elastic_mem_inst/buffer[14]} {-height 15 -radix hexadecimal}} vsim:/top/DUT/PCS_U/PCS_RX_U/buffer/elastic_mem_inst/buffer
add wave -noupdate -color Cyan vsim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/Din
add wave -noupdate -color {Green Yellow} vsim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/PI_Clk
add wave -noupdate -color Cyan vsim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/Dout
add wave -noupdate -color Gold -format Analog-Step -height 74 -max 50.0 vsim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/sin_sum
add wave -noupdate vsim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/code
add wave -noupdate -color Magenta -format Analog-Step -height 74 -max 65532.999999999993 -radix unsigned vsim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/DLF_U/freq_integrator
add wave -noupdate -format Analog-Step -height 74 -max 65532.0 -radix unsigned vsim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/DLF_U/phase_integrator
add wave -noupdate vsim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/DLF_U/UP_DN
add wave -noupdate -color Magenta vsim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/DLF_U/Up
add wave -noupdate -color Magenta vsim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/DLF_U/Dn
add wave -noupdate -divider CHANNEL
add wave -noupdate vsim:/top/DUT/PMA_U/channelInst/Data_in
add wave -noupdate -color Yellow -format Analog-Step -height 74 -max 0.99997199999999997 vsim:/top/DUT/PMA_U/channelInst/Ynew
add wave -noupdate -divider -height 30 {CDR important signals}
add wave -noupdate -format Analog-Step -height 74 -min -1.0 -radix decimal vsim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/Code
add wave -noupdate -divider -height 70 WATCH_SIGNALS
add wave -noupdate -childformat {{{/top/DUT/PCS_U/PCS_RX_U/buffer/elastic_mem_inst/buffer[14]} -radix hexadecimal}} -subitemconfig {{/top/DUT/PCS_U/PCS_RX_U/buffer/elastic_mem_inst/buffer[14]} {-height 15 -radix hexadecimal}} vsim:/top/DUT/PCS_U/PCS_RX_U/buffer/elastic_mem_inst/buffer
add wave -noupdate vsim:/top/dut_if/Reset_n
add wave -noupdate vsim:/top/dut_if/Ref_CLK
add wave -noupdate -color Magenta vsim:/top/dut_if/PCLK
add wave -noupdate -color Magenta vsim:/top/internals_if/Word_CLK
add wave -noupdate -color Magenta vsim:/top/internals_if/Bit_CLK
add wave -noupdate vsim:/top/internals_if/DataBusWidth
add wave -noupdate vsim:/top/dut_if/MAC_TX_Data
add wave -noupdate vsim:/top/dut_if/MAC_Data_En
add wave -noupdate vsim:/top/dut_if/MAC_TX_DataK
add wave -noupdate vsim:/top/DUT/PCS_U/PCS_TX_U/GasKet_U/TxData
add wave -noupdate vsim:/top/DUT/PCS_U/PCS_TX_U/GasKet_U/TxDataK
add wave -noupdate -color Yellow -radix binary -childformat {{{/top/DUT/Data_In_PMA[9]} -radix hexadecimal} {{/top/DUT/Data_In_PMA[8]} -radix hexadecimal} {{/top/DUT/Data_In_PMA[7]} -radix hexadecimal} {{/top/DUT/Data_In_PMA[6]} -radix hexadecimal} {{/top/DUT/Data_In_PMA[5]} -radix hexadecimal} {{/top/DUT/Data_In_PMA[4]} -radix hexadecimal} {{/top/DUT/Data_In_PMA[3]} -radix hexadecimal} {{/top/DUT/Data_In_PMA[2]} -radix hexadecimal} {{/top/DUT/Data_In_PMA[1]} -radix hexadecimal} {{/top/DUT/Data_In_PMA[0]} -radix hexadecimal}} -subitemconfig {{/top/DUT/Data_In_PMA[9]} {-color Yellow -height 15 -radix hexadecimal} {/top/DUT/Data_In_PMA[8]} {-color Yellow -height 15 -radix hexadecimal} {/top/DUT/Data_In_PMA[7]} {-color Yellow -height 15 -radix hexadecimal} {/top/DUT/Data_In_PMA[6]} {-color Yellow -height 15 -radix hexadecimal} {/top/DUT/Data_In_PMA[5]} {-color Yellow -height 15 -radix hexadecimal} {/top/DUT/Data_In_PMA[4]} {-color Yellow -height 15 -radix hexadecimal} {/top/DUT/Data_In_PMA[3]} {-color Yellow -height 15 -radix hexadecimal} {/top/DUT/Data_In_PMA[2]} {-color Yellow -height 15 -radix hexadecimal} {/top/DUT/Data_In_PMA[1]} {-color Yellow -height 15 -radix hexadecimal} {/top/DUT/Data_In_PMA[0]} {-color Yellow -height 15 -radix hexadecimal}} vsim:/top/DUT/Data_In_PMA
add wave -noupdate -color Yellow -radix hexadecimal -childformat {{{/top/DUT/Data_In_PMA[9]} -radix hexadecimal} {{/top/DUT/Data_In_PMA[8]} -radix hexadecimal} {{/top/DUT/Data_In_PMA[7]} -radix hexadecimal} {{/top/DUT/Data_In_PMA[6]} -radix hexadecimal} {{/top/DUT/Data_In_PMA[5]} -radix hexadecimal} {{/top/DUT/Data_In_PMA[4]} -radix hexadecimal} {{/top/DUT/Data_In_PMA[3]} -radix hexadecimal} {{/top/DUT/Data_In_PMA[2]} -radix hexadecimal} {{/top/DUT/Data_In_PMA[1]} -radix hexadecimal} {{/top/DUT/Data_In_PMA[0]} -radix hexadecimal}} -subitemconfig {{/top/DUT/Data_In_PMA[9]} {-color Yellow -height 15 -radix hexadecimal} {/top/DUT/Data_In_PMA[8]} {-color Yellow -height 15 -radix hexadecimal} {/top/DUT/Data_In_PMA[7]} {-color Yellow -height 15 -radix hexadecimal} {/top/DUT/Data_In_PMA[6]} {-color Yellow -height 15 -radix hexadecimal} {/top/DUT/Data_In_PMA[5]} {-color Yellow -height 15 -radix hexadecimal} {/top/DUT/Data_In_PMA[4]} {-color Yellow -height 15 -radix hexadecimal} {/top/DUT/Data_In_PMA[3]} {-color Yellow -height 15 -radix hexadecimal} {/top/DUT/Data_In_PMA[2]} {-color Yellow -height 15 -radix hexadecimal} {/top/DUT/Data_In_PMA[1]} {-color Yellow -height 15 -radix hexadecimal} {/top/DUT/Data_In_PMA[0]} {-color Yellow -height 15 -radix hexadecimal}} vsim:/top/DUT/Data_In_PMA
add wave -noupdate -radix binary vsim:/top/DUT/Data_In_PMA
add wave -noupdate vsim:/top/internals_if/TX_Out_P
add wave -noupdate vsim:/top/DUT/PCS_U/PCS_RX_U/buffer/overflow
add wave -noupdate vsim:/top/DUT/PCS_U/PCS_RX_U/buffer/underflow
add wave -noupdate vsim:/top/DUT/PCS_U/PCS_RX_U/buffer/delete_req
add wave -noupdate vsim:/top/DUT/PCS_U/PCS_RX_U/buffer/add_req
add wave -noupdate vsim:/top/DUT/PCS_U/PCS_RX_U/buffer/elastic_mem_inst/read_pointer
add wave -noupdate vsim:/top/DUT/PCS_U/PCS_RX_U/buffer/elastic_mem_inst/write_pointer
add wave -noupdate vsim:/top/DUT/PCS_U/PCS_RX_U/buffer/elastic_mem_inst/data_out
add wave -noupdate -color Magenta vsim:/top/dut_if/MAC_TX_Data
add wave -noupdate -color Magenta vsim:/top/DUT/RX_Data
add wave -noupdate -childformat {{{/top/DUT/PCS_U/PCS_RX_U/buffer/elastic_mem_inst/buffer[14]} -radix hexadecimal}} -subitemconfig {{/top/DUT/PCS_U/PCS_RX_U/buffer/elastic_mem_inst/buffer[14]} {-height 15 -radix hexadecimal}} vsim:/top/DUT/PCS_U/PCS_RX_U/buffer/elastic_mem_inst/buffer
add wave -noupdate vsim:/top/DUT/PCS_U/PCS_RX_U/buffer/Threshold_Monitor_Inst/num_elements
add wave -noupdate vsim:/top/dut_if/MAC_TX_Data
add wave -noupdate -color Magenta vsim:/top/dut_if/PCLK
add wave -noupdate vsim:/top/DUT/PCS_U/PCS_RX_U/buffer/elastic_mem_inst/data_out
add wave -noupdate vsim:/top/DUT/PCS_U/PCS_RX_U/decode/Data_out
add wave -noupdate vsim:/top/DUT/PCS_U/PCS_RX_U/decode/RxDataK
add wave -noupdate vsim:/top/dut_if/Rx_Data
add wave -noupdate vsim:/top/dut_if/Rx_DataK
add wave -noupdate -radix binary vsim:/top/dut_if/Rx_Status
add wave -noupdate vsim:/top/dut_if/Rx_Valid
add wave -noupdate -divider -height 70 BFM
add wave -noupdate vsim:/top/dut_if/Ref_CLK
add wave -noupdate vsim:/top/dut_if/Reset_n
add wave -noupdate vsim:/top/dut_if/DataBusWidth
add wave -noupdate -color Magenta vsim:/top/dut_if/MAC_TX_Data
add wave -noupdate vsim:/top/dut_if/MAC_TX_DataK
add wave -noupdate vsim:/top/dut_if/MAC_Data_En
add wave -noupdate vsim:/top/dut_if/RxPolarity
add wave -noupdate -color Magenta vsim:/top/dut_if/Rx_Data
add wave -noupdate vsim:/top/dut_if/Rx_DataK
add wave -noupdate -radix binary vsim:/top/dut_if/Rx_Status
add wave -noupdate vsim:/top/dut_if/Rx_Valid
add wave -noupdate -divider -height 50 INTERNALS
add wave -noupdate vsim:/top/dut_if/PCLK
add wave -noupdate vsim:/top/internals_if/Word_CLK
add wave -noupdate vsim:/top/internals_if/Bit_CLK
add wave -noupdate vsim:/top/internals_if/DataBusWidth
add wave -noupdate vsim:/top/dut_if/MAC_TX_Data
add wave -noupdate -radix binary vsim:/top/DUT/Data_In_PMA
add wave -noupdate -radix hexadecimal vsim:/top/DUT/Data_In_PMA
add wave -noupdate vsim:/top/DUT/PCS_U/PCS_TX_U/GasKet_U/TxData
add wave -noupdate vsim:/top/DUT/PCS_U/PCS_TX_U/GasKet_U/TxDataK
add wave -noupdate vsim:/top/internals_if/TX_Out_P
add wave -noupdate -divider -height 50 DUT
add wave -noupdate vsim:/top/dut_if/MAC_TX_Data
add wave -noupdate vsim:/top/DUT/PCLK
add wave -noupdate vsim:/top/DUT/Bit_Rate_CLK_10
add wave -noupdate vsim:/top/DUT/Bit_Rate_Clk
add wave -noupdate vsim:/top/internals_if/TX_Out_P
add wave -noupdate -radix binary vsim:/top/DUT/Data_In_PMA
add wave -noupdate vsim:/top/DUT/Data_Out_PMA
add wave -noupdate vsim:/top/DUT/DataBusWidth
add wave -noupdate vsim:/top/DUT/MAC_Data_En
add wave -noupdate vsim:/top/DUT/MAC_TX_Data
add wave -noupdate -radix binary vsim:/top/DUT/MAC_TX_DataK
add wave -noupdate vsim:/top/DUT/Ref_CLK
add wave -noupdate vsim:/top/DUT/Reset_n
add wave -noupdate -color Magenta vsim:/top/DUT/RX_Data
add wave -noupdate vsim:/top/DUT/PCS_U/PCS_RX_U/buffer/elastic_mem_inst/data_out
add wave -noupdate vsim:/top/DUT/PCS_U/PCS_RX_U/decode/Data_out
add wave -noupdate vsim:/top/DUT/PCS_U/PCS_RX_U/decode/flag
add wave -noupdate vsim:/top/DUT/PCS_U/PCS_RX_U/decode/RxDataK_N
add wave -noupdate vsim:/top/DUT/PCS_U/PCS_RX_U/decode/RxDataK_P
add wave -noupdate vsim:/top/DUT/PCS_U/PCS_RX_U/decode/RxDataK
add wave -noupdate vsim:/top/DUT/RX_Status
add wave -noupdate vsim:/top/DUT/RX_Valid
add wave -noupdate vsim:/top/DUT/RxPolarity
add wave -noupdate vsim:/top/DUT/Common_Block_U/Ref_Clk
add wave -noupdate vsim:/top/DUT/Common_Block_U/Rst_n
add wave -noupdate vsim:/top/DUT/Common_Block_U/DataBusWidth
add wave -noupdate vsim:/top/DUT/Common_Block_U/Bit_Rate_Clk
add wave -noupdate vsim:/top/DUT/Common_Block_U/Bit_Rate_CLK_10
add wave -noupdate vsim:/top/DUT/Common_Block_U/PCLK
add wave -noupdate vsim:/top/DUT/Common_Block_U/ratio
add wave -noupdate vsim:/top/DUT/PMA_U/PM_RX_U/serialToparallel/Recovered_Bit_Clk
add wave -noupdate vsim:/top/DUT/PMA_U/PM_RX_U/serialToparallel/Ser_in
add wave -noupdate vsim:/top/DUT/PMA_U/PM_RX_U/serialToparallel/Rst_n
add wave -noupdate vsim:/top/DUT/PMA_U/PM_RX_U/serialToparallel/RxPolarity
add wave -noupdate vsim:/top/DUT/PCS_U/PCS_RX_U/buffer/write_clk
add wave -noupdate vsim:/top/DUT/PCS_U/PCS_RX_U/buffer/read_clk
add wave -noupdate vsim:/top/DUT/PCS_U/PCS_RX_U/buffer/data_in
add wave -noupdate vsim:/top/DUT/PCS_U/PCS_RX_U/buffer/rst_n
add wave -noupdate vsim:/top/DUT/PCS_U/PCS_RX_U/buffer/Skp_Removed
add wave -noupdate vsim:/top/DUT/PCS_U/PCS_RX_U/buffer/overflow
add wave -noupdate vsim:/top/DUT/PCS_U/PCS_RX_U/buffer/underflow
add wave -noupdate vsim:/top/DUT/PCS_U/PCS_RX_U/buffer/data_out
add wave -noupdate vsim:/top/DUT/PCS_U/PCS_RX_U/buffer/gray_write_pointer
add wave -noupdate vsim:/top/DUT/PCS_U/PCS_RX_U/buffer/gray_read_pointer
add wave -noupdate vsim:/top/DUT/PCS_U/PCS_RX_U/buffer/write_address
add wave -noupdate vsim:/top/DUT/PCS_U/PCS_RX_U/buffer/read_address
add wave -noupdate vsim:/top/DUT/PCS_U/PCS_RX_U/buffer/sync_gray_read_out
add wave -noupdate vsim:/top/DUT/PCS_U/PCS_RX_U/buffer/sync_gray_write_out
add wave -noupdate vsim:/top/DUT/PCS_U/PCS_RX_U/buffer/delete_req
add wave -noupdate vsim:/top/DUT/PCS_U/PCS_RX_U/buffer/elastic_mem_inst/read_clk
add wave -noupdate vsim:/top/DUT/PCS_U/PCS_RX_U/buffer/elastic_mem_inst/write_clk
add wave -noupdate vsim:/top/DUT/PCS_U/PCS_RX_U/buffer/elastic_mem_inst/full
add wave -noupdate vsim:/top/DUT/PCS_U/PCS_RX_U/buffer/elastic_mem_inst/empty
add wave -noupdate vsim:/top/DUT/PCS_U/PCS_RX_U/buffer/elastic_mem_inst/data_in
add wave -noupdate vsim:/top/DUT/PCS_U/PCS_RX_U/buffer/add_req
add wave -noupdate vsim:/top/DUT/PCS_U/PCS_RX_U/buffer/elastic_mem_inst/read_pointer
add wave -noupdate vsim:/top/DUT/PCS_U/PCS_RX_U/buffer/elastic_mem_inst/write_pointer
add wave -noupdate -radix hexadecimal vsim:/top/DUT/Data_In_PMA
add wave -noupdate vsim:/top/DUT/PCS_U/PCS_RX_U/buffer/elastic_mem_inst/data_out
add wave -noupdate vsim:/top/DUT/PCS_U/PCS_RX_U/buffer/elastic_mem_inst/buffer
add wave -noupdate vsim:/top/DUT/PCS_U/PCS_TX_U/GasKet_U/Temp_Reg
add wave -noupdate -divider -height 50 Decoder
add wave -noupdate vsim:/top/DUT/PCS_U/PCS_RX_U/decode/CLK
add wave -noupdate vsim:/top/DUT/PCS_U/PCS_RX_U/decode/Rst_n
add wave -noupdate vsim:/top/DUT/PCS_U/PCS_RX_U/decode/Data_in
add wave -noupdate vsim:/top/DUT/PCS_U/PCS_RX_U/decode/Data_out
add wave -noupdate vsim:/top/DUT/PCS_U/PCS_RX_U/decode/DecodeError
add wave -noupdate vsim:/top/DUT/PCS_U/PCS_RX_U/decode/DisparityError
add wave -noupdate vsim:/top/DUT/PCS_U/PCS_RX_U/decode/RxDataK
add wave -noupdate vsim:/top/DUT/PCS_U/PCS_RX_U/decode/temp
add wave -noupdate vsim:/top/DUT/PCS_U/PCS_RX_U/decode/encoded_data_N
add wave -noupdate vsim:/top/DUT/PCS_U/PCS_RX_U/decode/encoded_data_P
add wave -noupdate vsim:/top/DUT/PCS_U/PCS_RX_U/decode/DecodeError_N
add wave -noupdate vsim:/top/DUT/PCS_U/PCS_RX_U/decode/DecodeError_P
add wave -noupdate vsim:/top/DUT/PCS_U/PCS_RX_U/decode/RxDataK_N
add wave -noupdate vsim:/top/DUT/PCS_U/PCS_RX_U/decode/RxDataK_P
add wave -noupdate vsim:/top/DUT/PCS_U/PCS_RX_U/decode/flag
add wave -noupdate vsim:/top/DUT/PCS_U/PCS_RX_U/decode/flag_n
add wave -noupdate vsim:/top/DUT/PCS_U/PCS_RX_U/decode/flag_p
add wave -noupdate -divider -height 50 RX_GASKET
add wave -noupdate vsim:/top/DUT/PCS_U/PCS_RX_U/rx_gasket/clk_to_get
add wave -noupdate vsim:/top/DUT/PCS_U/PCS_RX_U/rx_gasket/PCLK
add wave -noupdate vsim:/top/DUT/PCS_U/PCS_RX_U/rx_gasket/Rst_n
add wave -noupdate vsim:/top/DUT/PCS_U/PCS_RX_U/rx_gasket/Rx_Datak
add wave -noupdate vsim:/top/DUT/PCS_U/PCS_RX_U/rx_gasket/width
add wave -noupdate vsim:/top/DUT/PCS_U/PCS_RX_U/rx_gasket/Data_in
add wave -noupdate vsim:/top/DUT/PCS_U/PCS_RX_U/rx_gasket/Data_out
add wave -noupdate vsim:/top/DUT/PCS_U/PCS_RX_U/rx_gasket/data_out
add wave -noupdate vsim:/top/DUT/PCS_U/PCS_RX_U/rx_gasket/count
add wave -noupdate vsim:/top/DUT/PCS_U/PCS_RX_U/rx_gasket/flag
add wave -noupdate vsim:/top/DUT/PCS_U/PCS_RX_U/rx_gasket/temp_reg
add wave -noupdate -divider -height 30 {Comma Detection}
add wave -noupdate vsim:/top/DUT/PCS_U/PCS_RX_U/Comma_Detection_U/COMMA_NUMBER
add wave -noupdate vsim:/top/DUT/PCS_U/PCS_RX_U/Comma_Detection_U/IDLE
add wave -noupdate vsim:/top/DUT/PCS_U/PCS_RX_U/Comma_Detection_U/COMMA
add wave -noupdate vsim:/top/DUT/PCS_U/PCS_RX_U/Comma_Detection_U/DATA
add wave -noupdate vsim:/top/DUT/PCS_U/PCS_RX_U/Comma_Detection_U/clk
add wave -noupdate vsim:/top/DUT/PCS_U/PCS_RX_U/Comma_Detection_U/rst_n
add wave -noupdate vsim:/top/DUT/PCS_U/PCS_RX_U/Comma_Detection_U/Data_Collected
add wave -noupdate vsim:/top/DUT/PCS_U/PCS_RX_U/Comma_Detection_U/RxValid
add wave -noupdate vsim:/top/DUT/PCS_U/PCS_RX_U/Comma_Detection_U/Comma_Pulse
add wave -noupdate vsim:/top/DUT/PCS_U/PCS_RX_U/Comma_Detection_U/cs
add wave -noupdate vsim:/top/DUT/PCS_U/PCS_RX_U/Comma_Detection_U/ns
add wave -noupdate vsim:/top/DUT/PCS_U/PCS_RX_U/Comma_Detection_U/CP1
add wave -noupdate vsim:/top/DUT/PCS_U/PCS_RX_U/Comma_Detection_U/CP2
add wave -noupdate vsim:/top/DUT/PCS_U/PCS_RX_U/Comma_Detection_U/count
add wave -noupdate vsim:/top/DUT/PCS_U/PCS_RX_U/Comma_Detection_U/count_reset
add wave -noupdate -divider -height 30 Serial_To_Parallel
add wave -noupdate vsim:/top/DUT/PMA_U/PM_RX_U/serialToparallel/DATA_WIDTH
add wave -noupdate vsim:/top/DUT/PMA_U/PM_RX_U/serialToparallel/Recovered_Bit_Clk
add wave -noupdate vsim:/top/internals_if/Bit_CLK
add wave -noupdate vsim:/top/DUT/PMA_U/PM_RX_U/serialToparallel/Ser_in
add wave -noupdate vsim:/top/DUT/PMA_U/PM_RX_U/serialToparallel/Rst_n
add wave -noupdate vsim:/top/DUT/PMA_U/PM_RX_U/serialToparallel/RxPolarity
add wave -noupdate vsim:/top/DUT/PMA_U/PM_RX_U/serialToparallel/Data_Collected
add wave -noupdate vsim:/top/DUT/PMA_U/PM_RX_U/serialToparallel/serial
add wave -noupdate -divider -height 30 Sine
add wave -noupdate -radix unsigned vsim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/index
add wave -noupdate -childformat {{{/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/sin_0[176]} -radix unsigned}} -subitemconfig {{/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/sin_0[176]} {-height 15 -radix unsigned}} vsim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/sin_0
add wave -noupdate vsim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/sin_90
add wave -noupdate vsim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/sin_180
add wave -noupdate vsim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/sin_270
add wave -noupdate -childformat {{{/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/sin_45[176]} -radix unsigned}} -subitemconfig {{/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/sin_45[176]} {-height 15 -radix unsigned}} vsim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/sin_45
add wave -noupdate vsim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/sin_135
add wave -noupdate vsim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/sin_225
add wave -noupdate vsim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/sin_315
add wave -noupdate -divider -height 50 CHANNEL
add wave -noupdate vsim:/top/DUT/PMA_U/channelInst/A
add wave -noupdate vsim:/top/DUT/PMA_U/channelInst/A_
add wave -noupdate vsim:/top/DUT/PMA_U/channelInst/alpha
add wave -noupdate vsim:/top/DUT/PMA_U/channelInst/ATTENUATION
add wave -noupdate vsim:/top/DUT/PMA_U/channelInst/beta
add wave -noupdate vsim:/top/DUT/PMA_U/channelInst/Data_in
add wave -noupdate vsim:/top/DUT/PMA_U/channelInst/F
add wave -noupdate vsim:/top/DUT/PMA_U/channelInst/N
add wave -noupdate vsim:/top/DUT/PMA_U/channelInst/Sample_CLK
add wave -noupdate vsim:/top/DUT/PMA_U/channelInst/Unew
add wave -noupdate vsim:/top/DUT/PMA_U/channelInst/Uold
add wave -noupdate vsim:/top/DUT/PMA_U/channelInst/Wc
add wave -noupdate vsim:/top/DUT/PMA_U/channelInst/x1
add wave -noupdate vsim:/top/DUT/PMA_U/channelInst/x2
add wave -noupdate vsim:/top/DUT/PMA_U/channelInst/Ynew
add wave -noupdate vsim:/top/DUT/PMA_U/channelInst/Ynewn
add wave -noupdate vsim:/top/DUT/PMA_U/channelInst/Yold
add wave -noupdate vsim:/top/PPM_checker_PI_clk_U/assert_no_glitch
add wave -noupdate vsim:/top/PPM_checker_PI_clk_U/assert_PPM
add wave -noupdate vsim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phaseDetector/clk_ref
add wave -noupdate vsim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phaseDetector/Din
add wave -noupdate vsim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phaseDetector/rst_n
add wave -noupdate vsim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phaseDetector/Up
add wave -noupdate -color Magenta -format Analog-Step -height 74 -max 1073740000.0000001 -radix unsigned vsim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/DLF_U/freq_integrator
add wave -noupdate vsim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phaseDetector/Dn
add wave -noupdate -divider -height 50 PI
add wave -noupdate vsim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/CLK
add wave -noupdate vsim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/Code
add wave -noupdate vsim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/rst_n
add wave -noupdate vsim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/clk_90
add wave -noupdate vsim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/clk_180
add wave -noupdate vsim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/CLK_Out_i
add wave -noupdate vsim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/clk_index
add wave -noupdate vsim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/index
add wave -noupdate vsim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/sin_sum
add wave -noupdate vsim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/PHASE_SHIFT
add wave -noupdate vsim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/t1
add wave -noupdate vsim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/t2
add wave -noupdate vsim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/T1
add wave -noupdate vsim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/T_
add wave -noupdate vsim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/sin1
add wave -noupdate vsim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/t3
add wave -noupdate vsim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/t4
add wave -noupdate vsim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/T1_P2
add wave -noupdate vsim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/sin2
add wave -noupdate vsim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/t5
add wave -noupdate vsim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/t6
add wave -noupdate vsim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/RESULT_PERIOD
add wave -noupdate vsim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/time_now
add wave -noupdate vsim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/preparation_flag
add wave -noupdate vsim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/glitchR_found
add wave -noupdate vsim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/glitchF_found
add wave -noupdate vsim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/PPM
add wave -noupdate vsim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/CLK_Out
add wave -noupdate vsim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/i
add wave -noupdate vsim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/j
add wave -noupdate vsim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/k
add wave -noupdate vsim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/last_time
add wave -noupdate vsim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/sign_0
add wave -noupdate vsim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/sign_90
add wave -noupdate vsim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/sign_180
add wave -noupdate vsim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/sign_270
add wave -noupdate vsim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/sign_45
add wave -noupdate vsim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/sign_135
add wave -noupdate vsim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/sign_225
add wave -noupdate vsim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/sign_315
add wave -noupdate vsim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/clk_sin
add wave -noupdate -divider -height 40 SSC
add wave -noupdate vsim:/top/DUT/Common_Block_U/Bit_Rate_Clk_
add wave -noupdate sim:/top/PPM_checker_PI_clk_U/assert_no_glitch
add wave -noupdate sim:/top/PPM_checker_PI_clk_U/assert_PPM
add wave -noupdate sim:/top/PPM_checker_PI_clk_U/assert_PI_PPM
add wave -noupdate sim:/top/PPM_checker_PI_clk_U/assert_no_PI_glitch
add wave -noupdate sim:/top/PPM_checker_PI_clk_U/PPM_value
add wave -noupdate sim:/top/PPM_checker_PI_clk_U/PI_PPM_value
add wave -noupdate -divider -height 30 {Watched Signals}
add wave -noupdate -color Magenta sim:/top/internals_if/Bit_CLK
add wave -noupdate sim:/top/DUT/PMA_U/PM_RX_U/serialToparallel/Recovered_Bit_Clk
add wave -noupdate -color Magenta sim:/top/dut_if/MAC_TX_Data
add wave -noupdate -color Magenta sim:/top/DUT/RX_Data
add wave -noupdate -childformat {{{/top/DUT/PCS_U/PCS_RX_U/buffer/elastic_mem_inst/buffer[14]} -radix hexadecimal}} -subitemconfig {{/top/DUT/PCS_U/PCS_RX_U/buffer/elastic_mem_inst/buffer[14]} {-height 15 -radix hexadecimal}} sim:/top/DUT/PCS_U/PCS_RX_U/buffer/elastic_mem_inst/buffer
add wave -noupdate -color Cyan sim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/Din
add wave -noupdate -color {Green Yellow} sim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/PI_Clk
add wave -noupdate -color Cyan sim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/Dout
add wave -noupdate -color Gold -format Analog-Step -height 74 -max 50.0 sim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/sin_sum
add wave -noupdate sim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/code
add wave -noupdate -color Magenta -format Analog-Step -height 74 -max 65532.999999999993 -radix unsigned sim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/DLF_U/freq_integrator
add wave -noupdate -format Analog-Step -height 74 -max 65532.0 -radix unsigned sim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/DLF_U/phase_integrator
add wave -noupdate sim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/DLF_U/UP_DN
add wave -noupdate -color Magenta sim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/DLF_U/Up
add wave -noupdate -color Magenta sim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/DLF_U/Dn
add wave -noupdate -divider CHANNEL
add wave -noupdate sim:/top/DUT/PMA_U/channelInst/Data_in
add wave -noupdate -color Yellow -format Analog-Step -height 74 -max 0.99997199999999997 sim:/top/DUT/PMA_U/channelInst/Ynew
add wave -noupdate -divider -height 30 {CDR important signals}
add wave -noupdate -format Analog-Step -height 74 -min -1.0 -radix decimal sim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/Code
add wave -noupdate -divider -height 70 WATCH_SIGNALS
add wave -noupdate -childformat {{{/top/DUT/PCS_U/PCS_RX_U/buffer/elastic_mem_inst/buffer[14]} -radix hexadecimal}} -subitemconfig {{/top/DUT/PCS_U/PCS_RX_U/buffer/elastic_mem_inst/buffer[14]} {-height 15 -radix hexadecimal}} sim:/top/DUT/PCS_U/PCS_RX_U/buffer/elastic_mem_inst/buffer
add wave -noupdate sim:/top/dut_if/Reset_n
add wave -noupdate sim:/top/dut_if/Ref_CLK
add wave -noupdate -color Magenta sim:/top/dut_if/PCLK
add wave -noupdate -color Magenta sim:/top/internals_if/Word_CLK
add wave -noupdate -color Magenta sim:/top/internals_if/Bit_CLK
add wave -noupdate sim:/top/internals_if/DataBusWidth
add wave -noupdate sim:/top/dut_if/MAC_TX_Data
add wave -noupdate sim:/top/dut_if/MAC_Data_En
add wave -noupdate sim:/top/dut_if/MAC_TX_DataK
add wave -noupdate sim:/top/DUT/PCS_U/PCS_TX_U/GasKet_U/TxData
add wave -noupdate sim:/top/DUT/PCS_U/PCS_TX_U/GasKet_U/TxDataK
add wave -noupdate -color Yellow -radix binary -childformat {{{/top/DUT/Data_In_PMA[9]} -radix hexadecimal} {{/top/DUT/Data_In_PMA[8]} -radix hexadecimal} {{/top/DUT/Data_In_PMA[7]} -radix hexadecimal} {{/top/DUT/Data_In_PMA[6]} -radix hexadecimal} {{/top/DUT/Data_In_PMA[5]} -radix hexadecimal} {{/top/DUT/Data_In_PMA[4]} -radix hexadecimal} {{/top/DUT/Data_In_PMA[3]} -radix hexadecimal} {{/top/DUT/Data_In_PMA[2]} -radix hexadecimal} {{/top/DUT/Data_In_PMA[1]} -radix hexadecimal} {{/top/DUT/Data_In_PMA[0]} -radix hexadecimal}} -subitemconfig {{/top/DUT/Data_In_PMA[9]} {-color Yellow -height 15 -radix hexadecimal} {/top/DUT/Data_In_PMA[8]} {-color Yellow -height 15 -radix hexadecimal} {/top/DUT/Data_In_PMA[7]} {-color Yellow -height 15 -radix hexadecimal} {/top/DUT/Data_In_PMA[6]} {-color Yellow -height 15 -radix hexadecimal} {/top/DUT/Data_In_PMA[5]} {-color Yellow -height 15 -radix hexadecimal} {/top/DUT/Data_In_PMA[4]} {-color Yellow -height 15 -radix hexadecimal} {/top/DUT/Data_In_PMA[3]} {-color Yellow -height 15 -radix hexadecimal} {/top/DUT/Data_In_PMA[2]} {-color Yellow -height 15 -radix hexadecimal} {/top/DUT/Data_In_PMA[1]} {-color Yellow -height 15 -radix hexadecimal} {/top/DUT/Data_In_PMA[0]} {-color Yellow -height 15 -radix hexadecimal}} sim:/top/DUT/Data_In_PMA
add wave -noupdate -color Yellow -radix hexadecimal -childformat {{{/top/DUT/Data_In_PMA[9]} -radix hexadecimal} {{/top/DUT/Data_In_PMA[8]} -radix hexadecimal} {{/top/DUT/Data_In_PMA[7]} -radix hexadecimal} {{/top/DUT/Data_In_PMA[6]} -radix hexadecimal} {{/top/DUT/Data_In_PMA[5]} -radix hexadecimal} {{/top/DUT/Data_In_PMA[4]} -radix hexadecimal} {{/top/DUT/Data_In_PMA[3]} -radix hexadecimal} {{/top/DUT/Data_In_PMA[2]} -radix hexadecimal} {{/top/DUT/Data_In_PMA[1]} -radix hexadecimal} {{/top/DUT/Data_In_PMA[0]} -radix hexadecimal}} -subitemconfig {{/top/DUT/Data_In_PMA[9]} {-color Yellow -height 15 -radix hexadecimal} {/top/DUT/Data_In_PMA[8]} {-color Yellow -height 15 -radix hexadecimal} {/top/DUT/Data_In_PMA[7]} {-color Yellow -height 15 -radix hexadecimal} {/top/DUT/Data_In_PMA[6]} {-color Yellow -height 15 -radix hexadecimal} {/top/DUT/Data_In_PMA[5]} {-color Yellow -height 15 -radix hexadecimal} {/top/DUT/Data_In_PMA[4]} {-color Yellow -height 15 -radix hexadecimal} {/top/DUT/Data_In_PMA[3]} {-color Yellow -height 15 -radix hexadecimal} {/top/DUT/Data_In_PMA[2]} {-color Yellow -height 15 -radix hexadecimal} {/top/DUT/Data_In_PMA[1]} {-color Yellow -height 15 -radix hexadecimal} {/top/DUT/Data_In_PMA[0]} {-color Yellow -height 15 -radix hexadecimal}} sim:/top/DUT/Data_In_PMA
add wave -noupdate -radix binary sim:/top/DUT/Data_In_PMA
add wave -noupdate sim:/top/internals_if/TX_Out_P
add wave -noupdate sim:/top/DUT/PCS_U/PCS_RX_U/buffer/overflow
add wave -noupdate sim:/top/DUT/PCS_U/PCS_RX_U/buffer/underflow
add wave -noupdate sim:/top/DUT/PCS_U/PCS_RX_U/buffer/delete_req
add wave -noupdate sim:/top/DUT/PCS_U/PCS_RX_U/buffer/add_req
add wave -noupdate sim:/top/DUT/PCS_U/PCS_RX_U/buffer/elastic_mem_inst/read_pointer
add wave -noupdate sim:/top/DUT/PCS_U/PCS_RX_U/buffer/elastic_mem_inst/write_pointer
add wave -noupdate sim:/top/DUT/PCS_U/PCS_RX_U/buffer/elastic_mem_inst/data_out
add wave -noupdate -color Magenta sim:/top/dut_if/MAC_TX_Data
add wave -noupdate -color Magenta sim:/top/DUT/RX_Data
add wave -noupdate -childformat {{{/top/DUT/PCS_U/PCS_RX_U/buffer/elastic_mem_inst/buffer[14]} -radix hexadecimal}} -subitemconfig {{/top/DUT/PCS_U/PCS_RX_U/buffer/elastic_mem_inst/buffer[14]} {-height 15 -radix hexadecimal}} sim:/top/DUT/PCS_U/PCS_RX_U/buffer/elastic_mem_inst/buffer
add wave -noupdate sim:/top/DUT/PCS_U/PCS_RX_U/buffer/Threshold_Monitor_Inst/num_elements
add wave -noupdate sim:/top/dut_if/MAC_TX_Data
add wave -noupdate -color Magenta sim:/top/dut_if/PCLK
add wave -noupdate sim:/top/DUT/PCS_U/PCS_RX_U/buffer/elastic_mem_inst/data_out
add wave -noupdate sim:/top/DUT/PCS_U/PCS_RX_U/decode/Data_out
add wave -noupdate sim:/top/DUT/PCS_U/PCS_RX_U/decode/RxDataK
add wave -noupdate sim:/top/dut_if/Rx_Data
add wave -noupdate sim:/top/dut_if/Rx_DataK
add wave -noupdate -radix binary sim:/top/dut_if/Rx_Status
add wave -noupdate sim:/top/dut_if/Rx_Valid
add wave -noupdate -divider -height 70 BFM
add wave -noupdate sim:/top/dut_if/Ref_CLK
add wave -noupdate sim:/top/dut_if/Reset_n
add wave -noupdate sim:/top/dut_if/DataBusWidth
add wave -noupdate -color Magenta sim:/top/dut_if/MAC_TX_Data
add wave -noupdate sim:/top/dut_if/MAC_TX_DataK
add wave -noupdate sim:/top/dut_if/MAC_Data_En
add wave -noupdate sim:/top/dut_if/RxPolarity
add wave -noupdate -color Magenta sim:/top/dut_if/Rx_Data
add wave -noupdate sim:/top/dut_if/Rx_DataK
add wave -noupdate -radix binary sim:/top/dut_if/Rx_Status
add wave -noupdate sim:/top/dut_if/Rx_Valid
add wave -noupdate -divider -height 50 INTERNALS
add wave -noupdate sim:/top/dut_if/PCLK
add wave -noupdate sim:/top/internals_if/Word_CLK
add wave -noupdate sim:/top/internals_if/Bit_CLK
add wave -noupdate sim:/top/internals_if/DataBusWidth
add wave -noupdate sim:/top/dut_if/MAC_TX_Data
add wave -noupdate -radix binary sim:/top/DUT/Data_In_PMA
add wave -noupdate -radix hexadecimal sim:/top/DUT/Data_In_PMA
add wave -noupdate sim:/top/DUT/PCS_U/PCS_TX_U/GasKet_U/TxData
add wave -noupdate sim:/top/DUT/PCS_U/PCS_TX_U/GasKet_U/TxDataK
add wave -noupdate sim:/top/internals_if/TX_Out_P
add wave -noupdate -divider -height 50 DUT
add wave -noupdate sim:/top/dut_if/MAC_TX_Data
add wave -noupdate sim:/top/DUT/PCLK
add wave -noupdate sim:/top/DUT/Bit_Rate_CLK_10
add wave -noupdate sim:/top/DUT/Bit_Rate_Clk
add wave -noupdate sim:/top/internals_if/TX_Out_P
add wave -noupdate -radix binary sim:/top/DUT/Data_In_PMA
add wave -noupdate sim:/top/DUT/Data_Out_PMA
add wave -noupdate sim:/top/DUT/DataBusWidth
add wave -noupdate sim:/top/DUT/MAC_Data_En
add wave -noupdate sim:/top/DUT/MAC_TX_Data
add wave -noupdate -radix binary sim:/top/DUT/MAC_TX_DataK
add wave -noupdate sim:/top/DUT/Ref_CLK
add wave -noupdate sim:/top/DUT/Reset_n
add wave -noupdate -color Magenta sim:/top/DUT/RX_Data
add wave -noupdate sim:/top/DUT/PCS_U/PCS_RX_U/buffer/elastic_mem_inst/data_out
add wave -noupdate sim:/top/DUT/PCS_U/PCS_RX_U/decode/Data_out
add wave -noupdate sim:/top/DUT/PCS_U/PCS_RX_U/decode/flag
add wave -noupdate sim:/top/DUT/PCS_U/PCS_RX_U/decode/RxDataK_N
add wave -noupdate sim:/top/DUT/PCS_U/PCS_RX_U/decode/RxDataK_P
add wave -noupdate sim:/top/DUT/PCS_U/PCS_RX_U/decode/RxDataK
add wave -noupdate sim:/top/DUT/RX_Status
add wave -noupdate sim:/top/DUT/RX_Valid
add wave -noupdate sim:/top/DUT/RxPolarity
add wave -noupdate sim:/top/DUT/Common_Block_U/Ref_Clk
add wave -noupdate sim:/top/DUT/Common_Block_U/Rst_n
add wave -noupdate sim:/top/DUT/Common_Block_U/DataBusWidth
add wave -noupdate sim:/top/DUT/Common_Block_U/Bit_Rate_Clk
add wave -noupdate sim:/top/DUT/Common_Block_U/Bit_Rate_CLK_10
add wave -noupdate sim:/top/DUT/Common_Block_U/PCLK
add wave -noupdate sim:/top/DUT/Common_Block_U/ratio
add wave -noupdate sim:/top/DUT/PMA_U/PM_RX_U/serialToparallel/Recovered_Bit_Clk
add wave -noupdate sim:/top/DUT/PMA_U/PM_RX_U/serialToparallel/Ser_in
add wave -noupdate sim:/top/DUT/PMA_U/PM_RX_U/serialToparallel/Rst_n
add wave -noupdate sim:/top/DUT/PMA_U/PM_RX_U/serialToparallel/RxPolarity
add wave -noupdate sim:/top/DUT/PCS_U/PCS_RX_U/buffer/write_clk
add wave -noupdate sim:/top/DUT/PCS_U/PCS_RX_U/buffer/read_clk
add wave -noupdate sim:/top/DUT/PCS_U/PCS_RX_U/buffer/data_in
add wave -noupdate sim:/top/DUT/PCS_U/PCS_RX_U/buffer/rst_n
add wave -noupdate sim:/top/DUT/PCS_U/PCS_RX_U/buffer/Skp_Removed
add wave -noupdate sim:/top/DUT/PCS_U/PCS_RX_U/buffer/overflow
add wave -noupdate sim:/top/DUT/PCS_U/PCS_RX_U/buffer/underflow
add wave -noupdate sim:/top/DUT/PCS_U/PCS_RX_U/buffer/data_out
add wave -noupdate sim:/top/DUT/PCS_U/PCS_RX_U/buffer/gray_write_pointer
add wave -noupdate sim:/top/DUT/PCS_U/PCS_RX_U/buffer/gray_read_pointer
add wave -noupdate sim:/top/DUT/PCS_U/PCS_RX_U/buffer/write_address
add wave -noupdate sim:/top/DUT/PCS_U/PCS_RX_U/buffer/read_address
add wave -noupdate sim:/top/DUT/PCS_U/PCS_RX_U/buffer/sync_gray_read_out
add wave -noupdate sim:/top/DUT/PCS_U/PCS_RX_U/buffer/sync_gray_write_out
add wave -noupdate sim:/top/DUT/PCS_U/PCS_RX_U/buffer/delete_req
add wave -noupdate sim:/top/DUT/PCS_U/PCS_RX_U/buffer/elastic_mem_inst/read_clk
add wave -noupdate sim:/top/DUT/PCS_U/PCS_RX_U/buffer/elastic_mem_inst/write_clk
add wave -noupdate sim:/top/DUT/PCS_U/PCS_RX_U/buffer/elastic_mem_inst/full
add wave -noupdate sim:/top/DUT/PCS_U/PCS_RX_U/buffer/elastic_mem_inst/empty
add wave -noupdate sim:/top/DUT/PCS_U/PCS_RX_U/buffer/elastic_mem_inst/data_in
add wave -noupdate sim:/top/DUT/PCS_U/PCS_RX_U/buffer/add_req
add wave -noupdate sim:/top/DUT/PCS_U/PCS_RX_U/buffer/elastic_mem_inst/read_pointer
add wave -noupdate sim:/top/DUT/PCS_U/PCS_RX_U/buffer/elastic_mem_inst/write_pointer
add wave -noupdate -radix hexadecimal sim:/top/DUT/Data_In_PMA
add wave -noupdate sim:/top/DUT/PCS_U/PCS_RX_U/buffer/elastic_mem_inst/data_out
add wave -noupdate sim:/top/DUT/PCS_U/PCS_RX_U/buffer/elastic_mem_inst/buffer
add wave -noupdate sim:/top/DUT/PCS_U/PCS_TX_U/GasKet_U/Temp_Reg
add wave -noupdate -divider -height 50 Decoder
add wave -noupdate sim:/top/DUT/PCS_U/PCS_RX_U/decode/CLK
add wave -noupdate sim:/top/DUT/PCS_U/PCS_RX_U/decode/Rst_n
add wave -noupdate sim:/top/DUT/PCS_U/PCS_RX_U/decode/Data_in
add wave -noupdate sim:/top/DUT/PCS_U/PCS_RX_U/decode/Data_out
add wave -noupdate sim:/top/DUT/PCS_U/PCS_RX_U/decode/DecodeError
add wave -noupdate sim:/top/DUT/PCS_U/PCS_RX_U/decode/DisparityError
add wave -noupdate sim:/top/DUT/PCS_U/PCS_RX_U/decode/RxDataK
add wave -noupdate sim:/top/DUT/PCS_U/PCS_RX_U/decode/temp
add wave -noupdate sim:/top/DUT/PCS_U/PCS_RX_U/decode/encoded_data_N
add wave -noupdate sim:/top/DUT/PCS_U/PCS_RX_U/decode/encoded_data_P
add wave -noupdate sim:/top/DUT/PCS_U/PCS_RX_U/decode/DecodeError_N
add wave -noupdate sim:/top/DUT/PCS_U/PCS_RX_U/decode/DecodeError_P
add wave -noupdate sim:/top/DUT/PCS_U/PCS_RX_U/decode/RxDataK_N
add wave -noupdate sim:/top/DUT/PCS_U/PCS_RX_U/decode/RxDataK_P
add wave -noupdate sim:/top/DUT/PCS_U/PCS_RX_U/decode/flag
add wave -noupdate sim:/top/DUT/PCS_U/PCS_RX_U/decode/flag_n
add wave -noupdate sim:/top/DUT/PCS_U/PCS_RX_U/decode/flag_p
add wave -noupdate -divider -height 50 RX_GASKET
add wave -noupdate sim:/top/DUT/PCS_U/PCS_RX_U/rx_gasket/clk_to_get
add wave -noupdate sim:/top/DUT/PCS_U/PCS_RX_U/rx_gasket/PCLK
add wave -noupdate sim:/top/DUT/PCS_U/PCS_RX_U/rx_gasket/Rst_n
add wave -noupdate sim:/top/DUT/PCS_U/PCS_RX_U/rx_gasket/Rx_Datak
add wave -noupdate sim:/top/DUT/PCS_U/PCS_RX_U/rx_gasket/width
add wave -noupdate sim:/top/DUT/PCS_U/PCS_RX_U/rx_gasket/Data_in
add wave -noupdate sim:/top/DUT/PCS_U/PCS_RX_U/rx_gasket/Data_out
add wave -noupdate sim:/top/DUT/PCS_U/PCS_RX_U/rx_gasket/data_out
add wave -noupdate sim:/top/DUT/PCS_U/PCS_RX_U/rx_gasket/count
add wave -noupdate sim:/top/DUT/PCS_U/PCS_RX_U/rx_gasket/flag
add wave -noupdate sim:/top/DUT/PCS_U/PCS_RX_U/rx_gasket/temp_reg
add wave -noupdate -divider -height 30 {Comma Detection}
add wave -noupdate sim:/top/DUT/PCS_U/PCS_RX_U/Comma_Detection_U/COMMA_NUMBER
add wave -noupdate sim:/top/DUT/PCS_U/PCS_RX_U/Comma_Detection_U/IDLE
add wave -noupdate sim:/top/DUT/PCS_U/PCS_RX_U/Comma_Detection_U/COMMA
add wave -noupdate sim:/top/DUT/PCS_U/PCS_RX_U/Comma_Detection_U/DATA
add wave -noupdate sim:/top/DUT/PCS_U/PCS_RX_U/Comma_Detection_U/clk
add wave -noupdate sim:/top/DUT/PCS_U/PCS_RX_U/Comma_Detection_U/rst_n
add wave -noupdate sim:/top/DUT/PCS_U/PCS_RX_U/Comma_Detection_U/Data_Collected
add wave -noupdate sim:/top/DUT/PCS_U/PCS_RX_U/Comma_Detection_U/RxValid
add wave -noupdate sim:/top/DUT/PCS_U/PCS_RX_U/Comma_Detection_U/Comma_Pulse
add wave -noupdate sim:/top/DUT/PCS_U/PCS_RX_U/Comma_Detection_U/cs
add wave -noupdate sim:/top/DUT/PCS_U/PCS_RX_U/Comma_Detection_U/ns
add wave -noupdate sim:/top/DUT/PCS_U/PCS_RX_U/Comma_Detection_U/CP1
add wave -noupdate sim:/top/DUT/PCS_U/PCS_RX_U/Comma_Detection_U/CP2
add wave -noupdate sim:/top/DUT/PCS_U/PCS_RX_U/Comma_Detection_U/count
add wave -noupdate sim:/top/DUT/PCS_U/PCS_RX_U/Comma_Detection_U/count_reset
add wave -noupdate -divider -height 30 Serial_To_Parallel
add wave -noupdate sim:/top/DUT/PMA_U/PM_RX_U/serialToparallel/DATA_WIDTH
add wave -noupdate sim:/top/DUT/PMA_U/PM_RX_U/serialToparallel/Recovered_Bit_Clk
add wave -noupdate sim:/top/internals_if/Bit_CLK
add wave -noupdate sim:/top/DUT/PMA_U/PM_RX_U/serialToparallel/Ser_in
add wave -noupdate sim:/top/DUT/PMA_U/PM_RX_U/serialToparallel/Rst_n
add wave -noupdate sim:/top/DUT/PMA_U/PM_RX_U/serialToparallel/RxPolarity
add wave -noupdate sim:/top/DUT/PMA_U/PM_RX_U/serialToparallel/Data_Collected
add wave -noupdate sim:/top/DUT/PMA_U/PM_RX_U/serialToparallel/serial
add wave -noupdate -divider -height 30 Sine
add wave -noupdate -radix unsigned sim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/index
add wave -noupdate -childformat {{{/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/sin_0[176]} -radix unsigned}} -subitemconfig {{/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/sin_0[176]} {-height 15 -radix unsigned}} sim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/sin_0
add wave -noupdate sim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/sin_90
add wave -noupdate sim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/sin_180
add wave -noupdate sim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/sin_270
add wave -noupdate -childformat {{{/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/sin_45[176]} -radix unsigned}} -subitemconfig {{/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/sin_45[176]} {-height 15 -radix unsigned}} sim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/sin_45
add wave -noupdate sim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/sin_135
add wave -noupdate sim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/sin_225
add wave -noupdate sim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/sin_315
add wave -noupdate -divider -height 50 CHANNEL
add wave -noupdate sim:/top/DUT/PMA_U/channelInst/A
add wave -noupdate sim:/top/DUT/PMA_U/channelInst/A_
add wave -noupdate sim:/top/DUT/PMA_U/channelInst/alpha
add wave -noupdate sim:/top/DUT/PMA_U/channelInst/ATTENUATION
add wave -noupdate sim:/top/DUT/PMA_U/channelInst/beta
add wave -noupdate sim:/top/DUT/PMA_U/channelInst/Data_in
add wave -noupdate sim:/top/DUT/PMA_U/channelInst/F
add wave -noupdate sim:/top/DUT/PMA_U/channelInst/N
add wave -noupdate sim:/top/DUT/PMA_U/channelInst/Sample_CLK
add wave -noupdate sim:/top/DUT/PMA_U/channelInst/Unew
add wave -noupdate sim:/top/DUT/PMA_U/channelInst/Uold
add wave -noupdate sim:/top/DUT/PMA_U/channelInst/Wc
add wave -noupdate sim:/top/DUT/PMA_U/channelInst/x1
add wave -noupdate sim:/top/DUT/PMA_U/channelInst/x2
add wave -noupdate sim:/top/DUT/PMA_U/channelInst/Ynew
add wave -noupdate sim:/top/DUT/PMA_U/channelInst/Ynewn
add wave -noupdate sim:/top/DUT/PMA_U/channelInst/Yold
add wave -noupdate sim:/top/PPM_checker_PI_clk_U/assert_no_glitch
add wave -noupdate sim:/top/PPM_checker_PI_clk_U/assert_PPM
add wave -noupdate sim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phaseDetector/clk_ref
add wave -noupdate sim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phaseDetector/Din
add wave -noupdate sim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phaseDetector/rst_n
add wave -noupdate sim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phaseDetector/Up
add wave -noupdate -color Magenta -format Analog-Step -height 74 -max 1073740000.0000001 -radix unsigned sim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/DLF_U/freq_integrator
add wave -noupdate sim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phaseDetector/Dn
add wave -noupdate -divider -height 50 PI
add wave -noupdate sim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/CLK
add wave -noupdate sim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/Code
add wave -noupdate sim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/rst_n
add wave -noupdate sim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/clk_90
add wave -noupdate sim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/clk_180
add wave -noupdate sim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/CLK_Out_i
add wave -noupdate sim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/clk_index
add wave -noupdate sim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/index
add wave -noupdate sim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/sin_sum
add wave -noupdate sim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/PHASE_SHIFT
add wave -noupdate sim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/t1
add wave -noupdate sim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/t2
add wave -noupdate sim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/T1
add wave -noupdate sim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/T_
add wave -noupdate sim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/sin1
add wave -noupdate sim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/t3
add wave -noupdate sim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/t4
add wave -noupdate sim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/T1_P2
add wave -noupdate sim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/sin2
add wave -noupdate sim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/t5
add wave -noupdate sim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/t6
add wave -noupdate sim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/RESULT_PERIOD
add wave -noupdate sim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/time_now
add wave -noupdate sim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/preparation_flag
add wave -noupdate sim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/glitchR_found
add wave -noupdate sim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/glitchF_found
add wave -noupdate sim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/PPM
add wave -noupdate sim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/CLK_Out
add wave -noupdate sim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/i
add wave -noupdate sim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/j
add wave -noupdate sim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/k
add wave -noupdate sim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/last_time
add wave -noupdate sim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/sign_0
add wave -noupdate sim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/sign_90
add wave -noupdate sim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/sign_180
add wave -noupdate sim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/sign_270
add wave -noupdate sim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/sign_45
add wave -noupdate sim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/sign_135
add wave -noupdate sim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/sign_225
add wave -noupdate sim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/sign_315
add wave -noupdate sim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/clk_sin
add wave -noupdate -divider -height 40 SSC
add wave -noupdate sim:/top/DUT/Common_Block_U/Bit_Rate_Clk_
TreeUpdate [SetDefaultTree]
quietly WaveActivateNextPane
add wave -noupdate vsim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/rst_n
add wave -noupdate vsim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/clk_0
add wave -noupdate vsim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/clk_data
add wave -noupdate vsim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phaseDetector/clk
add wave -noupdate -color White vsim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phaseDetector/clk
add wave -noupdate -color White vsim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phaseDetector/clk_90
add wave -noupdate -color White vsim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phaseDetector/clk_180
add wave -noupdate -color Cyan vsim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/Din
add wave -noupdate -color {Green Yellow} vsim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/PI_Clk
add wave -noupdate -color Cyan vsim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/Dout
add wave -noupdate vsim:/top/internals_if/Bit_CLK
add wave -noupdate vsim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/DLF_U/code
add wave -noupdate vsim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/up
add wave -noupdate -color Magenta vsim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/DLF_U/Up
add wave -noupdate -color Magenta vsim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/DLF_U/Dn
add wave -noupdate vsim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phaseDetector/A
add wave -noupdate vsim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phaseDetector/A
add wave -noupdate vsim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phaseDetector/B
add wave -noupdate vsim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/DLF_U/clk
add wave -noupdate vsim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/DLF_U/rst_n
add wave -noupdate -color {Orange Red} vsim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/PI_Clk
add wave -noupdate -color Magenta -format Analog-Step -height 74 -max 1073740000.0000001 -radix unsigned vsim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/DLF_U/freq_integrator
add wave -noupdate -format Analog-Step -height 74 -max 1073740000.0000001 -radix unsigned vsim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/DLF_U/phase_integrator
add wave -noupdate vsim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/DLF_U/UP_DN
add wave -noupdate vsim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/dn
add wave -noupdate vsim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/code
add wave -noupdate vsim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/voting_clk
add wave -noupdate sim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/rst_n
add wave -noupdate sim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/clk_0
add wave -noupdate sim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/clk_data
add wave -noupdate sim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phaseDetector/clk
add wave -noupdate -color White sim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phaseDetector/clk
add wave -noupdate -color White sim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phaseDetector/clk_90
add wave -noupdate -color White sim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phaseDetector/clk_180
add wave -noupdate -color Cyan sim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/Din
add wave -noupdate -color {Green Yellow} sim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/PI_Clk
add wave -noupdate -color Cyan sim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/Dout
add wave -noupdate sim:/top/internals_if/Bit_CLK
add wave -noupdate sim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/DLF_U/code
add wave -noupdate sim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/up
add wave -noupdate -color Magenta sim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/DLF_U/Up
add wave -noupdate -color Magenta sim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/DLF_U/Dn
add wave -noupdate sim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phaseDetector/A
add wave -noupdate sim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phaseDetector/A
add wave -noupdate sim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phaseDetector/B
add wave -noupdate sim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/DLF_U/clk
add wave -noupdate sim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/DLF_U/rst_n
add wave -noupdate -color {Orange Red} sim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/PI_Clk
add wave -noupdate -color Magenta -format Analog-Step -height 74 -max 1073740000.0000001 -radix unsigned sim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/DLF_U/freq_integrator
add wave -noupdate -format Analog-Step -height 74 -max 1073740000.0000001 -radix unsigned sim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/DLF_U/phase_integrator
add wave -noupdate sim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/DLF_U/UP_DN
add wave -noupdate sim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/dn
add wave -noupdate sim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/code
add wave -noupdate sim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/voting_clk
add wave -noupdate sim:/top/DUT/PCS_U/PCS_TX_U/GasKet_U/PCLK
add wave -noupdate sim:/top/DUT/PCS_U/PCS_TX_U/GasKet_U/Bit_Rate_CLK_10
add wave -noupdate sim:/top/DUT/PCS_U/PCS_TX_U/GasKet_U/Reset_n
add wave -noupdate sim:/top/DUT/PCS_U/PCS_TX_U/GasKet_U/DataBusWidth
add wave -noupdate sim:/top/DUT/PCS_U/PCS_TX_U/GasKet_U/MAC_TX_Data
add wave -noupdate sim:/top/DUT/PCS_U/PCS_TX_U/GasKet_U/MAC_TX_DataK
add wave -noupdate sim:/top/DUT/PCS_U/PCS_TX_U/GasKet_U/MAC_Data_En
add wave -noupdate sim:/top/DUT/PCS_U/PCS_TX_U/GasKet_U/TxDataK
add wave -noupdate sim:/top/DUT/PCS_U/PCS_TX_U/GasKet_U/TxData
add wave -noupdate sim:/top/DUT/PCS_U/PCS_TX_U/GasKet_U/Counter_16
add wave -noupdate sim:/top/DUT/PCS_U/PCS_TX_U/GasKet_U/Counter_32
add wave -noupdate sim:/top/DUT/PCS_U/PCS_TX_U/GasKet_U/Temp_Reg
add wave -noupdate sim:/top/DUT/PCS_U/PCS_TX_U/GasKet_U/Tempk_Reg
add wave -noupdate sim:/top/DUT/PCS_U/PCS_TX_U/GasKet_U/MAC_TX_Data_temp
add wave -noupdate sim:/top/DUT/PCS_U/PCS_TX_U/GasKet_U/MAC_TX_DataK_temp
add wave -noupdate sim:/top/DUT/PCS_U/PCS_TX_U/GasKet_U/Enable
add wave -noupdate sim:/top/DUT/PCS_U/PCS_TX_U/Encoding_U/data
add wave -noupdate sim:/top/DUT/PCS_U/PCS_TX_U/Encoding_U/MAC_Data_En
add wave -noupdate sim:/top/DUT/PCS_U/PCS_TX_U/Encoding_U/Bit_Rate_10
add wave -noupdate sim:/top/DUT/PCS_U/PCS_TX_U/Encoding_U/Rst
add wave -noupdate sim:/top/DUT/PCS_U/PCS_TX_U/Encoding_U/TXDataK
add wave -noupdate sim:/top/DUT/PCS_U/PCS_TX_U/Encoding_U/data_out
add wave -noupdate sim:/top/DUT/PCS_U/PCS_TX_U/Encoding_U/encoded_pos_data
add wave -noupdate sim:/top/DUT/PCS_U/PCS_TX_U/Encoding_U/encoded_neg_data
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 11} {37770428 fs} 0} {{Cursor 2} {26400539721 fs} 0}
quietly wave cursor active 1
configure wave -namecolwidth 407
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
WaveRestoreZoom {0 fs} {120974848 fs}
