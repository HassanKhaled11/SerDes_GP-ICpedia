package decoder_config_db_pkg;

  import uvm_pkg::*;
  `include "uvm_macros.svh"


  class decoder_config_db extends uvm_object;

    `uvm_object_utils(decoder_config_db);

    virtual Decoder_if dec_vif;


    function new(string name = "decoder_config_db");
      super.new(name);
    endfunction


  endclass
endpackage
