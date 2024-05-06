#vlib work
#vlog   DLF.cpp DLF.sv -sv -dpiheader DLF.h
#vlog  BBPD.v PMIX4.sv clk_generation.sv CDR_Loop.sv +define+THREE_CLKS
vlog  PLL.v Clock_Div.v  Common_Block.v  PHY.v  PMA.v +define+OFFSET_TEST
vlog  BBPD.v PMIX4.sv clk_generation.sv CDR_Loop.sv +define+THREE_CLKS
vlog -f files.txt

set frugs {3 3 3 29  3}
set phugs {8 5 3 450 5}
set freq_width  {16 16 16 16 18}
set phase_width {16 16 16 24 18}
set seeds [list ""]
set num_runs 5

set current_phug [lindex $phugs 0] 
set current_frug [lindex $frugs 0] 
set current_ph_w [lindex $phase_width 0]
set current_fr_w [lindex $freq_width  0]

for {set i 0} {$i < $num_runs} {incr i} {


#vsim -voptargs=+acc -onfinish stop work.top \
# -wlf ./wave_files/simulation_[$i]_[$current_phug]_[$current_ph_w]_[$current_frug]_[$current_fr_w].wlf -sv_seed random 

vsim -voptargs=+acc -onfinish stop work.top \
		-wlf ./wave_files/simulation_[$i]_[$current_phug]_[$current_ph_w]_[$current_frug]_[$current_fr_w].wlf\
		-sv_seed random\
		-g top/DUT/PMA_U/PM_RX_U/CDRLoopInst/DLF_U/FRUG=[lindex $frugs $i]\
		-g top/DUT/PMA_U/PM_RX_U/CDRLoopInst/DLF_U/PHUG=[lindex $phugs $i]\
		-g top/DUT/PMA_U/PM_RX_U/CDRLoopInst/DLF_U/PHASE_WIDTH=[lindex $phase_width $i]\
		-g top/DUT/PMA_U/PM_RX_U/CDRLoopInst/DLF_U/FREQ_WIDTH=[lindex $freq_width $i] 


#vsim -voptargs=+acc -onfinish stop work.top \
#		-logfile ./logs/simulation_[$i]_[$current_phug]_[$current_ph_w]_[$current_frug]_[$current_fr_w].txt\
#		-wlf ./wave_files/simulation_[$i]_[$current_phug]_[$current_ph_w]_[$current_frug]_[$current_fr_w].wlf\
#		-sv_seed random\
#		-g top/DUT/PMA_U/PM_RX_U/CDRLoopInst/DLF_U/FRUG=[lindex $frugs $i]\
#		-g top/DUT/PMA_U/PM_RX_U/CDRLoopInst/DLF_U/PHUG=[lindex $phugs $i]\
#		-g top/DUT/PMA_U/PM_RX_U/CDRLoopInst/DLF_U/PHASE_WIDTH=[lindex $phase_width $i]\
#		-g top/DUT/PMA_U/PM_RX_U/CDRLoopInst/DLF_U/FREQ_WIDTH=[lindex $freq_width $i] 
#vsim -voptargs=+acc -onfinish stop work.top -qwavedb ./wave_files/simulation_[$i]_[$current_phug]_[$current_ph_w]_[$current_frug]_[$current_fr_w].db -sv_seed random
lappend seeds $Sv_Seed


#change top.DUT.PMA_U.PM_RX_U.CDRLoopInst.DLF_U.FRUG [lindex $frugs $i] 
#change top.DUT.PMA_U.PM_RX_U.CDRLoopInst.DLF_U.PHUG [lindex $phugs $i] 
#change top.DUT.PMA_U.PM_RX_U.CDRLoopInst.DLF_U.PHASE_WIDTH [lindex $phase_width $i] 
#change top.DUT.PMA_U.PM_RX_U.CDRLoopInst.DLF_U.FREQ_WIDTH  [lindex $freq_width  $i] 


set current_phug [lindex $phugs $i] 
set current_frug [lindex $frugs $i] 
set current_ph_w [lindex $phase_width $i]
set current_fr_w [lindex $freq_width  $i] 

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
#log -r /* log_$i.log --> only when invoke -wlf across vsim

write transcript ./logs/"simulation_[$i]_[$current_phug]_[$current_ph_w]_[$current_frug]_[$current_fr_w].log"
}
#vcover report alu.ucdb -details -annotate -all -output ALU_functional_Report.txt  