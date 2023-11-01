vlib work
vlog Encoding.v FSM_RD.v Optional_Block.v line_coding_8_10.v assertions.sv line_encoding_tb.sv line_encoding_pkg.sv +cover
vsim -voptargs=+acc work.line_encoding_tb -cover

add wave /line_encoding_tb/final_encoding/assertion_inst/assert__enable_pma_value

add wave *
add wave -position insertpoint  \
sim:/line_encoding_tb/line_tr

add wave -position insertpoint  \
sim:/line_encoding_tb/encoding_tb/enable \
sim:/line_encoding_tb/encoding_tb/TXDataK \
sim:/line_encoding_tb/encoding_tb/data \
sim:/line_encoding_tb/encoding_tb/encoded_data_pos \
sim:/line_encoding_tb/encoding_tb/encoded_data_neg



coverage save  encoding.ucdb -onexit 
run -all
#quit -sim
#vcover report encoding.ucdb -details -annotate -all -output encoding_coverage_Report.txt 
