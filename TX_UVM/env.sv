package env_pkg;
  import scoreboard_pkg::*;
  import coverage_collector_pkg::*;
  import agent_pkg::*;
  // import sequencer::*;
  import uvm_pkg::*;
  `include "uvm_macros.svh"
  class my_env extends uvm_env;
    `uvm_component_utils(my_env)
    my_scoreboard scoreboard;
    my_coverage   coverage;
    my_agent      agent;
    // my_shift_driver driver;
    // MySequencer  sqr;
    function new(string name = "my_env", uvm_component parent = null);
      super.new(name, parent);
    endfunction  //new()

    function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      scoreboard = my_scoreboard::type_id::create("scoreboard", this);
      coverage   = my_coverage::type_id::create("coverage", this);
      agent      = my_agent::type_id::create("agent", this);

    endfunction

    function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      agent.agt_ap.connect(scoreboard.sb_export);
      agent.agt_ap.connect(coverage.cov_export);
    endfunction
  endclass  //shift_test
endpackage
