package config_pkg;
  import uvm_pkg::*;
  `include "uvm_macros.svh"
  class my_config_obj extends uvm_object;
    `uvm_object_utils(my_config_obj)

    virtual TX_interface tx_vif;
    uvm_active_passive_enum passive_active;

    function new(string name = "my_config_obj");
      super.new(name);
    endfunction  //new()
  endclass  //alu_config extends uvm_object
endpackage
