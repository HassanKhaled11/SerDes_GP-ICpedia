vlib work
vlog PI_cpp2.cpp PI_sv2.sv -sv  +cover
vsim -voptargs=+acc  work.PMIX_Tb -cover
do wave.do
add wave -position insertpoint  \
sim:/PMIX_Tb/PMIX_DUT/sin_0 \
sim:/PMIX_Tb/PMIX_DUT/sin_45 \
sim:/PMIX_Tb/PMIX_DUT/sin_90 \
sim:/PMIX_Tb/PMIX_DUT/sin_135 \
sim:/PMIX_Tb/PMIX_DUT/sin_180 \
sim:/PMIX_Tb/PMIX_DUT/sin_225 \
sim:/PMIX_Tb/PMIX_DUT/sin_270 \
sim:/PMIX_Tb/PMIX_DUT/sin_315
run -all