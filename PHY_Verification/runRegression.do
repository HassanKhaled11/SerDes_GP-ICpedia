# Define a list of parameter sets to test
set parameter_sets {
    {PHUG 2 FREQ_WIDTH 10 PHASE_WIDTH 5 FRUG 8}
    {PHUG 3 FREQ_WIDTH 15 PHASE_WIDTH 6 FRUG 10}
    {PHUG 5 FREQ_WIDTH 20 PHASE_WIDTH 7 FRUG 12}
}

# Loop through each value in the array
foreach params $parameter_sets {
    .main clear

    # Read the original content of the adder.sv file
    set param_file [open "Digital_Loop_Filter.sv" r]
    set file_contents [read $param_file]
    close $param_file

    # Replace each parameter in the file content
    foreach {key value} $params {
        regsub -all "parameter\s+$key\s+=\s+\d+;" $file_contents "parameter $key = $value;" file_contents
    }

    # Write the modified content back to the adder.sv file
    set param_file [open "Digital_Loop_Filter.sv" w]
    puts $param_file $modified_contents
    close $param_file


    vlog  PLL.v Clock_Div.v  Common_Block.v  PHY.v  PMA.v 
    vlog  BBPD.v PMIX4.sv clk_generation.sv CDR_Loop.sv +define+THREE_CLKS
    vlog -f files.txt
    
    # Format the value for filename (remove special characters)
    set filename [string map {"'" "" "d" "d_" " " ""} $val]

    #set logFile "simulation_${filename}.log"
    puts "Starting simulation with width forced to: $val"

    # Create or clear the simulation library
    vlib work
    vmap work work


    # Start the simulation of the adder module, specifying the log file
    vsim -voptargs=+acc  -wlf "simulation_${filename}.wlf" work.adder_tb  -sv_seed random

    # Set UVM verbosity level to filter out UVM_MEDIUM messages
    set UVM_VERBOSITY UVM_HIGH

    # Force out to the current value in the loop
    # force sim:/rippleCounter_tb/Ass4counter/out $val

    # Add all signals to the wave
    do wave.do

    # Run the simulation
    run -all
    #set logFile "simulation_${filename}.log"

    # Redirect the transcript to a log file
    #log -r $logFile

    write transcript "simulation_${filename}.log"
}


#vcover report alu.ucdb -details -annotate -all -output ALU_functional_Report.txt  
