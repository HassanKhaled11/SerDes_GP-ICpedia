`timescale 1ns/10ps


import uvm_pkg::*    ;
`include "uvm_macros.svh"

import my_test_pkg::*;
import PARAMETERS_PKG::*;


module top ;

////////////////////////////////////
//////////// INTERFACE /////////////
////////////////////////////////////


 BFM_if          dut_if()     ;
 INTERNALS_if    internals_if();


/////////////////////////////////////
///////// Design instance ///////////
/////////////////////////////////////

PHY    DUT      
(
  .Ref_CLK       (dut_if.Ref_CLK)         ,
  .Reset_n       (dut_if.Reset_n)         ,
  .DataBusWidth  (dut_if.DataBusWidth)    ,
  .MAC_TX_Data   (dut_if.MAC_TX_Data)     ,
  .MAC_TX_DataK  (dut_if.MAC_TX_DataK)    ,
  .MAC_Data_En   (dut_if.MAC_Data_En)     , 
  .RxPolarity    (dut_if.RxPolarity)      ,

  .TX_Out_P      (dut_if.TX_Out_P)        ,
  .TX_Out_N      (dut_if.TX_Out_N)        ,
  .RX_Data       (dut_if.Rx_Data)         ,
  .RX_DataK      (dut_if.Rx_DataK)        ,
  .RX_Status     (dut_if.Rx_Status)       , 
  .RX_Valid      (dut_if.Rx_Valid)        ,
  .PCLK          (dut_if.PCLK)             
);


////////////////////////////////////
//////////// INTERNALS /////////////
////////////////////////////////////

assign internals_if.Bit_CLK      = DUT.Bit_Rate_Clk                   ;
assign internals_if.Word_CLK     = DUT.Bit_Rate_CLK_10                ;
assign internals_if.PCLK         = DUT.PCLK                           ;
assign internals_if.DataBusWidth = DUT.DataBusWidth                   ;
assign internals_if.TX_Out_P     = DUT.PMA_U.TX_Out_P                 ;

///////////////////////////////////
/////// Assertions Modules ////////
///////////////////////////////////

my_assertion DUTA
(

 .Bit_CLK      (DUT.Bit_Rate_Clk)   ,
 .Word_CLK     (DUT.Bit_Rate_CLK_10),
 .PCLK         (DUT.PCLK)           ,
 .DataBusWidth (DUT.DataBusWidth)   ,
 .TX_Out_P     (DUT.PMA_U.TX_Out_P)

);
///////////////////////////////////////////////////////////////////////////////////
///////////////////////////////// PHY Assertions //////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////
bind DUT phy_assertions #( .DATA_BUS_WIDTH(32) ) PHY_A (
                                    .clk     (DUT.PCLK)         ,
                                    .rst_n   (DUT.Reset_n)      ,
                                    .Data_in (DUT.MAC_TX_Data)  ,
                                    .Data_out(DUT.RX_Data)      ,
                                    .enable  (DUT.MAC_Data_En)
                                );



///////////////////// COMMA Assertions ///////////////////

bind DUT.PCS_U.PCS_RX_U.Comma_Detection_U comma_assertions #(.COMMA_NUMBER(DUT.PCS_U.PCS_RX_U.Comma_Detection_U.COMMA_NUMBER))
                                                                          commaAssertion (
                                                                            .clk                  (DUT.PCS_U.PCS_RX_U.Comma_Detection_U.clk)            ,
                                                                            .rst_n                (DUT.PCS_U.PCS_RX_U.Comma_Detection_U.rst_n)          ,
                                                                            .rx_valid             (DUT.PCS_U.PCS_RX_U.Comma_Detection_U.RxValid)        ,
                                                                            .comma_pulse          (DUT.PCS_U.PCS_RX_U.Comma_Detection_U.Comma_Pulse)    ,
                                                                            .cs                   (DUT.PCS_U.PCS_RX_U.Comma_Detection_U.cs)             ,  
                                                                            .ns                   (DUT.PCS_U.PCS_RX_U.Comma_Detection_U.ns)             ,
                                                                            .data                 (DUT.PCS_U.PCS_RX_U.Comma_Detection_U.Data_Collected) ,
                                                                            .count_rst            (DUT.PCS_U.PCS_RX_U.Comma_Detection_U.count_reset)    ,
                                                                            .count                (DUT.PCS_U.PCS_RX_U.Comma_Detection_U.count)
                                                                            
                                                                            );
///////////////////////////////////////////////////////////////////////////////////
/////////////////////////// Elastic Buffer Assertions /////////////////////////////
///////////////////////////////////////////////////////////////////////////////////
bind DUT.PCS_U.PCS_RX_U.buffer buffer_assertions  #(.MAXBUFFERADR(4), .DATAWIDTH(DUT.PCS_U.PCS_RX_U.buffer.DATA_WIDTH) )
                                                          bufferAssertion
                                                                  (
                                                                    .clk          (DUT.Bit_Rate_Clk)                        ,
                                                                    .writeclk     (DUT.PCS_U.PCS_RX_U.buffer.write_clk)     ,
                                                                    .readclk      (DUT.PCS_U.PCS_RX_U.buffer.read_clk)      ,
                                                                    .rst          (DUT.PCS_U.PCS_RX_U.buffer.rst_n)         ,
                                                                    .read_pointer (DUT.PCS_U.PCS_RX_U.buffer.read_address)  ,
                                                                    .write_pointer(DUT.PCS_U.PCS_RX_U.buffer.write_address) ,
                                                                    .data_in      (DUT.PCS_U.PCS_RX_U.buffer.data_in)       ,
                                                                    .data_out     (DUT.PCS_U.PCS_RX_U.buffer.data_out)      ,
                                                                    .empty        (DUT.PCS_U.PCS_RX_U.buffer.underflow)     ,
                                                                    .full         (DUT.PCS_U.PCS_RX_U.buffer.overflow)      ,
                                                                    .addreq       (DUT.PCS_U.PCS_RX_U.buffer.add_req)       ,
                                                                    .deletereq    (DUT.PCS_U.PCS_RX_U.buffer.delete_req)    ,
                                                                    .skpAdd       (DUT.PCS_U.PCS_RX_U.buffer.skp_added)     ,
                                                                    .skpRemove    (DUT.PCS_U.PCS_RX_U.buffer.Skp_Removed)
                                                                  );

///////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////// CDR Assertions ////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////
bind DUT.PMA_U.PM_RX_U.CDRLoopInst CDR_assertions CDR_A(
                                                        .clk              (DUT.PMA_U.PMA_TX_U.Bit_Rate_Clk)       , // clock used to serialize data inside TX
                                                        .rst_n            (DUT.PMA_U.PM_RX_U.CDRLoopInst.rst_n)   , // CDR rst
                                                        .MAC_EN           (DUT.MAC_Data_En)                       , // enable for serializer
                                                        .TX_POS           (DUT.PMA_U.PM_RX_U.CDRLoopInst.Din)     , // serial data from TX go through CDR
                                                        .recoverd_data    (DUT.PMA_U.PM_RX_U.CDRLoopInst.Dout)    , // serial data get from CDR "Recovered"
                                                        .pi_clk           (DUT.PMA_U.PM_RX_U.CDRLoopInst.PI_Clk)    // clock generated from CDR "Recovered Clock"
                                                        );



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
