
# Initial setup and other configurations
set frugs {3 3 3 3  3}
set phugs {5 5 5 5 5}
set freq_width {16 16 16 16 16}
set phase_width {16 16 16 16 16}
set seeds [list ""]
set num_runs 5

for {set i 0} {$i < $num_runs} {incr i} {
    set current_phug [lindex $phugs $i]
    set current_frug [lindex $frugs $i]
    set current_ph_w [lindex $phase_width $i]
    set current_fr_w [lindex $freq_width $i]

    vlog  PLL.v Clock_Div.v  Common_Block.v  PHY.v  PMA.v +define+OFFSET_TEST +cover=bcesf -covercells
    vlog  BBPD.v PMIX4.sv clk_generation.sv CDR_Loop.sv +define+THREE_CLKS +cover=bcesf -covercells
    vlog -f files.txt +cover=bcesf -covercells
    # Constructing log file path
    set log_file_path "logs/simulation_${i}_${current_phug}_${current_ph_w}_${current_frug}_${current_fr_w}.log"

    # Executing the simulation and redirecting output
    exec vsim -c -voptargs=+acc -onfinish stop work.top \
        -wlf "wave_files/simulation_${i}_${current_phug}_${current_ph_w}_${current_frug}_${current_fr_w}.wlf" \
        -sv_seed random \
        -g top/DUT/PMA_U/PM_RX_U/CDRLoopInst/DLF_U/FRUG=$current_frug \
        -g top/DUT/PMA_U/PM_RX_U/CDRLoopInst/DLF_U/PHUG=$current_phug \
        -g top/DUT/PMA_U/PM_RX_U/CDRLoopInst/DLF_U/PHASE_WIDTH=$current_ph_w \
        -g top/DUT/PMA_U/PM_RX_U/CDRLoopInst/DLF_U/FREQ_WIDTH=$current_fr_w \
        -cover  \
		-do "run 0;do wave.do;run -all;coverage save coverage/coverage_${i}_${current_phug}_${current_ph_w}_${current_frug}_${current_fr_w}.ucdb -onexit;quit -f" > $log_file_path 2>&1
		
		lappend seeds $Sv_Seed


			set current_phug [lindex $phugs $i] 
			set current_frug [lindex $frugs $i] 
			set current_ph_w [lindex $phase_width $i]
			set current_fr_w [lindex $freq_width  $i] 

		# Set UVM verbosity level to filter out UVM_MEDIUM messages
			set UVM_VERBOSITY UVM_MEDIUM
			#run 0
			#do wave.do

			#run -all> $log_file_path 2>&1
			#quit -sim

    # Save coverage
    #coverage save "coverage_${i}_${current_phug}_${current_ph_w}_${current_frug}_${current_fr_w}.ucdb" -onexit -du dff
}

#vcover merge coverage/dff_merged_coverage.ucdb 	coverage/coverage_0_5_16_3_16.ucdb coverage/coverage_1_5_16_3_16.ucdb	coverage/coverage_2_5_16_3_16.ucdb coverage/coverage_3_5_16_3_16.ucdb	coverage/coverage_4_5_16_3_16.ucdb

#vcover report coverage/dff_merged_coverage.ucdb -details -annotate -all -output coverage/dff_merged_functional_Report.txt 

#vcover report -html -htmldir coverage/html_merged_coverage -verbose -threshL 50 -threshH 90 coverage/dff_merged_coverage.ucdb

