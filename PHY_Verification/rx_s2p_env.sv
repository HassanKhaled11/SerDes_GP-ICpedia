package rx_s2p_env_pkg;
 
 import uvm_pkg::*;
`include "uvm_macros.svh"

`define create(type , inst_name) type::type_id::create(inst_name,this);


/////////// SEQ_ITEM ///////////////////

class rx_s2p_seq_itm extends uvm_sequence_item;
    `uvm_object_utils(rx_s2p_seq_itm);


    function new(string name = "rx_s2p_seq_itm");
      super.new(name);
    endfunction

endclass

/////////////////// MONITOR /////////////////////

class rx_s2p_mon extends uvm_monitor;
 `uvm_component_utils(rx_s2p_mon);

 uvm_analysis_port #(rx_s2p_seq_itm) mon_port;
 rx_s2p_seq_itm  data_to_send;


   function new(string name = "rx_s2p_mon" , uvm_component parent = null);
     super.new(name,parent);
   endfunction  


   function void build_phase(uvm_phase phase);
     super.build_phase(phase);
      mon_port = new("mon_port" , this);
      data_to_send = new("data_to_send");
     `uvm_info("rx_s2p_mon","BUILD_PHASE",UVM_LOW);
   endfunction
 
endclass


///////////////// SB ////////////////////////

class rx_s2p_sb extends uvm_scoreboard;

 `uvm_component_utils(rx_s2p_sb);

 uvm_analysis_export #(rx_s2p_seq_itm)  sb_export;
 rx_s2p_seq_itm  data_to_chk;
  uvm_tlm_analysis_fifo #(rx_s2p_seq_itm)  sb_fifo;



   function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      sb_export.connect(sb_fifo.analysis_export);
    endfunction


   function new(string name = "rx_s2p_sb" , uvm_component parent = null);
     super.new(name,parent);
   endfunction  


   function void build_phase(uvm_phase phase);
     super.build_phase(phase);
      
      sb_export    = new("sb_export" , this);
      sb_fifo       = new("sb_fifo", this);      
      data_to_chk  = new("data_to_chk");

     `uvm_info("rx_s2p_sb","BUILD_PHASE",UVM_LOW);
   endfunction


   task run_phase(uvm_phase phase);
     super.run_phase(phase);
      sb_fifo.get(data_to_chk);
   endtask 
endclass



//////////////////// AGENT ///////////////////////

class rx_s2p_agt extends uvm_agent;

 `uvm_component_utils(rx_s2p_agt);

 rx_s2p_mon mon;

  uvm_analysis_port #(rx_s2p_seq_itm) agt_port;

   function new(string name = "rx_s2p_agt" , uvm_component parent = null);
     super.new(name,parent);
   endfunction  


   function void build_phase(uvm_phase phase);
     super.build_phase(phase);

     agt_port = new("agt_port" , this);
     mon = `create(rx_s2p_mon , "mon");

     `uvm_info("rx_s2p_agt","BUILD_PHASE",UVM_LOW);
   endfunction

   
   function void connect_phase(uvm_phase phase);
     super.connect_phase(phase);
     mon.mon_port.connect(agt_port);
   endfunction
 
endclass


////////////////// ENV /////////////////////////

 class rx_s2p_env extends uvm_env;
    `uvm_component_utils(rx_s2p_env);
   
  rx_s2p_agt agt;
  rx_s2p_sb  sb;


   function new(string name = "rx_s2p_env" , uvm_component parent = null);
     super.new(name,parent);
   endfunction  


   function void build_phase(uvm_phase phase);
     super.build_phase(phase);
     
     agt = `create(rx_s2p_agt,"agt");
     sb  = `create(rx_s2p_sb,"sb");

     `uvm_info("rx_s2p_env","BUILD_PHASE",UVM_LOW);
   endfunction


   function void connect_phase(uvm_phase phase);
     super.connect_phase(phase);
      agt.agt_port.connect(sb.sb_export);
   endfunction
 
 endclass
	
endpackage