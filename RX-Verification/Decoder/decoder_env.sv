package decoder_env_pkg;

  import uvm_pkg::*;
  //   import decoder_config_db_pkg::*;
  `include "uvm_macros.svh"
  //   `include "my_agent.svh"
  //   `include "my_scoreboard.svh"
  //   `include "my_coverage.svh"
  import decoder_agent_pkg::*;
  //import my_monitor_pkg   ::*; 
  import decoder_scoreboard_pkg::*;
  import decoder_coverage_pkg::*;



  class decoder_env extends uvm_env;

    `uvm_component_utils(decoder_env);

    decoder_agent      agent;
    decoder_scoreboard scoreboard;
    decoder_coverage   coverage;

    function new(string name = "decoder_env", uvm_component parent = null);
      super.new(name, parent);
    endfunction


    function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      agent      = decoder_agent::type_id::create("agent", this);
      scoreboard = decoder_scoreboard::type_id::create("scoreboard", this);
      coverage   = decoder_coverage::type_id::create("coverage", this);
      `uvm_info("DECODER_ENV", "BUILD_PHASE", UVM_HIGH);
    endfunction


    function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      //agent.monitor.mon_port.connect(scoreboard.sb_export);
      agent.agt_port.connect(scoreboard.sb_export);
      agent.agt_port.connect(coverage.cov_export);
      `uvm_info("DECODER_ENV", "CONNECT_PHASE", UVM_HIGH);

    endfunction

  endclass
endpackage
