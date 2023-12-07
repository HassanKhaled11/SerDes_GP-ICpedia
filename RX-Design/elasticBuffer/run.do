vlib work
vlog binToGray.v binToGrayTB.v memory.v read_pointer_control.v synchronous_unit.v write_pointer_control_unit.v elasticBuffer.v elasticBuffer_tb.sv
vsim -voptargs=+acc work.elasticBuffer_tb 

add wave *
add wave -divider -height 30 "memory:"
add wave -position insertpoint  \
sim:/elasticBuffer_tb/DUT/elastic_mem_inst/data_in \
sim:/elasticBuffer_tb/DUT/elastic_mem_inst/read_pointer \
sim:/elasticBuffer_tb/DUT/elastic_mem_inst/write_pointer \
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
sim:/elasticBuffer_tb/DUT/write_inst/gray_read_pointer \
sim:/elasticBuffer_tb/DUT/write_inst/overflow \
sim:/elasticBuffer_tb/DUT/write_inst/skp_added \
sim:/elasticBuffer_tb/DUT/write_inst/skp_removed \
sim:/elasticBuffer_tb/DUT/write_inst/data_out \
sim:/elasticBuffer_tb/DUT/write_inst/write_address \
sim:/elasticBuffer_tb/DUT/write_inst/gray_write_pointer \
sim:/elasticBuffer_tb/DUT/write_inst/delete \
sim:/elasticBuffer_tb/DUT/write_inst/write_pointer \
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
sim:/elasticBuffer_tb/DUT/read_inst/gray_write_pointer \
sim:/elasticBuffer_tb/DUT/read_inst/empty \
sim:/elasticBuffer_tb/DUT/read_inst/skp_added \
sim:/elasticBuffer_tb/DUT/read_inst/skp_removed \
sim:/elasticBuffer_tb/DUT/read_inst/data_out \
sim:/elasticBuffer_tb/DUT/read_inst/read_address \
sim:/elasticBuffer_tb/DUT/read_inst/gray_read_pointer \
sim:/elasticBuffer_tb/DUT/read_inst/empty_val \
sim:/elasticBuffer_tb/DUT/read_inst/read_pointer \
sim:/elasticBuffer_tb/DUT/read_inst/full_val
#coverage save  encoding.ucdb -onexit 
run -all
#quit -sim
#vcover report encoding.ucdb -details -annotate -all -output encoding_coverage_Report.txt 
