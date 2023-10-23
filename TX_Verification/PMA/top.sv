`timescale 1ns/1ns

import uvm_pkg::*    ;
`include "uvm_macros.svh"
import my_test_pkg::*;
import PARAMETERS_pkg::*;


module top ;


BFM_if  dut_if() ;
golden_if g_if() ;
// Design instance 

PMA #(.DATA_WIDTH(dut_if.DATA_WIDTH))        dut(dut_if.Bit_Rate_10 , dut_if.Rst_n , dut_if.Data_in , dut_if.Tx_Data_Enable , dut_if.TX_Out,dut_if.TX_Done)    ;
golden_model #(.DATA_WIDTH(g_if.DATA_WIDTH)) g_dut (dut_if.Bit_Rate_10 , dut_if.Rst_n , dut_if.Data_in , dut_if.Tx_Data_Enable , g_if.TX_Out)   ;


assign g_if.Bit_Rate_10 = dut_if.Bit_Rate_10 ; 
assign g_if.TX_Done     = dut_if.TX_Done     ;
assign g_if.Rst_n       = dut_if.Rst_n       ;

initial begin
dut_if.Bit_Rate_10 = 0 ;
forever begin
#(CLOCK_PERIOD/2) dut_if.Bit_Rate_10 = ~dut_if.Bit_Rate_10 ;		
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
