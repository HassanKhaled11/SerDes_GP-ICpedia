package my_sequence_item_pkg;

import uvm_pkg::*;
`include "uvm_macros.svh"


class my_sequence_item extends uvm_sequence_item;

`uvm_object_utils(my_sequence_item);

logic [3:0] CommandK_Arr [3:0];


  //////// INPUTS //////////

 // rand logic                     Reset_n          ;
 //logic         [5  : 0 ]         DataBusWidth     ;
 rand logic         [31 : 0 ]      MAC_TX_Data      ;
 rand logic         [3  : 0 ]      MAC_TX_DataK     ;
 rand logic                        MAC_Data_En      ;
 rand logic                        RxPolarity       ;

 
  
  ///////// OUTPUTS ///////// 

 logic         [31 : 0 ]      Rx_Data          ;
 logic                        Rx_DataK         ;
 logic         [2  : 0 ]      Rx_Status        ; 
 logic                        Rx_Valid         ;
 logic                        PCLK             ; 

 //////// Helpers ////////////
 logic [3:0]  randomK ;
 // logic [7:0] Data_post;
 logic [31:0] Data_post;

function new(string name = "my_sequence_item");
	super.new(name);
   CommandK_Arr = '{4'b0001 , 4'b0010 , 4'b0100 , 4'b1000};
   Data_post = 0 ;
   //randomK = 0;
endfunction



// constraint randomK_c {
//   randomK inside {1,2,4,8};
// }


//-------- DATA WIDTH CONSTRAINT -----
// constraint DataBusWidth32_c {                 //One @ a time
// 	DataBusWidth == 6'd32;
// }

// constraint DataBusWidth16_c {
//   DataBusWidth == 6'd16;
// }

// constraint DataBusWidth8_c {
//   DataBusWidth == 6'd8;
// }


// //---------- MAC_DATAK_CONSTRAINT ----
// constraint MAC_TX_Data_c {
//  MAC_TX_Data[15:8 ] inside {[24'h0 : 24'hFFFFFF]};
//  MAC_TX_Data[31:24] inside {[24'h0 : 24'hFFFFFF]};
// }


// constraint MAC_TX_Data_CommaByte_c {
//  // if(Data_post == 32'hBC) {  
//  //     MAC_TX_Data[7:0]   inside {[0:8'hFF]};
//  //     MAC_TX_Data[23:16] inside {[0:8'hFF]};
//  //  }

//   //else {
//      MAC_TX_Data[7:0]   == 8'hBC;
//      MAC_TX_Data[23:16] == 8'hBC;
//   //}
// }


// //---------- MAC_DATAK_CONSTRAINT ----
// constraint MAC_TX_DataK_c {
//  //if(Data_post != 8'hBC ) {
//     MAC_TX_DataK == 4'b0101; 
//  // }
  
//   // else {
//   //   MAC_TX_DataK dist {4'd0 :/ 95 , 1:/ 4'd1};
//   // }
// }
 

// //------ MAC_DATA_En CONSTARINT------
// constraint MAC_Data_En_c {
//  MAC_Data_En dist {1'b1 :/ 95 , 1'b0:/ 5};
// }




//---------- MAC_DATAK_CONSTRAINT ----
constraint MAC_TX_Data_c {
 if(Data_post == 32'hBCBC_BCBC) {
     MAC_TX_Data inside {[32'h0 : 32'hFFFF_FFFF]};
  }
 
 else {
     MAC_TX_Data == 32'hBCBC_BCBC ;
  }

}


// constraint MAC_TX_Data_CommaByte_c {
//  // if(Data_post == 32'hBC) {  
//  //     MAC_TX_Data[7:0]   inside {[0:8'hFF]};
//  //     MAC_TX_Data[23:16] inside {[0:8'hFF]};
//  //  }

//   //else {
//      MAC_TX_Data[7:0]   == 8'hBC;
//      MAC_TX_Data[23:16] == 8'hBC;
//   //}
// }


//---------- MAC_DATAK_CONSTRAINT ----
constraint MAC_TX_DataK_c {
 if(Data_post != 32'hBCBC_BCBC) {
    MAC_TX_DataK == 4'b1111; 
  }
  
  else {
     MAC_TX_DataK == 4'b0000;
  }
}
 

//------ MAC_DATA_En CONSTARINT------
constraint MAC_Data_En_c {
 MAC_Data_En dist {1'b1 :/ 95 , 1'b0:/ 5};
}


//--------RXPOLARITY CONSTRAINT--------
 constraint RxPolarity_c {
  RxPolarity == 0 ;
}


function void post_randomize;
  Data_post = MAC_TX_Data;
endfunction 


endclass	
endpackage	