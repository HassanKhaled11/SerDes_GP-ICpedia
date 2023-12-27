package decoder_sequencer_pkg;

  import uvm_pkg::*;
  `include "uvm_macros.svh"

  import decoder_sequence_item_pkg::*;


  class decoder_sequencer extends uvm_sequencer #(decoder_sequence_item);

    `uvm_component_utils(decoder_sequencer);


    function new(string name = "decoder_sequencer", uvm_component parent = null);
      super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
      super.build_phase(phase);
    endfunction

  endclass
endpackage
