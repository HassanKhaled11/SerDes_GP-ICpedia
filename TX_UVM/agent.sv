package agent_pkg;
  import uvm_pkg::*;
  import sequencer_pkg::*;
  import sequence_item_pkg::*;
  import driver_pkg::*;
  import monitor_pkg::*;
  import config_pkg::*;
  `include "uvm_macros.svh"
  class my_agent extends uvm_agent;
    `uvm_component_utils(my_agent)

    MySequencer sqr;
    my_shift_driver driver;
    my_monitor monitor;
    my_config_obj config_obj;
    uvm_analysis_port #(my_sequence_item) agt_ap;

    function new(string name = "my_agent", uvm_component parent = null);
      super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      agt_ap = new("agt_ap", this);
      config_obj = my_config_obj::type_id::create("config_obj", this);
      if (!uvm_config_db#(my_config_obj)::get(this, "", "TX_if_config_obj", config_obj))
        `uvm_fatal("build phase", "couldn't get the configuration object");
      if (config_obj.passive_active == UVM_ACTIVE) begin
        driver = my_shift_driver::type_id::create("driver", this);
        sqr = MySequencer::type_id::create("sqr", this);
      end
      monitor = my_monitor::type_id::create("monitor", this);
    endfunction

    function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      if (config_obj.passive_active == UVM_ACTIVE) begin
        driver.shift_driver_vif = config_obj.tx_vif;
        driver.seq_item_port.connect(sqr.seq_item_export);
      end
      monitor.shift_driver_vif = config_obj.tx_vif;

      monitor.mon_ap.connect(agt_ap);

    endfunction

  endclass  //agent extends uvm_agent
endpackage
