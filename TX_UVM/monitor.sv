package monitor_pkg;
  import sequence_item_pkg::*;
  import uvm_pkg::*;
  `include "uvm_macros.svh"
  class my_monitor extends uvm_monitor;
    `uvm_component_utils(my_monitor)

    virtual TX_interface shift_driver_vif;
    my_sequence_item seq_item;
    uvm_analysis_port #(my_sequence_item) mon_ap;

    function new(string name = "my_monitor", uvm_component parent = null);
      super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      mon_ap = new("mon_ap", this);
    endfunction

    task run_phase(uvm_phase phase);
      super.run_phase(phase);
      forever begin
        seq_item = my_sequence_item::type_id::create("seq_item");
        // seq_item_port.get_next_item(seq_item);
        @(negedge shift_driver_vif.clk);

        seq_item.reset     = shift_driver_vif.reset;
        seq_item.serial_in = shift_driver_vif.serial_in;
        seq_item.direction = shift_driver_vif.direction;
        seq_item.mode      = shift_driver_vif.mode;
        seq_item.datain    = shift_driver_vif.datain;
        mon_ap.write(seq_item);
        // seq_item_port.item_done();
        `uvm_info("run_phase", seq_item.convert2string_stimulus(), UVM_HIGH);
      end
    endtask  //

  endclass  //agent extends uvm_agent
endpackage
