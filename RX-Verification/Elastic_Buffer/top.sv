
import uvm_pkg::*    ;
`include "uvm_macros.svh"
import my_test_pkg::*;

module top ;

parameter WRITE_CLOCK_PERIOD  = 4     ;  // Recovered Symbol CLK 250Mhz
parameter READ_CLOCK_PERIOD   = 4     ;  // CORE CLK 250Mhz


 BFM_if    dut_if() ;
 Internals_if internal_if();
//golden_if g_if() ;


// Design instance 
elasticBuffer #(.DATA_WIDTH(10) , .BUFFER_DEPTH(16)) DUT (

  .write_clk   (dut_if.write_clk)    ,
  .read_clk    (dut_if.read_clk)     ,
  .data_in     (dut_if.data_in)      ,
  .buffer_mode (dut_if.buffer_mode)  ,
  .write_enable(dut_if.write_enable) ,
  .read_enable (dut_if.read_enable)  ,
  .rst_n       (dut_if.rst_n)        ,
  .skp_added   (dut_if.skp_added)    ,
  .Skp_Removed (dut_if.Skp_Removed)  ,
  .overflow    (dut_if.overflow)     ,
  .underflow   (dut_if.underflow)    ,
  .data_out    (dut_if.data_out)     

);


assign internal_if.gray_read_pointer = DUT.gray_read_pointer ; 
assign internal_if.gray_write_pointer = DUT.gray_write_pointer ;
assign internal_if.write_address = DUT.write_address ;
assign internal_if.read_address = DUT.read_address;


initial begin
dut_if.write_clk = 0 ;
forever begin
#(WRITE_CLOCK_PERIOD/2) dut_if.write_clk = ~ dut_if.write_clk ;		
end
end


initial begin
dut_if.read_clk = 0 ;
forever begin
#(READ_CLOCK_PERIOD/2) dut_if.read_clk = ~ dut_if.read_clk ;		
end
end


initial begin
uvm_config_db#(virtual BFM_if)::set(null   , "*", "bfm_if",dut_if) ;
uvm_config_db#(virtual Internals_if)::set(null,"*" ,"internal_if",internal_if) ;
run_test("my_test");	
end


endmodule
