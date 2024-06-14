
set PROJECT_PATH /home/IC/GP/PHY_Design



lappend search_path $PROJECT_PATH/PCS
lappend search_path $PROJECT_PATH/PCS/PCS_TX/Encoding
lappend search_path $PROJECT_PATH/PCS/PCS_TX
lappend search_path $PROJECT_PATH/PCS/PCS_RX
lappend search_path $PROJECT_PATH/PCS/PCS_RX/Decoding
lappend search_path $PROJECT_PATH/PCS/PCS_RX/ElasticBuffer


############################## Formality Setup File ##############################

set SSLIB "/home/IC/Synthesis/Labs/Lab_Formal_2/std_cells/scmetro_tsmc_cl013g_rvt_ss_1p08v_125c.db"
set TTLIB "/home/IC/Synthesis/Labs/Lab_Formal_2/std_cells/scmetro_tsmc_cl013g_rvt_tt_1p2v_25c.db"
set FFLIB "/home/IC/Synthesis/Labs/Lab_Formal_2/std_cells/scmetro_tsmc_cl013g_rvt_ff_1p32v_m40c.db"

## Read Reference Design Files
set synopsys_auto_setup true
## set the top Reference Design 
set_svf "/home/IC/GP/PHY_Design/PCS/PCS.svf"

read_verilog -container Ref "line_coding_8_10.v"
read_verilog -container Ref "GasKet.v"
read_verilog -container Ref "FSM_RD.v"
read_verilog -container Ref "Encoding.v"
read_verilog -container Ref "PCS_TX.v"
read_verilog -container Ref "8_10_decoding.v"
read_verilog -container Ref "binToGray.v"
read_verilog -container Ref "grayToBin.v"
read_verilog -container Ref "memory.v"
read_verilog -container Ref "synchronous_unit.v"
read_verilog -container Ref "read_pointer_control.v"
read_verilog -container Ref "write_pointer_control_unit.v"
read_verilog -container Ref "thresholdMonitor.v"
read_verilog -container Ref "elasticBuffer.v"
read_verilog -container Ref "Comma_Detection.v"
read_verilog -container Ref "Receiver_Status.v"
read_verilog -container Ref "GasKet_RX.v"
read_verilog -container Ref "PCS_RX.v"
read_verilog -container Ref "PCS.v"


## Read Implementation technology libraries
read_db -container Ref [list $SSLIB $TTLIB $FFLIB]
## Read Implementation Design Files
set_reference_design PCS
set_top PCS
## set the top Implementation Design
read_db -container Imp [list $SSLIB $TTLIB $FFLIB]
read_verilog -container Imp -netlist "/home/IC/GP/PHY_Design/PCS/netlists/PCS.v"

set_implementation_design PCS
set_top PCS

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

