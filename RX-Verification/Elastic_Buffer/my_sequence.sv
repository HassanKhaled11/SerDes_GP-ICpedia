package my_sequence_pkg;

import uvm_pkg::*;
`include "uvm_macros.svh"

import my_sequence_item_pkg::*;
import PARAMETERS_PKG::*;


class my_sequence extends uvm_sequence #(my_sequence_item);

`uvm_object_utils(my_sequence);

my_sequence_item stim_seq_item ;

e_WALKING_ONES Walking_Ones_ ;



function new(string name = "my_sequence");
	super.new(name);
	 `uvm_info("MY_SEQUENCE","SEQ CREATED",UVM_MEDIUM);
	 Walking_Ones_ = Walking_Ones_.first();
endfunction


task body();

	  stim_seq_item = my_sequence_item :: type_id :: create("stim_seq_item");
	  // `uvm_info("MY_SEQUENCE","BEFORE START ITEM",UVM_MEDIUM);

`uvm_info("MY_SEQUENCE" , "///////// RESET SEQUENCE //////",UVM_MEDIUM);
   
    repeat(10) begin
     start_item(stim_seq_item);
     stim_seq_item.rst_n       = 0; 
     stim_seq_item.data_in     = 0;
     stim_seq_item.buffer_mode = 0 ;
     stim_seq_item.write_enable= 0 ;
     stim_seq_item.read_enable = 0 ;

     finish_item(stim_seq_item);
     get_response(stim_seq_item);    	
    end


//--------------- SEQUENCE WRITE WALKING ONES ----------------


`uvm_info("MY_SEQUENCE" , "///////// WALKING ONES SEQUENCE //////",UVM_MEDIUM);

	repeat(10) begin

     start_item(stim_seq_item);
     stim_seq_item.rst_n       = 1;
     Walking_Ones_ = Walking_Ones_.next(); 
     stim_seq_item.data_in     = Walking_Ones_;
     stim_seq_item.buffer_mode = 0 ;
     stim_seq_item.write_enable= 1 ;
     stim_seq_item.read_enable = 0 ;

      finish_item(stim_seq_item);
      get_response(stim_seq_item);
	end

//--------------- SEQUENCE READ WALKING ONES ----------------

`uvm_info("MY_SEQUENCE" , "///////// RWALKING ONES SEQUENCE //////",UVM_MEDIUM);
     
     stim_seq_item.Toggeling_Operation_c.constraint_mode(0) ;     
     stim_seq_item.writeOnly_en_mode_c.constraint_mode(0)   ;
     stim_seq_item.readOnly_en_mode_c.constraint_mode(1)    ;
     stim_seq_item.buffer_nomhalf_mode_c.constraint_mode(1) ;
     stim_seq_item.buffer_nomempty_mode_c.constraint_mode(0);

     repeat(10) begin

     start_item(stim_seq_item);
     stim_seq_item.rst_n       = 1;
     stim_seq_item.data_in     = Walking_Ones_.next();
     stim_seq_item.buffer_mode = 0 ;
     stim_seq_item.write_enable= 0 ;
     stim_seq_item.read_enable = 1 ;     
     finish_item(stim_seq_item);

     end


//--------------- SEQUENCE WRITE TESTING OVERFLOW ----------------

`uvm_info("MY_SEQUENCE" , "///////// OVERFLOW SEQUENCE //////",UVM_MEDIUM);
     
     stim_seq_item.Toggeling_Operation_c.constraint_mode(0) ;
     stim_seq_item.writeOnly_en_mode_c.constraint_mode(1)   ;
     stim_seq_item.readOnly_en_mode_c.constraint_mode(0)    ;
     stim_seq_item.buffer_nomhalf_mode_c.constraint_mode(1) ;
     stim_seq_item.buffer_nomempty_mode_c.constraint_mode(0);

     repeat(16) begin

      start_item(stim_seq_item);
     assert(stim_seq_item.randomize());
     finish_item(stim_seq_item);

     end


//--------------- SEQUENCE READ TESTING UNDERFLOW ----------------
     
    `uvm_info("MY_SEQUENCE" , "///////// UNDERFLOW SEQUENCE //////",UVM_MEDIUM);


     stim_seq_item.Toggeling_Operation_c.constraint_mode(0) ;
     stim_seq_item.writeOnly_en_mode_c.constraint_mode(0)   ;
     stim_seq_item.readOnly_en_mode_c.constraint_mode(1)    ;
     stim_seq_item.buffer_nomhalf_mode_c.constraint_mode(1) ;
     stim_seq_item.buffer_nomempty_mode_c.constraint_mode(0);

     repeat(16) begin
      start_item(stim_seq_item);
      assert(stim_seq_item.randomize());
      finish_item(stim_seq_item);
     end


      repeat(5) begin
      start_item(stim_seq_item);
     
      stim_seq_item.rst_n       = 0;
      stim_seq_item.data_in     = 10;
      stim_seq_item.buffer_mode = 0 ;
      stim_seq_item.write_enable= 0 ;
      stim_seq_item.read_enable = 1 ;         
     
      finish_item(stim_seq_item);
      end


       

//--------------- SEQUENCE TOGGELING WRITE AND READ ----------------

    `uvm_info("MY_SEQUENCE" , "///////// TOGGLING SEQUENCE //////",UVM_MEDIUM);


     stim_seq_item.Toggeling_Operation_c.constraint_mode(1) ;
     stim_seq_item.writeOnly_en_mode_c.constraint_mode(0)   ;
     stim_seq_item.readOnly_en_mode_c.constraint_mode(0)    ;
     stim_seq_item.buffer_nomhalf_mode_c.constraint_mode(1) ;
     stim_seq_item.buffer_nomempty_mode_c.constraint_mode(0);
     

     repeat(1000) begin
      start_item(stim_seq_item);
      assert(stim_seq_item.randomize());
      finish_item(stim_seq_item);
     end




//--------------- SEQUENCE READ TESTING UNDERFLOW ----------------


    `uvm_info("MY_SEQUENCE" , "///////// UNDERFLOW SEQUENCE //////",UVM_MEDIUM);


     stim_seq_item.Toggeling_Operation_c.constraint_mode(0) ;
     stim_seq_item.writeOnly_en_mode_c.constraint_mode(0)   ;
     stim_seq_item.readOnly_en_mode_c.constraint_mode(1)    ;
     stim_seq_item.buffer_nomhalf_mode_c.constraint_mode(1) ;
     stim_seq_item.buffer_nomempty_mode_c.constraint_mode(0);

     repeat(16) begin
      start_item(stim_seq_item);
      assert(stim_seq_item.randomize());
      finish_item(stim_seq_item);
     end


      repeat(8) begin
      start_item(stim_seq_item);
     
      stim_seq_item.rst_n       = 0;
      stim_seq_item.data_in     = 10;
      stim_seq_item.buffer_mode = 0 ;
      stim_seq_item.write_enable= 0 ;
      stim_seq_item.read_enable = 1 ;         
     
      finish_item(stim_seq_item);
      end


endtask


endclass


endpackage	