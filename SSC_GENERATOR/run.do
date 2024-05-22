#vlib work
vlog  calc_jitter_val.cpp SSC_Generator.sv 
vsim -voptargs=+acc work.SSC_Generator_tb
do wave.do
run -all