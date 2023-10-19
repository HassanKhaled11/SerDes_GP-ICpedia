package sequencer_pkg;
  import sequence_item_pkg::*;
  import uvm_pkg::*;
  `include "uvm_macros.svh"
  class MySequencer extends uvm_sequencer #(my_sequence_item);
    `uvm_component_utils(MySequencer)
    function new(string name = "MySequencer", uvm_component parent = null);
      super.new(name, parent);
    endfunction  //new()
  endclass  //MySequencer extends uvm_sequence
endpackage
