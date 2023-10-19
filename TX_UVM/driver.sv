package driver_pkg;
  import sequence_item_pkg::*;
  import config_pkg::*;
  import uvm_pkg::*;
  `include "uvm_macros.svh"
  class my_shift_driver extends uvm_driver #(my_sequence_item);
    `uvm_component_utils(my_shift_driver)

    virtual TX_interface shift_driver_vif;
    my_sequence_item seq_item;


    function new(string name = "my_shift_driver", uvm_component parent = null);
      super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
      super.build_phase(phase);

    endfunction

    function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      // my_shift_driver_vif = shift_config_obj_driver.tx_vif;
    endfunction

    task run_phase(uvm_phase phase);
      super.run_phase(phase);
      forever begin
        seq_item = my_sequence_item::type_id::create("seq_item");
        seq_item_port.get_next_item(seq_item);

        shift_driver_vif.reset     = seq_item.reset;
        shift_driver_vif.serial_in = seq_item.serial_in;
        shift_driver_vif.direction = seq_item.direction;
        shift_driver_vif.mode      = seq_item.mode;
        shift_driver_vif.datain    = seq_item.datain;
        @(negedge shift_driver_vif.clk);

        seq_item_port.item_done();
        `uvm_info("run_phase", seq_item.convert2string_stimulus(), UVM_HIGH);


      end
    endtask  //
  endclass
endpackage
