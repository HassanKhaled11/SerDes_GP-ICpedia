#vlib work

#--------- SEPARATE RF_CLK WITH NO SPREADING TESTING -------------
#vlog  parameters_pkg.sv PLL.v Clock_Div.v  Common_Block.v  PHY.v  PMA.v +define+SRNS_TEST +cover=bcesf


#--------- SEPARATE RF_CLK WITH INDEPENDANT SPREADING TESTING & OFFSET TESTING -------------
#vlog  calc_jitter_val.cpp  SSC_Generator.sv parameters_pkg.sv PLL.v Clock_Div.v  Common_Block.v  PHY.v  PMA.v +define+SRIS_TEST +define+OFFSET_TESTING +cover=bcesf


#--------- PPM OFFSET TESTING -------------
vlog  parameters_pkg.sv PLL.v Clock_Div.v  Common_Block.v  PHY.v  PMA.v +define+OFFSET_TEST +cover=bcesf



vlog  BBPD.v PMIX4.sv clk_generation.sv CDR_Loop.sv +define+THREE_CLKS +cover=bcesf
vlog -f files.txt +cover=bcesf
vsim -voptargs=+acc work.top  -debugDB -cover

# Set UVM verbosity level to filter out UVM_MEDIUM messages
set UVM_VERBOSITY UVM_MEDIUM


coverage save  system.ucdb -onexit 

run 0

do wave.do

run -all

#vcover report system.ucdb -details -annotate -all -output system_functional_Report.txt  