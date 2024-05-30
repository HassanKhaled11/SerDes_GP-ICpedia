package rx_gasket_env_pkg;
 
 import uvm_pkg::*;
`include "uvm_macros.svh"
import my_config_db_pkg::*;


`define create(type , inst_name) type::type_id::create(inst_name,this);

/////////// SEQ_ITEM ///////////////////

class rx_gasket_seq_itm extends uvm_sequence_item;
    `uvm_object_utils(rx_gasket_seq_itm);


  logic                                 rx_gasket_clk_to_get           ;
  logic                                 rx_gasket_PCLK                 ;
  logic                                 rx_gasket_Rst_n                ;
  logic                                 rx_gasket_Rx_Datak             ;
  logic [ 5:0]                          rx_gasket_width                ;
  logic [ 7:0]                          rx_gasket_Data_in              ;
  logic [31:0]                          rx_gasket_Data_out             ;


    function new(string name = "rx_gasket_seq_itm");
      super.new(name);
    endfunction

endclass

/////////////////// MONITOR /////////////////////

class rx_gasket_mon extends uvm_monitor;
 `uvm_component_utils(rx_gasket_mon);

 uvm_analysis_port #(rx_gasket_seq_itm) mon_port;
 rx_gasket_seq_itm  data_to_send;
 virtual PASSIVE_if passive_vif;


   function new(string name = "rx_gasket_mon" , uvm_component parent = null);
     super.new(name,parent);
   endfunction  


   function void build_phase(uvm_phase phase);
     super.build_phase(phase);
      mon_port = new("mon_port" , this);
     `uvm_info("rx_gasket_mon","BUILD_PHASE",UVM_LOW);
   endfunction
 


  task run_phase(uvm_phase phase);
     super.run_phase(phase);

     forever begin
       data_to_send = `create(rx_gasket_seq_itm, "data_to_send");
       @(negedge  passive_vif.rx_gasket_PCLK);
       data_to_send.rx_gasket_Data_out = passive_vif.rx_gasket_Data_out;

       mon_port.write(data_to_send);
     end
   endtask  



endclass


///////////////// SB ////////////////////////

class rx_gasket_sb extends uvm_scoreboard;

 `uvm_component_utils(rx_gasket_sb);

 uvm_analysis_export #(rx_gasket_seq_itm)  sb_export;
 rx_gasket_seq_itm  data_to_chk;
  uvm_tlm_analysis_fifo #(rx_gasket_seq_itm)  sb_fifo;

  virtual PASSIVE_if passive_vif;


   function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      sb_export.connect(sb_fifo.analysis_export);
    endfunction


   function new(string name = "rx_gasket_sb" , uvm_component parent = null);
     super.new(name,parent);
   endfunction  


   function void build_phase(uvm_phase phase);
     super.build_phase(phase);
      
      sb_export    = new("sb_export" , this);
      sb_fifo       = new("sb_fifo", this);      
      data_to_chk  = new("data_to_chk");

    if (!uvm_config_db#(virtual PASSIVE_if)::get(this, "" , "passive_if" , passive_vif)) begin
          `uvm_fatal("RX_GASKET", "FATAL GETTING intf");
    end      

     `uvm_info("rx_gasket_sb","BUILD_PHASE",UVM_LOW);
   endfunction


   task run_phase(uvm_phase phase);
     super.run_phase(phase);
     forever begin
      @(posedge passive_vif.rx_gasket_PCLK);
      sb_fifo.get(data_to_chk);
      `uvm_info("RX_GASKET_SCOREBOARD", $sformatf("OUT_DATA = %h", data_to_chk.rx_gasket_Data_out), UVM_LOW);             
     end
   endtask 


endclass


///////////////// Coverage ////////////////////////


class rx_gasket_cov extends uvm_component;

 `uvm_component_utils(rx_gasket_cov);

 uvm_analysis_export #(rx_gasket_seq_itm)  cov_export;
 rx_gasket_seq_itm  data_to_chk;
 uvm_tlm_analysis_fifo #(rx_gasket_seq_itm)  cov_fifo;
 
 virtual PASSIVE_if passive_vif;



covergroup rx_gasket_cg();
rx_gasket_dout: coverpoint data_to_chk.rx_gasket_Data_out;
endgroup



   function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      cov_export.connect(cov_fifo.analysis_export);
    endfunction



   function void build_phase(uvm_phase phase);
     super.build_phase(phase);
      
      cov_export     = new("cov_export" , this);
      cov_fifo       = new("cov_fifo", this);      
      data_to_chk    = `create(rx_gasket_seq_itm, "data_to_chk");

      if (!uvm_config_db#(virtual PASSIVE_if)::get(this, "" , "passive_if" , passive_vif)) begin
          `uvm_fatal("TX_PMA", "FATAL GETTING if");
      end

     `uvm_info("rx_gasket_cov","BUILD_PHASE",UVM_LOW);
   endfunction


   function new(string name = "rx_gasket_cov" , uvm_component parent = null);
     super.new(name,parent);
     rx_gasket_cg = new();
   endfunction  


   task run_phase(uvm_phase phase);
     super.run_phase(phase);
     forever begin
      @(posedge passive_vif.rx_gasket_PCLK);
      cov_fifo.get(data_to_chk);
      rx_gasket_cg.sample();
      `uvm_info("rx_gasket_COVERAGE", "", UVM_LOW);             
     end
   endtask 

endclass

//////////////////// AGENT ///////////////////////

class rx_gasket_agt extends uvm_agent;

 `uvm_component_utils(rx_gasket_agt);

 rx_gasket_config_db  rx_gasket_cfg;
 rx_gasket_mon mon;

  uvm_analysis_port #(rx_gasket_seq_itm) agt_port;

   function new(string name = "rx_gasket_agt" , uvm_component parent = null);
     super.new(name,parent);
   endfunction  


   function void build_phase(uvm_phase phase);
     super.build_phase(phase);

     agt_port = new("agt_port" , this);
     mon = `create(rx_gasket_mon , "mon");

     rx_gasket_cfg = `create(rx_gasket_config_db , "rx_gasket_cfg");

    if(!uvm_config_db#(rx_gasket_config_db)::get(this,"","RX_GASKET_CFG",rx_gasket_cfg)) begin
          `uvm_fatal("rx_gasket_agt", "FATAL GETTING CFG");        
    end  

     `uvm_info("rx_gasket_agt","BUILD_PHASE",UVM_LOW);
   endfunction

   
   function void connect_phase(uvm_phase phase);
     super.connect_phase(phase);
     mon.mon_port.connect(agt_port);
     mon.passive_vif = rx_gasket_cfg.passive_vif;
   endfunction
 
endclass


////////////////// ENV /////////////////////////

 class rx_gasket_env extends uvm_env;
    `uvm_component_utils(rx_gasket_env);
   
  rx_gasket_agt agt;
  rx_gasket_sb  sb;
  rx_gasket_cov cov;


   function new(string name = "rx_gasket_env" , uvm_component parent = null);
     super.new(name,parent);
   endfunction  


   function void build_phase(uvm_phase phase);
     super.build_phase(phase);
     
     agt = `create(rx_gasket_agt,"agt");
     sb  = `create(rx_gasket_sb,"sb");
     cov = `create(rx_gasket_cov,"cov");

     `uvm_info("rx_gasket_env","BUILD_PHASE",UVM_LOW);
   endfunction


   function void connect_phase(uvm_phase phase);
     super.connect_phase(phase);
      agt.agt_port.connect(sb.sb_export);
      agt.agt_port.connect(cov.cov_export);
   endfunction
 
 endclass
	
endpackage