package my_sequence_item_pkg;

import uvm_pkg::*;
`include "uvm_macros.svh"


class my_sequence_item extends uvm_sequence_item;

`uvm_object_utils(my_sequence_item);


function new(string name = "my_sequence_item" );
	super.new(name);
endfunction


rand logic                    Rst_n           ;
rand logic         [9:0]      Data_in         ; 
rand logic                    Tx_Data_Enable  ; 
logic                         TX_Out          ;
logic                         TX_Done         ;



constraint Rst_n_c {
    Rst_n dist {1:= 990 , 0 := 1};	
}


constraint Tx_Data_Enable_c {
	Tx_Data_Enable dist {1:/ 90 , 0:/ 10 };
}

endclass	
endpackage	