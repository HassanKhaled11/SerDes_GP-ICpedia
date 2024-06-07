package ebuffer_env_pkg;
 
 import uvm_pkg::*;
`include "uvm_macros.svh"
import my_config_db_pkg::*;


`define create(type , inst_name) type::type_id::create(inst_name,this);



/////////// SEQ_ITEM ///////////////////

class ebuffer_seq_itm extends uvm_sequence_item;
    `uvm_object_utils(ebuffer_seq_itm);


  logic                                 ebuffer_write_clk            ;
  logic                                 ebuffer_read_clk             ;
  logic [10:0]                          ebuffer_data_in              ;
  logic                                 ebuffer_rst_n                ;
  logic                                 ebuffer_skp_added            ;
  logic                                 ebuffer_Skp_Removed          ;
  logic                                 ebuffer_overflow             ;
  logic                                 ebuffer_underflow            ;
  logic [10:0]                          ebuffer_data_out             ;



    function new(string name = "ebuffer_seq_itm");
      super.new(name);
    endfunction

endclass

/////////////////// MONITOR /////////////////////

class ebuffer_mon extends uvm_monitor;
 `uvm_component_utils(ebuffer_mon);

 uvm_analysis_port #(ebuffer_seq_itm) mon_port;
 ebuffer_seq_itm  data_to_send;
 virtual PASSIVE_if passive_vif;


   function new(string name = "ebuffer_mon" , uvm_component parent = null);
     super.new(name,parent);
   endfunction  


   function void build_phase(uvm_phase phase);
     super.build_phase(phase);
      mon_port = new("mon_port" , this);
    // `uvm_info("ebuffer_mon","BUILD_PHASE",UVM_LOW);
   endfunction
 

   task run_phase(uvm_phase phase);
     super.run_phase(phase);

     forever begin
       data_to_send = `create(ebuffer_seq_itm, "data_to_send");
       @(negedge  passive_vif.ebuffer_read_clk);
       data_to_send.ebuffer_data_out = passive_vif.ebuffer_data_out;
       data_to_send.ebuffer_overflow = passive_vif.ebuffer_overflow;
       data_to_send.ebuffer_underflow = passive_vif.ebuffer_underflow;
       data_to_send.ebuffer_skp_added = passive_vif.ebuffer_skp_added;
       data_to_send.ebuffer_Skp_Removed = passive_vif.ebuffer_Skp_Removed;

       mon_port.write(data_to_send);
     end

   endtask


endclass


///////////////// SB ////////////////////////

class ebuffer_sb extends uvm_scoreboard;

 `uvm_component_utils(ebuffer_sb);

 uvm_analysis_export #(ebuffer_seq_itm)  sb_export;
 ebuffer_seq_itm  data_to_chk;
  uvm_tlm_analysis_fifo #(ebuffer_seq_itm)  sb_fifo;

  virtual PASSIVE_if passive_vif;


   function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      sb_export.connect(sb_fifo.analysis_export);
    endfunction


   function new(string name = "ebuffer_sb" , uvm_component parent = null);
     super.new(name,parent);
   endfunction  


   function void build_phase(uvm_phase phase);
     super.build_phase(phase);
      
      sb_export    = new("sb_export" , this);
      sb_fifo       = new("sb_fifo", this);      
      data_to_chk  = new("data_to_chk");

    if (!uvm_config_db#(virtual PASSIVE_if)::get(this, "" , "passive_if" , passive_vif)) begin
          `uvm_fatal("EBUFFER", "FATAL GETTING intf");
    end

     //`uvm_info("ebuffer_sb","BUILD_PHASE",UVM_LOW);
   endfunction


   task run_phase(uvm_phase phase);
     super.run_phase(phase);
     forever begin
      @(posedge passive_vif.ebuffer_read_clk);
      sb_fifo.get(data_to_chk);
     // `uvm_info("EBUFFER_SCOREBOARD", $sformatf("OUT_DATA = %h", data_to_chk.ebuffer_data_out), UVM_LOW);             
     end
   endtask 

endclass


///////////////// Coverage ////////////////////////


class ebuffer_cov extends uvm_component;

 `uvm_component_utils(ebuffer_cov);

 uvm_analysis_export #(ebuffer_seq_itm)  cov_export;
 ebuffer_seq_itm  data_to_chk;
 uvm_tlm_analysis_fifo #(ebuffer_seq_itm)  cov_fifo;
 
 virtual PASSIVE_if passive_vif;



covergroup ebuffer_cg();
ebuffer_dout: coverpoint data_to_chk.ebuffer_data_out;
ebuffer_overflow: coverpoint data_to_chk.ebuffer_overflow;
ebuffer_underflow:coverpoint data_to_chk.ebuffer_underflow;
ebuffer_skp_added:coverpoint data_to_chk.ebuffer_skp_added;
ebuffer_Skp_Removed:coverpoint data_to_chk.ebuffer_Skp_Removed;
endgroup



   function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      cov_export.connect(cov_fifo.analysis_export);
    endfunction



   function void build_phase(uvm_phase phase);
     super.build_phase(phase);
      
      cov_export     = new("cov_export" , this);
      cov_fifo       = new("cov_fifo", this);      
      data_to_chk    = `create(ebuffer_seq_itm, "data_to_chk");

      if (!uvm_config_db#(virtual PASSIVE_if)::get(this, "" , "passive_if" , passive_vif)) begin
          `uvm_fatal("TX_PMA", "FATAL GETTING if");
      end

     //`uvm_info("ebuffer_cov","BUILD_PHASE",UVM_LOW);
   endfunction


   function new(string name = "ebuffer_cov" , uvm_component parent = null);
     super.new(name,parent);
     ebuffer_cg = new();
   endfunction  


   task run_phase(uvm_phase phase);
     super.run_phase(phase);
     forever begin
      @(posedge passive_vif.ebuffer_read_clk);
      cov_fifo.get(data_to_chk);
      ebuffer_cg.sample();
      //`uvm_info("ebuffer_COVERAGE", "", UVM_LOW);             
     end
   endtask 

endclass


//////////////////// AGENT ///////////////////////

class ebuffer_agt extends uvm_agent;

 `uvm_component_utils(ebuffer_agt);

 ebuffer_config_db  ebuffer_cfg;
 ebuffer_mon mon;

  uvm_analysis_port #(ebuffer_seq_itm) agt_port;

   function new(string name = "ebuffer_agt" , uvm_component parent = null);
     super.new(name,parent);
   endfunction  


   function void build_phase(uvm_phase phase);
     super.build_phase(phase);

     agt_port = new("agt_port" , this);
     mon = `create(ebuffer_mon , "mon");

     ebuffer_cfg = `create(ebuffer_config_db, "ebuffer_cfg");

    if(!uvm_config_db#(ebuffer_config_db)::get(this,"","EBUFFER_CFG",ebuffer_cfg)) begin
          `uvm_fatal("ebuffer_agt", "FATAL GETTING CFG");        
    end

     //`uvm_info("ebuffer_agt","BUILD_PHASE",UVM_LOW);
   endfunction

   
   function void connect_phase(uvm_phase phase);
     super.connect_phase(phase);
     mon.mon_port.connect(agt_port);
     mon.passive_vif = ebuffer_cfg.passive_vif;
   endfunction
 
endclass


////////////////// ENV /////////////////////////

 class ebuffer_env extends uvm_env;
    `uvm_component_utils(ebuffer_env);
   
  ebuffer_agt agt;
  ebuffer_sb  sb;
  ebuffer_cov cov;

   function new(string name = "ebuffer_env" , uvm_component parent = null);
     super.new(name,parent);
   endfunction  


   function void build_phase(uvm_phase phase);
     super.build_phase(phase);
     
     agt = `create(ebuffer_agt,"agt");
     sb  = `create(ebuffer_sb,"sb");
     cov = `create(ebuffer_cov,"cov");

     //`uvm_info("ebuffer_env","BUILD_PHASE",UVM_LOW);
   endfunction


   function void connect_phase(uvm_phase phase);
     super.connect_phase(phase);
      agt.agt_port.connect(sb.sb_export);
      agt.agt_port.connect(cov.cov_export);
   endfunction
 
 endclass

endpackage