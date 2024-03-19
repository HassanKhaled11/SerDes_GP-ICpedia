vlib work
vlog Channel.c Channel.sv  +cover
vsim -voptargs=+acc  work.Channel_TB -cover
do wave.do
run -all
