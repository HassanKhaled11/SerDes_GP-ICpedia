package my_sequence_item_pkg;

import uvm_pkg::*;
`include "uvm_macros.svh"


class my_sequence_item extends uvm_sequence_item;

`uvm_object_utils(my_sequence_item);

// logic [3:0] CommandK_Arr [3:0];



//////// INPUTS //////////

 //rand logic                      Reset_n            ;
 logic         [5  : 0 ]         DataBusWidth       ;
 rand logic                      TX_P               ;
 // rand logic         [31 : 0 ] MAC_TX_Data        ;
 // rand logic         [3  : 0 ] MAC_TX_DataK       ;
 // rand logic                   MAC_Data_En        ;
 rand logic                      RxPolarity         ;

 logic                           CDR_OUT            ;
 logic                           RECOVERED_CLK      ;  
  
  ///////// OUTPUTS ///////// 
 //logic                       TX_Out_P              ;
 //logic                       TX_Out_N              ;
 
 logic         [31 : 0 ]       Rx_Data               ;
 logic                         Rx_DataK              ;
 logic         [2  : 0 ]       Rx_Status             ; 
 logic                         Rx_Valid              ;
 logic                         PCLK                  ; 

 //////// Helpers ////////////
 logic [3:0]  randomK ;
 logic  Data_post;
 int count_8 ;
 int count_16;


function new(string name = "my_sequence_item");
	super.new(name);
   // CommandK_Arr = '{4'b0001 , 4'b0010 , 4'b0100 , 4'b1000};
   Data_post = 0 ;
   count_8  = 0  ;
   count_16 = 0  ;
endfunction



// constraint reset_c {
//     Reset_n dist {1'b1:/ 95 , 1'b0:/5 };
// }


//---------- MAC_DATAK_CONSTRAINT --------
// constraint MAC_TX_Data_32c {
//  if(Data_post == 32'hBCBC_BCBC) {
//      MAC_TX_Data inside {[32'h0 : 32'hFFFF_FFFF]};
//   }
 
//  else {
//      MAC_TX_Data == 32'hBCBC_BCBC ;
//   }

// }




// //---------- MAC_DATAK_CONSTRAINT ---------
// constraint MAC_TX_DataK_32c {
//  if(Data_post != 32'hBCBC_BCBC) {
//     MAC_TX_DataK == 4'b1111; 
//   }
  
//   else {
//      MAC_TX_DataK == 4'b0000;
//   }
// }


// //------ MAC_DATA_En CONSTARINT------
// constraint MAC_Data_En_c {
//  MAC_Data_En dist {1'b1 :/ 95 , 1'b0:/ 5};
// }


//--------RXPOLARITY CONSTRAINT--------
 constraint RxPolarity_c {
  RxPolarity == 0 ;
}


function void post_randomize;
  Data_post = TX_P;
  count_16  = (count_16 + 1) % 3;
  count_8   = (count_8  + 1) % 5;  
endfunction 


//----------------------------------


constraint Tx_P_c_Training_sequence {
    TX_P != Data_post ;
}

endclass	
endpackage	