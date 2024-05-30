package cdr_env_pkg;
 
 import uvm_pkg::*;
`include "uvm_macros.svh"
import my_config_db_pkg::*;


`define create(type , inst_name) type::type_id::create(inst_name,this);


/////////// SEQ_ITEM ///////////////////

class cdr_seq_itm extends uvm_sequence_item;
    `uvm_object_utils(cdr_seq_itm);


  logic                                 cdr_rst_n                   ;  
  logic                                 cdr_clk_0                   ;
  logic                                 cdr_clk_data                ;  
  logic                                 cdr_Din                     ;
  logic                                 cdr_PI_Clk                  ;
  logic                                 cdr_Dout                    ;
  //...internal 
  logic [10:0]                          cdr_code                    ;


    function new(string name = "cdr_seq_itm");
      super.new(name);
    endfunction

endclass

/////////////////// MONITOR /////////////////////

class cdr_mon extends uvm_monitor;
 `uvm_component_utils(cdr_mon);

 uvm_analysis_port #(cdr_seq_itm) mon_port;
 cdr_seq_itm  data_to_send;
 virtual PASSIVE_if passive_vif;


   function new(string name = "cdr_mon" , uvm_component parent = null);
     super.new(name,parent);
   endfunction  


   function void build_phase(uvm_phase phase);
     super.build_phase(phase);
      mon_port = new("mon_port" , this);
     `uvm_info("cdr_mon","BUILD_PHASE",UVM_LOW);
   endfunction
 

   task run_phase(uvm_phase phase);
     super.run_phase(phase);

     forever begin
       data_to_send = `create(cdr_seq_itm, "data_to_send");
       @(negedge  passive_vif.cdr_clk_0);
       data_to_send.cdr_Dout = passive_vif.cdr_Dout;
       data_to_send.cdr_code = passive_vif.cdr_code;

       mon_port.write(data_to_send);
     end

   endtask


endclass


///////////////// SB ////////////////////////

class cdr_sb extends uvm_scoreboard;

 `uvm_component_utils(cdr_sb);

 uvm_analysis_export #(cdr_seq_itm)  sb_export;
 cdr_seq_itm  data_to_chk;
 uvm_tlm_analysis_fifo #(cdr_seq_itm)  sb_fifo;

  virtual PASSIVE_if passive_vif;


   function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      sb_export.connect(sb_fifo.analysis_export);
    endfunction


   function new(string name = "cdr_sb" , uvm_component parent = null);
     super.new(name,parent);
   endfunction  


   function void build_phase(uvm_phase phase);
     super.build_phase(phase);
      
      sb_export    = new("sb_export" , this);
      sb_fifo       = new("sb_fifo", this);      
      data_to_chk  = new("data_to_chk");

    if (!uvm_config_db#(virtual PASSIVE_if)::get(this, "" , "passive_if" , passive_vif)) begin
          `uvm_fatal("CDR", "FATAL GETTING intf");
      end

     `uvm_info("cdr_sb","BUILD_PHASE",UVM_LOW);
   endfunction


   task run_phase(uvm_phase phase);
     super.run_phase(phase);
     forever begin
      @(posedge passive_vif.cdr_clk_0);
      sb_fifo.get(data_to_chk);
      `uvm_info("CDR_SCOREBOARD", $sformatf("OUT_DATA = %h", data_to_chk.cdr_Dout), UVM_LOW);             
     end
   endtask 


endclass


///////////////// Coverage ////////////////////////


class cdr_cov extends uvm_component;

 `uvm_component_utils(cdr_cov);

 uvm_analysis_export #(cdr_seq_itm)  cov_export;
 cdr_seq_itm  data_to_chk;
 uvm_tlm_analysis_fifo #(cdr_seq_itm)  cov_fifo;
 
 virtual PASSIVE_if passive_vif;



covergroup cdr_cg();
cdr_code: coverpoint data_to_chk.cdr_code;
cdr_data: coverpoint data_to_chk.cdr_Dout; 
endgroup



   function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      cov_export.connect(cov_fifo.analysis_export);
    endfunction



   function void build_phase(uvm_phase phase);
     super.build_phase(phase);
      
      cov_export     = new("cov_export" , this);
      cov_fifo       = new("cov_fifo", this);      
      data_to_chk    = `create(cdr_seq_itm, "data_to_chk");

      if (!uvm_config_db#(virtual PASSIVE_if)::get(this, "" , "passive_if" , passive_vif)) begin
          `uvm_fatal("TX_PMA", "FATAL GETTING if");
      end

     `uvm_info("cdr_cov","BUILD_PHASE",UVM_LOW);
   endfunction


   function new(string name = "cdr_cov" , uvm_component parent = null);
     super.new(name,parent);
     cdr_cg = new();
   endfunction  


   task run_phase(uvm_phase phase);
     super.run_phase(phase);
     forever begin
      @(posedge passive_vif.cdr_clk_0);
      cov_fifo.get(data_to_chk);
      cdr_cg.sample();
      `uvm_info("cdr_COVERAGE", "", UVM_LOW);             
     end
   endtask 

endclass



//////////////////// AGENT ///////////////////////

class cdr_agt extends uvm_agent;

 `uvm_component_utils(cdr_agt);

 cdr_config_db  cdr_cfg;
 cdr_mon mon;

  uvm_analysis_port #(cdr_seq_itm) agt_port;

   function new(string name = "cdr_agt" , uvm_component parent = null);
     super.new(name,parent);
   endfunction  


   function void build_phase(uvm_phase phase);
     super.build_phase(phase);

     agt_port = new("agt_port" , this);
     mon = `create(cdr_mon , "mon");

     cdr_cfg = `create(cdr_config_db, "cdr_cfg");

   if(!uvm_config_db#(cdr_config_db)::get(this,"","CDR_CFG",cdr_cfg)) begin
          `uvm_fatal("cdr_agt", "FATAL GETTING CFG");        
    end

     `uvm_info("cdr_agt","BUILD_PHASE",UVM_LOW);
   endfunction

   
   function void connect_phase(uvm_phase phase);
     super.connect_phase(phase);
     mon.mon_port.connect(agt_port);
     mon.passive_vif = cdr_cfg.passive_vif;
   endfunction
 
endclass


////////////////// ENV /////////////////////////

 class cdr_env extends uvm_env;
    `uvm_component_utils(cdr_env);
   
  cdr_agt agt;
  cdr_sb  sb;
  cdr_cov cov;

   function new(string name = "cdr_env" , uvm_component parent = null);
     super.new(name,parent);
   endfunction  


   function void build_phase(uvm_phase phase);
     super.build_phase(phase);
     
     agt = `create(cdr_agt,"agt");
     sb  = `create(cdr_sb,"sb");
     cov = `create(cdr_cov,"cov");

     `uvm_info("cdr_env","BUILD_PHASE",UVM_LOW);
   endfunction


   function void connect_phase(uvm_phase phase);
     super.connect_phase(phase);
      agt.agt_port.connect(sb.sb_export);
      agt.agt_port.connect(cov.cov_export);
   endfunction
 
 endclass
	
endpackage