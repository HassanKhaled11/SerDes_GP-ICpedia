vlib work
vlog PI_cpp.cpp PI_sv.sv -sv  +cover
vsim -voptargs=+acc  work.PMIX_Tb -cover
do wave.do
run -all