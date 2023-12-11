#vlib work
vlog -f src_files.txt +cover -covercells
vsim -voptargs=+acc work.top -cover
#coverage save  tx.ucdb -onexit 
add wave -position insertpoint sim:/top/DUT/*
run 0
add wave -position insertpoint  \
sim:/uvm_root/uvm_test_top/env/scoreboard/data_collect \
sim:/uvm_root/uvm_test_top/env/scoreboard/temp \
sim:/uvm_root/uvm_test_top/env/scoreboard/counter \
sim:/uvm_root/uvm_test_top/env/scoreboard/flag

run -all

#vcover report tx.ucdb -details -annotate -all -output TX_functional_Report.txt 