#vlib work
#vlog   DLF.cpp DLF.sv -sv -dpiheader DLF.h
#vlog  BBPD.v PMIX4.sv clk_generation.sv CDR_Loop.sv +define+THREE_CLKS
vlog  PLL.v Clock_Div.v  Common_Block.v  PHY.v  PMA.v +define+OFFSET_TEST
vlog  BBPD.v PMIX4.sv clk_generation.sv CDR_Loop.sv +define+THREE_CLKS
vlog -f files.txt
vsim -voptargs=+acc work.top 

# Set UVM verbosity level to filter out UVM_MEDIUM messages
set UVM_VERBOSITY UVM_MEDIUM


#coverage save  alu.ucdb -onexit 
#add wave -position insertpoint  \
#sim:/top/DUT/dataout
#add wave -position insertpoint sim:/top/DUT/*
run 0
do wave.do
#add wave -position insertpoint  \
#sim:/uvm_root/uvm_test_top/env/driver/seq_item
run -all

#vcover report alu.ucdb -details -annotate -all -output ALU_functional_Report.txt  