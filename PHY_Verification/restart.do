vlog -sv -f files.txt -dpiheader headerDPI.h 
restart
vsim -voptargs=+acc work.top 
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