import test_pkg::*;
import uvm_pkg::*;
`include "uvm_macros.svh"
module top ();
  bit clk = 0;
  initial begin
    forever #1 clk = ~clk;
  end

  TX_interface tx_vif (clk);

  //instantiate the DUT
  shift_reg DUT (
      clk,
      tx_vif.reset,
      tx_vif.serial_in,
      tx_vif.direction,
      tx_vif.mode,
      tx_vif.datain,
      tx_vif.dataout
  );


  initial begin
    uvm_config_db#(virtual TX_interface)::set(null, "uvm_test_top", "TX_IFC_DB", tx_vif);
    run_test("my_test");
  end
endmodule
