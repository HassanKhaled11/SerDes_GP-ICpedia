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
     //`uvm_info("rx_gasket_mon","BUILD_PHASE",UVM_LOW);
   endfunction
 


  task run_phase(uvm_phase phase);
     super.run_phase(phase);

     forever begin
       @(negedge  passive_vif.rx_gasket_Rx_Datak);
       data_to_send = `create(rx_gasket_seq_itm, "data_to_send");
      
       for (int i = 0; i < 4; i++) begin
      
       @(posedge passive_vif.rx_gasket_clk_to_get);  
       data_to_send.rx_gasket_Data_in = passive_vif.rx_gasket_Data_in;
       mon_port.write(data_to_send);
      
       end

     end
   endtask  
endclass



class rx_gasket_mon_after extends uvm_monitor;
 `uvm_component_utils(rx_gasket_mon_after);

 uvm_analysis_port #(rx_gasket_seq_itm) mon_port_aft;
 rx_gasket_seq_itm  data_to_send;
 virtual PASSIVE_if passive_vif;


   function new(string name = "rx_gasket_mon_after" , uvm_component parent = null);
     super.new(name,parent);
   endfunction  


   function void build_phase(uvm_phase phase);
     super.build_phase(phase);
      mon_port_aft = new("mon_port_aft" , this);
     //`uvm_info("rx_gasket_mon_after","BUILD_PHASE",UVM_LOW);
   endfunction
 


  task run_phase(uvm_phase phase);
     super.run_phase(phase);

     forever begin
       @(negedge  passive_vif.rx_gasket_Rx_Datak);
       data_to_send = `create(rx_gasket_seq_itm, "data_to_send");
       @(posedge passive_vif.rx_gasket_PCLK);
       @(posedge passive_vif.rx_gasket_PCLK);
       @(posedge passive_vif.rx_gasket_clk_to_get);
       data_to_send.rx_gasket_Data_out = passive_vif.rx_gasket_Data_out;
       mon_port_aft.write(data_to_send);
     end
   endtask  


endclass


///////////////// SB ////////////////////////

class rx_gasket_sb extends uvm_scoreboard;

 `uvm_component_utils(rx_gasket_sb);

 uvm_analysis_export #(rx_gasket_seq_itm)  sb_export;
 rx_gasket_seq_itm  data_to_chk;
 uvm_tlm_analysis_fifo #(rx_gasket_seq_itm)  sb_fifo;

 uvm_analysis_export #(rx_gasket_seq_itm)  sb_export_ref;
 rx_gasket_seq_itm  data_to_chk_ref;
 uvm_tlm_analysis_fifo #(rx_gasket_seq_itm)  sb_fifo_ref;

  virtual PASSIVE_if passive_vif;

  logic [31:0] actual_data_collected ;
  logic [31:0] expected_data_collected ;

  function void connect_phase(uvm_phase phase);
     super.connect_phase(phase);
     sb_export.connect(sb_fifo.analysis_export);
     sb_export_ref.connect(sb_fifo_ref.analysis_export);
   endfunction


   function new(string name = "rx_gasket_sb" , uvm_component parent = null);
     super.new(name,parent);
   endfunction  


   function void build_phase(uvm_phase phase);
     super.build_phase(phase);
      
      sb_export    = new("sb_export" , this);
      sb_fifo       = new("sb_fifo", this);      
      data_to_chk  = new("data_to_chk");

      sb_export_ref    = new("sb_export_ref" , this);
      sb_fifo_ref       = new("sb_fifo_ref", this);      
      data_to_chk_ref  = `create(rx_gasket_seq_itm, "data_to_chk_ref");     


    if (!uvm_config_db#(virtual PASSIVE_if)::get(this, "" , "passive_if" , passive_vif)) begin
          `uvm_fatal("RX_GASKET", "FATAL GETTING intf");
    end      

     //`uvm_info("rx_gasket_sb","BUILD_PHASE",UVM_LOW);
   endfunction


   task run_phase(uvm_phase phase);
    super.run_phase(phase);
    forever begin
     
     for (int i = 0; i < 4; i++) begin
      sb_fifo_ref.get(data_to_chk_ref);
      if(i == 0) begin  
        expected_data_collected[7:0] = data_to_chk_ref.rx_gasket_Data_in;     
      end

      else if(i == 1) begin
        expected_data_collected[15:8] = data_to_chk_ref.rx_gasket_Data_in;           
      end

      else if(i == 2) begin
        expected_data_collected[23:16] = data_to_chk_ref.rx_gasket_Data_in;           
      end

      else begin
        expected_data_collected[31:24] = data_to_chk_ref.rx_gasket_Data_in;        
      end
     end

     sb_fifo.get(data_to_chk);
     actual_data_collected = data_to_chk.rx_gasket_Data_out;

     compare(expected_data_collected , actual_data_collected);
        

   end
   endtask 

   function void compare(logic [31:0] expected_pkt , logic [31:0] actual_pkt);
   if(expected_pkt == actual_pkt) begin
     `uvm_info("RX_GASKET_TEST RIGHT", $sformatf("COLLECTED_DATA= %h , EXPECTED = %h", actual_pkt , expected_pkt), UVM_LOW);
   end

   else begin
     `uvm_info("RX_GASKET_TEST WRONG", $sformatf("COLLECTED_DATA= %h , EXPECTED = %h", actual_pkt , expected_pkt), UVM_LOW);
   end
 endfunction 

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

     //`uvm_info("rx_gasket_cov","BUILD_PHASE",UVM_LOW);
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
     // `uvm_info("rx_gasket_COVERAGE", "", UVM_LOW);             
     end
   endtask 

endclass

//////////////////// AGENT ///////////////////////

class rx_gasket_agt extends uvm_agent;

 `uvm_component_utils(rx_gasket_agt);

 rx_gasket_config_db  rx_gasket_cfg;
 rx_gasket_mon mon;
 rx_gasket_mon_after mon_aft;

  uvm_analysis_port #(rx_gasket_seq_itm) agt_port;
  uvm_analysis_port #(rx_gasket_seq_itm) agt_port_aft;

   function new(string name = "rx_gasket_agt" , uvm_component parent = null);
     super.new(name,parent);
   endfunction  


   function void build_phase(uvm_phase phase);
     super.build_phase(phase);

     agt_port = new("agt_port" , this);
     agt_port_aft = new("agt_port_aft" , this);

     mon = `create(rx_gasket_mon , "mon");
     mon_aft = `create(rx_gasket_mon_after , "mon_aft");

     rx_gasket_cfg = `create(rx_gasket_config_db , "rx_gasket_cfg");

    if(!uvm_config_db#(rx_gasket_config_db)::get(this,"","RX_GASKET_CFG",rx_gasket_cfg)) begin
          `uvm_fatal("rx_gasket_agt", "FATAL GETTING CFG");        
    end  

     //`uvm_info("rx_gasket_agt","BUILD_PHASE",UVM_LOW);
   endfunction

   
   function void connect_phase(uvm_phase phase);
     super.connect_phase(phase);
     mon.mon_port.connect(agt_port);
     mon.passive_vif = rx_gasket_cfg.passive_vif;
     mon_aft.mon_port_aft.connect(agt_port_aft);
     mon_aft.passive_vif = rx_gasket_cfg.passive_vif;
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

     //`uvm_info("rx_gasket_env","BUILD_PHASE",UVM_LOW);
   endfunction


   function void connect_phase(uvm_phase phase);
     super.connect_phase(phase);
      agt.agt_port.connect(sb.sb_export_ref);
      agt.agt_port.connect(cov.cov_export);
      agt.agt_port_aft.connect(sb.sb_export);
   endfunction
 
 endclass
	
endpackage