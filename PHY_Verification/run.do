#vlib work
#vlog   DLF.cpp DLF.sv -sv -dpiheader DLF.h
#vlog  BBPD.v PMIX4.sv clk_generation.sv CDR_Loop.sv +define+THREE_CLKS
vlog  PLL.v Clock_Div.v  Common_Block.v  PHY.v  PMA.v +define+OFFSET_TEST +cover
vlog  BBPD.v PMIX4.sv clk_generation.sv CDR_Loop.sv +define+THREE_CLKS +cover
#vlog Channel.c 
vlog -f files.txt +cover
vsim -voptargs=+acc work.top  -debugDB -cover

# Set UVM verbosity level to filter out UVM_MEDIUM messages
set UVM_VERBOSITY UVM_MEDIUM


coverage save  system.ucdb -onexit 
#add wave -position insertpoint  \
#sim:/top/DUT/dataout
#add wave -position insertpoint sim:/top/DUT/*
run 0
do wave.do
#add wave -position insertpoint  \
#sim:/uvm_root/uvm_test_top/env/driver/seq_item
run -all

#vcover report system.ucdb -details -annotate -all -output system_functional_Report.txt  