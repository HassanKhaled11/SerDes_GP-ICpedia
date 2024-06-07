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

class tx_gasket_mon extends uvm_monitor;              //REF MONITOR
 `uvm_component_utils(tx_gasket_mon);

 int counter;

 uvm_analysis_port #(tx_gasket_seq_itm) mon_port;
 tx_gasket_seq_itm  data_to_send;
 virtual PASSIVE_if passive_vif;

   function new(string name = "tx_gasket_mon" , uvm_component parent = null);
     super.new(name,parent);
   endfunction  


   function void build_phase(uvm_phase phase);
     super.build_phase(phase);
      mon_port = new("mon_port" , this);
      counter = 0;
     //`uvm_info("tx_gasket_mon","BUILD_PHASE",UVM_LOW);
   endfunction


   task run_phase(uvm_phase phase);
     super.run_phase(phase);
     
     forever begin
         @(posedge  passive_vif.tx_gasket_PCLK);
         data_to_send = `create(tx_gasket_seq_itm, "data_to_send");
         data_to_send.tx_gasket_MAC_TX_Data = passive_vif.tx_gasket_MAC_TX_Data;
                     `uvm_info("MON_REF", $sformatf("data= %h , time = %t", data_to_send.tx_gasket_MAC_TX_Data , $realtime() ), UVM_LOW);
         data_to_send.tx_gasket_Bit_Rate_CLK_10 = passive_vif.tx_gasket_Bit_Rate_CLK_10;
         data_to_send.tx_gasket_TxDataK = passive_vif.tx_gasket_TxDataK;
         mon_port.write(data_to_send);
     end

   endtask
 
endclass



class tx_gasket_mon_after extends uvm_monitor;              //OUTPUT MONITOR
 `uvm_component_utils(tx_gasket_mon_after);

 int counter;

 uvm_analysis_port #(tx_gasket_seq_itm) mon_port_aft;
 tx_gasket_seq_itm  data_to_send;
 virtual PASSIVE_if passive_vif;

   function new(string name = "tx_gasket_mon_after" , uvm_component parent = null);
     super.new(name,parent);
   endfunction  


   function void build_phase(uvm_phase phase);
     super.build_phase(phase);
      mon_port_aft = new("mon_port_aft" , this);
      counter = 0;
     //`uvm_info("tx_gasket_mon_after","BUILD_PHASE",UVM_LOW);
   endfunction


   task run_phase(uvm_phase phase);
     super.run_phase(phase);
     
     @(posedge  passive_vif.tx_gasket_PCLK);
     @(posedge passive_vif.tx_gasket_Bit_Rate_CLK_10);
     forever begin
         @(posedge  passive_vif.tx_gasket_Bit_Rate_CLK_10);
         data_to_send = `create(tx_gasket_seq_itm, "data_to_send");
         data_to_send.tx_gasket_TxData = passive_vif.tx_gasket_TxData;
                // `uvm_info("MON_AFTER", $sformatf("data= %h , time = %t", data_to_send.tx_gasket_TxData , $realtime() ), UVM_LOW);
         data_to_send.tx_gasket_TxDataK = passive_vif.tx_gasket_TxDataK;
         mon_port_aft.write(data_to_send);
     end

   endtask
 
endclass



///////////////// SB ////////////////////////

class tx_gasket_sb extends uvm_scoreboard;

 `uvm_component_utils(tx_gasket_sb);

 uvm_analysis_export #(tx_gasket_seq_itm)  sb_export;
 tx_gasket_seq_itm  data_to_chk;
 uvm_tlm_analysis_fifo #(tx_gasket_seq_itm)  sb_fifo;
 


 uvm_analysis_export #(tx_gasket_seq_itm)  sb_export_ref;
 tx_gasket_seq_itm  data_to_chk_ref;
 uvm_tlm_analysis_fifo #(tx_gasket_seq_itm)  sb_fifo_ref;

  virtual PASSIVE_if passive_vif;


  logic [31:0] expected_MAC_TX_DATA;
  logic [7:0] expected_TX_DATA;
  logic [31:0] actual_TX_DATA;

  tx_gasket_seq_itm data_to_chk_arr [4];
  int counter;

   function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      sb_export.connect(sb_fifo.analysis_export);
      sb_export_ref.connect(sb_fifo_ref.analysis_export);
    endfunction


   function new(string name = "tx_gasket_sb" , uvm_component parent = null);
     super.new(name,parent);
     counter = 0;
   endfunction  


   function void build_phase(uvm_phase phase);
     super.build_phase(phase);

      sb_export     = new("sb_export" , this);
      sb_fifo       = new("sb_fifo", this);      
      data_to_chk = `create(tx_gasket_seq_itm, "data_to_chk");


      // for (int i = 0; i < 4; i++) begin
      //   data_to_chk_arr[i] = `create(tx_gasket_seq_itm, $sformatf("data_to_chk_arr[%0d]", i));  //instantiate array
      // end

      sb_export_ref     = new("sb_export_ref" , this);
      sb_fifo_ref       = new("sb_fifo_ref", this);      
      data_to_chk_ref = `create(tx_gasket_seq_itm, "data_to_chk_ref");


      if (!uvm_config_db#(virtual PASSIVE_if)::get(this, "" , "passive_if" , passive_vif)) begin
          `uvm_fatal("TX_GASKET", "FATAL GETTING tx_pma_if");
      end

     //`uvm_info("tx_gasket_sb","BUILD_PHASE",UVM_LOW);
   endfunction




   task run_phase(uvm_phase phase);
     super.run_phase(phase);


    forever begin

       sb_fifo_ref.get(data_to_chk_ref);
       expected_MAC_TX_DATA = data_to_chk_ref.tx_gasket_MAC_TX_Data;
     
       
       sb_fifo.get(data_to_chk);
       actual_TX_DATA[7:0]  = data_to_chk.tx_gasket_TxData;


       sb_fifo.get(data_to_chk);
       actual_TX_DATA[15:8] = data_to_chk.tx_gasket_TxData;
      

       sb_fifo.get(data_to_chk);
       actual_TX_DATA[23:16] = data_to_chk.tx_gasket_TxData;
      

       sb_fifo.get(data_to_chk);
       actual_TX_DATA[31:24] = data_to_chk.tx_gasket_TxData;

      compare(expected_MAC_TX_DATA , actual_TX_DATA); 

  end

 endtask 

 function void compare(logic [31:0] expected_pkt , logic [31:0] actual_pkt);
   if(expected_pkt == actual_pkt) begin
     `uvm_info("TX_GASKET_DATA_TEST RIGHT", $sformatf("COLLECTED_DATA= %h , EXPECTED = %h", actual_pkt , expected_pkt), UVM_LOW);
   end

   else begin
     `uvm_info("TX_GASKET_DATA_TEST WRONG", $sformatf("COLLECTED_DATA= %h , EXPECTED = %h", actual_pkt , expected_pkt), UVM_LOW);
   end
 endfunction


endclass


///////////////// Coverage ////////////////////////


class tx_gasket_cov extends uvm_component;

 `uvm_component_utils(tx_gasket_cov);

 uvm_analysis_export #(tx_gasket_seq_itm)  cov_export;
 tx_gasket_seq_itm  data_to_chk;
 uvm_tlm_analysis_fifo #(tx_gasket_seq_itm)  cov_fifo;
 
  virtual PASSIVE_if passive_vif;



covergroup tx_gasket_cg();
  
  txdata_cp: coverpoint data_to_chk.tx_gasket_TxData;
  txdatak: coverpoint data_to_chk.tx_gasket_TxDataK;

endgroup



   function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      cov_export.connect(cov_fifo.analysis_export);
    endfunction



   function void build_phase(uvm_phase phase);
     super.build_phase(phase);
      
      cov_export    = new("cov_export" , this);
      cov_fifo       = new("cov_fifo", this);      
      data_to_chk = `create(tx_gasket_seq_itm, "data_to_chk");

      if (!uvm_config_db#(virtual PASSIVE_if)::get(this, "" , "passive_if" , passive_vif)) begin
          `uvm_fatal("TX_GASKET", "FATAL GETTING tx_pma_if");
      end

     //`uvm_info("tx_gasket_cov","BUILD_PHASE",UVM_LOW);
   endfunction


   function new(string name = "tx_gasket_cov" , uvm_component parent = null);
     super.new(name,parent);
     tx_gasket_cg = new();
   endfunction  


   task run_phase(uvm_phase phase);
     super.run_phase(phase);
     forever begin
      @(posedge passive_vif.tx_gasket_Bit_Rate_CLK_10);
      cov_fifo.get(data_to_chk);
      tx_gasket_cg.sample();
      //`uvm_info("TX_GASKET_COVERAGE", "", UVM_LOW);             
     end
   endtask 

endclass


//////////////////// AGENT ///////////////////////

class tx_gasket_agt extends uvm_agent;
 `uvm_component_utils(tx_gasket_agt);

 tx_gasket_config_db tx_gasket_cfg;
 tx_gasket_mon mon;
 tx_gasket_mon_after mon_aft;

  uvm_analysis_port #(tx_gasket_seq_itm) agt_port;
  uvm_analysis_port #(tx_gasket_seq_itm) agt_port_aft;

   function new(string name = "tx_gasket_agt" , uvm_component parent = null);
     super.new(name,parent);
   endfunction  


   function void build_phase(uvm_phase phase);
     super.build_phase(phase);

     agt_port = new("agt_port" , this);
     agt_port_aft = new("agt_port_aft" , this);

     mon = `create(tx_gasket_mon , "mon");
     mon_aft = `create(tx_gasket_mon_after , "mon_aft");


     tx_gasket_cfg = `create(tx_gasket_config_db, "tx_gasket_cfg");

     if(!uvm_config_db#(tx_gasket_config_db)::get(this,"","TX_GASKET_CFG",tx_gasket_cfg)) begin
          `uvm_fatal("tx_gasket_agt", "FATAL GETTING TX_GASKET_CFG");        
     end

     //`uvm_info("tx_gasket_agt","BUILD_PHASE",UVM_LOW);
   endfunction

   
   function void connect_phase(uvm_phase phase);
     super.connect_phase(phase);
     mon.passive_vif = tx_gasket_cfg.passive_vif;
     mon_aft.passive_vif = tx_gasket_cfg.passive_vif;
     mon.mon_port.connect(agt_port);
     mon_aft.mon_port_aft.connect(agt_port_aft);
   endfunction
 
endclass


////////////////// ENV /////////////////////////

 class tx_gasket_env extends uvm_env;
    `uvm_component_utils(tx_gasket_env);
   
  tx_gasket_agt agt;
  tx_gasket_sb  sb;
  tx_gasket_cov cov;

   function new(string name = "tx_gasket_env" , uvm_component parent = null);
     super.new(name,parent);
   endfunction  


   function void build_phase(uvm_phase phase);
   	 super.build_phase(phase);
     
     agt = `create(tx_gasket_agt,"agt");
     sb  = `create(tx_gasket_sb,"sb");
     cov = `create(tx_gasket_cov , "cov");

     //`uvm_info("tx_gasket_env","BUILD_PHASE",UVM_LOW);
   endfunction


   function void connect_phase(uvm_phase phase);
     super.connect_phase(phase);
     agt.agt_port.connect(sb.sb_export_ref);
     agt.agt_port.connect(cov.cov_export);
     agt.agt_port_aft.connect(sb.sb_export);
   endfunction
 
 endclass
	

///////////////////////////////////////

endpackage