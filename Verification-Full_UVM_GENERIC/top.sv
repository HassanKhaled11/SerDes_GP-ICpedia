import uvm_pkg::*    ;
`include "uvm_macros.svh"
import my_test_pkg::*;

module top ;

parameter CLOCK_PERIOD = 10 ;

BFM_if  dut_if() ;
golden_if g_if() ;
// Design instance 

tst dut(dut_if.clk , dut_if.A , dut_if.B , dut_if.out);
golden_model g_dut (dut_if.clk , dut_if.A , dut_if.B , g_if.out) ;

// assign g_if.clk = dut_if.clk ; 
// assign g_if.A   = dut_if.A   ;
// assign g_if.B   = dut_if.B   ;

initial begin
dut_if.clk = 0 ;
forever begin
#4 dut_if.clk = ~ dut_if.clk ;		
end
end


// initial begin

// end

initial begin
uvm_config_db#(virtual BFM_if)::set(null   , "*", "bfm_if",dut_if) ;
uvm_config_db#(virtual golden_if)::set(null,"*" ,"gm_if"   ,g_if)  ;
run_test("my_test");	
end


endmodule
