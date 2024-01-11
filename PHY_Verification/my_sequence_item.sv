package my_sequence_item_pkg;

import uvm_pkg::*;
`include "uvm_macros.svh"


class my_sequence_item extends uvm_sequence_item;

`uvm_object_utils(my_sequence_item);

logic [3:0] CommandK_Arr [3:0];

function new(string name = "my_sequence_item");
	super.new(name);
   CommandK_Arr = '{4'b0001 , 4'b0010 , 4'b0100 , 4'b1000};
endfunction

  //////// INPUTS //////////

 // rand logic                        Reset_n          ;
 rand logic         [5  : 0 ]      DataBusWidth     ;
 rand logic         [31 : 0 ]      MAC_TX_Data      ;
 rand logic         [3  : 0 ]      MAC_TX_DataK     ;
 rand logic                        MAC_Data_En      ;

 
  
  ///////// OUTPUTS ///////// 

 logic         [31 : 0 ]      Rx_Data          ;
 logic                        Rx_DataK         ;
 logic         [2  : 0 ]      Rx_Status        ; 
 logic                        Rx_Valid         ;
 logic                        PCLK             ; 

 //////// Helpers ////////////
 logic [3:0] randomK ;

constraint randomK_c {
  randomK inside {CommandK_Arr};
}


//-------- DATA WIDTH CONSTRAINT -----
constraint DataBusWidth32_c {
	DataBusWidth == 6'd32;
}

constraint DataBusWidth16_c {
  DataBusWidth == 6'd16;
}

constraint DataBusWidth8_c {
  DataBusWidth == 6'd8;
}


//---------- MAC_DATAK_CONSTRAINT ----
constraint MAC_TX_DataK_c {
 MAC_TX_DataK dist {4'b000 :/ 90 , randomK:/ 10};
}
 

//------ MAC_DATA_En CONSTARINT------

constraint MAC_Data_En_c {
 MAC_Data_En dist {1'b1 :/ 95 , 1'b0:/ 5};
}

//-----------------------------------
 

endclass	
endpackage	