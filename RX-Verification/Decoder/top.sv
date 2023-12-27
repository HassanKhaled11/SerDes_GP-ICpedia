//`timescale 1ns/1ns
`timescale 1ns / 10ps
import uvm_pkg::*;
import decoder_test_pkg::*;
`include "uvm_macros.svh"
// `include "my_test.svh"




module top;

  import PARAMETERS_pkg::*;
  // Design instance 
  bit CLK;
  Decoder_if dec_if (CLK);
  decoder DUT (
      .CLK(CLK),
      .Rst_n(dec_if.Rst_n),
      .Data_in(dec_if.Data_in),
      .Data_out(dec_if.Data_out),
      .DecodeError(dec_if.DecodeError),
      .DisparityError(dec_if.DisparityError),
      .RxDataK(dec_if.RxDataK)
  );


  //   assign dut_if.data_In_PMA     = DUT.Data_In_PMA;

  //   assign clk_if.Bit_Rate_Clk    = DUT.Bit_Rate_Clk;
  //   assign clk_if.Bit_Rate_CLK_10 = DUT.Bit_Rate_CLK_10;
  // bit CLK;
  // assign dec_if.CLK = CLK;

  initial begin
    CLK = 0;
    forever #(CLOCK_PERIOD_Ref / 2) CLK = ~CLK;

  end



  initial begin
    uvm_config_db#(virtual Decoder_if)::set(null, "*", "dec_if", dec_if);
    run_test("decoder_test");
  end

  // initial begin
  //   #1000;

  //   $stop();
  // end

endmodule
