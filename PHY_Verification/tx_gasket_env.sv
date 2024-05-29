package tx_gasket_env_pkg;
 
 import uvm_pkg::*;
`include "uvm_macros.svh"
import my_config_db_pkg::*;


`define create(type , inst_name) type::type_id::create(inst_name,this);


/////////// SEQ_ITEM ///////////////////

class tx_gasket_seq_itm extends uvm_sequence_item;
    `uvm_object_utils(tx_gasket_seq_itm);

   logic                                 tx_gasket_PCLK                 ;
   logic                                 tx_gasket_Bit_Rate_CLK_10      ;
   logic                                 tx_gasket_Reset_n              ;
   logic  [5  : 0 ]                      tx_gasket_DataBusWidth         ;
   logic  [31 : 0 ]                      tx_gasket_MAC_TX_Data          ;
   logic  [3  : 0 ]                      tx_gasket_MAC_TX_DataK         ;
   logic                                 tx_gasket_MAC_Data_En          ; 
   logic                                 tx_gasket_TxDataK              ;
   logic  [7  : 0 ]                      tx_gasket_TxData               ;


    function new(string name = "tx_gasket_seq_itm");
      super.new(name);
    endfunction

endclass

/////////////////// MONITOR /////////////////////

class tx_gasket_mon extends uvm_monitor;
 `uvm_component_utils(tx_gasket_mon);

 uvm_analysis_port #(tx_gasket_seq_itm) mon_port;
 tx_gasket_seq_itm  data_to_send;
 virtual PASSIVE_if passive_vif;

   function new(string name = "tx_gasket_mon" , uvm_component parent = null);
     super.new(name,parent);
   endfunction  


   function void build_phase(uvm_phase phase);
     super.build_phase(phase);
      mon_port = new("mon_port" , this);
     `uvm_info("tx_gasket_mon","BUILD_PHASE",UVM_LOW);
   endfunction


   task run_phase(uvm_phase phase);
     super.run_phase(phase);

     forever begin
        data_to_send = `create(tx_gasket_seq_itm, "data_to_send");
       @(negedge  passive_vif.tx_gasket_Bit_Rate_CLK_10);
       data_to_send.tx_gasket_TxData = passive_vif.tx_gasket_TxData;
       data_to_send.tx_gasket_Bit_Rate_CLK_10 = passive_vif.tx_gasket_Bit_Rate_CLK_10;

       mon_port.write(data_to_send);
     end

   endtask
 
endclass


///////////////// SB ////////////////////////

class tx_gasket_sb extends uvm_scoreboard;

 `uvm_component_utils(tx_gasket_sb);

 uvm_analysis_export #(tx_gasket_seq_itm)  sb_export;
 tx_gasket_seq_itm  data_to_chk;
 uvm_tlm_analysis_fifo #(tx_gasket_seq_itm)  sb_fifo;
 
  virtual PASSIVE_if passive_vif;


   function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      sb_export.connect(sb_fifo.analysis_export);
    endfunction


   function new(string name = "tx_gasket_sb" , uvm_component parent = null);
     super.new(name,parent);
   endfunction  


   function void build_phase(uvm_phase phase);
     super.build_phase(phase);
      
      sb_export    = new("sb_export" , this);
      sb_fifo       = new("sb_fifo", this);      
      data_to_chk = `create(tx_gasket_seq_itm, "data_to_chk");

      if (!uvm_config_db#(virtual PASSIVE_if)::get(this, "" , "passive_if" , passive_vif)) begin
          `uvm_fatal("TX_GASKET", "FATAL GETTING tx_pma_if");
      end

     `uvm_info("tx_gasket_sb","BUILD_PHASE",UVM_LOW);
   endfunction


   task run_phase(uvm_phase phase);
     super.run_phase(phase);
     forever begin
      @(posedge passive_vif.tx_gasket_Bit_Rate_CLK_10);
      sb_fifo.get(data_to_chk);
      `uvm_info("TX_GASKET_SCOREBOARD", $sformatf("OUT_DATA = %h", data_to_chk.tx_gasket_TxData), UVM_LOW);             
     end
   endtask 

endclass



//////////////////// AGENT ///////////////////////

class tx_gasket_agt extends uvm_agent;
 `uvm_component_utils(tx_gasket_agt);

 tx_gasket_config_db tx_gasket_cfg;
 tx_gasket_mon mon;

  uvm_analysis_port #(tx_gasket_seq_itm) agt_port;

   function new(string name = "tx_gasket_agt" , uvm_component parent = null);
     super.new(name,parent);
   endfunction  


   function void build_phase(uvm_phase phase);
     super.build_phase(phase);

     agt_port = new("agt_port" , this);
     mon = `create(tx_gasket_mon , "mon");

     tx_gasket_cfg = `create(tx_gasket_config_db, "tx_gasket_cfg");

     if(!uvm_config_db#(tx_gasket_config_db)::get(this,"","TX_GASKET_CFG",tx_gasket_cfg)) begin
          `uvm_fatal("tx_gasket_agt", "FATAL GETTING TX_GASKET_CFG");        
     end

     `uvm_info("tx_gasket_agt","BUILD_PHASE",UVM_LOW);
   endfunction

   
   function void connect_phase(uvm_phase phase);
     super.connect_phase(phase);
     mon.mon_port.connect(agt_port);
     mon.passive_vif = tx_gasket_cfg.passive_vif;
   endfunction
 
endclass


////////////////// ENV /////////////////////////

 class tx_gasket_env extends uvm_env;
    `uvm_component_utils(tx_gasket_env);
   
  tx_gasket_agt agt;
  tx_gasket_sb  sb;


   function new(string name = "tx_gasket_env" , uvm_component parent = null);
     super.new(name,parent);
   endfunction  


   function void build_phase(uvm_phase phase);
   	 super.build_phase(phase);
     
     agt = `create(tx_gasket_agt,"agt");
     sb  = `create(tx_gasket_sb,"sb");

     `uvm_info("tx_gasket_env","BUILD_PHASE",UVM_LOW);
   endfunction


   function void connect_phase(uvm_phase phase);
     super.connect_phase(phase);
      agt.agt_port.connect(sb.sb_export);
   endfunction
 
 endclass
	

///////////////////////////////////////

endpackage