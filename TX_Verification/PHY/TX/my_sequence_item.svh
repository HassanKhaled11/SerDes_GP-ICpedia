package my_sequence_item_pkg;

import uvm_pkg::*;
`include "uvm_macros.svh"


class my_sequence_item extends uvm_sequence_item;

`uvm_object_utils(my_sequence_item);


function new(string name = "my_sequence_item" );
	super.new(name);
endfunction



// rand logic Reset_n;
rand logic [5:0] DataBusWidth;
rand logic [31:0] MAC_TX_Data;
rand logic [3:0] MAC_TX_DataK;
rand logic MAC_Data_En;
rand logic TX_Out_P;
rand logic TX_Out_N;
logic [9:0] data_in;

 
// constraint Rst_n_c {
//     Reset_n dist {1:= 990 , 0 := 3};	
// }

constraint Tx_Data_Enable_cv {
	MAC_Data_En dist {1:/ 90 , 0:/ 10 };
}
constraint buswidth {
	DataBusWidth == 6'd16;
}
constraint data_in_ {
	MAC_TX_Data inside {32'h26c4 , 32'hdd81 , 32'h5a02 , 32'h719c}; // , 32'hdd81 , 32'h5a02 , 32'h719c
}
constraint data_k {
	MAC_TX_DataK inside {4'ha , 4'hf , 4'h0 , 4'h5};
}
endclass	
endpackage	