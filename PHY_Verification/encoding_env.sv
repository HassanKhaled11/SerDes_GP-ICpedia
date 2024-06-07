package encoding_env_pkg;
 
 import uvm_pkg::*;
`include "uvm_macros.svh"
import my_config_db_pkg::*;

`define create(type , inst_name) type::type_id::create(inst_name,this);


/////////// SEQ_ITEM ///////////////////

class encoding_seq_itm extends uvm_sequence_item;
    `uvm_object_utils(encoding_seq_itm);

  logic  [7:0]                          encoder_data                 ;
  logic                                 encoder_MAC_Data_En          ;
  logic                                 encoder_Bit_Rate_10          ;
  logic                                 encoder_Rst                  ;
  logic                                 encoder_TXDataK              ; 
  logic  [9:0]                          encoder_data_out             ;


    function new(string name = "encoding_seq_itm");
      super.new(name);
    endfunction

endclass

/////////////////// MONITOR /////////////////////

class encoding_mon extends uvm_monitor;
 `uvm_component_utils(encoding_mon);

 uvm_analysis_port #(encoding_seq_itm) mon_port;
 encoding_seq_itm  data_to_send;
 virtual PASSIVE_if passive_vif;


   function new(string name = "encoding_mon" , uvm_component parent = null);
     super.new(name,parent);
   endfunction  


   function void build_phase(uvm_phase phase);
     super.build_phase(phase);
      mon_port = new("mon_port" , this);
     //`uvm_info("encoding_mon","BUILD_PHASE",UVM_LOW);
   endfunction
 

   task run_phase(uvm_phase phase);
     super.run_phase(phase);

     forever begin
       data_to_send = `create(encoding_seq_itm, "data_to_send");
       @(negedge  passive_vif.encoder_Bit_Rate_10);
       data_to_send.encoder_data_out = passive_vif.encoder_data_out;
       data_to_send.encoder_TXDataK  = passive_vif.encoder_TXDataK;

       mon_port.write(data_to_send);
     end

   endtask

endclass


///////////////// SB ////////////////////////

class encoding_sb extends uvm_scoreboard;

 `uvm_component_utils(encoding_sb);

 uvm_analysis_export #(encoding_seq_itm)  sb_export;
 encoding_seq_itm  data_to_chk;
  uvm_tlm_analysis_fifo #(encoding_seq_itm)  sb_fifo;

  virtual PASSIVE_if passive_vif;


   function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      sb_export.connect(sb_fifo.analysis_export);
    endfunction


   function new(string name = "encoding_sb" , uvm_component parent = null);
     super.new(name,parent);
   endfunction  


   function void build_phase(uvm_phase phase);
     super.build_phase(phase);
      
      sb_export    = new("sb_export" , this);
      sb_fifo       = new("sb_fifo", this);      
      data_to_chk = `create(encoding_seq_itm, "data_to_chk");


     if (!uvm_config_db#(virtual PASSIVE_if)::get(this, "" , "passive_if" , passive_vif)) begin
          `uvm_fatal("ENCODING", "FATAL GETTING encoding_if");
      end


     //`uvm_info("encoding_sb","BUILD_PHASE",UVM_LOW);
   endfunction


   task run_phase(uvm_phase phase);
     super.run_phase(phase);
     forever begin
      @(posedge passive_vif.encoder_Bit_Rate_10);
      sb_fifo.get(data_to_chk);
    //  `uvm_info("ENCODING_SCOREBOARD", $sformatf("OUT_DATA = %h", data_to_chk.encoder_data_out), UVM_LOW);             
     end
   endtask 

endclass



//////////////////// AGENT ///////////////////////

class encoding_agt extends uvm_agent;

 `uvm_component_utils(encoding_agt);

 encoding_config_db encoding_cfg;
 encoding_mon mon;

  uvm_analysis_port #(encoding_seq_itm) agt_port;

   function new(string name = "encoding_agt" , uvm_component parent = null);
     super.new(name,parent);
   endfunction  


   function void build_phase(uvm_phase phase);
     super.build_phase(phase);

     agt_port = new("agt_port" , this);
     mon = `create(encoding_mon , "mon");

     encoding_cfg = `create(encoding_config_db,"encoding_cfg");

     if(!uvm_config_db#(encoding_config_db)::get(this,"","ENCODING_CFG",encoding_cfg)) begin
          `uvm_fatal("encoding_agt", "FATAL GETTING ENCODING_CFG");        
     end

     //`uvm_info("encoding_agt","BUILD_PHASE",UVM_LOW);
   endfunction

   
   function void connect_phase(uvm_phase phase);
     super.connect_phase(phase);
     mon.mon_port.connect(agt_port);
     mon.passive_vif = encoding_cfg.passive_vif;
   endfunction
 
endclass



///////////////// Coverage ////////////////////////


class encoding_cov extends uvm_component;

 `uvm_component_utils(encoding_cov);

 uvm_analysis_export #(encoding_seq_itm)  cov_export;
 encoding_seq_itm  data_to_chk;
 uvm_tlm_analysis_fifo #(encoding_seq_itm)  cov_fifo;
 
  virtual PASSIVE_if passive_vif;



covergroup encoding_cg();
  
data_out_cp: coverpoint data_to_chk.encoder_data_out;
txdatak_cp: coverpoint data_to_chk.encoder_TXDataK;

endgroup



   function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      cov_export.connect(cov_fifo.analysis_export);
    endfunction



   function void build_phase(uvm_phase phase);
     super.build_phase(phase);
      
      cov_export    = new("cov_export" , this);
      cov_fifo       = new("cov_fifo", this);      
      data_to_chk = `create(encoding_seq_itm, "data_to_chk");

      if (!uvm_config_db#(virtual PASSIVE_if)::get(this, "" , "passive_if" , passive_vif)) begin
          `uvm_fatal("ENCODING", "FATAL GETTING if");
      end

    // `uvm_info("encoding_cov","BUILD_PHASE",UVM_LOW);
   endfunction


   function new(string name = "encoding_cov" , uvm_component parent = null);
     super.new(name,parent);
     encoding_cg = new();
   endfunction  


   task run_phase(uvm_phase phase);
     super.run_phase(phase);
     forever begin
      @(posedge passive_vif.encoder_Bit_Rate_10);
      cov_fifo.get(data_to_chk);
      encoding_cg.sample();
     // `uvm_info("ENCODING_COVERAGE", "", UVM_LOW);             
     end
   endtask 

endclass



////////////////// ENV /////////////////////////

 class encoding_env extends uvm_env;
    `uvm_component_utils(encoding_env);
   
  encoding_agt agt;
  encoding_sb  sb;
  encoding_cov cov;

   function new(string name = "encoding_env" , uvm_component parent = null);
     super.new(name,parent);
   endfunction  


   function void build_phase(uvm_phase phase);
     super.build_phase(phase);
     
     agt = `create(encoding_agt,"agt");
     sb  = `create(encoding_sb,"sb");
     cov = `create(encoding_cov,"cov");

     //`uvm_info("encoding_env","BUILD_PHASE",UVM_LOW);
   endfunction


   function void connect_phase(uvm_phase phase);
     super.connect_phase(phase);
      agt.agt_port.connect(sb.sb_export);
      agt.agt_port.connect(cov.cov_export);
   endfunction
 
 endclass
  
endpackage