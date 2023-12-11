vlib work
vlog binToGray.v binToGrayTB.v memory.v read_pointer_control.v synchronous_unit.v write_pointer_control_unit.v elasticBuffer.v elasticBuffer_tb.sv
vsim -voptargs=+acc work.elasticBuffer_tb

add wave -divider -height 30 "top:"
add wave *

add wave -divider -height 30 "synchhronous unit:"
add wave -position insertpoint  \
sim:/elasticBuffer_tb/DUT/sync_unit_inst/n \
sim:/elasticBuffer_tb/DUT/sync_unit_inst/rst_n \
sim:/elasticBuffer_tb/DUT/sync_unit_inst/read_to_write_clk \
sim:/elasticBuffer_tb/DUT/sync_unit_inst/write_to_read_clk \
sim:/elasticBuffer_tb/DUT/sync_unit_inst/gray_counter_read \
sim:/elasticBuffer_tb/DUT/sync_unit_inst/gray_counter_write \
sim:/elasticBuffer_tb/DUT/sync_unit_inst/gray_counter_read_out \
sim:/elasticBuffer_tb/DUT/sync_unit_inst/gray_counter_write_out \
sim:/elasticBuffer_tb/DUT/sync_unit_inst/gray_counter_read_reg1 \
sim:/elasticBuffer_tb/DUT/sync_unit_inst/gray_counter_read_reg2 \
sim:/elasticBuffer_tb/DUT/sync_unit_inst/gray_counter_write_reg1 \
sim:/elasticBuffer_tb/DUT/sync_unit_inst/gray_counter_write_reg2

add wave -divider -height 30 "memory:"
add wave -position insertpoint  \
sim:/elasticBuffer_tb/DUT/elastic_mem_inst/DATA_WIDTH \
sim:/elasticBuffer_tb/DUT/elastic_mem_inst/BUFFER_DEPTH \
sim:/elasticBuffer_tb/DUT/elastic_mem_inst/max_buffer_addr \
sim:/elasticBuffer_tb/DUT/elastic_mem_inst/read_clk \
sim:/elasticBuffer_tb/DUT/elastic_mem_inst/write_clk \
sim:/elasticBuffer_tb/DUT/elastic_mem_inst/full \
sim:/elasticBuffer_tb/DUT/elastic_mem_inst/empty \
sim:/elasticBuffer_tb/DUT/elastic_mem_inst/data_in \
sim:/elasticBuffer_tb/DUT/elastic_mem_inst/read_pointer \
sim:/elasticBuffer_tb/DUT/elastic_mem_inst/write_pointer \
sim:/elasticBuffer_tb/DUT/elastic_mem_inst/rd_en \
sim:/elasticBuffer_tb/DUT/elastic_mem_inst/wr_en \
sim:/elasticBuffer_tb/DUT/elastic_mem_inst/data_out \
sim:/elasticBuffer_tb/DUT/elastic_mem_inst/buffer

add wave -divider -height 30 "write control:"
add wave -position insertpoint  \
sim:/elasticBuffer_tb/DUT/write_inst/DATA_WIDTH \
sim:/elasticBuffer_tb/DUT/write_inst/BUFFER_DEPTH \
sim:/elasticBuffer_tb/DUT/write_inst/max_buffer_addr \
sim:/elasticBuffer_tb/DUT/write_inst/write_clk \
sim:/elasticBuffer_tb/DUT/write_inst/buffer_mode \
sim:/elasticBuffer_tb/DUT/write_inst/rst_n \
sim:/elasticBuffer_tb/DUT/write_inst/overflow \
sim:/elasticBuffer_tb/DUT/write_inst/skp_added \
sim:/elasticBuffer_tb/DUT/write_inst/skp_removed \
sim:/elasticBuffer_tb/DUT/write_inst/read_enable \
sim:/elasticBuffer_tb/DUT/write_inst/write_enable \
sim:/elasticBuffer_tb/DUT/write_inst/write_address \
sim:/elasticBuffer_tb/DUT/write_inst/gray_read_pointer \
sim:/elasticBuffer_tb/DUT/write_inst/gray_write_pointer \
sim:/elasticBuffer_tb/DUT/write_inst/delete \
sim:/elasticBuffer_tb/DUT/write_inst/full_val

add wave -divider -height 30 "read control:"
add wave -position insertpoint  \
sim:/elasticBuffer_tb/DUT/read_inst/DATA_WIDTH \
sim:/elasticBuffer_tb/DUT/read_inst/BUFFER_DEPTH \
sim:/elasticBuffer_tb/DUT/read_inst/max_buffer_addr \
sim:/elasticBuffer_tb/DUT/read_inst/delete \
sim:/elasticBuffer_tb/DUT/read_inst/read_clk \
sim:/elasticBuffer_tb/DUT/read_inst/buffer_mode \
sim:/elasticBuffer_tb/DUT/read_inst/rst_n \
sim:/elasticBuffer_tb/DUT/read_inst/empty \
sim:/elasticBuffer_tb/DUT/read_inst/skp_added \
sim:/elasticBuffer_tb/DUT/read_inst/skp_removed \
sim:/elasticBuffer_tb/DUT/read_inst/read_enable \
sim:/elasticBuffer_tb/DUT/read_inst/read_address \
sim:/elasticBuffer_tb/DUT/read_inst/gray_write_pointer \
sim:/elasticBuffer_tb/DUT/read_inst/gray_read_pointer \
sim:/elasticBuffer_tb/DUT/read_inst/empty_val 

#sim:/elasticBuffer_tb/DUT/read_inst/read_pointer 

add wave -divider -height 30 "binary to gray:"
add wave -position insertpoint  \
sim:/elasticBuffer_tb/DUT/write_inst/bin_gray_write/COUNTER_WIDTH \
sim:/elasticBuffer_tb/DUT/write_inst/bin_gray_write/binary \
sim:/elasticBuffer_tb/DUT/write_inst/bin_gray_write/gray

#coverage save  encoding.ucdb -onexit 
run -all
#quit -sim
#vcover report encoding.ucdb -details -annotate -all -output encoding_coverage_Report.txt 
