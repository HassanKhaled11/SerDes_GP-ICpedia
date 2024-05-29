package decoder_env_pkg;
 
 import uvm_pkg::*;
`include "uvm_macros.svh"

`define create(type , inst_name) type::type_id::create(inst_name,this);


/////////// SEQ_ITEM ///////////////////

class decoder_seq_itm extends uvm_sequence_item;
    `uvm_object_utils(decoder_seq_itm);


    function new(string name = "decoder_seq_itm");
      super.new(name);
    endfunction

endclass

/////////////////// MONITOR /////////////////////

class decoder_mon extends uvm_monitor;
 `uvm_component_utils(decoder_mon);

 uvm_analysis_port #(decoder_seq_itm) mon_port;
 decoder_seq_itm  data_to_send;


   function new(string name = "decoder_mon" , uvm_component parent = null);
     super.new(name,parent);
   endfunction  


   function void build_phase(uvm_phase phase);
     super.build_phase(phase);
      mon_port = new("mon_port" , this);
      data_to_send = new("data_to_send");
     `uvm_info("decoder_mon","BUILD_PHASE",UVM_LOW);
   endfunction
 
endclass


///////////////// SB ////////////////////////

class decoder_sb extends uvm_scoreboard;

 `uvm_component_utils(decoder_sb);

 uvm_analysis_export #(decoder_seq_itm)  sb_export;
 decoder_seq_itm  data_to_chk;
  uvm_tlm_analysis_fifo #(decoder_seq_itm)  sb_fifo;



   function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      sb_export.connect(sb_fifo.analysis_export);
    endfunction


   function new(string name = "decoder_sb" , uvm_component parent = null);
     super.new(name,parent);
   endfunction  


   function void build_phase(uvm_phase phase);
     super.build_phase(phase);
      
      sb_export    = new("sb_export" , this);
      sb_fifo       = new("sb_fifo", this);      
      data_to_chk  = new("data_to_chk");

     `uvm_info("decoder_sb","BUILD_PHASE",UVM_LOW);
   endfunction


   task run_phase(uvm_phase phase);
     super.run_phase(phase);
      sb_fifo.get(data_to_chk);
   endtask 
endclass



//////////////////// AGENT ///////////////////////

class decoder_agt extends uvm_agent;

 `uvm_component_utils(decoder_agt);

 decoder_mon mon;

  uvm_analysis_port #(decoder_seq_itm) agt_port;

   function new(string name = "decoder_agt" , uvm_component parent = null);
     super.new(name,parent);
   endfunction  


   function void build_phase(uvm_phase phase);
     super.build_phase(phase);

     agt_port = new("agt_port" , this);
     mon = `create(decoder_mon , "mon");

     `uvm_info("decoder_agt","BUILD_PHASE",UVM_LOW);
   endfunction

   
   function void connect_phase(uvm_phase phase);
     super.connect_phase(phase);
     mon.mon_port.connect(agt_port);
   endfunction
 
endclass


////////////////// ENV /////////////////////////

 class decoder_env extends uvm_env;
    `uvm_component_utils(decoder_env);
   
  decoder_agt agt;
  decoder_sb  sb;


   function new(string name = "decoder_env" , uvm_component parent = null);
     super.new(name,parent);
   endfunction  


   function void build_phase(uvm_phase phase);
     super.build_phase(phase);
     
     agt = `create(decoder_agt,"agt");
     sb  = `create(decoder_sb,"sb");

     `uvm_info("decoder_env","BUILD_PHASE",UVM_LOW);
   endfunction


   function void connect_phase(uvm_phase phase);
     super.connect_phase(phase);
      agt.agt_port.connect(sb.sb_export);
   endfunction
 
 endclass
endpackage