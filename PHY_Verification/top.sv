`timescale 1ns / 10ps


import uvm_pkg::*;
`include "uvm_macros.svh"

import my_test_pkg::*;
import PARAMETERS_PKG::*;


module top;

  ////////////////////////////////////
  //////////// INTERFACE /////////////
  ////////////////////////////////////


  BFM_if dut_if ();
  INTERNALS_if internals_if ();


  /////////////////////////////////////
  ///////// Design instance ///////////
  /////////////////////////////////////

  PHY DUT (
      .Ref_CLK     (dut_if.Ref_CLK),
      .Reset_n     (dut_if.Reset_n),
      .DataBusWidth(dut_if.DataBusWidth),
      .MAC_TX_Data (dut_if.MAC_TX_Data),
      .MAC_TX_DataK(dut_if.MAC_TX_DataK),
      .MAC_Data_En (dut_if.MAC_Data_En),
      .RxPolarity  (dut_if.RxPolarity),

      .TX_Out_P (dut_if.TX_Out_P),
      .TX_Out_N (dut_if.TX_Out_N),
      .RX_Data  (dut_if.Rx_Data),
      .RX_DataK (dut_if.Rx_DataK),
      .RX_Status(dut_if.Rx_Status),
      .RX_Valid (dut_if.Rx_Valid),
      .PCLK     (dut_if.PCLK)
  );

  ////////////////////////////////////
  //////////// INTERNALS /////////////
  ////////////////////////////////////

  assign internals_if.Bit_CLK          = DUT.Bit_Rate_Clk;
  assign internals_if.Word_CLK         = DUT.Bit_Rate_CLK_10;
  assign internals_if.PCLK             = DUT.PCLK;
  assign internals_if.DataBusWidth     = DUT.DataBusWidth;
  assign internals_if.TX_Out_P         = DUT.PMA_U.TX_Out_P;
  assign internals_if.Clk_offset       = DUT.PMA_U.Bit_Rate_Clk_offset;
  assign internals_if.recovered_clk_5G = DUT.PMA_U.recovered_clk_5G;

  PPM_checker #(
      .PERIOD (PARAMETERS_PKG::REF_CLK_PERIOD_5G),
      .MAX_PPM(PARAMETERS_PKG::PPM_TOLERANCE_MAX)
  ) PPM_checker_U (
      DUT.PMA_U.Bit_Rate_Clk_offset,
      dut_if.Reset_n
  );

  PPM_checker #(
      .PERIOD (PARAMETERS_PKG::REF_CLK_PERIOD_5G),
      .MAX_PPM(PARAMETERS_PKG::PPM_TOLERANCE_MAX)
  ) PPM_checker_PI_clk_U (
      DUT.PMA_U.recovered_clk_5G,
      dut_if.Reset_n
  );

  my_assertion DUTA (

      .Bit_CLK     (DUT.Bit_Rate_Clk),
      .Word_CLK    (DUT.Bit_Rate_CLK_10),
      .PCLK        (DUT.PCLK),
      .DataBusWidth(DUT.DataBusWidth),
      .TX_Out_P    (DUT.PMA_U.TX_Out_P)

  );


  ///////////////////////////////////
  ///////// CLOCK GENERATION ////////
  ///////////////////////////////////

  initial begin
    dut_if.Ref_CLK = 0;
    forever begin
      #(REF_CLK_PERIOD / 2) dut_if.Ref_CLK = ~dut_if.Ref_CLK;
    end
  end


  ///////////////////////////////////
  ///////////// DATABASE ////////////
  ///////////////////////////////////

  initial begin
    uvm_config_db#(virtual BFM_if)::set(null, "*", "bfm_if", dut_if);  // BUS FUNCTIONAL MODEL
    uvm_config_db#(virtual INTERNALS_if)::set(null, "*", "internals_if",
                                              internals_if);  // INTERNAL INTERFACE

    //------ RUNNING THE TEST --------
    run_test("my_test");
  end


endmodule
