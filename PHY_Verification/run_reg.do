#vlib work
#vlog   DLF.cpp DLF.sv -sv -dpiheader DLF.h
#vlog  BBPD.v PMIX4.sv clk_generation.sv CDR_Loop.sv +define+THREE_CLKS
vlog  PLL.v Clock_Div.v  Common_Block.v  PHY.v  PMA.v +define+OFFSET_TEST +cover
vlog  BBPD.v PMIX4.sv clk_generation.sv CDR_Loop.sv +define+THREE_CLKS +cover
vlog -f files.txt +cover

set frugs {3 3 3 3  3}
set phugs {5 5 5 5 5}
set freq_width  {16 16 16 16 16}
set phase_width {16 16 16 16 16}
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
		-g top/DUT/PMA_U/PM_RX_U/CDRLoopInst/DLF_U/FREQ_WIDTH=[lindex $freq_width $i]\
		-cover


lappend seeds $Sv_Seed


set current_phug [lindex $phugs $i] 
set current_frug [lindex $frugs $i] 
set current_ph_w [lindex $phase_width $i]
set current_fr_w [lindex $freq_width  $i] 

# Set UVM verbosity level to filter out UVM_MEDIUM messages
set UVM_VERBOSITY UVM_MEDIUM


coverage save  "coverage_[$i]_[$current_phug]_[$current_ph_w]_[$current_frug]_[$current_fr_w].ucdb" -onexit -du dff

run 0
do wave.do

run -all
#log -r /* log_$i.log --> only when invoke -wlf across vsim

write transcript ./logs/"simulation_[$i]_[$current_phug]_[$current_ph_w]_[$current_frug]_[$current_fr_w].log"
quit -sim
}


vcover merge dff_merged_coverage.ucdb 	coverage_[0]_[5]_[16]_[3]_[16].ucdb\ 
										coverage_[1]_[5]_[16]_[3]_[16].ucdb\ 
										coverage_[2]_[5]_[16]_[3]_[16].ucdb\ 
										coverage_[3]_[5]_[16]_[3]_[16].ucdb\ 
										coverage_[4]_[5]_[16]_[3]_[16].ucdb -du dff
