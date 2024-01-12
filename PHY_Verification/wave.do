onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider -height 50 BFM
add wave -noupdate /top/dut_if/Ref_CLK
add wave -noupdate /top/dut_if/Reset_n
add wave -noupdate /top/dut_if/DataBusWidth
add wave -noupdate /top/dut_if/MAC_TX_Data
add wave -noupdate /top/dut_if/MAC_TX_DataK
add wave -noupdate /top/dut_if/MAC_Data_En
add wave -noupdate /top/dut_if/RxPolarity
add wave -noupdate /top/dut_if/Rx_Data
add wave -noupdate /top/dut_if/Rx_DataK
add wave -noupdate /top/dut_if/Rx_Status
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
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/Dutc/clk
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/Dutc/rst_n
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/Dutc/Data_Collected
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/Dutc/RxValid
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/Dutc/Comma_Pulse
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/Dutc/Found_Comma
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/Dutc/count
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
add wave -noupdate /top/DUT/RX_Data
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
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/Dutc/clk
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/Dutc/rst_n
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/Dutc/Data_Collected
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/Dutc/RxValid
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/Dutc/Comma_Pulse
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/Dutc/Found_Comma
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/Dutc/count
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
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/Dutc/RxValid
add wave -noupdate -radix hexadecimal /top/DUT/Data_In_PMA
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/Dutc/Data_Collected
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/buffer/elastic_mem_inst/data_out
add wave -noupdate -expand /top/DUT/PCS_U/PCS_RX_U/buffer/elastic_mem_inst/buffer
add wave -noupdate /top/DUT/PCS_U/PCS_TX_U/GasKet_U/Temp_Reg
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {18900 ps} 1} {{Cursor 2} {27300 ps} 1 Magenta default} {{Cursor 3} {111706 ps} 1 Magenta default} {{Cursor 4} {109243 ps} 0}
quietly wave cursor active 4
configure wave -namecolwidth 401
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
WaveRestoreZoom {93877 ps} {145404 ps}
