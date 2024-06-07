package tx_pma_env_pkg;
 
 import uvm_pkg::*;
`include "uvm_macros.svh"
import my_config_db_pkg::*;


`define create(type , inst_name) type::type_id::create(inst_name,this);


/////////// SEQ_ITEM ///////////////////

class tx_pma_seq_itm extends uvm_sequence_item;
    `uvm_object_utils(tx_pma_seq_itm);

  logic                                 tx_pma_Bit_Rate_Clk_10      ;  
  logic                                 tx_pma_Bit_Rate_Clk         ;
  logic                                 tx_pma_Rst_n                ;
  logic [10:0]                          tx_pma_Data_in              ; 
  logic                                 tx_pma_MAC_Data_En          ; 
  logic                                 tx_pma_TX_Out_P             ;   
  logic                                 tx_pma_TX_Out_N             ;


    function new(string name = "tx_pma_seq_itm");
      super.new(name);
    endfunction

endclass

/////////////////// MONITOR /////////////////////

class tx_pma_mon extends uvm_monitor;         //INPUT MONITOR
 `uvm_component_utils(tx_pma_mon);

 uvm_analysis_port #(tx_pma_seq_itm) mon_port;
 tx_pma_seq_itm  data_to_send;
 virtual PASSIVE_if passive_vif;


   function new(string name = "tx_pma_mon" , uvm_component parent = null);
     super.new(name,parent);
   endfunction  


   function void build_phase(uvm_phase phase);
     super.build_phase(phase);
      mon_port = new("mon_port" , this);
     //`uvm_info("tx_pma_mon","BUILD_PHASE",UVM_LOW);
   endfunction
 

   task run_phase(uvm_phase phase);
     super.run_phase(phase);

     forever begin
       data_to_send = `create(tx_pma_seq_itm, "data_to_send");
       @(negedge   passive_vif.tx_pma_Bit_Rate_Clk_10);
       data_to_send.tx_pma_Data_in = passive_vif.tx_pma_Data_in;

       mon_port.write(data_to_send);
     end

   endtask


endclass




class tx_pma_mon_after extends uvm_monitor;         //OUTPUT MONITOR
 `uvm_component_utils(tx_pma_mon_after);

 uvm_analysis_port #(tx_pma_seq_itm) mon_port_aft;
 tx_pma_seq_itm  data_to_send;
 virtual PASSIVE_if passive_vif;


   function new(string name = "tx_pma_mon_after" , uvm_component parent = null);
     super.new(name,parent);
   endfunction  


   function void build_phase(uvm_phase phase);
     super.build_phase(phase);
      mon_port_aft = new("mon_port_aft" , this);
     //`uvm_info("tx_pma_mon_after","BUILD_PHASE",UVM_LOW);
   endfunction
 

   task run_phase(uvm_phase phase);
     super.run_phase(phase);

    @(posedge passive_vif.tx_gasket_PCLK);
    @(posedge passive_vif.encoder_Bit_Rate_10);
    @(posedge passive_vif.tx_pma_Bit_Rate_Clk);
    @(posedge passive_vif.tx_pma_Bit_Rate_Clk);
     forever begin
       @(posedge  passive_vif.tx_pma_Bit_Rate_Clk);
       data_to_send = `create(tx_pma_seq_itm, "data_to_send");
       data_to_send.tx_pma_TX_Out_P = passive_vif.tx_pma_TX_Out_P;

       mon_port_aft.write(data_to_send);
     end

   endtask


endclass

///////////////// SB ////////////////////////

class tx_pma_sb extends uvm_scoreboard;

 `uvm_component_utils(tx_pma_sb);

 uvm_analysis_export #(tx_pma_seq_itm)  sb_export;
 tx_pma_seq_itm  data_to_chk;
 uvm_tlm_analysis_fifo #(tx_pma_seq_itm)  sb_fifo;

 uvm_analysis_export #(tx_pma_seq_itm)  sb_export_ref;
 tx_pma_seq_itm  data_to_chk_ref;
 uvm_tlm_analysis_fifo #(tx_pma_seq_itm)  sb_fifo_ref;


logic [9:0] actual_data_collected ;
logic [9:0] expected_data_collected ;


  virtual PASSIVE_if passive_vif;


   function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      sb_export.connect(sb_fifo.analysis_export);
      sb_export_ref.connect(sb_fifo_ref.analysis_export);      
    endfunction


   function new(string name = "tx_pma_sb" , uvm_component parent = null);
     super.new(name,parent);
   endfunction  


   function void build_phase(uvm_phase phase);
     super.build_phase(phase);
      
      sb_export    = new("sb_export" , this);
      sb_fifo       = new("sb_fifo", this);      
      data_to_chk  = new("data_to_chk");


      sb_export_ref     = new("sb_export_ref" , this);
      sb_fifo_ref       = new("sb_fifo_ref", this);      
      data_to_chk_ref = `create(tx_pma_seq_itm, "data_to_chk_ref");


      if (!uvm_config_db#(virtual PASSIVE_if)::get(this, "" , "passive_if" , passive_vif)) begin
          `uvm_fatal("TX_PMA", "FATAL GETTING intf");
      end

     //`uvm_info("tx_pma_sb","BUILD_PHASE",UVM_LOW);
   endfunction


   task run_phase(uvm_phase phase);
     super.run_phase(phase);
     forever begin
      
      sb_fifo_ref.get(data_to_chk_ref);
      expected_data_collected = data_to_chk_ref.tx_pma_Data_in;

      for (int i = 0; i < 10; i++) begin
      sb_fifo.get(data_to_chk);
      actual_data_collected[i] = data_to_chk.tx_pma_TX_Out_P;  
      end

     compare(expected_data_collected , actual_data_collected);
           
     end
   endtask 


   function void compare(logic [31:0] expected_pkt , logic [31:0] actual_pkt);
   if(expected_pkt == actual_pkt) begin
     `uvm_info("TX_PMA_DATA_TEST RIGHT", $sformatf("COLLECTED_DATA= %h , EXPECTED = %h", actual_pkt , expected_pkt), UVM_LOW);
   end

   else begin
     `uvm_info("TX_PMA_DATA_TEST WRONG", $sformatf("COLLECTED_DATA= %h , EXPECTED = %h", actual_pkt , expected_pkt), UVM_LOW);
   end
 endfunction 


endclass




///////////////// Coverage ////////////////////////


class tx_pma_cov extends uvm_component;

 `uvm_component_utils(tx_pma_cov);

 uvm_analysis_export #(tx_pma_seq_itm)  cov_export;
 tx_pma_seq_itm  data_to_chk;
 uvm_tlm_analysis_fifo #(tx_pma_seq_itm)  cov_fifo;
 
 virtual PASSIVE_if passive_vif;



covergroup tx_pma_cg();
 tx_out_p: coverpoint data_to_chk.tx_pma_TX_Out_P;
endgroup



   function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      cov_export.connect(cov_fifo.analysis_export);
    endfunction



   function void build_phase(uvm_phase phase);
     super.build_phase(phase);
      
      cov_export     = new("cov_export" , this);
      cov_fifo       = new("cov_fifo", this);      
      data_to_chk    = `create(tx_pma_seq_itm, "data_to_chk");

      if (!uvm_config_db#(virtual PASSIVE_if)::get(this, "" , "passive_if" , passive_vif)) begin
          `uvm_fatal("TX_PMA", "FATAL GETTING if");
      end

     //`uvm_info("tx_pma_cov","BUILD_PHASE",UVM_LOW);
   endfunction


   function new(string name = "tx_pma_cov" , uvm_component parent = null);
     super.new(name,parent);
     tx_pma_cg = new();
   endfunction  


   task run_phase(uvm_phase phase);
     super.run_phase(phase);
     forever begin
      @(posedge passive_vif.encoder_Bit_Rate_10);
      cov_fifo.get(data_to_chk);
      tx_pma_cg.sample();
      //`uvm_info("tx_pma_COVERAGE", "", UVM_LOW);             
     end
   endtask 

endclass



//////////////////// AGENT ///////////////////////

class tx_pma_agt extends uvm_agent;

 `uvm_component_utils(tx_pma_agt);

 tx_pma_config_db tx_pma_cfg;
 tx_pma_mon mon;
 tx_pma_mon_after mon_aft;


  uvm_analysis_port #(tx_pma_seq_itm) agt_port;
  uvm_analysis_port #(tx_pma_seq_itm) agt_port_aft;


   function new(string name = "tx_pma_agt" , uvm_component parent = null);
     super.new(name,parent);
   endfunction  


   function void build_phase(uvm_phase phase);
     super.build_phase(phase);

     agt_port = new("agt_port" , this);
     agt_port_aft = new("agt_port_aft" , this);     
  
     mon = `create(tx_pma_mon , "mon");
     mon_aft = `create(tx_pma_mon_after , "mon_aft");

     tx_pma_cfg = `create(tx_pma_config_db,"tx_pma_cfg");

   if(!uvm_config_db#(tx_pma_config_db)::get(this,"","TX_PMA_CFG",tx_pma_cfg)) begin
          `uvm_fatal("tx_pma_agt", "FATAL GETTING CFG");        
     end

     //`uvm_info("tx_pma_agt","BUILD_PHASE",UVM_LOW);
   endfunction

   
   function void connect_phase(uvm_phase phase);
     super.connect_phase(phase);
     mon.passive_vif = tx_pma_cfg.passive_vif;
     mon.mon_port.connect(agt_port);
     mon_aft.mon_port_aft.connect(agt_port_aft);
     mon_aft.passive_vif = tx_pma_cfg.passive_vif;   
   endfunction
 
endclass





////////////////// ENV /////////////////////////

 class tx_pma_env extends uvm_env;
    `uvm_component_utils(tx_pma_env);
   
  tx_pma_agt agt;
  tx_pma_sb  sb;
  tx_pma_cov cov;

   function new(string name = "tx_pma_env" , uvm_component parent = null);
     super.new(name,parent);
   endfunction  


   function void build_phase(uvm_phase phase);
     super.build_phase(phase);
     
     agt = `create(tx_pma_agt,"agt");
     sb  = `create(tx_pma_sb,"sb");
     cov = `create(tx_pma_cov,"cov");

     //`uvm_info("tx_pma_env","BUILD_PHASE",UVM_LOW);
   endfunction


   function void connect_phase(uvm_phase phase);
     super.connect_phase(phase);
      agt.agt_port.connect(sb.sb_export_ref);
      agt.agt_port.connect(cov.cov_export);
      agt.agt_port_aft.connect(sb.sb_export);
   endfunction
 
 endclass
	
endpackage