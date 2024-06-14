
set PROJECT_PATH /home/IC/GP/PHY_Design/CDR/BBPD

lappend search_path $PROJECT_PATH


############################## Formality Setup File ##############################

set SSLIB "/home/IC/Synthesis/Labs/Lab_Formal_2/std_cells/scmetro_tsmc_cl013g_rvt_ss_1p08v_125c.db"
set TTLIB "/home/IC/Synthesis/Labs/Lab_Formal_2/std_cells/scmetro_tsmc_cl013g_rvt_tt_1p2v_25c.db"
set FFLIB "/home/IC/Synthesis/Labs/Lab_Formal_2/std_cells/scmetro_tsmc_cl013g_rvt_ff_1p32v_m40c.db"

## Read Reference Design Files
set synopsys_auto_setup true
## set the top Reference Design 
set_svf "/home/IC/GP/PHY_Design/CDR/BBPD/BBPD.svf"

read_verilog -container Ref "BBPD.v"



## Read Implementation technology libraries
read_db -container Ref [list $SSLIB $TTLIB $FFLIB]
## Read Implementation Design Files
set_reference_design BBPD
set_top BBPD
## set the top Implementation Design
read_db -container Imp [list $SSLIB $TTLIB $FFLIB]
read_verilog -container Imp -netlist "/home/IC/GP/PHY_Design/CDR/BBPD/netlists/BBPD.v"

set_implementation_design BBPD
set_top BBPD

## matching Compare points
match


## verify
set successful [verify]
if {!$successful} {
diagnose
analyze_points -failing
}

#Reports
report_passing_points > "passing_points.rpt"
report_failing_points > "failing_points.rpt"
report_aborted_points > "aborted_points.rpt"
report_unverified_points > "unverified_points.rpt"


start_gui

