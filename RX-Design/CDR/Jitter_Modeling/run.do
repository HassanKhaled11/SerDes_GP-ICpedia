#vlib work
vlog -f files.txt 
#-dpiheader headerDPI.h 
vsim -voptargs=+acc work.top 

# Set UVM verbosity level to filter out UVM_MEDIUM messages
set UVM_VERBOSITY UVM_HIGH


#coverage save  alu.ucdb -onexit 
#add wave -position insertpoint  \
#sim:/top/DUT/dataout
#add wave -position insertpoint sim:/top/DUT/*
run 0
do wave.do

add wave -position insertpoint  \
sim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/RESULT_PERIOD
add wave -position insertpoint  \
sim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/jitter_value
add wave -position insertpoint  \
sim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/count_neg \
sim:/top/DUT/PMA_U/PM_RX_U/CDRLoopInst/phase_interpolator/count_pos
#add wave -position insertpoint  \
#sim:/uvm_root/uvm_test_top/env/driver/seq_item
run -all

#vcover report alu.ucdb -details -annotate -all -output ALU_functional_Report.txt  