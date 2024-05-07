
mkdir logs
mkdir wave_files
mkdir coverage

C:\questasim64_2021.1\win64\vsim -do run_reg_batch.do -batch -do "quit"
::vsim -do run.do -batch
::echo > ./logs/runs.txt
::cls
