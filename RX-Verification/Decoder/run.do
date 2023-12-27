#vlib work
vlog -f src_files.txt
vsim -voptargs=+acc work.top 
#coverage save  tx.ucdb -onexit 
add wave -position insertpoint sim:/top/DUT/*
#run 0

run -all

#vcover report tx.ucdb -details -annotate -all -output TX_functional_Report.txt 