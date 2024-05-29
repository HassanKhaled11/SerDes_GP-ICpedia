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
  PASSIVE_if passive_if();


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
  assign internals_if.recovered_clk_5G = DUT.PMA_U.recovered_clk_5G;
  assign internals_if.MAC_Data_En      = DUT.MAC_Data_En;
  assign internals_if.Decode_Error     = DUT.PCS_U.PCS_RX_U.DecodeError;
  assign internals_if.Disparity_Error  = DUT.PCS_U.PCS_RX_U.Disparity_Error;
  assign internals_if.COMMA_PULSE      = DUT.PCS_U.PCS_RX_U.Comma_pulse;

  PPM_checker #(
      .PERIOD (PARAMETERS_PKG::REF_CLK_PERIOD_5G),
      .MAX_PPM(PARAMETERS_PKG::PPM_TOLERANCE_MAX)
  ) PPM_checker_PI_clk_U (
      DUT.PMA_U.Bit_Rate_Clk,
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


/////////////////////////////////////////
//////////// PASSIVE_AGENT_SIGNALS //////
/////////////////////////////////////////


////////////// TX_GASKET /////////////////

  assign passive_if.tx_gasket_PCLK            = DUT.PCS_U.PCS_TX_U.GasKet_U.PCLK;
  assign passive_if.tx_gasket_Bit_Rate_CLK_10 = DUT.PCS_U.PCS_TX_U.GasKet_U.Bit_Rate_CLK_10;
  assign passive_if.tx_gasket_Reset_n         = DUT.PCS_U.PCS_TX_U.GasKet_U.Reset_n;
  assign passive_if.tx_gasket_DataBusWidth    = DUT.PCS_U.PCS_TX_U.GasKet_U.DataBusWidth;
  assign passive_if.tx_gasket_MAC_TX_Data     = DUT.PCS_U.PCS_TX_U.GasKet_U.MAC_TX_Data;
  assign passive_if.tx_gasket_MAC_TX_DataK    = DUT.PCS_U.PCS_TX_U.GasKet_U.MAC_TX_DataK;
  assign passive_if.tx_gasket_MAC_Data_En     = DUT.PCS_U.PCS_TX_U.GasKet_U.MAC_Data_En; 
  assign passive_if.tx_gasket_TxDataK         = DUT.PCS_U.PCS_TX_U.GasKet_U.TxDataK;
  assign passive_if.tx_gasket_TxData          = DUT.PCS_U.PCS_TX_U.GasKet_U.TxData;

////////////// ENCODER /////////////////

  assign passive_if.encoder_data              = DUT.PCS_U.PCS_TX_U.Encoding_U.data;
  assign passive_if.encoder_MAC_Data_En       = DUT.PCS_U.PCS_TX_U.Encoding_U.MAC_Data_En;
  assign passive_if.encoder_Bit_Rate_10       = DUT.PCS_U.PCS_TX_U.Encoding_U.Bit_Rate_10;
  assign passive_if.encoder_Rst               = DUT.PCS_U.PCS_TX_U.Encoding_U.Rst;
  assign passive_if.encoder_TXDataK           = DUT.PCS_U.PCS_TX_U.Encoding_U.TXDataK; 
  assign passive_if.encoder_data_out          = DUT.PCS_U.PCS_TX_U.Encoding_U.data_out;

////////////// TX_PMA /////////////////

  assign passive_if.tx_pma_Bit_Rate_Clk_10    = DUT.PMA_U.PMA_TX_U.Bit_Rate_Clk_10;  
  assign passive_if.tx_pma_Bit_Rate_Clk       = DUT.PMA_U.PMA_TX_U.Bit_Rate_Clk;
  assign passive_if.tx_pma_Rst_n              = DUT.PMA_U.PMA_TX_U.Rst_n;
  assign passive_if.tx_pma_Data_in            = DUT.PMA_U.PMA_TX_U.Data_in; 
  assign passive_if.tx_pma_MAC_Data_En        = DUT.PMA_U.PMA_TX_U.MAC_Data_En; 
  assign passive_if.tx_pma_TX_Out_P           = DUT.PMA_U.PMA_TX_U.TX_Out_P;   
  assign passive_if.tx_pma_TX_Out_N           = DUT.PMA_U.PMA_TX_U.TX_Out_N;

////////////// RX_S2p /////////////////

  assign passive_if.rx_s2p_Recovered_Bit_Clk  = DUT.PMA_U.PM_RX_U.serialToparallel.Recovered_Bit_Clk;
  assign passive_if.rx_s2p_Ser_in             = DUT.PMA_U.PM_RX_U.serialToparallel.Ser_in;
  assign passive_if.rx_s2p_Rst_n              = DUT.PMA_U.PM_RX_U.serialToparallel.Rst_n;
  assign passive_if.rx_s2p_RxPolarity         = DUT.PMA_U.PM_RX_U.serialToparallel.RxPolarity;
  assign passive_if.rx_s2p_Data_Collected     = DUT.PMA_U.PM_RX_U.serialToparallel.Data_Collected;

////////////// RX_CDR /////////////////

  assign passive_if.cdr_rst_n                 = DUT.PMA_U.PM_RX_U.CDRLoopInst.rst_n;  
  assign passive_if.cdr_clk_0                 = DUT.PMA_U.PM_RX_U.CDRLoopInst.clk_0;
  assign passive_if.cdr_clk_data              = DUT.PMA_U.PM_RX_U.CDRLoopInst.clk_data;  
  assign passive_if.cdr_Din                   = DUT.PMA_U.PM_RX_U.CDRLoopInst.Din;
  assign passive_if.cdr_PI_Clk                = DUT.PMA_U.PM_RX_U.CDRLoopInst.PI_Clk;
  assign passive_if.cdr_Dout                  = DUT.PMA_U.PM_RX_U.CDRLoopInst.Dout;
  //...internal 
  assign passive_if.cdr_code                  = DUT.PMA_U.PM_RX_U.CDRLoopInst.DLF_U.code;

////////////// EBUFFER /////////////////

  assign passive_if.ebuffer_write_clk         = DUT.PCS_U.PCS_RX_U.buffer.write_clk;
  assign passive_if.ebuffer_read_clk          = DUT.PCS_U.PCS_RX_U.buffer.read_clk;
  assign passive_if.ebuffer_data_in           = DUT.PCS_U.PCS_RX_U.buffer.data_in;
  assign passive_if.ebuffer_rst_n             = DUT.PCS_U.PCS_RX_U.buffer.rst_n;
  assign passive_if.ebuffer_skp_added         = DUT.PCS_U.PCS_RX_U.buffer.skp_added;
  assign passive_if.ebuffer_Skp_Removed       = DUT.PCS_U.PCS_RX_U.buffer.Skp_Removed;
  assign passive_if.ebuffer_overflow          = DUT.PCS_U.PCS_RX_U.buffer.overflow;
  assign passive_if.ebuffer_underflow         = DUT.PCS_U.PCS_RX_U.buffer.underflow;
  assign passive_if.ebuffer_data_out          = DUT.PCS_U.PCS_RX_U.buffer.data_out;


////////////// DECODER /////////////////

  assign passive_if.decoder_CLK               = DUT.PCS_U.PCS_RX_U.decode.CLK;
  assign passive_if.decoder_Rst_n             = DUT.PCS_U.PCS_RX_U.decode.Rst_n;
  assign passive_if.decoder_Data_in           = DUT.PCS_U.PCS_RX_U.decode.Data_in;
  assign passive_if.decoder_Data_out          = DUT.PCS_U.PCS_RX_U.decode.Data_out;
  assign passive_if.decoder_DecodeError       = DUT.PCS_U.PCS_RX_U.decode.DecodeError;
  assign passive_if.decoder_DisparityError    = DUT.PCS_U.PCS_RX_U.decode.DisparityError;
  assign passive_if.decoder_RxDataK           = DUT.PCS_U.PCS_RX_U.decode.RxDataK;

////////////// RX_GASKET ///////////////

  assign passive_if.rx_gasket_clk_to_get      = DUT.PCS_U.PCS_RX_U.rx_gasket.clk_to_get;
  assign passive_if.rx_gasket_PCLK            = DUT.PCS_U.PCS_RX_U.rx_gasket.PCLK;
  assign passive_if.rx_gasket_Rst_n           = DUT.PCS_U.PCS_RX_U.rx_gasket.Rst_n;
  assign passive_if.rx_gasket_Rx_Datak        = DUT.PCS_U.PCS_RX_U.rx_gasket.Rx_Datak;
  assign passive_if.rx_gasket_width           = DUT.PCS_U.PCS_RX_U.rx_gasket.width;
  assign passive_if.rx_gasket_Data_in         = DUT.PCS_U.PCS_RX_U.rx_gasket.Data_in;
  assign passive_if.rx_gasket_Data_out        = DUT.PCS_U.PCS_RX_U.rx_gasket.Data_out;



  ////////////////////////////////////
  ////////// PHY ASSERTIONS //////////
  ////////////////////////////////////

  bind DUT phy_assertions #(
      .DATA_BUS_WIDTH(32)
  ) PHY_A (
      .clk     (DUT.PCLK),
      .rst_n   (DUT.Reset_n),
      .Data_in (DUT.MAC_TX_Data),
      .Data_out(DUT.RX_Data),
      .enable  (DUT.MAC_Data_En)
  );

  /////////// COMMA Assertions ////////

  bind DUT.PCS_U.PCS_RX_U.Comma_Detection_U comma_assertions commaAssertion (
      .clk         (DUT.PCS_U.PCS_RX_U.Comma_Detection_U.clk),
      .rst_n       (DUT.PCS_U.PCS_RX_U.Comma_Detection_U.rst_n),
      .rx_valid    (DUT.PCS_U.PCS_RX_U.Comma_Detection_U.RxValid),
      .comma_pulse (DUT.PCS_U.PCS_RX_U.Comma_Detection_U.Comma_Pulse),
      .COMMA_NUMBER(DUT.PCS_U.PCS_RX_U.Comma_Detection_U.COMMA_NUMBER),
      .cs          (DUT.PCS_U.PCS_RX_U.Comma_Detection_U.cs),
      .ns          (DUT.PCS_U.PCS_RX_U.Comma_Detection_U.ns),
      .data        (DUT.PCS_U.PCS_RX_U.Comma_Detection_U.Data_Collected),
      .count_rst   (DUT.PCS_U.PCS_RX_U.Comma_Detection_U.count_reset),
      .count       (DUT.PCS_U.PCS_RX_U.Comma_Detection_U.count)

  );


  ///////////////////////////////////////////////
  //////////// ELASTIC BUFFER ASSERTIONS ////////
  ///////////////////////////////////////////////


  bind DUT.PCS_U.PCS_RX_U.buffer buffer_assertions #(
      .MAXBUFFERADR(4),
      .DATAWIDTH(DUT.PCS_U.PCS_RX_U.buffer.DATA_WIDTH)
  ) bufferAssertion (
      .clk          (DUT.Bit_Rate_Clk),
      .writeclk     (DUT.PCS_U.PCS_RX_U.buffer.write_clk),
      .readclk      (DUT.PCS_U.PCS_RX_U.buffer.read_clk),
      .rst          (DUT.PCS_U.PCS_RX_U.buffer.rst_n),
      .read_pointer (DUT.PCS_U.PCS_RX_U.buffer.read_address),
      .write_pointer(DUT.PCS_U.PCS_RX_U.buffer.write_address),
      .data_in      (DUT.PCS_U.PCS_RX_U.buffer.data_in),
      .data_out     (DUT.PCS_U.PCS_RX_U.buffer.data_out),
      .empty        (DUT.PCS_U.PCS_RX_U.buffer.underflow),
      .full         (DUT.PCS_U.PCS_RX_U.buffer.overflow),
      .addreq       (DUT.PCS_U.PCS_RX_U.buffer.add_req),
      .deletereq    (DUT.PCS_U.PCS_RX_U.buffer.delete_req),
      .skpAdd       (DUT.PCS_U.PCS_RX_U.buffer.skp_added),
      .skpRemove    (DUT.PCS_U.PCS_RX_U.buffer.Skp_Removed)
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
    uvm_config_db#(virtual INTERNALS_if)::set(null, "*", "internals_if",internals_if);  // INTERNAL INTERFACE
    uvm_config_db#(virtual PASSIVE_if)::set(null,"*","passive_if",passive_if);

    //------ RUNNING THE TEST --------
    run_test("my_test");
  end



  ///////////////////////////////////
  /////// MATLAB PREPARATION ////////
  ///////////////////////////////////

  wire [15:0] Freq_Integrator;
  wire [15:0] Phase_Integrator;

  assign UP = DUT.PMA_U.PM_RX_U.CDRLoopInst.DLF_U.Up;
  assign DN = DUT.PMA_U.PM_RX_U.CDRLoopInst.DLF_U.Dn;
  assign Freq_Integrator = DUT.PMA_U.PM_RX_U.CDRLoopInst.DLF_U.freq_integrator;
  assign Phase_Integrator = DUT.PMA_U.PM_RX_U.CDRLoopInst.DLF_U.phase_integrator;

  int fd, fd2, fd3, fd4, fd5;
  initial begin
    fd  = $fopen("./Up_Dn.hex", "w");
    fd2 = $fopen("./Freq_Integrator.hex", "w");
    fd3 = $fopen("./Phase_Integrator.hex", "w");

    //to empty files
    fd4 = $fopen("./MAC_TX_Data_Stim.hex", "w");
    $fclose(fd4);
    fd5 = $fopen("./PHY_OUT.hex", "w");
    $fclose(fd5);


  end

  always @(UP, DN) begin
    $fwrite(fd, "%h,%h\n", UP, DN);
  end

  always @(Freq_Integrator) begin
    $fwrite(fd2, "%h\n", Freq_Integrator);
  end


  always @(Phase_Integrator) begin
    $fwrite(fd3, "%h\n", Phase_Integrator);
  end

  //////////////////////////////////
  //////////////////////////////////
  //////////////////////////////////






endmodule
