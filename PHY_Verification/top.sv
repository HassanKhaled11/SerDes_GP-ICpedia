import uvm_pkg::*    ;
`include "uvm_macros.svh"

import my_test_pkg::*;
import PARAMETERS_PKG::*;


module top ;

////////////////////////////////////
//////////// INTERFACE /////////////
////////////////////////////////////


 BFM_if          dut_if()     ;
 INTERNALS_if    internal_if();


/////////////////////////////////////
///////// Design instance ///////////
/////////////////////////////////////

PHY        //!!!!!! Will be updated 
(
  .Ref_CLK       (dut_if.Ref_CLK)         ,
  .Reset_n       (dut_if.Reset_n)         ,
  .DataBusWidth  (dut_if.DataBusWidth)    ,
  .MAC_TX_Data   (dut_if.MAC_TX_Data)     ,
  .MAC_TX_DataK  (dut_if.MAC_TX_DataK)    ,
  .MAC_Data_En   (dut_if.MAC_Data_En)     , 
  .RX_In_P       (dut_if.RX_In_P)         ,
  .RX_In_N       (dut_if.RX_In_N)         ,
  .TX_Out_P      (dut_if.TX_Out_P)        ,
  .TX_Out_N      (dut_if.TX_Out_N)
);


////////////////////////////////////
//////////// INTERNALS /////////////
////////////////////////////////////



///////////////////////////////////
///////// CLOCK GENERATION ////////
///////////////////////////////////

initial begin
dut_if.Ref_CLK = 0 ;
  forever begin
  #(REF_CLK_PERIOD/2) dut_if.Ref_CLK = ~ dut_if.Ref_CLK;		
  end
end


///////////////////////////////////
///////////// DATABASE ////////////
///////////////////////////////////

initial begin
uvm_config_db#(virtual BFM_if)::set(null   , "*", "bfm_if",dut_if)              ;    // BUS FUNCTIONAL MODEL
uvm_config_db#(virtual INTERNALS_if)::set(null,"*" ,"internals_if",internals_if)  ;  // INTERNAL INTERFACE

//------ RUNNING THE TEST --------
run_test("my_test");	
end


endmodule
