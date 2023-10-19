package test_pkg;
  import env_pkg::*;
  import config_pkg::*;
  import sequence_item_pkg::*;
  import sequence_pkg::*;
  import uvm_pkg::*;
  `include "uvm_macros.svh"
  class my_test extends uvm_test;
    `uvm_component_utils(my_test)

    my_env env;
    my_config_obj config_obj;
    reset_seq my_reset_seq;
    main_seq my_main_seq;


    function new(string name = "my_test", uvm_component parent = null);
      super.new(name, parent);
    endfunction  //new()

    function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      env          = my_env::type_id::create("env", this);
      config_obj   = my_config_obj::type_id::create("config_obj", this);
      my_reset_seq = reset_seq::type_id::create("my_reset_seq", this);
      my_main_seq  = main_seq::type_id::create("my_main_seq", this);

      //retrieving the virtual interface
      if (!uvm_config_db#(virtual TX_interface)::get(this, "", "TX_IFC_DB", config_obj.tx_vif))
        `uvm_fatal("build_phase", "couldb't get the interface");
      config_obj.passive_active = UVM_ACTIVE;

      uvm_config_db#(my_config_obj)::set(this, "*", "TX_if_config_obj", config_obj);

    endfunction

    task run_phase(uvm_phase phase);
      super.run_phase(phase);
      phase.raise_objection(this);
      //reset sequence
      `uvm_info("run phase", "reset seqence asserted", UVM_LOW);
      my_reset_seq.start(env.agent.sqr);
      `uvm_info("run phase", "reset seqence deasserted", UVM_LOW);

      //main sequence
      `uvm_info("run phase", "main seqence deasserted", UVM_LOW);
      my_main_seq.start(env.agent.sqr);
      `uvm_info("run phase", "main seqence deasserted", UVM_LOW);

      phase.drop_objection(this);

    endtask  //
  endclass  //shift_test
endpackage
