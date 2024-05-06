package my_test_pkg;

  import uvm_pkg::*;
  `include "uvm_macros.svh"

  import my_env_pkg::*;
  import my_sequence_pkg::*;
  import my_config_db_pkg::*;


  class my_test extends uvm_test;

    `uvm_component_utils(my_test);

    my_env         env;
    my_sequence_32 main_seq_32;
    my_sequence_16 main_seq_16;
    my_sequence_8  main_seq_8;
    my_config_db   cfg;

    function new(string name = "my_test", uvm_component parent = null);
      super.new(name, parent);
    endfunction


    function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      `uvm_info("MY_TEST", "BUILD_PHASE", UVM_MEDIUM);

      env         = my_env::type_id::create("env", this);
      main_seq_32 = my_sequence_32::type_id::create("main_seq_32", this);
      main_seq_16 = my_sequence_16::type_id::create("main_seq_16", this);
      main_seq_8  = my_sequence_8::type_id::create("main_seq_8", this);
      cfg         = my_config_db::type_id::create("cfg", this);


      if (!uvm_config_db#(virtual BFM_if)::get(this, "", "bfm_if", cfg.dut_vif))
        `uvm_fatal("MY_TEST", "FATAL PUTTING BFM INTERFACE in CONFIG_DB");

      if (!uvm_config_db#(virtual INTERNALS_if)::get(this, "", "internals_if", cfg.internals_if))
        `uvm_fatal("MY_TEST", "FATAL PUTTING INTERNALS INTERFACE in CONFIG_DB");

      uvm_config_db#(my_config_db)::set(this, "*", "CFG", cfg);

    endfunction


    task run_phase(uvm_phase phase);
      phase.raise_objection(this);

      fork
        // begin
        //   `uvm_warning("MY_TEST","MAIN SEQ START");
        // end
        begin
          ///////////WIDTH = 32//////////////

          cfg.dut_vif.DataBusWidth = 6'd32;
          // cfg.dut_vif.DataBusWidth = 6'd32;
          `uvm_warning("MY_TEST_32", "RESET");
          cfg.dut_vif.Reset_n = 0;
          #1000;
          cfg.dut_vif.Reset_n = 1;

          #4;
          `uvm_warning("MY_TEST_32", "MAIN TEST START..");
          main_seq_32.start(env.agent.sqr);


          ////////////WIDTH = 16////////////
          cfg.dut_vif.DataBusWidth = 6'd16;
          `uvm_warning("MY_TEST_16", "RESET");
          cfg.dut_vif.Reset_n = 0;
          #1000;
          cfg.dut_vif.Reset_n = 1;

          #4;
          `uvm_warning("MY_TEST_16", "MAIN TEST START..");
          main_seq_16.start(env.agent.sqr);

          #3000;
          cfg.dut_vif.MAC_Data_En = 0;
          #3000;
          cfg.dut_vif.MAC_Data_En  = 1;

          //////////WIDTH = 8////////////
          cfg.dut_vif.DataBusWidth = 6'd8;
          `uvm_warning("MY_TEST_8", "RESET");
          cfg.dut_vif.Reset_n = 0;
          #1000;
          cfg.dut_vif.Reset_n = 1;

          #4;
          `uvm_warning("MY_TEST_8", "MAIN TEST START..");
          main_seq_8.start(env.agent.sqr);
        end

      join


      phase.drop_objection(this);
    endtask



  endclass
endpackage
