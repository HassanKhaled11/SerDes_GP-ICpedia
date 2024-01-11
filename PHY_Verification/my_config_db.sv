package my_config_db_pkg;

import uvm_pkg::*;
`include "uvm_macros.svh"


class my_config_db extends uvm_object;

`uvm_object_utils(my_config_db);

virtual BFM_if        dut_vif    ;
virtual INTERNALS_if  internals_if;

function new(string name = "my_config_db");
	super.new(name);
endfunction
	

endclass	
endpackage	