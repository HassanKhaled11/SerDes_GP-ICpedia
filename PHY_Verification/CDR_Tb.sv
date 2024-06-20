`timescale 1ps / 1fs
module CDR_Tb ();


  parameter CLK_Period = 200;

  reg rst_n, clk_0, clk_90, clk_180, clk_270, Din;
  reg  clk_data;
  wire PI_Clk;
  wire Dout;

  ////////////////////////////////////////////////////////////////
  ///////////////////////// VCO Clocks ///////////////////////////
  ////////////////////////////////////////////////////////////////
  always begin
    #100 clk_0 = ~clk_0;  //CLK_Period/2.0
  end

  initial begin
    #50  //CLK_Period/2.0
      forever
        #100 clk_90 = ~clk_90;
  end

  initial begin
    #100  //CLK_Period/2.0
      forever
        #100 clk_180 = ~clk_180;
  end
  initial begin
    #150  //3*CLK_Period/4.0
      forever
        #100 clk_270 = ~clk_270;
  end

  ////////////////////////////////////////////////////////////////
  ///////////////////////// Din Clock ////////////////////////////
  ////////////////////////////////////////////////////////////////

  initial begin
    // #110;
    forever #99.9 clk_data = ~clk_data;
  end

  ////////////////////////////////////////////////////////////////
  //////////////////////////// Din  //////////////////////////////
  ////////////////////////////////////////////////////////////////

  initial begin
    clk_0 = 0;
    clk_90 = 0;
    clk_180 = 0;
    clk_270 = 0;
    clk_data = 0;
    Din = 0;
    rst_n = 1;
    @(negedge clk_0);
    rst_n = 0;
    @(negedge clk_0);
    rst_n = 1;
    for (int i = 0; i < 2000000; i++) begin
      Din = ~Din;
      @(negedge clk_data);
    end
    $stop();
  end

  CDR_Loop Dut (.*);

endmodule : CDR_Tb
