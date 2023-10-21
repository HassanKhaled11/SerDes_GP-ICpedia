package my_sequence_pkg;

import uvm_pkg::*;
`include "uvm_macros.svh"
import my_sequence_item_pkg::*;


class my_sequence extends uvm_sequence #(my_sequence_item);

`uvm_object_utils(my_sequence);

function new(string name = "my_sequence");
	super.new(name);
endfunction

endclass




class reset_sequence extends my_sequence;

`uvm_object_utils(reset_sequence);

function new(string name = "reset_sequence");
	super.new(name);
endfunction

endclass	


endpackage	