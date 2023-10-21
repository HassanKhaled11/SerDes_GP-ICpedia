package my_sequence_item_pkg;

import uvm_pkg::*;
`include "uvm_macros.svh"


class my_sequence_item extends uvm_sequence_item;

`uvm_object_utils(my_sequence_item);

function new(string name = "my_sequence_item");
	super.new(name);
endfunction


 // rand logic [3:0] A;
 // rand logic [3:0] B;
 // logic [3:0] out;



endclass	
endpackage	