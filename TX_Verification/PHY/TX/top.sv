//`timescale 1ns/1ns
`timescale 1ns/10ps
import uvm_pkg::*    ;
`include "uvm_macros.svh"
`include "my_test.svh"
//import my_test_pkg::*;



module top ;

import PARAMETERS_pkg::*;
TX_if   dut_if() ;
CLK_if  clk_if() ;
//golden_if g_if() ;
// Design instance 

PHY DUT(
		.MAC_Data_En    (dut_if.MAC_Data_En),
		.MAC_TX_Data    (dut_if.MAC_TX_Data),
		.DataBusWidth   (dut_if.DataBusWidth),
		.Reset_n        (dut_if.Reset_n),
		.TX_Out_N       (dut_if.TX_Out_N),
		.TX_Out_P       (dut_if.TX_Out_P),
		.MAC_TX_DataK   (dut_if.MAC_TX_DataK),
		.Ref_CLK        (dut_if.Ref_CLK)
		);




//golden_model #(.DATA_WIDTH(g_if.DATA_WIDTH)) g_dut (dut_if.Bit_Rate_10 , //dut_if.Rst_n , dut_if.Data_in , dut_if.Tx_Data_Enable , g_if.TX_Out)   ;


//assign g_if.Bit_Rate_10 = dut_if.Bit_Rate_10 ; 


// ClkDiv__  ClkDiv___U0 
// (
//    .i_ref_clk  (dut_if.Bit_Rate_Clk) ,
//    .i_rst_n    (1'b1) ,
//    .i_div_ratio(8'd10) ,
//    .o_div_clk  (dut_if.Bit_Rate_CLK_10)
// );



// ClkDiv__  ClkDiv___U1
// (
//    .i_ref_clk  (dut_if.Bit_Rate_Clk) ,
//    .i_rst_n    (1'b1) ,
//    .i_div_ratio(8'd20) ,
//    .o_div_clk  (dut_if.PCLK)
// );


// initial begin
// dut_if.Bit_Rate_CLK_10 = 0 ; 
// forever begin
// #(CLOCK_PERIOD_10/2) dut_if.Bit_Rate_CLK_10 = ~dut_if.Bit_Rate_CLK_10 ;		
// end
// end

// initial begin
// dut_if.Bit_Rate_Clk = 0 ;
// forever begin
// #(CLOCK_PERIOD_TX/2) dut_if.Bit_Rate_Clk = ~dut_if.Bit_Rate_Clk ;		
// end
// end

// initial begin
// dut_if.PCLK = 0 ;
// forever begin
// #(CLOCK_PERIOD_PCLK/2) dut_if.PCLK = ~dut_if.PCLK ;		
// end
// end
// initial begin

// end

assign clk_if.Bit_Rate_Clk    = DUT.Bit_Rate_Clk;      
assign clk_if.Bit_Rate_CLK_10 = DUT.Bit_Rate_CLK_10;
assign clk_if.PCLK            = DUT.PCLK  ;

always #(CLOCK_PERIOD_Ref/2) dut_if.Ref_CLK = ~dut_if.Ref_CLK;


initial begin
	dut_if.Ref_CLK = 0;
	dut_if.Reset_n = 0 ;
	#(CLOCK_PERIOD_PCLK);
	dut_if.Reset_n = 1;
end


initial begin
uvm_config_db#(virtual CLK_if)::set(null   , "*", "CLK_if",clk_if) ;
end


initial begin
uvm_config_db#(virtual TX_if)::set(null   , "*", "tx_if",dut_if) ;
//uvm_config_db#(virtual golden_if)::set(null,"*" ,"gm_if"   ,g_if)  ;
run_test("my_test");	
end
/*
initial begin
	#100000;

	$stop();
end
*/
endmodule
