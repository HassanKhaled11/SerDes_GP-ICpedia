package rx_s2p_env_pkg;
 
 import uvm_pkg::*;
`include "uvm_macros.svh"
import my_config_db_pkg::*;

`define create(type , inst_name) type::type_id::create(inst_name,this);


/////////// SEQ_ITEM ///////////////////

class rx_s2p_seq_itm extends uvm_sequence_item;
    `uvm_object_utils(rx_s2p_seq_itm);

  logic                                 rx_s2p_Recovered_Bit_Clk        ;
  logic                                 rx_s2p_Ser_in                   ;
  logic                                 rx_s2p_Rst_n                    ;
  logic                                 rx_s2p_RxPolarity               ;
  logic [9:0]                           rx_s2p_Data_Collected           ;
  logic [9:0]                           rx_s2p_expected_Data_Collected  ;



    function new(string name = "rx_s2p_seq_itm");
      super.new(name);
    endfunction

endclass

/////////////////// MONITOR /////////////////////

class rx_s2p_mon extends uvm_monitor;
 `uvm_component_utils(rx_s2p_mon);

 uvm_analysis_port #(rx_s2p_seq_itm) mon_port;
 rx_s2p_seq_itm  data_to_send;
 virtual PASSIVE_if passive_vif;


   function new(string name = "rx_s2p_mon" , uvm_component parent = null);
     super.new(name,parent);
   endfunction  


   function void build_phase(uvm_phase phase);
     super.build_phase(phase);
      mon_port = new("mon_port" , this);
    // `uvm_info("rx_s2p_mon","BUILD_PHASE",UVM_LOW);
   endfunction
 

   task run_phase(uvm_phase phase);
     super.run_phase(phase);

     forever begin
       @(negedge  passive_vif.encoder_Bit_Rate_10);
       data_to_send = `create(rx_s2p_seq_itm, "data_to_send");
       data_to_send.rx_s2p_expected_Data_Collected = passive_vif.tx_pma_Data_in;

       mon_port.write(data_to_send);
     end

   endtask
endclass


class rx_s2p_mon_after extends uvm_monitor;
 `uvm_component_utils(rx_s2p_mon_after);

 uvm_analysis_port #(rx_s2p_seq_itm) mon_port_aft;
 rx_s2p_seq_itm  data_to_send;
 virtual PASSIVE_if passive_vif;


   function new(string name = "rx_s2p_mon_after" , uvm_component parent = null);
     super.new(name,parent);
   endfunction  


   function void build_phase(uvm_phase phase);
     super.build_phase(phase);
      mon_port_aft = new("mon_port_aft" , this);
     //`uvm_info("rx_s2p_mon_after","BUILD_PHASE",UVM_LOW);
   endfunction
 

   task run_phase(uvm_phase phase);
     super.run_phase(phase);


    @(posedge passive_vif.tx_gasket_PCLK);
    @(posedge passive_vif.encoder_Bit_Rate_10);
    @(posedge passive_vif.rx_s2p_Recovered_Bit_Clk);
    @(posedge passive_vif.rx_s2p_Recovered_Bit_Clk);

     forever begin
      @(posedge  passive_vif.rx_s2p_Recovered_Bit_Clk);
       data_to_send = `create(rx_s2p_seq_itm, "data_to_send");
       data_to_send.rx_s2p_Data_Collected = passive_vif.rx_s2p_Data_Collected;

       mon_port_aft.write(data_to_send);
     end

   endtask

endclass
///////////////// SB ////////////////////////

class rx_s2p_sb extends uvm_scoreboard;

 `uvm_component_utils(rx_s2p_sb);

 uvm_analysis_export #(rx_s2p_seq_itm)  sb_export;
 rx_s2p_seq_itm  data_to_chk;
 uvm_tlm_analysis_fifo #(rx_s2p_seq_itm)  sb_fifo;


 uvm_analysis_export #(rx_s2p_seq_itm)  sb_export_ref;
 rx_s2p_seq_itm  data_to_chk_ref;
 uvm_tlm_analysis_fifo #(rx_s2p_seq_itm)  sb_fifo_ref;


logic [9:0] actual_data_collected ;
logic [9:0] expected_data_collected ;

int counter ;


 virtual PASSIVE_if passive_vif;



   function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      sb_export.connect(sb_fifo.analysis_export);
      sb_export_ref.connect(sb_fifo_ref.analysis_export);
    endfunction


   function new(string name = "rx_s2p_sb" , uvm_component parent = null);
     super.new(name,parent);
     counter = 0;
   endfunction  


   function void build_phase(uvm_phase phase);
     super.build_phase(phase);
      
      sb_export    = new("sb_export" , this);
      sb_fifo       = new("sb_fifo", this);      
      data_to_chk  = new("data_to_chk");


      sb_export_ref     = new("sb_export_ref" , this);
      sb_fifo_ref       = new("sb_fifo_ref", this);      
      data_to_chk_ref = `create(rx_s2p_seq_itm, "data_to_chk_ref");



   if (!uvm_config_db#(virtual PASSIVE_if)::get(this, "" , "passive_if" , passive_vif)) begin
          `uvm_fatal("ENCODING", "FATAL GETTING intf");
    end

     //`uvm_info("rx_s2p_sb","BUILD_PHASE",UVM_LOW);
   endfunction


   task run_phase(uvm_phase phase);
     super.run_phase(phase);
     forever begin

      sb_fifo_ref.get(data_to_chk_ref);
      expected_data_collected = data_to_chk_ref.rx_s2p_expected_Data_Collected;

     
     while(counter < 30) begin
      sb_fifo.get(data_to_chk);
       if(expected_data_collected == data_to_chk.rx_s2p_Data_Collected) begin
             `uvm_info("RX_S2P_TEST RIGHT", $sformatf("COLLECTED_DATA= %h , EXPECTED = %h", data_to_chk.rx_s2p_Data_Collected , expected_data_collected), UVM_LOW);
         break;
       end
     end
      
      `uvm_info("RX_S2P_TEST WRONG","DATA NOT FOUND", UVM_LOW);
       counter = 0;

     end
   endtask 


   function void compare(logic [31:0] expected_pkt , logic [31:0] actual_pkt);
   if(expected_pkt == actual_pkt) begin
     `uvm_info("RX_S2P_TEST RIGHT", $sformatf("COLLECTED_DATA= %h , EXPECTED = %h", actual_pkt , expected_pkt), UVM_LOW);
   end

   else begin
     `uvm_info("RX_S2P_TEST WRONG", $sformatf("COLLECTED_DATA= %h , EXPECTED = %h", actual_pkt , expected_pkt), UVM_LOW);
   end
 endfunction 


endclass

///////////////// Coverage ////////////////////////


class rx_s2p_cov extends uvm_component;

 `uvm_component_utils(rx_s2p_cov);

 uvm_analysis_export #(rx_s2p_seq_itm)  cov_export;
 rx_s2p_seq_itm  data_to_chk;
 uvm_tlm_analysis_fifo #(rx_s2p_seq_itm)  cov_fifo;
 
  virtual PASSIVE_if passive_vif;



covergroup rx_s2p_cg();
  
data_collected_cp: coverpoint data_to_chk.rx_s2p_Data_Collected;

endgroup



   function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      cov_export.connect(cov_fifo.analysis_export);
    endfunction



   function void build_phase(uvm_phase phase);
     super.build_phase(phase);
      
      cov_export    = new("cov_export" , this);
      cov_fifo       = new("cov_fifo", this);      
      data_to_chk = `create(rx_s2p_seq_itm, "data_to_chk");

      if (!uvm_config_db#(virtual PASSIVE_if)::get(this, "" , "passive_if" , passive_vif)) begin
          `uvm_fatal("RX_S2P", "FATAL GETTING if");
      end

     //`uvm_info("rx_s2p_cov","BUILD_PHASE",UVM_LOW);
   endfunction


   function new(string name = "rx_s2p_cov" , uvm_component parent = null);
     super.new(name,parent);
     rx_s2p_cg = new();
   endfunction  


   task run_phase(uvm_phase phase);
     super.run_phase(phase);
     forever begin
      @(posedge passive_vif.rx_s2p_Recovered_Bit_Clk);
      cov_fifo.get(data_to_chk);
      rx_s2p_cg.sample();
      //`uvm_info("RX_S2P_COVERAGE", "", UVM_LOW);             
     end
   endtask 

endclass




//////////////////// AGENT ///////////////////////

class rx_s2p_agt extends uvm_agent;

 `uvm_component_utils(rx_s2p_agt);

 rx_s2p_config_db rx_s2p_cfg;
 rx_s2p_mon mon;
 rx_s2p_mon_after mon_aft;

  uvm_analysis_port #(rx_s2p_seq_itm) agt_port;
  uvm_analysis_port #(rx_s2p_seq_itm) agt_port_aft;

   function new(string name = "rx_s2p_agt" , uvm_component parent = null);
     super.new(name,parent);
   endfunction  


   function void build_phase(uvm_phase phase);
     super.build_phase(phase);

     agt_port = new("agt_port" , this);
     agt_port_aft = new("agt_port_aft" , this);

     mon = `create(rx_s2p_mon , "mon");
     mon_aft = `create(rx_s2p_mon_after , "mon_aft");


     rx_s2p_cfg = `create(rx_s2p_config_db,"rx_s2p_cfg");

     if(!uvm_config_db#(rx_s2p_config_db)::get(this,"","RX_S2P_CFG",rx_s2p_cfg)) begin
          `uvm_fatal("rx_s2p_agt", "FATAL GETTING RX_S2P_CFG");        
     end     

     //`uvm_info("rx_s2p_agt","BUILD_PHASE",UVM_LOW);
   endfunction

   
   function void connect_phase(uvm_phase phase);
     super.connect_phase(phase);
     mon.mon_port.connect(agt_port);
     mon.passive_vif = rx_s2p_cfg.passive_vif;
     mon_aft.mon_port_aft.connect(agt_port_aft);
     mon_aft.passive_vif = rx_s2p_cfg.passive_vif;
   endfunction
 
endclass


////////////////// ENV /////////////////////////

 class rx_s2p_env extends uvm_env;
    `uvm_component_utils(rx_s2p_env);
   
  rx_s2p_agt agt;
  rx_s2p_sb  sb;
  rx_s2p_cov cov;

   function new(string name = "rx_s2p_env" , uvm_component parent = null);
     super.new(name,parent);
   endfunction  


   function void build_phase(uvm_phase phase);
     super.build_phase(phase);
     
     agt = `create(rx_s2p_agt,"agt");
     sb  = `create(rx_s2p_sb,"sb");
     cov  = `create(rx_s2p_cov,"cov");

    // `uvm_info("rx_s2p_env","BUILD_PHASE",UVM_LOW);
   endfunction


   function void connect_phase(uvm_phase phase);
     super.connect_phase(phase);
      agt.agt_port.connect(sb.sb_export_ref);
      agt.agt_port.connect(cov.cov_export);
      agt.agt_port_aft.connect(sb.sb_export);
   endfunction
 
 endclass
	
endpackage