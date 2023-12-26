package my_sequence_item_pkg;

import uvm_pkg::*;
`include "uvm_macros.svh"
import PARAMETERS_PKG::*;


class my_sequence_item extends uvm_sequence_item;

`uvm_object_utils(my_sequence_item);

// logic [9:0] Walking_Ones_arr [9:0];
e_WALKING_ONES Walking_Ones_ ;
int i , i_post ;

function new(string name = "my_sequence_item");
	super.new(name);
	// Walking_Ones_arr = '{10'h001,10'h200,10'h100,10'h080,10'h040,10'h020,10'h010,10'h008,10'h004,10'h002};
      Walking_Ones_ = Walking_Ones_.first();
      i_post = 0 ;
      i = 0 ;
endfunction

 bit write_enable_post;

 rand logic [9:0] data_in;
 rand logic rst_n;
 rand logic buffer_mode;                      //0:nominal half full ,1:nominal empty buffer
 rand logic write_enable;
 rand logic read_enable;
 
 logic skp_added;
 logic Skp_Removed;
 logic overflow, underflow;
 logic [9:0] data_out;



// constraint data_in_Walking_Ones {
// 	// data_in inside {Walking_Ones_arr};
//        data_in == Walking_Ones_.next;
// }

constraint rst_n_c {
 rst_n dist {1 := 98 , 0:= 2};
}
 

constraint buffer_nomhalf_mode_c {
  buffer_mode == 0;
}


constraint buffer_nomempty_mode_c {
  buffer_mode == 1;
}


constraint writeOnly_en_mode_c {
   write_enable == 1;
   read_enable  == 0;	
}

constraint readOnly_en_mode_c {
  read_enable  == 1 ;
  write_enable == 0 ;	
}


constraint Toggeling_Operation_c {
	if(write_enable_post) {
		 write_enable == 0;
		 read_enable == 1 ;
	  } 

    else {
          write_enable == 1;
          read_enable == 0 ;    	
    	}
}


function void post_randomize;
 write_enable_post = write_enable ;
 i_post = i ;	
endfunction

endclass	
endpackage	