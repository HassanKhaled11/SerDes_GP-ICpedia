import uvm_pkg::*    ;
`include "uvm_macros.svh"
import my_test_pkg::*;

module top ;

parameter CLOCK_PERIOD = 10 ;

BFM_if  dut_if() ;
// Design instance 


initial begin
uvm_config_db#(virtual BFM_if)::set(null, "*", "bfm_if",dut_if);	
end

initial begin
run_test("my_test");	
end


endmodule
