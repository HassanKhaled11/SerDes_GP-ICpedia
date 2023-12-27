package decoder_test_pkg;

  import uvm_pkg::*;
  `include "uvm_macros.svh"
  // `include "my_env.svh"
  // `include "my_sequence.svh"
  import decoder_env_pkg::*;
  import decoder_sequence_pkg::*;
  // import decoder_sequence_item_pkg::*;
  import decoder_config_db_pkg::*;


  class decoder_test extends uvm_test;

    `uvm_component_utils(decoder_test);

    decoder_env env;
    decoder_sequence main_seq;
    reset_sequence reset_seq;
    decoder_config_db cfg;

    function new(string name = "decoder_test", uvm_component parent = null);
      super.new(name, parent);
    endfunction


    function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      `uvm_info("DECODER_TEST", "BUILD_PHASE", UVM_MEDIUM);

      env       = decoder_env::type_id::create("env", this);
      main_seq  = decoder_sequence::type_id::create("main_seq", this);
      reset_seq = reset_sequence::type_id::create("reset_seq", this);
      cfg       = decoder_config_db::type_id::create("cfg", this);

      if (!uvm_config_db#(virtual Decoder_if)::get(this, "", "dec_if", cfg.dec_vif))
        `uvm_fatal("DECODER_TEST", "FATAL GETTING BFM INTERFACE");

      uvm_config_db#(decoder_config_db)::set(this, "*", "CFG", cfg);

    endfunction


    task run_phase(uvm_phase phase);
      phase.raise_objection(this);

      `uvm_info("MY_TEST", "RESET SEQ START", UVM_MEDIUM);
      reset_seq.start(env.agent.sqr);
      `uvm_info("MY_TEST", "RESET SEQ END", UVM_MEDIUM);

      `uvm_info("DECODER_TEST", "MAIN SEQ START", UVM_MEDIUM);
      main_seq.start(env.agent.sqr);
      `uvm_info("DECODER_TEST", "MAIN SEQ END", UVM_MEDIUM);

      phase.drop_objection(this);
    endtask



  endclass
endpackage
