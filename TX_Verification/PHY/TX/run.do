#vlib work

vsim -voptargs=+acc work.top 
#coverage save  tx.ucdb -onexit 
add wave -position insertpoint sim:/top/DUT/*
run 0
add wave -position insertpoint  \
sim:/uvm_root/uvm_test_top/env/scoreboard/flag \
sim:/uvm_root/uvm_test_top/env/scoreboard/counter \
sim:/uvm_root/uvm_test_top/env/scoreboard/data_collect \
sim:/uvm_root/uvm_test_top/env/scoreboard/temp \
sim:/uvm_root/uvm_test_top/env/scoreboard/i  \
sim:/uvm_root/uvm_test_top/env/scoreboard/temp32 \
sim:/uvm_root/uvm_test_top/env/scoreboard/temp24 \
sim:/uvm_root/uvm_test_top/env/scoreboard/temp16 \
sim:/uvm_root/uvm_test_top/env/scoreboard/temp8 \
sim:/uvm_root/uvm_test_top/env/scoreboard/temp
run -all

#vcover report tx.ucdb -details -annotate -all -output TX_functional_Report.txt 