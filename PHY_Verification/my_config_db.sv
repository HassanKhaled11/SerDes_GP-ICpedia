package my_config_db_pkg;

import uvm_pkg::*;
`include "uvm_macros.svh"


///////////////// MAIN_CONFIG ////////////////

class my_config_db extends uvm_object;
  `uvm_object_utils(my_config_db);

virtual BFM_if        dut_vif    ;
virtual INTERNALS_if  internals_if;

uvm_active_passive_enum is_active;

function new(string name = "my_config_db");
	super.new(name);
endfunction
	
endclass


///////////////// TX_GASKET_CONFIG ////////////////

class tx_gasket_config_db extends uvm_object;
  `uvm_object_utils(tx_gasket_config_db);	
 
 virtual PASSIVE_if passive_vif;
 uvm_active_passive_enum is_active;  //MAKING THE AGENT PASSIVE TO CONSTRAINT THE DRIVING OPERATIONS

function new(string name = "tx_gasket_config_db");
	super.new(name);
endfunction

endclass

///////////////// ENCODING_CONFIG ////////////////

class encoding_config_db extends uvm_object;
  `uvm_object_utils(encoding_config_db);	
 
 virtual PASSIVE_if passive_vif;
 uvm_active_passive_enum is_active;  //MAKING THE AGENT PASSIVE TO CONSTRAINT THE DRIVING OPERATIONS

function new(string name = "encoding_config_db");
	super.new(name);
endfunction

endclass

///////////////// TX_PMA_CONFIG ////////////////

class tx_pma_config_db extends uvm_object;
  `uvm_object_utils(tx_pma_config_db);	
 
 virtual PASSIVE_if passive_vif;
 uvm_active_passive_enum is_active;  //MAKING THE AGENT PASSIVE TO CONSTRAINT THE DRIVING OPERATIONS

function new(string name = "tx_pma_config_db");
	super.new(name);
endfunction

endclass

///////////////// RX_S2P_CONFIG ////////////////

class rx_s2p_config_db extends uvm_object;
  `uvm_object_utils(rx_s2p_config_db);	
 
 virtual PASSIVE_if passive_vif;
 uvm_active_passive_enum is_active;  //MAKING THE AGENT PASSIVE TO CONSTRAINT THE DRIVING OPERATIONS

function new(string name = "rx_s2p_config_db");
	super.new(name);
endfunction

endclass


///////////////// CDR_CONFIG ////////////////

class cdr_config_db extends uvm_object;
  `uvm_object_utils(cdr_config_db);	
 
 virtual PASSIVE_if passive_vif;
 uvm_active_passive_enum is_active;  //MAKING THE AGENT PASSIVE TO CONSTRAINT THE DRIVING OPERATIONS

function new(string name = "cdr_config_db");
	super.new(name);
endfunction

endclass


///////////////// EBUFFER_CONFIG ////////////////

class ebuffer_config_db extends uvm_object;
  `uvm_object_utils(ebuffer_config_db);	
 
 virtual PASSIVE_if passive_vif;
 uvm_active_passive_enum is_active;  //MAKING THE AGENT PASSIVE TO CONSTRAINT THE DRIVING OPERATIONS

function new(string name = "ebuffer_config_db");
	super.new(name);
endfunction

endclass


///////////////// DECODER_CONFIG ////////////////

class decoder_config_db extends uvm_object;
  `uvm_object_utils(decoder_config_db);	
 
 virtual PASSIVE_if passive_vif;
 uvm_active_passive_enum is_active;  //MAKING THE AGENT PASSIVE TO CONSTRAINT THE DRIVING OPERATIONS

function new(string name = "decoder_config_db");
	super.new(name);
endfunction

endclass

///////////////// RX_GASKET_CONFIG ////////////////

class rx_gasket_config_db extends uvm_object;
  `uvm_object_utils(rx_gasket_config_db);	
 
 virtual PASSIVE_if passive_vif;
 uvm_active_passive_enum is_active;  //MAKING THE AGENT PASSIVE TO CONSTRAINT THE DRIVING OPERATIONS

function new(string name = "rx_gasket_config_db");
	super.new(name);
endfunction

endclass

endpackage	