package decoder_agent_pkg;

  import uvm_pkg::*;
  `include "uvm_macros.svh"
  // `include "my_driver.svh"
  // `include "my_monitor.svh"
  // `include "my_sequencer.svh"
  import decoder_sequencer_pkg::*;
  import decoder_sequence_item_pkg::*;
  import decoder_driver_pkg::*;
  import decoder_monitor_pkg::*;
  import decoder_config_db_pkg::*;



  class decoder_agent extends uvm_agent;

    `uvm_component_utils(decoder_agent);

    uvm_analysis_port #(decoder_sequence_item) agt_port;

    decoder_config_db                          cfg;
    decoder_driver                             driver;
    decoder_monitor                            monitor;
    decoder_sequencer                          sqr;


    function new(string name = "decoder_agent", uvm_component parent = null);
      super.new(name, parent);
    endfunction


    function void build_phase(uvm_phase phase);
      super.build_phase(phase);

      driver   = decoder_driver::type_id::create("driver", this);
      sqr      = decoder_sequencer::type_id::create("sqr", this);
      monitor  = decoder_monitor::type_id::create("monitor", this);
      cfg      = decoder_config_db::type_id::create("cfg", this);
      agt_port = new("agt_port", this);

      if (!uvm_config_db#(decoder_config_db)::get(this, "", "CFG", cfg))
        `uvm_fatal("DECODER_AGENT", "FAILED GETTING CONFIG DB");

      `uvm_info("DECODER_AGENT", "BUILD_PHASE", UVM_HIGH);
    endfunction



    function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      driver.dec_vif = cfg.dec_vif;
      driver.seq_item_port.connect(sqr.seq_item_export);
      `uvm_info("DECODER_AGENT", "CONNECT_PHASE", UVM_HIGH);
      monitor.decoder_bfm_vif = cfg.dec_vif;
      monitor.mon_port.connect(agt_port);

    endfunction



  endclass
endpackage
