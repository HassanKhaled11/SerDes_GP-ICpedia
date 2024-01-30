onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /top/DUTA/cover_PCLK32_period
add wave -noupdate /top/DUTA/cover_Bit_CLK_period
add wave -noupdate /top/DUTA/cover_WORD_CLK_period
add wave -noupdate -divider -height 50 {Common Block}
add wave -noupdate /top/DUT/Common_Block_U/Rst_n
add wave -noupdate /top/DUT/Common_Block_U/DataBusWidth
add wave -noupdate /top/DUT/Common_Block_U/Ref_Clk
add wave -noupdate -color Magenta /top/DUT/Common_Block_U/PCLK
add wave -noupdate -color Magenta /top/DUT/Common_Block_U/Bit_Rate_Clk
add wave -noupdate -color Magenta /top/DUT/Common_Block_U/Bit_Rate_CLK_10
add wave -noupdate -divider -height 50 PCS_TX
add wave -noupdate /top/DUT/PCS_U/PCS_TX_U/PCLK
add wave -noupdate /top/DUT/PCS_U/PCS_TX_U/RST_n
add wave -noupdate /top/DUT/PCS_U/PCS_TX_U/Bit_Rate_Clk_10
add wave -noupdate /top/DUT/PCS_U/PCS_TX_U/DataBusWidth
add wave -noupdate /top/DUT/PCS_U/PCS_TX_U/MAC_TX_Data
add wave -noupdate /top/DUT/PCS_U/PCS_TX_U/MAC_TX_Datak
add wave -noupdate /top/DUT/PCS_U/PCS_TX_U/MAC_Data_En
add wave -noupdate /top/DUT/PCS_U/PCS_TX_U/Data_In_PMA
add wave -noupdate /top/DUT/PCS_U/PCS_TX_U/TxData
add wave -noupdate /top/DUT/PCS_U/PCS_TX_U/TXDataK
add wave -noupdate -divider TX_GASKET
add wave -noupdate /top/DUT/PCS_U/PCS_TX_U/GasKet_U/PCLK
add wave -noupdate /top/DUT/PCS_U/PCS_TX_U/GasKet_U/Bit_Rate_CLK_10
add wave -noupdate /top/DUT/PCS_U/PCS_TX_U/GasKet_U/Reset_n
add wave -noupdate /top/DUT/PCS_U/PCS_TX_U/GasKet_U/DataBusWidth
add wave -noupdate -color Yellow /top/DUT/PCS_U/PCS_TX_U/GasKet_U/MAC_TX_Data
add wave -noupdate /top/DUT/PCS_U/PCS_TX_U/GasKet_U/MAC_TX_DataK
add wave -noupdate /top/DUT/PCS_U/PCS_TX_U/GasKet_U/MAC_Data_En
add wave -noupdate /top/DUT/PCS_U/PCS_TX_U/GasKet_U/TxDataK
add wave -noupdate /top/DUT/PCS_U/PCS_TX_U/GasKet_U/TxData
add wave -noupdate /top/DUT/PCS_U/PCS_TX_U/GasKet_U/Counter_16
add wave -noupdate -color Yellow /top/DUT/PCS_U/PCS_TX_U/GasKet_U/Counter_32
add wave -noupdate -color Yellow /top/DUT/PCS_U/PCS_TX_U/GasKet_U/Temp_Reg
add wave -noupdate /top/DUT/PCS_U/PCS_TX_U/GasKet_U/Tempk_Reg
add wave -noupdate /top/DUT/PCS_U/PCS_TX_U/GasKet_U/MAC_TX_Data_temp
add wave -noupdate /top/DUT/PCS_U/PCS_TX_U/GasKet_U/MAC_TX_DataK_temp
add wave -noupdate /top/DUT/PCS_U/PCS_TX_U/GasKet_U/Enable
add wave -noupdate -divider ENCODER
add wave -noupdate -color Cyan /top/DUT/PCS_U/PCS_TX_U/Encoding_U/data
add wave -noupdate /top/DUT/PCS_U/PCS_TX_U/Encoding_U/MAC_Data_En
add wave -noupdate /top/DUT/PCS_U/PCS_TX_U/Encoding_U/Bit_Rate_10
add wave -noupdate /top/DUT/PCS_U/PCS_TX_U/Encoding_U/Rst
add wave -noupdate /top/DUT/PCS_U/PCS_TX_U/Encoding_U/TXDataK
add wave -noupdate -color Cyan /top/DUT/PCS_U/PCS_TX_U/Encoding_U/data_out
add wave -noupdate -color Cyan -radix binary /top/DUT/PCS_U/PCS_TX_U/Encoding_U/encoded_pos_data
add wave -noupdate -color Cyan -radix binary /top/DUT/PCS_U/PCS_TX_U/Encoding_U/encoded_neg_data
add wave -noupdate -divider -height 50 {PMA TX}
add wave -noupdate /top/DUT/PMA_U/PMA_TX_U/Bit_Rate_Clk_10
add wave -noupdate /top/DUT/PMA_U/PMA_TX_U/Bit_Rate_Clk
add wave -noupdate /top/DUT/PMA_U/PMA_TX_U/Rst_n
add wave -noupdate -color Magenta /top/DUT/PMA_U/PMA_TX_U/Data_in
add wave -noupdate -color Magenta -radix binary /top/DUT/PMA_U/PMA_TX_U/Data_in
add wave -noupdate /top/DUT/PMA_U/PMA_TX_U/MAC_Data_En
add wave -noupdate -color Magenta /top/DUT/PMA_U/PMA_TX_U/TX_Out_P
add wave -noupdate -color Magenta /top/DUT/PMA_U/PMA_TX_U/TX_Out_N
add wave -noupdate /top/DUT/PMA_U/PMA_TX_U/Temp_Reg
add wave -noupdate /top/DUT/PMA_U/PMA_TX_U/Temp_Reg2
add wave -noupdate /top/DUT/PMA_U/PMA_TX_U/Counter
add wave -noupdate /top/DUT/PMA_U/PMA_TX_U/flag
add wave -noupdate -divider -height 50 PMA_RX
add wave -noupdate /top/DUT/PMA_U/PM_RX_U/RX_POS
add wave -noupdate /top/DUT/PMA_U/PM_RX_U/RX_NEG
add wave -noupdate /top/DUT/PMA_U/PM_RX_U/Rst_n
add wave -noupdate /top/DUT/PMA_U/PM_RX_U/CLK_5G
add wave -noupdate /top/DUT/PMA_U/PM_RX_U/RxPolarity
add wave -noupdate /top/DUT/PMA_U/PM_RX_U/Data_out
add wave -noupdate -divider -height 50 PCS_RX
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/Collected_Data
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/WordClk
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/PCLK
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/CLK_5G
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/Rst_n
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/DataBusWidth
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/RX_Data
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/RX_DataK
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/RX_Status
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/RX_Valid
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/Comma_pulse
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/overflow
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/skp_added
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/Skp_Removed
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/underflow
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/data_to_decoder
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/data_to_gasket
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/DecodeError
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/Disparity_Error
add wave -noupdate -divider {Comma Detection}
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/Comma_Detection_U/clk
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/Comma_Detection_U/rst_n
add wave -noupdate -color Cyan /top/DUT/PCS_U/PCS_RX_U/Comma_Detection_U/Data_Collected
add wave -noupdate -color Cyan /top/DUT/PCS_U/PCS_RX_U/Comma_Detection_U/RxValid
add wave -noupdate -color Cyan /top/DUT/PCS_U/PCS_RX_U/Comma_Detection_U/Comma_Pulse
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/Comma_Detection_U/cs
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/Comma_Detection_U/ns
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/Comma_Detection_U/CP1
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/Comma_Detection_U/CP2
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/Comma_Detection_U/count
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/Comma_Detection_U/count_reset
add wave -noupdate -divider Buffer
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/buffer/write_clk
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/buffer/read_clk
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/buffer/data_in
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/buffer/rst_n
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/buffer/skp_added
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/buffer/Skp_Removed
add wave -noupdate -color Magenta /top/DUT/PCS_U/PCS_RX_U/buffer/overflow
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/buffer/underflow
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/buffer/data_out
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/buffer/gray_write_pointer
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/buffer/gray_read_pointer
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/buffer/write_address
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/buffer/read_address
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/buffer/sync_gray_read_out
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/buffer/sync_gray_write_out
add wave -noupdate -color Magenta /top/DUT/PCS_U/PCS_RX_U/buffer/delete_req
add wave -noupdate -color Magenta /top/DUT/PCS_U/PCS_RX_U/buffer/add_req
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/buffer/elastic_mem_inst/read_clk
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/buffer/elastic_mem_inst/empty
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/buffer/elastic_mem_inst/full
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/buffer/elastic_mem_inst/read_pointer
add wave -noupdate -color Yellow /top/DUT/PCS_U/PCS_RX_U/buffer/elastic_mem_inst/write_clk
add wave -noupdate -color Yellow /top/DUT/PCS_U/PCS_RX_U/buffer/elastic_mem_inst/write_pointer
add wave -noupdate -color Cyan -expand -subitemconfig {{/top/DUT/PCS_U/PCS_RX_U/buffer/elastic_mem_inst/buffer[0]} {-color Cyan -height 15} {/top/DUT/PCS_U/PCS_RX_U/buffer/elastic_mem_inst/buffer[1]} {-color Cyan -height 15} {/top/DUT/PCS_U/PCS_RX_U/buffer/elastic_mem_inst/buffer[2]} {-color Cyan -height 15} {/top/DUT/PCS_U/PCS_RX_U/buffer/elastic_mem_inst/buffer[3]} {-color Cyan -height 15} {/top/DUT/PCS_U/PCS_RX_U/buffer/elastic_mem_inst/buffer[4]} {-color Cyan -height 15} {/top/DUT/PCS_U/PCS_RX_U/buffer/elastic_mem_inst/buffer[5]} {-color Cyan -height 15} {/top/DUT/PCS_U/PCS_RX_U/buffer/elastic_mem_inst/buffer[6]} {-color Cyan -height 15} {/top/DUT/PCS_U/PCS_RX_U/buffer/elastic_mem_inst/buffer[7]} {-color Cyan -height 15} {/top/DUT/PCS_U/PCS_RX_U/buffer/elastic_mem_inst/buffer[8]} {-color Cyan -height 15} {/top/DUT/PCS_U/PCS_RX_U/buffer/elastic_mem_inst/buffer[9]} {-color Cyan -height 15} {/top/DUT/PCS_U/PCS_RX_U/buffer/elastic_mem_inst/buffer[10]} {-color Cyan -height 15} {/top/DUT/PCS_U/PCS_RX_U/buffer/elastic_mem_inst/buffer[11]} {-color Cyan -height 15} {/top/DUT/PCS_U/PCS_RX_U/buffer/elastic_mem_inst/buffer[12]} {-color Cyan -height 15} {/top/DUT/PCS_U/PCS_RX_U/buffer/elastic_mem_inst/buffer[13]} {-color Cyan -height 15} {/top/DUT/PCS_U/PCS_RX_U/buffer/elastic_mem_inst/buffer[14]} {-color Cyan -height 15} {/top/DUT/PCS_U/PCS_RX_U/buffer/elastic_mem_inst/buffer[15]} {-color Cyan -height 15}} /top/DUT/PCS_U/PCS_RX_U/buffer/elastic_mem_inst/buffer
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/buffer/elastic_mem_inst/data_in
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/buffer/elastic_mem_inst/add_req
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/buffer/elastic_mem_inst/data_out
add wave -noupdate -divider decoder
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/decode/CLK
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/decode/Rst_n
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/decode/Data_in
add wave -noupdate -radix binary /top/DUT/PCS_U/PCS_RX_U/decode/Data_in
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
add wave -noupdate -divider {Rx Status}
add wave -noupdate -color Orange /top/DUT/PCS_U/PCS_RX_U/rx_status/Overflow
add wave -noupdate -color Orange /top/DUT/PCS_U/PCS_RX_U/rx_status/Underflow
add wave -noupdate -color Orange /top/DUT/PCS_U/PCS_RX_U/rx_status/Skp_Added
add wave -noupdate -color Orange /top/DUT/PCS_U/PCS_RX_U/rx_status/Skp_Removed
add wave -noupdate -color Orange /top/DUT/PCS_U/PCS_RX_U/rx_status/Decode_Error
add wave -noupdate -color Orange /top/DUT/PCS_U/PCS_RX_U/rx_status/Disparity_Error
add wave -noupdate -color {Medium Spring Green} -radix binary /top/DUT/PCS_U/PCS_RX_U/rx_status/RxStatus
add wave -noupdate -divider RX_Gasket
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/rx_gasket/clk_to_get
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/rx_gasket/PCLK
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/rx_gasket/Rst_n
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/rx_gasket/Rx_Datak
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/rx_gasket/width
add wave -noupdate -color Cyan /top/DUT/PCS_U/PCS_RX_U/rx_gasket/Data_in
add wave -noupdate -color Cyan /top/DUT/PCS_U/PCS_RX_U/rx_gasket/Data_out
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/rx_gasket/data_out
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/rx_gasket/count
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/rx_gasket/flag
add wave -noupdate /top/DUT/PCS_U/PCS_RX_U/rx_gasket/temp_reg
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {28593 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 376
configure wave -valuecolwidth 96
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
WaveRestoreZoom {16974 ps} {54710 ps}
