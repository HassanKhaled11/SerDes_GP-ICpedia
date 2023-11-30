vlib work
vlog elasticBuffer.v elasticBuffer_tb.sv
vsim -voptargs=+acc work.elasticBuffer_tb 

add wave *
add wave -position insertpoint  \
sim:/elasticBuffer_tb/uut/buffer \
sim:/elasticBuffer_tb/uut/read_pointer \
sim:/elasticBuffer_tb/uut/write_pointer \
sim:/elasticBuffer_tb/uut/count \
sim:/elasticBuffer_tb/uut/buffer_limit

#coverage save  encoding.ucdb -onexit 
run -all
#quit -sim
#vcover report encoding.ucdb -details -annotate -all -output encoding_coverage_Report.txt 
