package encoding_db_config_pkg;

import uvm_pkg::*;
`include "uvm_macros.svh"

class encoding_config_db extends uvm_object;
  `uvm_object_utils(encoding_config_db);	
 
 virtual PASSIVE_if passive_vif;
 uvm_active_passive_enum is_passive;  //MAKING THE AGENT PASSIVE TO CONSTRAINT THE DRIVING OPERATIONS

function new(string name = "encoding_config_db");
	super.new(name);
endfunction

endclass

endpackage