package encoding_env_pkg;
 
 import uvm_pkg::*;
`include "uvm_macros.svh"
import my_config_db_pkg::*;

import Enc_Dec_RAL_pkg::*;


`define create(type , inst_name) type::type_id::create(inst_name,this);


/////////// SEQ_ITEM ///////////////////

class encoding_seq_itm extends uvm_sequence_item;
    `uvm_object_utils(encoding_seq_itm);

  logic  [7:0]     encoder_data                 ;
  rand logic       encoder_MAC_Data_En          ;
  logic            encoder_Bit_Rate_10          ;
  rand logic       encoder_Rst                  ;
  rand logic       encoder_TXDataK              ; 
  rand logic       encoder_enable               ;
  logic  [9:0]     encoder_data_out             ;
  logic  [9:0]     encoder_encoded_neg_data     ;
  logic  [9:0]     encoder_encoded_pos_data     ; 



   constraint encoder_MAC_Data_En_c {
     encoder_MAC_Data_En == 1;
   }


   constraint encoder_TXDataK_c {
     encoder_TXDataK == 0;
   }

   constraint encoder_enable_c {
     encoder_enable == 1;
   }


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


class encoding_driver extends  uvm_driver #(encoding_seq_itm);
  `uvm_component_utils(encoding_driver);


encoding_seq_itm req;
virtual PASSIVE_if passive_vif;


  function new(string name = "encoding_driver" , uvm_component parent = null);
     super.new(name,parent);
   endfunction  
   

 
   function void build_phase(uvm_phase phase);
     super.build_phase(phase);

      req = encoding_seq_itm::type_id::create("req",this);

     //`uvm_info("encoding_agt","BUILD_PHASE",UVM_LOW);
   endfunction


   task run_phase(uvm_phase phase);
     super.run_phase(phase);
     
     forever begin
     seq_item_port.get_next_item (req);
     
     @(negedge passive_vif.encoder_Bit_Rate_10);
      passive_vif.encoder_TXDataK = 0;
      passive_vif.encoder_data = req.encoder_data;
      passive_vif.encoder_Rst = 1;
     end


   endtask
   

endclass


//////////////////// AGENT ///////////////////////

class encoding_agt extends uvm_agent;

 `uvm_component_utils(encoding_agt);

 encoding_config_db encoding_cfg;
 encoding_mon mon;
 uvm_sequencer#(encoding_seq_itm) sequencer;
 encoding_driver driver;

  uvm_analysis_port #(encoding_seq_itm) agt_port;

   function new(string name = "encoding_agt" , uvm_component parent = null);
     super.new(name,parent);
   endfunction  


   function void build_phase(uvm_phase phase);
     super.build_phase(phase);

     agt_port = new("agt_port" , this);
     mon = `create(encoding_mon , "mon");
     sequencer =  uvm_sequencer#(encoding_seq_itm)::type_id::create("sequencer",this);

     encoding_cfg = `create(encoding_config_db,"encoding_cfg");

     if(encoding_cfg.is_active == UVM_ACTIVE) begin
      driver     = encoding_driver:: type_id :: create("driver" ,this) ;       
     end

     if(!uvm_config_db#(encoding_config_db)::get(this,"","ENCODING_CFG",encoding_cfg)) begin
          `uvm_fatal("encoding_agt", "FATAL GETTING ENCODING_CFG");        
     end

     //`uvm_info("encoding_agt","BUILD_PHASE",UVM_LOW);
   endfunction

   
   function void connect_phase(uvm_phase phase);
     super.connect_phase(phase);
     mon.mon_port.connect(agt_port);
     mon.passive_vif = encoding_cfg.passive_vif;

     if(encoding_cfg.is_active == UVM_ACTIVE) begin
     driver.passive_vif = encoding_cfg.passive_vif;
     end
    
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

////////////////////////////////////////////////////////////////////////

 class adapter extends uvm_reg_adapter;

  `uvm_object_utils(adapter);


  function new (string name = "adapter");
      super.new(name);
  endfunction


virtual function void bus2reg(uvm_sequence_item bus_item , ref uvm_reg_bus_op rw);
  
  encoding_seq_itm item;
  assert($cast(item , bus_item));

  rw.kind = UVM_WRITE;
  rw.data = item.encoder_encoded_pos_data;
  //rw.addr = ;
  rw.status = UVM_IS_OK;
 // uvm_reg_adapter::bus2reg(bus_item, rw);  // Send the first transaction

  rw.kind = UVM_WRITE;
  //rw.addr = ;
  rw.data = item.encoder_encoded_neg_data;
  rw.status = UVM_IS_OK;
  //uvm_reg_adapter::bus2reg(bus_item, rw);  // Send the first transaction

endfunction



virtual function uvm_sequence_item reg2bus(const ref uvm_reg_bus_op rw);
  
  encoding_seq_itm item;

  item = encoding_seq_itm :: type_id :: create("item");
  item.encoder_data = rw.data;
  item.encoder_TXDataK = 0;
  item.encoder_enable = 1;
  item.encoder_Rst = 1;

  return item;
endfunction


endclass

////////////////// ENV /////////////////////////

 class encoding_env extends uvm_env;
    `uvm_component_utils(encoding_env);
   
  encoding_agt agt;
  encoding_sb  sb;
  encoding_cov cov;

  Reg_Block reg_block;
  uvm_reg_predictor #(encoding_seq_itm) predictor_inst ;
  adapter adapter_inst;

   function new(string name = "encoding_env" , uvm_component parent = null);
     super.new(name,parent);
   endfunction  


   function void build_phase(uvm_phase phase);
     super.build_phase(phase);
     
     agt = `create(encoding_agt,"agt");
     sb  = `create(encoding_sb,"sb");
     cov = `create(encoding_cov,"cov");
 
     adapter_inst = adapter :: type_id :: create("adapter_inst");
     
     reg_block = Reg_Block::type_id::create("reg_block");
     reg_block.build();

     predictor_inst = uvm_reg_predictor#(encoding_seq_itm)::type_id::create("predictor_inst",this);

     //`uvm_info("encoding_env","BUILD_PHASE",UVM_LOW);
   endfunction


   function void connect_phase(uvm_phase phase);
     super.connect_phase(phase);
 
      reg_block.default_map.set_sequencer(.sequencer(agt.sequencer) , .adapter(adapter_inst));
      reg_block.default_map.set_base_addr(0);

      predictor_inst.map = reg_block.default_map;
      predictor_inst.adapter = adapter_inst;

      agt.agt_port.connect(sb.sb_export);
      agt.agt_port.connect(cov.cov_export);
      agt.agt_port.connect(predictor_inst.bus_in);
   endfunction
 
 endclass



////////////////////////////////////////////////////////////////////////////////////

class encoder_reg_seq extends uvm_sequence;
  `uvm_object_utils(encoder_reg_seq)

   Reg_Block reg_block;
   
   logic [9:0] pos_encoding [logic[7:0]];
   logic [9:0] neg_encoding [logic[7:0]];   
   logic [7:0] pos_decoding [logic[9:0]];
   logic [7:0] neg_decoding [logic[9:0]]; 
   logic [9:0] decode_stimulus_neg [logic[8:0]];
   logic [9:0] decode_stimulus_pos [logic[8:0]];

  function new(string name = "encoder_reg_seq");
        super.new(name);
  endfunction

    task body();

      uvm_status_e  status;
      bit [7:0] wdata;
      bit [9:0] rdata_pos;
      bit [9:0] rdata_neg;

      golden_model();


//******************* BACKDOOR ACCESS ENCODER TEST *************************


      for(int i = 0 ; i < 256 ; i++) begin
        reg_block.Enc_Data_In_Reg_inst.poke(status , i);
        reg_block.Enable_Reg_inst.poke(status,1'b1);
        reg_block.TX_DataK_Reg_inst.poke(status,1'b0);
        #3;
        reg_block.Enc_Pos_Out_Reg_inst.peek(status,rdata_pos);
        reg_block.Enc_Neg_Out_Reg_inst.peek(status,rdata_neg);

        if(rdata_pos == pos_encoding[i] && rdata_neg == neg_encoding[i]) begin
            `uvm_info("(BACKDOOR ACCESS) SUCCEEDED_DATA_ENCODER TEST" , $sformatf("Data = %0d ,RDATA_POS = %b , RDATA_NEG = %b", i ,rdata_pos , rdata_neg),UVM_LOW);
        end

        else begin
            `uvm_info("(BACKDOOR ACCESS) FAILED_DATA_ENCODER TEST" , $sformatf("Data = %0d ,RDATA_POS = %b , RDATA_NEG = %b", i ,rdata_pos , rdata_neg),UVM_LOW);          
        end
        reg_block.Enable_Reg_inst.poke(status,1'b0);
        reg_block.TX_DataK_Reg_inst.poke(status,1'b1);
        #1;        
      end


//******************* BACKDOOR ACCESS DECODER TEST *************************

      for(int i = 0 ; i < 256 ; i++) begin
        reg_block.Dec_Data_In_Reg_inst.poke(status , decode_stimulus_neg[i]);
        reg_block.Dec_CLK_Reg_inst.poke(status ,1'b1);
        reg_block.Dec_RST_Reg_inst.poke(status , 1'b1);
        #3;
        reg_block.Dec_Pos_Out_Reg_inst.peek(status,rdata_pos);
        reg_block.Dec_Neg_Out_Reg_inst.peek(status,rdata_neg);

        if(rdata_pos == pos_decoding[decode_stimulus_pos[i]] || rdata_neg == neg_decoding[decode_stimulus_neg[i]]) begin
            `uvm_info("(BACKDOOR ACCESS) SUCCEEDED_DATA_DECODED TEST" , $sformatf("Data = %0d ,RDATA_POS = %b , RDATA_NEG = %b", decode_stimulus_neg[i] ,rdata_pos , rdata_neg),UVM_LOW);
        end

        else begin
            `uvm_info("(BACKDOOR ACCESS) FAILED_DATA_DECODED TEST" , $sformatf("Data = %0d ,RDATA_POS = %b , RDATA_NEG = %b", decode_stimulus_neg[i] ,rdata_pos , rdata_neg),UVM_LOW);          
        end
        // reg_block.Enable_Reg_inst.poke(status,1'b0);
        // reg_block.TX_DataK_Reg_inst.poke(status,1'b1);
        reg_block.Dec_CLK_Reg_inst.poke(status , 1'b0);       
        #1; 
      end      


    endtask



task golden_model();

    // data - negative
neg_encoding[8'b0000_0000] = 10'b10_0111_0100;  //0
neg_encoding[8'b0000_0001] = 10'b01_1101_0100;  //1
neg_encoding[8'b0000_0010] = 10'b10_1101_0100;  //2
neg_encoding[8'b0000_0011] = 10'b11_0001_1011;  //3
neg_encoding[8'b0000_0100] = 10'b11_0101_0100;  //4
neg_encoding[8'b0000_0101] = 10'b10_1001_1011;  //5
neg_encoding[8'b0000_0110] = 10'b01_1001_1011;  //6
neg_encoding[8'b0000_0111] = 10'b11_1000_1011;  //7
neg_encoding[8'b0000_1000] = 10'b11_1001_0100;  //8
neg_encoding[8'b0000_1001] = 10'b10_0101_1011;  //9
neg_encoding[8'b0000_1010] = 10'b01_0101_1011;  //10
neg_encoding[8'b0000_1011] = 10'b11_0100_1011;  //11
neg_encoding[8'b0000_1100] = 10'b00_1101_1011;  //12
neg_encoding[8'b0000_1101] = 10'b10_1100_1011;  //13
neg_encoding[8'b0000_1110] = 10'b01_1100_1011;  //14
neg_encoding[8'b0000_1111] = 10'b01_0111_0100;  //15
neg_encoding[8'b0001_0000] = 10'b01_1011_0100;  //16
neg_encoding[8'b0001_0001] = 10'b10_0011_1011;  //17
neg_encoding[8'b0001_0010] = 10'b01_0011_1011;  //18
neg_encoding[8'b0001_0011] = 10'b11_0010_1011;  //19
neg_encoding[8'b0001_0100] = 10'b00_1011_1011;  //20
neg_encoding[8'b0001_0101] = 10'b10_1010_1011;  //21
neg_encoding[8'b0001_0110] = 10'b01_1010_1011;  //22
neg_encoding[8'b0001_0111] = 10'b11_1010_0100;  //23
neg_encoding[8'b0001_1000] = 10'b11_0011_0100;  //24
neg_encoding[8'b0001_1001] = 10'b10_0110_1011;  //25
neg_encoding[8'b0001_1010] = 10'b01_0110_1011;  //26
neg_encoding[8'b0001_1011] = 10'b11_0110_0100;  //27
neg_encoding[8'b0001_1100] = 10'b00_1110_1011;  //28
neg_encoding[8'b0001_1101] = 10'b10_1110_0100;  //29
neg_encoding[8'b0001_1110] = 10'b01_1110_0100;  //30
neg_encoding[8'b0001_1111] = 10'b10_1011_0100;  //31
neg_encoding[8'b0010_0000] = 10'b10_0111_1001;  //32
neg_encoding[8'b0010_0001] = 10'b01_1101_1001;  //33
neg_encoding[8'b0010_0010] = 10'b10_1101_1001;  //34
neg_encoding[8'b0010_0011] = 10'b11_0001_1001;  //35
neg_encoding[8'b0010_0100] = 10'b11_0101_1001;  //36
neg_encoding[8'b0010_0101] = 10'b10_1001_1001;  //37
neg_encoding[8'b0010_0110] = 10'b01_1001_1001;  //38
neg_encoding[8'b0010_0111] = 10'b11_1000_1001;  //39
neg_encoding[8'b0010_1000] = 10'b11_1001_1001;  //40
neg_encoding[8'b0010_1001] = 10'b10_0101_1001;  //41
neg_encoding[8'b0010_1010] = 10'b01_0101_1001;  //42
neg_encoding[8'b0010_1011] = 10'b11_0100_1001;  //43
neg_encoding[8'b0010_1100] = 10'b00_1101_1001;  //44
neg_encoding[8'b0010_1101] = 10'b10_1100_1001;  //45
neg_encoding[8'b0010_1110] = 10'b01_1100_1001;  //46
neg_encoding[8'b0010_1111] = 10'b01_0111_1001;  //47
neg_encoding[8'b0011_0000] = 10'b01_1011_1001;  //48
neg_encoding[8'b0011_0001] = 10'b10_0011_1001;  //49
neg_encoding[8'b0011_0010] = 10'b01_0011_1001;  //50
neg_encoding[8'b0011_0011] = 10'b11_0010_1001;  //51
neg_encoding[8'b0011_0100] = 10'b00_1011_1001;  //52
neg_encoding[8'b0011_0101] = 10'b10_1010_1001;  //53
neg_encoding[8'b0011_0110] = 10'b01_1010_1001;  //54
neg_encoding[8'b0011_0111] = 10'b11_1010_1001;  //55
neg_encoding[8'b0011_1000] = 10'b11_0011_1001;  //56
neg_encoding[8'b0011_1001] = 10'b10_0110_1001;  //57
neg_encoding[8'b0011_1010] = 10'b01_0110_1001;  //58
neg_encoding[8'b0011_1011] = 10'b11_0110_1001;  //59
neg_encoding[8'b0011_1100] = 10'b00_1110_1001;  //60
neg_encoding[8'b0011_1101] = 10'b10_1110_1001;  //61
neg_encoding[8'b0011_1110] = 10'b01_1110_1001;  //62
neg_encoding[8'b0011_1111] = 10'b10_1011_1001;  //63
neg_encoding[8'b0100_0000] = 10'b10_0111_0101;  //64
neg_encoding[8'b0100_0001] = 10'b01_1101_0101;  //65
neg_encoding[8'b0100_0010] = 10'b10_1101_0101;  //66
neg_encoding[8'b0100_0011] = 10'b11_0001_0101;  //67
neg_encoding[8'b0100_0100] = 10'b11_0101_0101;  //68
neg_encoding[8'b0100_0101] = 10'b10_1001_0101;  //69
neg_encoding[8'b0100_0110] = 10'b01_1001_0101;  //70
neg_encoding[8'b0100_0111] = 10'b11_1000_0101;  //71
neg_encoding[8'b0100_1000] = 10'b11_1001_0101;  //72
neg_encoding[8'b0100_1001] = 10'b10_0101_0101;  //73
neg_encoding[8'b0100_1010] = 10'b01_0101_0101;  //74
neg_encoding[8'b0100_1011] = 10'b11_0100_0101;  //75
neg_encoding[8'b0100_1100] = 10'b00_1101_0101;  //76
neg_encoding[8'b0100_1101] = 10'b10_1100_0101;  //77
neg_encoding[8'b0100_1110] = 10'b01_1100_0101;  //78
neg_encoding[8'b0100_1111] = 10'b01_0111_0101;  //79
neg_encoding[8'b0101_0000] = 10'b01_1011_0101;  //80
neg_encoding[8'b0101_0001] = 10'b10_0011_0101;  //81
neg_encoding[8'b0101_0010] = 10'b01_0011_0101;  //82
neg_encoding[8'b0101_0011] = 10'b11_0010_0101;  //83
neg_encoding[8'b0101_0100] = 10'b00_1011_0101;  //84
neg_encoding[8'b0101_0101] = 10'b10_1010_0101;  //85
neg_encoding[8'b0101_0110] = 10'b01_1010_0101;  //86
neg_encoding[8'b0101_0111] = 10'b11_1010_0101;  //87
neg_encoding[8'b0101_1000] = 10'b11_0011_0101;  //88
neg_encoding[8'b0101_1001] = 10'b10_0110_0101;  //89
neg_encoding[8'b0101_1010] = 10'b01_0110_0101;  //90
neg_encoding[8'b0101_1011] = 10'b11_0110_0101;  //91
neg_encoding[8'b0101_1100] = 10'b00_1110_0101;  //92
neg_encoding[8'b0101_1101] = 10'b10_1110_0101;  //93
neg_encoding[8'b0101_1110] = 10'b01_1110_0101;  //94
neg_encoding[8'b0101_1111] = 10'b10_1011_0101;  //95
neg_encoding[8'b0110_0000] = 10'b10_0111_0011;  //96
neg_encoding[8'b0110_0001] = 10'b01_1101_0011;  //97
neg_encoding[8'b0110_0010] = 10'b10_1101_0011;  //98
neg_encoding[8'b0110_0011] = 10'b11_0001_1100;  //99
neg_encoding[8'b0110_0100] = 10'b11_0101_0011;  //100
neg_encoding[8'b0110_0101] = 10'b10_1001_1100;  //101
neg_encoding[8'b0110_0110] = 10'b01_1001_1100;  //102
neg_encoding[8'b0110_0111] = 10'b11_1000_1100;  //103
neg_encoding[8'b0110_1000] = 10'b11_1001_0011;  //104
neg_encoding[8'b0110_1001] = 10'b10_0101_1100;  //105
neg_encoding[8'b0110_1010] = 10'b01_0101_1100;  //106
neg_encoding[8'b0110_1011] = 10'b11_0100_1100;  //107
neg_encoding[8'b0110_1100] = 10'b00_1101_1100;  //108
neg_encoding[8'b0110_1101] = 10'b10_1100_1100;  //109
neg_encoding[8'b0110_1110] = 10'b01_1100_1100;  //110
neg_encoding[8'b0110_1111] = 10'b01_0111_0011;  //111
neg_encoding[8'b0111_0000] = 10'b01_1011_0011;  //112
neg_encoding[8'b0111_0001] = 10'b10_0011_1100;  //113
neg_encoding[8'b0111_0010] = 10'b01_0011_1100;  //114
neg_encoding[8'b0111_0011] = 10'b11_0010_1100;  //115
neg_encoding[8'b0111_0100] = 10'b00_1011_1100;  //116
neg_encoding[8'b0111_0101] = 10'b10_1010_1100;  //117
neg_encoding[8'b0111_0110] = 10'b01_1010_1100;  //118
neg_encoding[8'b0111_0111] = 10'b11_1010_0011;  //119
neg_encoding[8'b0111_1000] = 10'b11_0011_0011;  //120
neg_encoding[8'b0111_1001] = 10'b10_0110_1100;  //121
neg_encoding[8'b0111_1010] = 10'b01_0110_1100;  //122
neg_encoding[8'b0111_1011] = 10'b11_0110_0011;  //123
neg_encoding[8'b0111_1100] = 10'b00_1110_1100;  //124
neg_encoding[8'b0111_1101] = 10'b10_1110_0011;  //125
neg_encoding[8'b0111_1110] = 10'b01_1110_0011;  //126
neg_encoding[8'b0111_1111] = 10'b10_1011_0011;  //127
neg_encoding[8'b1000_0000] = 10'b10_0111_0010;  //128
neg_encoding[8'b1000_0001] = 10'b01_1101_0010;  //129
neg_encoding[8'b1000_0010] = 10'b10_1101_0010;  //130
neg_encoding[8'b1000_0011] = 10'b11_0001_1101;  //131
neg_encoding[8'b1000_0100] = 10'b11_0101_0010;  //132
neg_encoding[8'b1000_0101] = 10'b10_1001_1101;  //133
neg_encoding[8'b1000_0110] = 10'b01_1001_1101;  //134
neg_encoding[8'b1000_0111] = 10'b11_1000_1101;  //135
neg_encoding[8'b1000_1000] = 10'b11_1001_0010;  //136
neg_encoding[8'b1000_1001] = 10'b10_0101_1101;  //137
neg_encoding[8'b1000_1010] = 10'b01_0101_1101;  //138
neg_encoding[8'b1000_1011] = 10'b11_0100_1101;  //139
neg_encoding[8'b1000_1100] = 10'b00_1101_1101;  //140
neg_encoding[8'b1000_1101] = 10'b10_1100_1101;  //141
neg_encoding[8'b1000_1110] = 10'b01_1100_1101;  //142
neg_encoding[8'b1000_1111] = 10'b01_0111_0010;  //143
neg_encoding[8'b1001_0000] = 10'b01_1011_0010;  //144
neg_encoding[8'b1001_0001] = 10'b10_0011_1101;  //145
neg_encoding[8'b1001_0010] = 10'b01_0011_1101;  //146
neg_encoding[8'b1001_0011] = 10'b11_0010_1101;  //147
neg_encoding[8'b1001_0100] = 10'b00_1011_1101;  //148
neg_encoding[8'b1001_0101] = 10'b10_1010_1101;  //149
neg_encoding[8'b1001_0110] = 10'b01_1010_1101;  //150
neg_encoding[8'b1001_0111] = 10'b11_1010_0010;  //151
neg_encoding[8'b1001_1000] = 10'b11_0011_0010;  //152
neg_encoding[8'b1001_1001] = 10'b10_0110_1101;  //153
neg_encoding[8'b1001_1010] = 10'b01_0110_1101;  //154
neg_encoding[8'b1001_1011] = 10'b11_0110_0010;  //155
neg_encoding[8'b1001_1100] = 10'b00_1110_1101;  //156
neg_encoding[8'b1001_1101] = 10'b10_1110_0010;  //157
neg_encoding[8'b1001_1110] = 10'b01_1110_0010;  //158
neg_encoding[8'b1001_1111] = 10'b10_1011_0010;  //159
neg_encoding[8'b1010_0000] = 10'b10_0111_1010;  //160
neg_encoding[8'b1010_0001] = 10'b01_1101_1010;  //161
neg_encoding[8'b1010_0010] = 10'b10_1101_1010;  //162
neg_encoding[8'b1010_0011] = 10'b11_0001_1010;  //163
neg_encoding[8'b1010_0100] = 10'b11_0101_1010;  //164
neg_encoding[8'b1010_0101] = 10'b10_1001_1010;  //165
neg_encoding[8'b1010_0110] = 10'b01_1001_1010;  //166
neg_encoding[8'b1010_0111] = 10'b11_1000_1010;  //167
neg_encoding[8'b1010_1000] = 10'b11_1001_1010;  //168
neg_encoding[8'b1010_1001] = 10'b10_0101_1010;  //169
neg_encoding[8'b1010_1010] = 10'b01_0101_1010;  //170
neg_encoding[8'b1010_1011] = 10'b11_0100_1010;  //171
neg_encoding[8'b1010_1100] = 10'b00_1101_1010;  //172
neg_encoding[8'b1010_1101] = 10'b10_1100_1010;  //173
neg_encoding[8'b1010_1110] = 10'b01_1100_1010;  //174
neg_encoding[8'b1010_1111] = 10'b01_0111_1010;  //175
neg_encoding[8'b1011_0000] = 10'b01_1011_1010;  //176
neg_encoding[8'b1011_0001] = 10'b10_0011_1010;  //177
neg_encoding[8'b1011_0010] = 10'b01_0011_1010;  //178
neg_encoding[8'b1011_0011] = 10'b11_0010_1010;  //179
neg_encoding[8'b1011_0100] = 10'b00_1011_1010;  //180
neg_encoding[8'b1011_0101] = 10'b10_1010_1010;  //181
neg_encoding[8'b1011_0110] = 10'b01_1010_1010;  //182
neg_encoding[8'b1011_0111] = 10'b11_1010_1010;  //183
neg_encoding[8'b1011_1000] = 10'b11_0011_1010;  //184
neg_encoding[8'b1011_1001] = 10'b10_0110_1010;  //185
neg_encoding[8'b1011_1010] = 10'b01_0110_1010;  //186
neg_encoding[8'b1011_1011] = 10'b11_0110_1010;  //187
neg_encoding[8'b1011_1100] = 10'b00_1110_1010;  //188
neg_encoding[8'b1011_1101] = 10'b10_1110_1010;  //189
neg_encoding[8'b1011_1110] = 10'b01_1110_1010;  //190
neg_encoding[8'b1011_1111] = 10'b10_1011_1010;  //191
neg_encoding[8'b1100_0000] = 10'b10_0111_0110;  //192
neg_encoding[8'b1100_0001] = 10'b01_1101_0110;  //193
neg_encoding[8'b1100_0010] = 10'b10_1101_0110;  //194
neg_encoding[8'b1100_0011] = 10'b11_0001_0110;  //195
neg_encoding[8'b1100_0100] = 10'b11_0101_0110;  //196
neg_encoding[8'b1100_0101] = 10'b10_1001_0110;  //197
neg_encoding[8'b1100_0110] = 10'b01_1001_0110;  //198
neg_encoding[8'b1100_0111] = 10'b11_1000_0110;  //199
neg_encoding[8'b1100_1000] = 10'b11_1001_0110;  //200
neg_encoding[8'b1100_1001] = 10'b10_0101_0110;  //201
neg_encoding[8'b1100_1010] = 10'b01_0101_0110;  //202
neg_encoding[8'b1100_1011] = 10'b11_0100_0110;  //203
neg_encoding[8'b1100_1100] = 10'b00_1101_0110;  //204
neg_encoding[8'b1100_1101] = 10'b10_1100_0110;  //205
neg_encoding[8'b1100_1110] = 10'b01_1100_0110;  //206
neg_encoding[8'b1100_1111] = 10'b01_0111_0110;  //207
neg_encoding[8'b1101_0000] = 10'b01_1011_0110;  //208
neg_encoding[8'b1101_0001] = 10'b10_0011_0110;  //209
neg_encoding[8'b1101_0010] = 10'b01_0011_0110;  //210
neg_encoding[8'b1101_0011] = 10'b11_0010_0110;  //211
neg_encoding[8'b1101_0100] = 10'b00_1011_0110;  //212
neg_encoding[8'b1101_0101] = 10'b10_1010_0110;  //213
neg_encoding[8'b1101_0110] = 10'b01_1010_0110;  //214
neg_encoding[8'b1101_0111] = 10'b11_1010_0110;  //215
neg_encoding[8'b1101_1000] = 10'b11_0011_0110;  //216
neg_encoding[8'b1101_1001] = 10'b10_0110_0110;  //217
neg_encoding[8'b1101_1010] = 10'b01_0110_0110;  //218
neg_encoding[8'b1101_1011] = 10'b11_0110_0110;  //219
neg_encoding[8'b1101_1100] = 10'b00_1110_0110;  //220
neg_encoding[8'b1101_1101] = 10'b10_1110_0110;  //221
neg_encoding[8'b1101_1110] = 10'b01_1110_0110;  //222
neg_encoding[8'b1101_1111] = 10'b10_1011_0110;  //223
neg_encoding[8'b1110_0000] = 10'b10_0111_0001;  //224
neg_encoding[8'b1110_0001] = 10'b01_1101_0001;  //225
neg_encoding[8'b1110_0010] = 10'b10_1101_0001;  //226
neg_encoding[8'b1110_0011] = 10'b11_0001_1110;  //227
neg_encoding[8'b1110_0100] = 10'b11_0101_0001;  //228
neg_encoding[8'b1110_0101] = 10'b10_1001_1110;  //229
neg_encoding[8'b1110_0110] = 10'b01_1001_1110;  //230
neg_encoding[8'b1110_0111] = 10'b11_1000_1110;  //231
neg_encoding[8'b1110_1000] = 10'b11_1001_0001;  //232
neg_encoding[8'b1110_1001] = 10'b10_0101_1110;  //233
neg_encoding[8'b1110_1010] = 10'b01_0101_1110;  //234
neg_encoding[8'b1110_1011] = 10'b11_0100_1110;  //235
neg_encoding[8'b1110_1100] = 10'b00_1101_1110;  //236
neg_encoding[8'b1110_1101] = 10'b10_1100_1110;  //237
neg_encoding[8'b1110_1110] = 10'b01_1100_1110;  //238
neg_encoding[8'b1110_1111] = 10'b01_0111_0001;  //239
neg_encoding[8'b1111_0000] = 10'b01_1011_0001;  //240
neg_encoding[8'b1111_0001] = 10'b10_0011_0111;  //241
neg_encoding[8'b1111_0010] = 10'b01_0011_0111;  //242
neg_encoding[8'b1111_0011] = 10'b11_0010_1110;  //243
neg_encoding[8'b1111_0100] = 10'b00_1011_0111;  //244
neg_encoding[8'b1111_0101] = 10'b10_1010_1110;  //245
neg_encoding[8'b1111_0110] = 10'b01_1010_1110;  //246
neg_encoding[8'b1111_0111] = 10'b11_1010_0001;  //247
neg_encoding[8'b1111_1000] = 10'b11_0011_0001;  //248
neg_encoding[8'b1111_1001] = 10'b10_0110_1110;  //249
neg_encoding[8'b1111_1010] = 10'b01_0110_1110;  //250
neg_encoding[8'b1111_1011] = 10'b11_0110_0001;  //251
neg_encoding[8'b1111_1100] = 10'b00_1110_1110;  //252
neg_encoding[8'b1111_1101] = 10'b10_1110_0001;  //253
neg_encoding[8'b1111_1110] = 10'b01_1110_0001;  //254
neg_encoding[8'b1111_1111] = 10'b10_1011_0001;  //255

    ///////////////////////////////////////////
    /////////////positive encoding/////////////
    ///////////////////////////////////////////

    // data - positive
pos_encoding[8'b0000_0000] = 10'b01_1000_1011;  //0
pos_encoding[8'b0000_0001] = 10'b10_0010_1011;  //1
pos_encoding[8'b0000_0010] = 10'b01_0010_1011;  //2
pos_encoding[8'b0000_0011] = 10'b11_0001_0100;  //3
pos_encoding[8'b0000_0100] = 10'b00_1010_1011;  //4
pos_encoding[8'b0000_0101] = 10'b10_1001_0100;  //5
pos_encoding[8'b0000_0110] = 10'b01_1001_0100;  //6
pos_encoding[8'b0000_0111] = 10'b00_0111_0100;  //7
pos_encoding[8'b0000_1000] = 10'b00_0110_1011;  //8
pos_encoding[8'b0000_1001] = 10'b10_0101_0100;  //9
pos_encoding[8'b0000_1010] = 10'b01_0101_0100;  //10
pos_encoding[8'b0000_1011] = 10'b11_0100_0100;  //11
pos_encoding[8'b0000_1100] = 10'b00_1101_0100;  //12
pos_encoding[8'b0000_1101] = 10'b10_1100_0100;  //13
pos_encoding[8'b0000_1110] = 10'b01_1100_0100;  //14
pos_encoding[8'b0000_1111] = 10'b10_1000_1011;  //15
pos_encoding[8'b0001_0000] = 10'b10_0100_1011;  //16
pos_encoding[8'b0001_0001] = 10'b10_0011_0100;  //17
pos_encoding[8'b0001_0010] = 10'b01_0011_0100;  //18
pos_encoding[8'b0001_0011] = 10'b11_0010_0100;  //19
pos_encoding[8'b0001_0100] = 10'b00_1011_0100;  //20
pos_encoding[8'b0001_0101] = 10'b10_1010_0100;  //21
pos_encoding[8'b0001_0110] = 10'b01_1010_0100;  //22
pos_encoding[8'b0001_0111] = 10'b00_0101_1011;  //23
pos_encoding[8'b0001_1000] = 10'b00_1100_1011;  //24
pos_encoding[8'b0001_1001] = 10'b10_0110_0100;  //25
pos_encoding[8'b0001_1010] = 10'b01_0110_0100;  //26
pos_encoding[8'b0001_1011] = 10'b00_1001_1011;  //27
pos_encoding[8'b0001_1100] = 10'b00_1110_0100;  //28
pos_encoding[8'b0001_1101] = 10'b01_0001_1011;  //29
pos_encoding[8'b0001_1110] = 10'b10_0001_1011;  //30
pos_encoding[8'b0001_1111] = 10'b01_0100_1011;  //31
pos_encoding[8'b0010_0000] = 10'b01_1000_1001;  //32
pos_encoding[8'b0010_0001] = 10'b10_0010_1001;  //33
pos_encoding[8'b0010_0010] = 10'b01_0010_1001;  //34
pos_encoding[8'b0010_0011] = 10'b11_0001_1001;  //35
pos_encoding[8'b0010_0100] = 10'b00_1010_1001;  //36
pos_encoding[8'b0010_0101] = 10'b10_1001_1001;  //37
pos_encoding[8'b0010_0110] = 10'b01_1001_1001;  //38
pos_encoding[8'b0010_0111] = 10'b00_0111_1001;  //39
pos_encoding[8'b0010_1000] = 10'b00_0110_1001;  //40
pos_encoding[8'b0010_1001] = 10'b10_0101_1001;  //41
pos_encoding[8'b0010_1010] = 10'b01_0101_1001;  //42
pos_encoding[8'b0010_1011] = 10'b11_0100_1001;  //43
pos_encoding[8'b0010_1100] = 10'b00_1101_1001;  //44
pos_encoding[8'b0010_1101] = 10'b10_1100_1001;  //45
pos_encoding[8'b0010_1110] = 10'b01_1100_1001;  //46
pos_encoding[8'b0010_1111] = 10'b10_1000_1001;  //47
pos_encoding[8'b0011_0000] = 10'b10_0100_1001;  //48
pos_encoding[8'b0011_0001] = 10'b10_0011_1001;  //49
pos_encoding[8'b0011_0010] = 10'b01_0011_1001;  //50
pos_encoding[8'b0011_0011] = 10'b11_0010_1001;  //51
pos_encoding[8'b0011_0100] = 10'b00_1011_1001;  //52
pos_encoding[8'b0011_0101] = 10'b10_1010_1001;  //53
pos_encoding[8'b0011_0110] = 10'b01_1010_1001;  //54
pos_encoding[8'b0011_0111] = 10'b00_0101_1001;  //55
pos_encoding[8'b0011_1000] = 10'b00_1100_1001;  //56
pos_encoding[8'b0011_1001] = 10'b10_0110_1001;  //57
pos_encoding[8'b0011_1010] = 10'b01_0110_1001;  //58
pos_encoding[8'b0011_1011] = 10'b00_1001_1001;  //59
pos_encoding[8'b0011_1100] = 10'b00_1110_1001;  //60
pos_encoding[8'b0011_1101] = 10'b01_0001_1001;  //61
pos_encoding[8'b0011_1110] = 10'b10_0001_1001;  //62
pos_encoding[8'b0011_1111] = 10'b01_0100_1001;  //63
pos_encoding[8'b0100_0000] = 10'b01_1000_0101;  //64
pos_encoding[8'b0100_0001] = 10'b10_0010_0101;  //65
pos_encoding[8'b0100_0010] = 10'b01_0010_0101;  //66
pos_encoding[8'b0100_0011] = 10'b11_0001_0101;  //67
pos_encoding[8'b0100_0100] = 10'b00_1010_0101;  //68
pos_encoding[8'b0100_0101] = 10'b10_1001_0101;  //69
pos_encoding[8'b0100_0110] = 10'b01_1001_0101;  //70
pos_encoding[8'b0100_0111] = 10'b00_0111_0101;  //71
pos_encoding[8'b0100_1000] = 10'b00_0110_0101;  //72
pos_encoding[8'b0100_1001] = 10'b10_0101_0101;  //73
pos_encoding[8'b0100_1010] = 10'b01_0101_0101;  //74
pos_encoding[8'b0100_1011] = 10'b11_0100_0101;  //75
pos_encoding[8'b0100_1100] = 10'b00_1101_0101;  //76
pos_encoding[8'b0100_1101] = 10'b10_1100_0101;  //77
pos_encoding[8'b0100_1110] = 10'b01_1100_0101;  //78
pos_encoding[8'b0100_1111] = 10'b10_1000_0101;  //79
pos_encoding[8'b0101_0000] = 10'b10_0100_0101;  //80
pos_encoding[8'b0101_0001] = 10'b10_0011_0101;  //81
pos_encoding[8'b0101_0010] = 10'b01_0011_0101;  //82
pos_encoding[8'b0101_0011] = 10'b11_0010_0101;  //83
pos_encoding[8'b0101_0100] = 10'b00_1011_0101;  //84
pos_encoding[8'b0101_0101] = 10'b10_1010_0101;  //85
pos_encoding[8'b0101_0110] = 10'b01_1010_0101;  //86
pos_encoding[8'b0101_0111] = 10'b00_0101_0101;  //87
pos_encoding[8'b0101_1000] = 10'b00_1100_0101;  //88
pos_encoding[8'b0101_1001] = 10'b10_0110_0101;  //89
pos_encoding[8'b0101_1010] = 10'b01_0110_0101;  //90
pos_encoding[8'b0101_1011] = 10'b00_1001_0101;  //91
pos_encoding[8'b0101_1100] = 10'b00_1110_0101;  //92
pos_encoding[8'b0101_1101] = 10'b01_0001_0101;  //93
pos_encoding[8'b0101_1110] = 10'b10_0001_0101;  //94
pos_encoding[8'b0101_1111] = 10'b01_0100_0101;  //95
pos_encoding[8'b0110_0000] = 10'b01_1000_1100;  //96
pos_encoding[8'b0110_0001] = 10'b10_0010_1100;  //97
pos_encoding[8'b0110_0010] = 10'b01_0010_1100;  //98
pos_encoding[8'b0110_0011] = 10'b11_0001_0011;  //99
pos_encoding[8'b0110_0100] = 10'b00_1010_1100;  //100
pos_encoding[8'b0110_0101] = 10'b10_1001_0011;  //101
pos_encoding[8'b0110_0110] = 10'b01_1001_0011;  //102
pos_encoding[8'b0110_0111] = 10'b00_0111_0011;  //103
pos_encoding[8'b0110_1000] = 10'b00_0110_1100;  //104
pos_encoding[8'b0110_1001] = 10'b10_0101_0011;  //105
pos_encoding[8'b0110_1010] = 10'b01_0101_0011;  //106
pos_encoding[8'b0110_1011] = 10'b11_0100_0011;  //107
pos_encoding[8'b0110_1100] = 10'b00_1101_0011;  //108
pos_encoding[8'b0110_1101] = 10'b10_1100_0011;  //109
pos_encoding[8'b0110_1110] = 10'b01_1100_0011;  //110
pos_encoding[8'b0110_1111] = 10'b10_1000_1100;  //111
pos_encoding[8'b0111_0000] = 10'b10_0100_1100;  //112
pos_encoding[8'b0111_0001] = 10'b10_0011_0011;  //113
pos_encoding[8'b0111_0010] = 10'b01_0011_0011;  //114
pos_encoding[8'b0111_0011] = 10'b11_0010_0011;  //115
pos_encoding[8'b0111_0100] = 10'b00_1011_0011;  //116
pos_encoding[8'b0111_0101] = 10'b10_1010_0011;  //117
pos_encoding[8'b0111_0110] = 10'b01_1010_0011;  //118
pos_encoding[8'b0111_0111] = 10'b00_0101_1100;  //119
pos_encoding[8'b0111_1000] = 10'b00_1100_1100;  //120
pos_encoding[8'b0111_1001] = 10'b10_0110_0011;  //121
pos_encoding[8'b0111_1010] = 10'b01_0110_0011;  //122
pos_encoding[8'b0111_1011] = 10'b00_1001_1100;  //123
pos_encoding[8'b0111_1100] = 10'b00_1110_0011;  //124
pos_encoding[8'b0111_1101] = 10'b01_0001_1100;  //125
pos_encoding[8'b0111_1110] = 10'b10_0001_1100;  //126
pos_encoding[8'b0111_1111] = 10'b01_0100_1100;  //127
pos_encoding[8'b1000_0000] = 10'b01_1000_1101;  //128
pos_encoding[8'b1000_0001] = 10'b10_0010_1101;  //129
pos_encoding[8'b1000_0010] = 10'b01_0010_1101;  //130
pos_encoding[8'b1000_0011] = 10'b11_0001_0010;  //131
pos_encoding[8'b1000_0100] = 10'b00_1010_1101;  //132
pos_encoding[8'b1000_0101] = 10'b10_1001_0010;  //133
pos_encoding[8'b1000_0110] = 10'b01_1001_0010;  //134
pos_encoding[8'b1000_0111] = 10'b00_0111_0010;  //135
pos_encoding[8'b1000_1000] = 10'b00_0110_1101;  //136
pos_encoding[8'b1000_1001] = 10'b10_0101_0010;  //137
pos_encoding[8'b1000_1010] = 10'b01_0101_0010;  //138
pos_encoding[8'b1000_1011] = 10'b11_0100_0010;  //139
pos_encoding[8'b1000_1100] = 10'b00_1101_0010;  //140
pos_encoding[8'b1000_1101] = 10'b10_1100_0010;  //141
pos_encoding[8'b1000_1110] = 10'b01_1100_0010;  //142
pos_encoding[8'b1000_1111] = 10'b10_1000_1101;  //143
pos_encoding[8'b1001_0000] = 10'b10_0100_1101;  //144
pos_encoding[8'b1001_0001] = 10'b10_0011_0010;  //145
pos_encoding[8'b1001_0010] = 10'b01_0011_0010;  //146
pos_encoding[8'b1001_0011] = 10'b11_0010_0010;  //147
pos_encoding[8'b1001_0100] = 10'b00_1011_0010;  //148
pos_encoding[8'b1001_0101] = 10'b10_1010_0010;  //149
pos_encoding[8'b1001_0110] = 10'b01_1010_0010;  //150
pos_encoding[8'b1001_0111] = 10'b00_0101_1101;  //151
pos_encoding[8'b1001_1000] = 10'b00_1100_1101;  //152
pos_encoding[8'b1001_1001] = 10'b10_0110_0010;  //153
pos_encoding[8'b1001_1010] = 10'b01_0110_0010;  //154
pos_encoding[8'b1001_1011] = 10'b00_1001_1101;  //155
pos_encoding[8'b1001_1100] = 10'b00_1110_0010;  //156
pos_encoding[8'b1001_1101] = 10'b01_0001_1101;  //157
pos_encoding[8'b1001_1110] = 10'b10_0001_1101;  //158
pos_encoding[8'b1001_1111] = 10'b01_0100_1101;  //159
pos_encoding[8'b1010_0000] = 10'b01_1000_1010;  //160
pos_encoding[8'b1010_0001] = 10'b10_0010_1010;  //161
pos_encoding[8'b1010_0010] = 10'b01_0010_1010;  //162
pos_encoding[8'b1010_0011] = 10'b11_0001_1010;  //163
pos_encoding[8'b1010_0100] = 10'b00_1010_1010;  //164
pos_encoding[8'b1010_0101] = 10'b10_1001_1010;  //165
pos_encoding[8'b1010_0110] = 10'b01_1001_1010;  //166
pos_encoding[8'b1010_0111] = 10'b00_0111_1010;  //167
pos_encoding[8'b1010_1000] = 10'b00_0110_1010;  //168
pos_encoding[8'b1010_1001] = 10'b10_0101_1010;  //169
pos_encoding[8'b1010_1010] = 10'b01_0101_1010;  //170
pos_encoding[8'b1010_1011] = 10'b11_0100_1010;  //171
pos_encoding[8'b1010_1100] = 10'b00_1101_1010;  //172
pos_encoding[8'b1010_1101] = 10'b10_1100_1010;  //173
pos_encoding[8'b1010_1110] = 10'b01_1100_1010;  //174
pos_encoding[8'b1010_1111] = 10'b10_1000_1010;  //175
pos_encoding[8'b1011_0000] = 10'b10_0100_1010;  //176
pos_encoding[8'b1011_0001] = 10'b10_0011_1010;  //177
pos_encoding[8'b1011_0010] = 10'b01_0011_1010;  //178
pos_encoding[8'b1011_0011] = 10'b11_0010_1010;  //179
pos_encoding[8'b1011_0100] = 10'b00_1011_1010;  //180
pos_encoding[8'b1011_0101] = 10'b10_1010_1010;  //181
pos_encoding[8'b1011_0110] = 10'b01_1010_1010;  //182
pos_encoding[8'b1011_0111] = 10'b00_0101_1010;  //183
pos_encoding[8'b1011_1000] = 10'b00_1100_1010;  //184
pos_encoding[8'b1011_1001] = 10'b10_0110_1010;  //185
pos_encoding[8'b1011_1010] = 10'b01_0110_1010;  //186
pos_encoding[8'b1011_1011] = 10'b00_1001_1010;  //187
pos_encoding[8'b1011_1100] = 10'b00_1110_1010;  //188
pos_encoding[8'b1011_1101] = 10'b01_0001_1010;  //189
pos_encoding[8'b1011_1110] = 10'b10_0001_1010;  //190
pos_encoding[8'b1011_1111] = 10'b01_0100_1010;  //191
pos_encoding[8'b1100_0000] = 10'b01_1000_0110;  //192
pos_encoding[8'b1100_0001] = 10'b10_0010_0110;  //193
pos_encoding[8'b1100_0010] = 10'b01_0010_0110;  //194
pos_encoding[8'b1100_0011] = 10'b11_0001_0110;  //195
pos_encoding[8'b1100_0100] = 10'b00_1010_0110;  //196
pos_encoding[8'b1100_0101] = 10'b10_1001_0110;  //197
pos_encoding[8'b1100_0110] = 10'b01_1001_0110;  //198
pos_encoding[8'b1100_0111] = 10'b00_0111_0110;  //199
pos_encoding[8'b1100_1000] = 10'b00_0110_0110;  //200
pos_encoding[8'b1100_1001] = 10'b10_0101_0110;  //201
pos_encoding[8'b1100_1010] = 10'b01_0101_0110;  //202
pos_encoding[8'b1100_1011] = 10'b11_0100_0110;  //203
pos_encoding[8'b1100_1100] = 10'b00_1101_0110;  //204
pos_encoding[8'b1100_1101] = 10'b10_1100_0110;  //205
pos_encoding[8'b1100_1110] = 10'b01_1100_0110;  //206
pos_encoding[8'b1100_1111] = 10'b10_1000_0110;  //207
pos_encoding[8'b1101_0000] = 10'b10_0100_0110;  //208
pos_encoding[8'b1101_0001] = 10'b10_0011_0110;  //209
pos_encoding[8'b1101_0010] = 10'b01_0011_0110;  //210
pos_encoding[8'b1101_0011] = 10'b11_0010_0110;  //211
pos_encoding[8'b1101_0100] = 10'b00_1011_0110;  //212
pos_encoding[8'b1101_0101] = 10'b10_1010_0110;  //213
pos_encoding[8'b1101_0110] = 10'b01_1010_0110;  //214
pos_encoding[8'b1101_0111] = 10'b00_0101_0110;  //215
pos_encoding[8'b1101_1000] = 10'b00_1100_0110;  //216
pos_encoding[8'b1101_1001] = 10'b10_0110_0110;  //217
pos_encoding[8'b1101_1010] = 10'b01_0110_0110;  //218
pos_encoding[8'b1101_1011] = 10'b00_1001_0110;  //219
pos_encoding[8'b1101_1100] = 10'b00_1110_0110;  //220
pos_encoding[8'b1101_1101] = 10'b01_0001_0110;  //221
pos_encoding[8'b1101_1110] = 10'b10_0001_0110;  //222
pos_encoding[8'b1101_1111] = 10'b01_0100_0110;  //223
pos_encoding[8'b1110_0000] = 10'b01_1000_1110;  //224
pos_encoding[8'b1110_0001] = 10'b10_0010_1110;  //225
pos_encoding[8'b1110_0010] = 10'b01_0010_1110;  //226
pos_encoding[8'b1110_0011] = 10'b11_0001_0001;  //227
pos_encoding[8'b1110_0100] = 10'b00_1010_1110;  //228
pos_encoding[8'b1110_0101] = 10'b10_1001_0001;  //229
pos_encoding[8'b1110_0110] = 10'b01_1001_0001;  //230
pos_encoding[8'b1110_0111] = 10'b00_0111_0001;  //231
pos_encoding[8'b1110_1000] = 10'b00_0110_1110;  //232
pos_encoding[8'b1110_1001] = 10'b10_0101_0001;  //233
pos_encoding[8'b1110_1010] = 10'b01_0101_0001;  //234
pos_encoding[8'b1110_1011] = 10'b11_0100_1000;  //235
pos_encoding[8'b1110_1100] = 10'b00_1101_0001;  //236
pos_encoding[8'b1110_1101] = 10'b10_1100_1000;  //237
pos_encoding[8'b1110_1110] = 10'b01_1100_1000;  //238
pos_encoding[8'b1110_1111] = 10'b10_1000_1110;  //239
pos_encoding[8'b1111_0000] = 10'b10_0100_1110;  //240
pos_encoding[8'b1111_0001] = 10'b10_0011_0001;  //241
pos_encoding[8'b1111_0010] = 10'b01_0011_0001;  //242
pos_encoding[8'b1111_0011] = 10'b11_0010_0001;  //243
pos_encoding[8'b1111_0100] = 10'b00_1011_0001;  //244
pos_encoding[8'b1111_0101] = 10'b10_1010_0001;  //245
pos_encoding[8'b1111_0110] = 10'b01_1010_0001;  //246
pos_encoding[8'b1111_0111] = 10'b00_0101_1110;  //247
pos_encoding[8'b1111_1000] = 10'b00_1100_1110;  //248
pos_encoding[8'b1111_1001] = 10'b10_0110_0001;  //249
pos_encoding[8'b1111_1010] = 10'b01_0110_0001;  //250
pos_encoding[8'b1111_1011] = 10'b00_1001_1110;  //251
pos_encoding[8'b1111_1100] = 10'b00_1110_0001;  //252
pos_encoding[8'b1111_1101] = 10'b01_0001_1110;  //253
pos_encoding[8'b1111_1110] = 10'b10_0001_1110;  //254
pos_encoding[8'b1111_1111] = 10'b01_0100_1110;  //255 



////////////////////////////////////////////////////////////////////////////
///////////////////////////////// DECODING /////////////////////////////////
////////////////////////////////////////////////////////////////////////////


    neg_decoding[10'b10_0111_0100] = 8'b0000_0000;  //0
    neg_decoding[10'b01_1101_0100] = 8'b0000_0001;  //1
    neg_decoding[10'b10_1101_0100] = 8'b0000_0010;  //2
    neg_decoding[10'b11_0001_1011] = 8'b0000_0011;  //3
    neg_decoding[10'b11_0101_0100] = 8'b0000_0100;  //4
    neg_decoding[10'b10_1001_1011] = 8'b0000_0101;  //5
    neg_decoding[10'b01_1001_1011] = 8'b0000_0110;  //6
    neg_decoding[10'b11_1000_1011] = 8'b0000_0111;  //7
    neg_decoding[10'b11_1001_0100] = 8'b0000_1000;  //8
    neg_decoding[10'b10_0101_1011] = 8'b0000_1001;  //9
    neg_decoding[10'b01_0101_1011] = 8'b0000_1010;  //10
    neg_decoding[10'b11_0100_1011] = 8'b0000_1011;  //11
    neg_decoding[10'b00_1101_1011] = 8'b0000_1100;  //12
    neg_decoding[10'b10_1100_1011] = 8'b0000_1101;  //13
    neg_decoding[10'b01_1100_1011] = 8'b0000_1110;  //14
    neg_decoding[10'b01_0111_0100] = 8'b0000_1111;  //15
    neg_decoding[10'b01_1011_0100] = 8'b0001_0000;  //16
    neg_decoding[10'b10_0011_1011] = 8'b0001_0001;  //17
    neg_decoding[10'b01_0011_1011] = 8'b0001_0010;  //18
    neg_decoding[10'b11_0010_1011] = 8'b0001_0011;  //19
    neg_decoding[10'b00_1011_1011] = 8'b0001_0100;  //20
    neg_decoding[10'b10_1010_1011] = 8'b0001_0101;  //21
    neg_decoding[10'b01_1010_1011] = 8'b0001_0110;  //22
    neg_decoding[10'b11_1010_0100] = 8'b0001_0111;  //23
    neg_decoding[10'b11_0011_0100] = 8'b0001_1000;  //24
    neg_decoding[10'b10_0110_1011] = 8'b0001_1001;  //25
    neg_decoding[10'b01_0110_1011] = 8'b0001_1010;  //26
    neg_decoding[10'b11_0110_0100] = 8'b0001_1011;  //27
    neg_decoding[10'b00_1110_1011] = 8'b0001_1100;  //28
    neg_decoding[10'b10_1110_0100] = 8'b0001_1101;  //29
    neg_decoding[10'b01_1110_0100] = 8'b0001_1110;  //30
    neg_decoding[10'b10_1011_0100] = 8'b0001_1111;  //31
    neg_decoding[10'b10_0111_1001] = 8'b0010_0000;  //32
    neg_decoding[10'b01_1101_1001] = 8'b0010_0001;  //33
    neg_decoding[10'b10_1101_1001] = 8'b0010_0010;  //34
    neg_decoding[10'b11_0001_1001] = 8'b0010_0011;  //35
    neg_decoding[10'b11_0101_1001] = 8'b0010_0100;  //36
    neg_decoding[10'b10_1001_1001] = 8'b0010_0101;  //37
    neg_decoding[10'b01_1001_1001] = 8'b0010_0110;  //38
    neg_decoding[10'b11_1000_1001] = 8'b0010_0111;  //39
    neg_decoding[10'b11_1001_1001] = 8'b0010_1000;  //40
    neg_decoding[10'b10_0101_1001] = 8'b0010_1001;  //41
    neg_decoding[10'b01_0101_1001] = 8'b0010_1010;  //42
    neg_decoding[10'b11_0100_1001] = 8'b0010_1011;  //43
    neg_decoding[10'b00_1101_1001] = 8'b0010_1100;  //44
    neg_decoding[10'b10_1100_1001] = 8'b0010_1101;  //45
    neg_decoding[10'b01_1100_1001] = 8'b0010_1110;  //46
    neg_decoding[10'b01_0111_1001] = 8'b0010_1111;  //47
    neg_decoding[10'b01_1011_1001] = 8'b0011_0000;  //48
    neg_decoding[10'b10_0011_1001] = 8'b0011_0001;  //49
    neg_decoding[10'b01_0011_1001] = 8'b0011_0010;  //50
    neg_decoding[10'b11_0010_1001] = 8'b0011_0011;  //51
    neg_decoding[10'b00_1011_1001] = 8'b0011_0100;  //52
    neg_decoding[10'b10_1010_1001] = 8'b0011_0101;  //53
    neg_decoding[10'b01_1010_1001] = 8'b0011_0110;  //54
    neg_decoding[10'b11_1010_1001] = 8'b0011_0111;  //55
    neg_decoding[10'b11_0011_1001] = 8'b0011_1000;  //56
    neg_decoding[10'b10_0110_1001] = 8'b0011_1001;  //57
    neg_decoding[10'b01_0110_1001] = 8'b0011_1010;  //58
    neg_decoding[10'b11_0110_1001] = 8'b0011_1011;  //59
    neg_decoding[10'b00_1110_1001] = 8'b0011_1100;  //60
    neg_decoding[10'b10_1110_1001] = 8'b0011_1101;  //61
    neg_decoding[10'b01_1110_1001] = 8'b0011_1110;  //62
    neg_decoding[10'b10_1011_1001] = 8'b0011_1111;  //63
    neg_decoding[10'b10_0111_0101] = 8'b0100_0000;  //64
    neg_decoding[10'b01_1101_0101] = 8'b0100_0001;  //65
    neg_decoding[10'b10_1101_0101] = 8'b0100_0010;  //66
    neg_decoding[10'b11_0001_0101] = 8'b0100_0011;  //67
    neg_decoding[10'b11_0101_0101] = 8'b0100_0100;  //68
    neg_decoding[10'b10_1001_0101] = 8'b0100_0101;  //69
    neg_decoding[10'b01_1001_0101] = 8'b0100_0110;  //70
    neg_decoding[10'b11_1000_0101] = 8'b0100_0111;  //71
    neg_decoding[10'b11_1001_0101] = 8'b0100_1000;  //72
    neg_decoding[10'b10_0101_0101] = 8'b0100_1001;  //73
    neg_decoding[10'b01_0101_0101] = 8'b0100_1010;  //74
    neg_decoding[10'b11_0100_0101] = 8'b0100_1011;  //75
    neg_decoding[10'b00_1101_0101] = 8'b0100_1100;  //76
    neg_decoding[10'b10_1100_0101] = 8'b0100_1101;  //77
    neg_decoding[10'b01_1100_0101] = 8'b0100_1110;  //78
    neg_decoding[10'b01_0111_0101] = 8'b0100_1111;  //79
    neg_decoding[10'b01_1011_0101] = 8'b0101_0000;  //80
    neg_decoding[10'b10_0011_0101] = 8'b0101_0001;  //81
    neg_decoding[10'b01_0011_0101] = 8'b0101_0010;  //82
    neg_decoding[10'b11_0010_0101] = 8'b0101_0011;  //83
    neg_decoding[10'b00_1011_0101] = 8'b0101_0100;  //84
    neg_decoding[10'b10_1010_0101] = 8'b0101_0101;  //85
    neg_decoding[10'b01_1010_0101] = 8'b0101_0110;  //86
    neg_decoding[10'b11_1010_0101] = 8'b0101_0111;  //87
    neg_decoding[10'b11_0011_0101] = 8'b0101_1000;  //88
    neg_decoding[10'b10_0110_0101] = 8'b0101_1001;  //89
    neg_decoding[10'b01_0110_0101] = 8'b0101_1010;  //90
    neg_decoding[10'b11_0110_0101] = 8'b0101_1011;  //91
    neg_decoding[10'b00_1110_0101] = 8'b0101_1100;  //92
    neg_decoding[10'b10_1110_0101] = 8'b0101_1101;  //93
    neg_decoding[10'b01_1110_0101] = 8'b0101_1110;  //94
    neg_decoding[10'b10_1011_0101] = 8'b0101_1111;  //95
    neg_decoding[10'b10_0111_0011] = 8'b0110_0000;  //96
    neg_decoding[10'b01_1101_0011] = 8'b0110_0001;  //97
    neg_decoding[10'b10_1101_0011] = 8'b0110_0010;  //98
    neg_decoding[10'b11_0001_1100] = 8'b0110_0011;  //99
    neg_decoding[10'b11_0101_0011] = 8'b0110_0100;  //100
    neg_decoding[10'b10_1001_1100] = 8'b0110_0101;  //101
    neg_decoding[10'b01_1001_1100] = 8'b0110_0110;  //102
    neg_decoding[10'b11_1000_1100] = 8'b0110_0111;  //103
    neg_decoding[10'b11_1001_0011] = 8'b0110_1000;  //104
    neg_decoding[10'b10_0101_1100] = 8'b0110_1001;  //105
    neg_decoding[10'b01_0101_1100] = 8'b0110_1010;  //106
    neg_decoding[10'b11_0100_1100] = 8'b0110_1011;  //107
    neg_decoding[10'b00_1101_1100] = 8'b0110_1100;  //108
    neg_decoding[10'b10_1100_1100] = 8'b0110_1101;  //109
    neg_decoding[10'b01_1100_1100] = 8'b0110_1110;  //110
    neg_decoding[10'b01_0111_0011] = 8'b0110_1111;  //111
    neg_decoding[10'b01_1011_0011] = 8'b0111_0000;  //112
    neg_decoding[10'b10_0011_1100] = 8'b0111_0001;  //113
    neg_decoding[10'b01_0011_1100] = 8'b0111_0010;  //114
    neg_decoding[10'b11_0010_1100] = 8'b0111_0011;  //115
    neg_decoding[10'b00_1011_1100] = 8'b0111_0100;  //116
    neg_decoding[10'b10_1010_1100] = 8'b0111_0101;  //117
    neg_decoding[10'b01_1010_1100] = 8'b0111_0110;  //118
    neg_decoding[10'b11_1010_0011] = 8'b0111_0111;  //119
    neg_decoding[10'b11_0011_0011] = 8'b0111_1000;  //120
    neg_decoding[10'b10_0110_1100] = 8'b0111_1001;  //121
    neg_decoding[10'b01_0110_1100] = 8'b0111_1010;  //122
    neg_decoding[10'b11_0110_0011] = 8'b0111_1011;  //123
    neg_decoding[10'b00_1110_1100] = 8'b0111_1100;  //124
    neg_decoding[10'b10_1110_0011] = 8'b0111_1101;  //125
    neg_decoding[10'b01_1110_0011] = 8'b0111_1110;  //126
    neg_decoding[10'b10_1011_0011] = 8'b0111_1111;  //127
    neg_decoding[10'b10_0111_0010] = 8'b1000_0000;  //128
    neg_decoding[10'b01_1101_0010] = 8'b1000_0001;  //129
    neg_decoding[10'b10_1101_0010] = 8'b1000_0010;  //130
    neg_decoding[10'b11_0001_1101] = 8'b1000_0011;  //131
    neg_decoding[10'b11_0101_0010] = 8'b1000_0100;  //132
    neg_decoding[10'b10_1001_1101] = 8'b1000_0101;  //133
    neg_decoding[10'b01_1001_1101] = 8'b1000_0110;  //134
    neg_decoding[10'b11_1000_1101] = 8'b1000_0111;  //135
    neg_decoding[10'b11_1001_0010] = 8'b1000_1000;  //136
    neg_decoding[10'b10_0101_1101] = 8'b1000_1001;  //137
    neg_decoding[10'b01_0101_1101] = 8'b1000_1010;  //138
    neg_decoding[10'b11_0100_1101] = 8'b1000_1011;  //139
    neg_decoding[10'b00_1101_1101] = 8'b1000_1100;  //140
    neg_decoding[10'b10_1100_1101] = 8'b1000_1101;  //141
    neg_decoding[10'b01_1100_1101] = 8'b1000_1110;  //142
    neg_decoding[10'b01_0111_0010] = 8'b1000_1111;  //143
    neg_decoding[10'b01_1011_0010] = 8'b1001_0000;  //144
    neg_decoding[10'b10_0011_1101] = 8'b1001_0001;  //145
    neg_decoding[10'b01_0011_1101] = 8'b1001_0010;  //146
    neg_decoding[10'b11_0010_1101] = 8'b1001_0011;  //147
    neg_decoding[10'b00_1011_1101] = 8'b1001_0100;  //148
    neg_decoding[10'b10_1010_1101] = 8'b1001_0101;  //149
    neg_decoding[10'b01_1010_1101] = 8'b1001_0110;  //150
    neg_decoding[10'b11_1010_0010] = 8'b1001_0111;  //151
    neg_decoding[10'b11_0011_0010] = 8'b1001_1000;  //152
    neg_decoding[10'b10_0110_1101] = 8'b1001_1001;  //153
    neg_decoding[10'b01_0110_1101] = 8'b1001_1010;  //154
    neg_decoding[10'b11_0110_0010] = 8'b1001_1011;  //155
    neg_decoding[10'b00_1110_1101] = 8'b1001_1100;  //156
    neg_decoding[10'b10_1110_0010] = 8'b1001_1101;  //157
    neg_decoding[10'b01_1110_0010] = 8'b1001_1110;  //158
    neg_decoding[10'b10_1011_0010] = 8'b1001_1111;  //159
    neg_decoding[10'b10_0111_1010] = 8'b1010_0000;  //160
    neg_decoding[10'b01_1101_1010] = 8'b1010_0001;  //161
    neg_decoding[10'b10_1101_1010] = 8'b1010_0010;  //162
    neg_decoding[10'b11_0001_1010] = 8'b1010_0011;  //163
    neg_decoding[10'b11_0101_1010] = 8'b1010_0100;  //164
    neg_decoding[10'b10_1001_1010] = 8'b1010_0101;  //165
    neg_decoding[10'b01_1001_1010] = 8'b1010_0110;  //166
    neg_decoding[10'b11_1000_1010] = 8'b1010_0111;  //167
    neg_decoding[10'b11_1001_1010] = 8'b1010_1000;  //168
    neg_decoding[10'b10_0101_1010] = 8'b1010_1001;  //169
    neg_decoding[10'b01_0101_1010] = 8'b1010_1010;  //170
    neg_decoding[10'b11_0100_1010] = 8'b1010_1011;  //171
    neg_decoding[10'b00_1101_1010] = 8'b1010_1100;  //172
    neg_decoding[10'b10_1100_1010] = 8'b1010_1101;  //173
    neg_decoding[10'b01_1100_1010] = 8'b1010_1110;  //174
    neg_decoding[10'b01_0111_1010] = 8'b1010_1111;  //175
    neg_decoding[10'b01_1011_1010] = 8'b1011_0000;  //176
    neg_decoding[10'b10_0011_1010] = 8'b1011_0001;  //177
    neg_decoding[10'b01_0011_1010] = 8'b1011_0010;  //178
    neg_decoding[10'b11_0010_1010] = 8'b1011_0011;  //179
    neg_decoding[10'b00_1011_1010] = 8'b1011_0100;  //180
    neg_decoding[10'b10_1010_1010] = 8'b1011_0101;  //181
    neg_decoding[10'b01_1010_1010] = 8'b1011_0110;  //182
    neg_decoding[10'b11_1010_1010] = 8'b1011_0111;  //183
    neg_decoding[10'b11_0011_1010] = 8'b1011_1000;  //184
    neg_decoding[10'b10_0110_1010] = 8'b1011_1001;  //185
    neg_decoding[10'b01_0110_1010] = 8'b1011_1010;  //186
    neg_decoding[10'b11_0110_1010] = 8'b1011_1011;  //187
    neg_decoding[10'b00_1110_1010] = 8'b1011_1100;  //188
    neg_decoding[10'b10_1110_1010] = 8'b1011_1101;  //189
    neg_decoding[10'b01_1110_1010] = 8'b1011_1110;  //190
    neg_decoding[10'b10_1011_1010] = 8'b1011_1111;  //191
    neg_decoding[10'b10_0111_0110] = 8'b1100_0000;  //192
    neg_decoding[10'b01_1101_0110] = 8'b1100_0001;  //193
    neg_decoding[10'b10_1101_0110] = 8'b1100_0010;  //194
    neg_decoding[10'b11_0001_0110] = 8'b1100_0011;  //195
    neg_decoding[10'b11_0101_0110] = 8'b1100_0100;  //196
    neg_decoding[10'b10_1001_0110] = 8'b1100_0101;  //197
    neg_decoding[10'b01_1001_0110] = 8'b1100_0110;  //198
    neg_decoding[10'b11_1000_0110] = 8'b1100_0111;  //199
    neg_decoding[10'b11_1001_0110] = 8'b1100_1000;  //200
    neg_decoding[10'b10_0101_0110] = 8'b1100_1001;  //201
    neg_decoding[10'b01_0101_0110] = 8'b1100_1010;  //202
    neg_decoding[10'b11_0100_0110] = 8'b1100_1011;  //203
    neg_decoding[10'b00_1101_0110] = 8'b1100_1100;  //204
    neg_decoding[10'b10_1100_0110] = 8'b1100_1101;  //205
    neg_decoding[10'b01_1100_0110] = 8'b1100_1110;  //206
    neg_decoding[10'b01_0111_0110] = 8'b1100_1111;  //207
    neg_decoding[10'b01_1011_0110] = 8'b1101_0000;  //208
    neg_decoding[10'b10_0011_0110] = 8'b1101_0001;  //209
    neg_decoding[10'b01_0011_0110] = 8'b1101_0010;  //210
    neg_decoding[10'b11_0010_0110] = 8'b1101_0011;  //211
    neg_decoding[10'b00_1011_0110] = 8'b1101_0100;  //212
    neg_decoding[10'b10_1010_0110] = 8'b1101_0101;  //213
    neg_decoding[10'b01_1010_0110] = 8'b1101_0110;  //214
    neg_decoding[10'b11_1010_0110] = 8'b1101_0111;  //215
    neg_decoding[10'b11_0011_0110] = 8'b1101_1000;  //216
    neg_decoding[10'b10_0110_0110] = 8'b1101_1001;  //217
    neg_decoding[10'b01_0110_0110] = 8'b1101_1010;  //218
    neg_decoding[10'b11_0110_0110] = 8'b1101_1011;  //219
    neg_decoding[10'b00_1110_0110] = 8'b1101_1100;  //220
    neg_decoding[10'b10_1110_0110] = 8'b1101_1101;  //221
    neg_decoding[10'b01_1110_0110] = 8'b1101_1110;  //222
    neg_decoding[10'b10_1011_0110] = 8'b1101_1111;  //223
    neg_decoding[10'b10_0111_0001] = 8'b1110_0000;  //224
    neg_decoding[10'b01_1101_0001] = 8'b1110_0001;  //225
    neg_decoding[10'b10_1101_0001] = 8'b1110_0010;  //226
    neg_decoding[10'b11_0001_1110] = 8'b1110_0011;  //227
    neg_decoding[10'b11_0101_0001] = 8'b1110_0100;  //228
    neg_decoding[10'b10_1001_1110] = 8'b1110_0101;  //229
    neg_decoding[10'b01_1001_1110] = 8'b1110_0110;  //230
    neg_decoding[10'b11_1000_1110] = 8'b1110_0111;  //231
    neg_decoding[10'b11_1001_0001] = 8'b1110_1000;  //232
    neg_decoding[10'b10_0101_1110] = 8'b1110_1001;  //233
    neg_decoding[10'b01_0101_1110] = 8'b1110_1010;  //234
    neg_decoding[10'b11_0100_1110] = 8'b1110_1011;  //235
    neg_decoding[10'b00_1101_1110] = 8'b1110_1100;  //236
    neg_decoding[10'b10_1100_1110] = 8'b1110_1101;  //237
    neg_decoding[10'b01_1100_1110] = 8'b1110_1110;  //238
    neg_decoding[10'b01_0111_0001] = 8'b1110_1111;  //239
    neg_decoding[10'b01_1011_0001] = 8'b1111_0000;  //240
    neg_decoding[10'b10_0011_0111] = 8'b1111_0001;  //241
    neg_decoding[10'b01_0011_0111] = 8'b1111_0010;  //242
    neg_decoding[10'b11_0010_1110] = 8'b1111_0011;  //243
    neg_decoding[10'b00_1011_0111] = 8'b1111_0100;  //244
    neg_decoding[10'b10_1010_1110] = 8'b1111_0101;  //245
    neg_decoding[10'b01_1010_1110] = 8'b1111_0110;  //246
    neg_decoding[10'b11_1010_0001] = 8'b1111_0111;  //247
    neg_decoding[10'b11_0011_0001] = 8'b1111_1000;  //248
    neg_decoding[10'b10_0110_1110] = 8'b1111_1001;  //249
    neg_decoding[10'b01_0110_1110] = 8'b1111_1010;  //250
    neg_decoding[10'b11_0110_0001] = 8'b1111_1011;  //251
    neg_decoding[10'b00_1110_1110] = 8'b1111_1100;  //252
    neg_decoding[10'b10_1110_0001] = 8'b1111_1101;  //253
    neg_decoding[10'b01_1110_0001] = 8'b1111_1110;  //254
    neg_decoding[10'b10_1011_0001] = 8'b1111_1111;  //255

    ///////////////////////////////////////////
    /////////////positive decoding/////////////
    ///////////////////////////////////////////

    // data - positive
    pos_decoding[10'b01_1000_1011] = 8'b0000_0000;  //0
    pos_decoding[10'b10_0010_1011] = 8'b0000_0001;  //1
    pos_decoding[10'b01_0010_1011] = 8'b0000_0010;  //2
    pos_decoding[10'b11_0001_0100] = 8'b0000_0011;  //3
    pos_decoding[10'b00_1010_1011] = 8'b0000_0100;  //4
    pos_decoding[10'b10_1001_0100] = 8'b0000_0101;  //5
    pos_decoding[10'b01_1001_0100] = 8'b0000_0110;  //6
    pos_decoding[10'b00_0111_0100] = 8'b0000_0111;  //7
    pos_decoding[10'b00_0110_1011] = 8'b0000_1000;  //8
    pos_decoding[10'b10_0101_0100] = 8'b0000_1001;  //9
    pos_decoding[10'b01_0101_0100] = 8'b0000_1010;  //10
    pos_decoding[10'b11_0100_0100] = 8'b0000_1011;  //11
    pos_decoding[10'b00_1101_0100] = 8'b0000_1100;  //12
    pos_decoding[10'b10_1100_0100] = 8'b0000_1101;  //13
    pos_decoding[10'b01_1100_0100] = 8'b0000_1110;  //14
    pos_decoding[10'b10_1000_1011] = 8'b0000_1111;  //15
    pos_decoding[10'b10_0100_1011] = 8'b0001_0000;  //16
    pos_decoding[10'b10_0011_0100] = 8'b0001_0001;  //17
    pos_decoding[10'b01_0011_0100] = 8'b0001_0010;  //18
    pos_decoding[10'b11_0010_0100] = 8'b0001_0011;  //19
    pos_decoding[10'b00_1011_0100] = 8'b0001_0100;  //20
    pos_decoding[10'b10_1010_0100] = 8'b0001_0101;  //21
    pos_decoding[10'b01_1010_0100] = 8'b0001_0110;  //22
    pos_decoding[10'b00_0101_1011] = 8'b0001_0111;  //23
    pos_decoding[10'b00_1100_1011] = 8'b0001_1000;  //24
    pos_decoding[10'b10_0110_0100] = 8'b0001_1001;  //25
    pos_decoding[10'b01_0110_0100] = 8'b0001_1010;  //26
    pos_decoding[10'b00_1001_1011] = 8'b0001_1011;  //27
    pos_decoding[10'b00_1110_0100] = 8'b0001_1100;  //28
    pos_decoding[10'b01_0001_1011] = 8'b0001_1101;  //29
    pos_decoding[10'b10_0001_1011] = 8'b0001_1110;  //30
    pos_decoding[10'b01_0100_1011] = 8'b0001_1111;  //31
    pos_decoding[10'b01_1000_1001] = 8'b0010_0000;  //32
    pos_decoding[10'b10_0010_1001] = 8'b0010_0001;  //33
    pos_decoding[10'b01_0010_1001] = 8'b0010_0010;  //34
    pos_decoding[10'b11_0001_1001] = 8'b0010_0011;  //35
    pos_decoding[10'b00_1010_1001] = 8'b0010_0100;  //36
    pos_decoding[10'b10_1001_1001] = 8'b0010_0101;  //37
    pos_decoding[10'b01_1001_1001] = 8'b0010_0110;  //38
    pos_decoding[10'b00_0111_1001] = 8'b0010_0111;  //39
    pos_decoding[10'b00_0110_1001] = 8'b0010_1000;  //40
    pos_decoding[10'b10_0101_1001] = 8'b0010_1001;  //41
    pos_decoding[10'b01_0101_1001] = 8'b0010_1010;  //42
    pos_decoding[10'b11_0100_1001] = 8'b0010_1011;  //43
    pos_decoding[10'b00_1101_1001] = 8'b0010_1100;  //44
    pos_decoding[10'b10_1100_1001] = 8'b0010_1101;  //45
    pos_decoding[10'b01_1100_1001] = 8'b0010_1110;  //46
    pos_decoding[10'b10_1000_1001] = 8'b0010_1111;  //47
    pos_decoding[10'b10_0100_1001] = 8'b0011_0000;  //48
    pos_decoding[10'b10_0011_1001] = 8'b0011_0001;  //49
    pos_decoding[10'b01_0011_1001] = 8'b0011_0010;  //50
    pos_decoding[10'b11_0010_1001] = 8'b0011_0011;  //51
    pos_decoding[10'b00_1011_1001] = 8'b0011_0100;  //52
    pos_decoding[10'b10_1010_1001] = 8'b0011_0101;  //53
    pos_decoding[10'b01_1010_1001] = 8'b0011_0110;  //54
    pos_decoding[10'b00_0101_1001] = 8'b0011_0111;  //55
    pos_decoding[10'b00_1100_1001] = 8'b0011_1000;  //56
    pos_decoding[10'b10_0110_1001] = 8'b0011_1001;  //57
    pos_decoding[10'b01_0110_1001] = 8'b0011_1010;  //58
    pos_decoding[10'b00_1001_1001] = 8'b0011_1011;  //59
    pos_decoding[10'b00_1110_1001] = 8'b0011_1100;  //60
    pos_decoding[10'b01_0001_1001] = 8'b0011_1101;  //61
    pos_decoding[10'b10_0001_1001] = 8'b0011_1110;  //62
    pos_decoding[10'b01_0100_1001] = 8'b0011_1111;  //63
    pos_decoding[10'b01_1000_0101] = 8'b0100_0000;  //64
    pos_decoding[10'b10_0010_0101] = 8'b0100_0001;  //65
    pos_decoding[10'b01_0010_0101] = 8'b0100_0010;  //66
    pos_decoding[10'b11_0001_0101] = 8'b0100_0011;  //67
    pos_decoding[10'b00_1010_0101] = 8'b0100_0100;  //68
    pos_decoding[10'b10_1001_0101] = 8'b0100_0101;  //69
    pos_decoding[10'b01_1001_0101] = 8'b0100_0110;  //70
    pos_decoding[10'b00_0111_0101] = 8'b0100_0111;  //71
    pos_decoding[10'b00_0110_0101] = 8'b0100_1000;  //72
    pos_decoding[10'b10_0101_0101] = 8'b0100_1001;  //73
    pos_decoding[10'b01_0101_0101] = 8'b0100_1010;  //74
    pos_decoding[10'b11_0100_0101] = 8'b0100_1011;  //75
    pos_decoding[10'b00_1101_0101] = 8'b0100_1100;  //76
    pos_decoding[10'b10_1100_0101] = 8'b0100_1101;  //77
    pos_decoding[10'b01_1100_0101] = 8'b0100_1110;  //78
    pos_decoding[10'b10_1000_0101] = 8'b0100_1111;  //79
    pos_decoding[10'b10_0100_0101] = 8'b0101_0000;  //80
    pos_decoding[10'b10_0011_0101] = 8'b0101_0001;  //81
    pos_decoding[10'b01_0011_0101] = 8'b0101_0010;  //82
    pos_decoding[10'b11_0010_0101] = 8'b0101_0011;  //83
    pos_decoding[10'b00_1011_0101] = 8'b0101_0100;  //84
    pos_decoding[10'b10_1010_0101] = 8'b0101_0101;  //85
    pos_decoding[10'b01_1010_0101] = 8'b0101_0110;  //86
    pos_decoding[10'b00_0101_0101] = 8'b0101_0111;  //87
    pos_decoding[10'b00_1100_0101] = 8'b0101_1000;  //88
    pos_decoding[10'b10_0110_0101] = 8'b0101_1001;  //89
    pos_decoding[10'b01_0110_0101] = 8'b0101_1010;  //90
    pos_decoding[10'b00_1001_0101] = 8'b0101_1011;  //91
    pos_decoding[10'b00_1110_0101] = 8'b0101_1100;  //92
    pos_decoding[10'b01_0001_0101] = 8'b0101_1101;  //93
    pos_decoding[10'b10_0001_0101] = 8'b0101_1110;  //94
    pos_decoding[10'b01_0100_0101] = 8'b0101_1111;  //95
    pos_decoding[10'b01_1000_1100] = 8'b0110_0000;  //96
    pos_decoding[10'b10_0010_1100] = 8'b0110_0001;  //97
    pos_decoding[10'b01_0010_1100] = 8'b0110_0010;  //98
    pos_decoding[10'b11_0001_0011] = 8'b0110_0011;  //99
    pos_decoding[10'b00_1010_1100] = 8'b0110_0100;  //100
    pos_decoding[10'b10_1001_0011] = 8'b0110_0101;  //101
    pos_decoding[10'b01_1001_0011] = 8'b0110_0110;  //102
    pos_decoding[10'b00_0111_0011] = 8'b0110_0111;  //103
    pos_decoding[10'b00_0110_1100] = 8'b0110_1000;  //104
    pos_decoding[10'b10_0101_0011] = 8'b0110_1001;  //105
    pos_decoding[10'b01_0101_0011] = 8'b0110_1010;  //106
    pos_decoding[10'b11_0100_0011] = 8'b0110_1011;  //107
    pos_decoding[10'b00_1101_0011] = 8'b0110_1100;  //108
    pos_decoding[10'b10_1100_0011] = 8'b0110_1101;  //109
    pos_decoding[10'b01_1100_0011] = 8'b0110_1110;  //110
    pos_decoding[10'b10_1000_1100] = 8'b0110_1111;  //111
    pos_decoding[10'b10_0100_1100] = 8'b0111_0000;  //112
    pos_decoding[10'b10_0011_0011] = 8'b0111_0001;  //113
    pos_decoding[10'b01_0011_0011] = 8'b0111_0010;  //114
    pos_decoding[10'b11_0010_0011] = 8'b0111_0011;  //115
    pos_decoding[10'b00_1011_0011] = 8'b0111_0100;  //116
    pos_decoding[10'b10_1010_0011] = 8'b0111_0101;  //117
    pos_decoding[10'b01_1010_0011] = 8'b0111_0110;  //118
    pos_decoding[10'b00_0101_1100] = 8'b0111_0111;  //119
    pos_decoding[10'b00_1100_1100] = 8'b0111_1000;  //120
    pos_decoding[10'b10_0110_0011] = 8'b0111_1001;  //121
    pos_decoding[10'b01_0110_0011] = 8'b0111_1010;  //122
    pos_decoding[10'b00_1001_1100] = 8'b0111_1011;  //123
    pos_decoding[10'b00_1110_0011] = 8'b0111_1100;  //124
    pos_decoding[10'b01_0001_1100] = 8'b0111_1101;  //125
    pos_decoding[10'b10_0001_1100] = 8'b0111_1110;  //126
    pos_decoding[10'b01_0100_1100] = 8'b0111_1111;  //127
    pos_decoding[10'b01_1000_1101] = 8'b1000_0000;  //128
    pos_decoding[10'b10_0010_1101] = 8'b1000_0001;  //129
    pos_decoding[10'b01_0010_1101] = 8'b1000_0010;  //130
    pos_decoding[10'b11_0001_0010] = 8'b1000_0011;  //131
    pos_decoding[10'b00_1010_1101] = 8'b1000_0100;  //132
    pos_decoding[10'b10_1001_0010] = 8'b1000_0101;  //133
    pos_decoding[10'b01_1001_0010] = 8'b1000_0110;  //134
    pos_decoding[10'b00_0111_0010] = 8'b1000_0111;  //135
    pos_decoding[10'b00_0110_1101] = 8'b1000_1000;  //136
    pos_decoding[10'b10_0101_0010] = 8'b1000_1001;  //137
    pos_decoding[10'b01_0101_0010] = 8'b1000_1010;  //138
    pos_decoding[10'b11_0100_0010] = 8'b1000_1011;  //139
    pos_decoding[10'b00_1101_0010] = 8'b1000_1100;  //140
    pos_decoding[10'b10_1100_0010] = 8'b1000_1101;  //141
    pos_decoding[10'b01_1100_0010] = 8'b1000_1110;  //142
    pos_decoding[10'b10_1000_1101] = 8'b1000_1111;  //143
    pos_decoding[10'b10_0100_1101] = 8'b1001_0000;  //144
    pos_decoding[10'b10_0011_0010] = 8'b1001_0001;  //145
    pos_decoding[10'b01_0011_0010] = 8'b1001_0010;  //146
    pos_decoding[10'b11_0010_0010] = 8'b1001_0011;  //147
    pos_decoding[10'b00_1011_0010] = 8'b1001_0100;  //148
    pos_decoding[10'b10_1010_0010] = 8'b1001_0101;  //149
    pos_decoding[10'b01_1010_0010] = 8'b1001_0110;  //150
    pos_decoding[10'b00_0101_1101] = 8'b1001_0111;  //151
    pos_decoding[10'b00_1100_1101] = 8'b1001_1000;  //152
    pos_decoding[10'b10_0110_0010] = 8'b1001_1001;  //153
    pos_decoding[10'b01_0110_0010] = 8'b1001_1010;  //154
    pos_decoding[10'b00_1001_1101] = 8'b1001_1011;  //155
    pos_decoding[10'b00_1110_0010] = 8'b1001_1100;  //156
    pos_decoding[10'b01_0001_1101] = 8'b1001_1101;  //157
    pos_decoding[10'b10_0001_1101] = 8'b1001_1110;  //158
    pos_decoding[10'b01_0100_1101] = 8'b1001_1111;  //159
    pos_decoding[10'b01_1000_1010] = 8'b1010_0000;  //160
    pos_decoding[10'b10_0010_1010] = 8'b1010_0001;  //161
    pos_decoding[10'b01_0010_1010] = 8'b1010_0010;  //162
    pos_decoding[10'b11_0001_1010] = 8'b1010_0011;  //163
    pos_decoding[10'b00_1010_1010] = 8'b1010_0100;  //164
    pos_decoding[10'b10_1001_1010] = 8'b1010_0101;  //165
    pos_decoding[10'b01_1001_1010] = 8'b1010_0110;  //166
    pos_decoding[10'b00_0111_1010] = 8'b1010_0111;  //167
    pos_decoding[10'b00_0110_1010] = 8'b1010_1000;  //168
    pos_decoding[10'b10_0101_1010] = 8'b1010_1001;  //169
    pos_decoding[10'b01_0101_1010] = 8'b1010_1010;  //170
    pos_decoding[10'b11_0100_1010] = 8'b1010_1011;  //171
    pos_decoding[10'b00_1101_1010] = 8'b1010_1100;  //172
    pos_decoding[10'b10_1100_1010] = 8'b1010_1101;  //173
    pos_decoding[10'b01_1100_1010] = 8'b1010_1110;  //174
    pos_decoding[10'b10_1000_1010] = 8'b1010_1111;  //175
    pos_decoding[10'b10_0100_1010] = 8'b1011_0000;  //176
    pos_decoding[10'b10_0011_1010] = 8'b1011_0001;  //177
    pos_decoding[10'b01_0011_1010] = 8'b1011_0010;  //178
    pos_decoding[10'b11_0010_1010] = 8'b1011_0011;  //179
    pos_decoding[10'b00_1011_1010] = 8'b1011_0100;  //180
    pos_decoding[10'b10_1010_1010] = 8'b1011_0101;  //181
    pos_decoding[10'b01_1010_1010] = 8'b1011_0110;  //182
    pos_decoding[10'b00_0101_1010] = 8'b1011_0111;  //183
    pos_decoding[10'b00_1100_1010] = 8'b1011_1000;  //184
    pos_decoding[10'b10_0110_1010] = 8'b1011_1001;  //185
    pos_decoding[10'b01_0110_1010] = 8'b1011_1010;  //186
    pos_decoding[10'b00_1001_1010] = 8'b1011_1011;  //187
    pos_decoding[10'b00_1110_1010] = 8'b1011_1100;  //188
    pos_decoding[10'b01_0001_1010] = 8'b1011_1101;  //189
    pos_decoding[10'b10_0001_1010] = 8'b1011_1110;  //190
    pos_decoding[10'b01_0100_1010] = 8'b1011_1111;  //191
    pos_decoding[10'b01_1000_0110] = 8'b1100_0000;  //192
    pos_decoding[10'b10_0010_0110] = 8'b1100_0001;  //193
    pos_decoding[10'b01_0010_0110] = 8'b1100_0010;  //194
    pos_decoding[10'b11_0001_0110] = 8'b1100_0011;  //195
    pos_decoding[10'b00_1010_0110] = 8'b1100_0100;  //196
    pos_decoding[10'b10_1001_0110] = 8'b1100_0101;  //197
    pos_decoding[10'b01_1001_0110] = 8'b1100_0110;  //198
    pos_decoding[10'b00_0111_0110] = 8'b1100_0111;  //199
    pos_decoding[10'b00_0110_0110] = 8'b1100_1000;  //200
    pos_decoding[10'b10_0101_0110] = 8'b1100_1001;  //201
    pos_decoding[10'b01_0101_0110] = 8'b1100_1010;  //202
    pos_decoding[10'b11_0100_0110] = 8'b1100_1011;  //203
    pos_decoding[10'b00_1101_0110] = 8'b1100_1100;  //204
    pos_decoding[10'b10_1100_0110] = 8'b1100_1101;  //205
    pos_decoding[10'b01_1100_0110] = 8'b1100_1110;  //206
    pos_decoding[10'b10_1000_0110] = 8'b1100_1111;  //207
    pos_decoding[10'b10_0100_0110] = 8'b1101_0000;  //208
    pos_decoding[10'b10_0011_0110] = 8'b1101_0001;  //209
    pos_decoding[10'b01_0011_0110] = 8'b1101_0010;  //210
    pos_decoding[10'b11_0010_0110] = 8'b1101_0011;  //211
    pos_decoding[10'b00_1011_0110] = 8'b1101_0100;  //212
    pos_decoding[10'b10_1010_0110] = 8'b1101_0101;  //213
    pos_decoding[10'b01_1010_0110] = 8'b1101_0110;  //214
    pos_decoding[10'b00_0101_0110] = 8'b1101_0111;  //215
    pos_decoding[10'b00_1100_0110] = 8'b1101_1000;  //216
    pos_decoding[10'b10_0110_0110] = 8'b1101_1001;  //217
    pos_decoding[10'b01_0110_0110] = 8'b1101_1010;  //218
    pos_decoding[10'b00_1001_0110] = 8'b1101_1011;  //219
    pos_decoding[10'b00_1110_0110] = 8'b1101_1100;  //220
    pos_decoding[10'b01_0001_0110] = 8'b1101_1101;  //221
    pos_decoding[10'b10_0001_0110] = 8'b1101_1110;  //222
    pos_decoding[10'b01_0100_0110] = 8'b1101_1111;  //223
    pos_decoding[10'b01_1000_1110] = 8'b1110_0000;  //224
    pos_decoding[10'b10_0010_1110] = 8'b1110_0001;  //225
    pos_decoding[10'b01_0010_1110] = 8'b1110_0010;  //226
    pos_decoding[10'b11_0001_0001] = 8'b1110_0011;  //227
    pos_decoding[10'b00_1010_1110] = 8'b1110_0100;  //228
    pos_decoding[10'b10_1001_0001] = 8'b1110_0101;  //229
    pos_decoding[10'b01_1001_0001] = 8'b1110_0110;  //230
    pos_decoding[10'b00_0111_0001] = 8'b1110_0111;  //231
    pos_decoding[10'b00_0110_1110] = 8'b1110_1000;  //232
    pos_decoding[10'b10_0101_0001] = 8'b1110_1001;  //233
    pos_decoding[10'b01_0101_0001] = 8'b1110_1010;  //234
    pos_decoding[10'b11_0100_1000] = 8'b1110_1011;  //235
    pos_decoding[10'b00_1101_0001] = 8'b1110_1100;  //236
    pos_decoding[10'b10_1100_1000] = 8'b1110_1101;  //237
    pos_decoding[10'b01_1100_1000] = 8'b1110_1110;  //238
    pos_decoding[10'b10_1000_1110] = 8'b1110_1111;  //239
    pos_decoding[10'b10_0100_1110] = 8'b1111_0000;  //240
    pos_decoding[10'b10_0011_0001] = 8'b1111_0001;  //241
    pos_decoding[10'b01_0011_0001] = 8'b1111_0010;  //242
    pos_decoding[10'b11_0010_0001] = 8'b1111_0011;  //243
    pos_decoding[10'b00_1011_0001] = 8'b1111_0100;  //244
    pos_decoding[10'b10_1010_0001] = 8'b1111_0101;  //245
    pos_decoding[10'b01_1010_0001] = 8'b1111_0110;  //246
    pos_decoding[10'b00_0101_1110] = 8'b1111_0111;  //247
    pos_decoding[10'b00_1100_1110] = 8'b1111_1000;  //248
    pos_decoding[10'b10_0110_0001] = 8'b1111_1001;  //249
    pos_decoding[10'b01_0110_0001] = 8'b1111_1010;  //250
    pos_decoding[10'b00_1001_1110] = 8'b1111_1011;  //251
    pos_decoding[10'b00_1110_0001] = 8'b1111_1100;  //252
    pos_decoding[10'b01_0001_1110] = 8'b1111_1101;  //253
    pos_decoding[10'b10_0001_1110] = 8'b1111_1110;  //254
    pos_decoding[10'b01_0100_1110] = 8'b1111_1111;  //255



 decode_stimulus_neg[0  ] = 10'b10_0111_0100;
 decode_stimulus_neg[1  ] = 10'b01_1101_0100;
 decode_stimulus_neg[2  ] = 10'b10_1101_0100;
 decode_stimulus_neg[3  ] = 10'b11_0001_1011;
 decode_stimulus_neg[4  ] = 10'b11_0101_0100;
 decode_stimulus_neg[5  ] = 10'b10_1001_1011;
 decode_stimulus_neg[6  ] = 10'b01_1001_1011;
 decode_stimulus_neg[7  ] = 10'b11_1000_1011;
 decode_stimulus_neg[8  ] = 10'b11_1001_0100;
 decode_stimulus_neg[9  ] = 10'b10_0101_1011;
 decode_stimulus_neg[10 ] = 10'b01_0101_1011;
 decode_stimulus_neg[11 ] = 10'b11_0100_1011;
 decode_stimulus_neg[12 ] = 10'b00_1101_1011;
 decode_stimulus_neg[13 ] = 10'b10_1100_1011;
 decode_stimulus_neg[14 ] = 10'b01_1100_1011;
 decode_stimulus_neg[15 ] = 10'b01_0111_0100;
 decode_stimulus_neg[16 ] = 10'b01_1011_0100;
 decode_stimulus_neg[17 ] = 10'b10_0011_1011;
 decode_stimulus_neg[18 ] = 10'b01_0011_1011;
 decode_stimulus_neg[19 ] = 10'b11_0010_1011;
 decode_stimulus_neg[20 ] = 10'b00_1011_1011;
 decode_stimulus_neg[21 ] = 10'b10_1010_1011;
 decode_stimulus_neg[22 ] = 10'b01_1010_1011;
 decode_stimulus_neg[23 ] = 10'b11_1010_0100;
 decode_stimulus_neg[24 ] = 10'b11_0011_0100;
 decode_stimulus_neg[25 ] = 10'b10_0110_1011;
 decode_stimulus_neg[26 ] = 10'b01_0110_1011;
 decode_stimulus_neg[27 ] = 10'b11_0110_0100;
 decode_stimulus_neg[28 ] = 10'b00_1110_1011;
 decode_stimulus_neg[29 ] = 10'b10_1110_0100;
 decode_stimulus_neg[30 ] = 10'b01_1110_0100;
 decode_stimulus_neg[31 ] = 10'b10_1011_0100;
 decode_stimulus_neg[32 ] = 10'b10_0111_1001;
 decode_stimulus_neg[33 ] = 10'b01_1101_1001;
 decode_stimulus_neg[34 ] = 10'b10_1101_1001;
 decode_stimulus_neg[35 ] = 10'b11_0001_1001;
 decode_stimulus_neg[36 ] = 10'b11_0101_1001;
 decode_stimulus_neg[37 ] = 10'b10_1001_1001;
 decode_stimulus_neg[38 ] = 10'b01_1001_1001;
 decode_stimulus_neg[39 ] = 10'b11_1000_1001;
 decode_stimulus_neg[40 ] = 10'b11_1001_1001;
 decode_stimulus_neg[41 ] = 10'b10_0101_1001;
 decode_stimulus_neg[42 ] = 10'b01_0101_1001;
 decode_stimulus_neg[43 ] = 10'b11_0100_1001;
 decode_stimulus_neg[44 ] = 10'b00_1101_1001;
 decode_stimulus_neg[45 ] = 10'b10_1100_1001;
 decode_stimulus_neg[46 ] = 10'b01_1100_1001;
 decode_stimulus_neg[47 ] = 10'b01_0111_1001;
 decode_stimulus_neg[48 ] = 10'b01_1011_1001;
 decode_stimulus_neg[49 ] = 10'b10_0011_1001;
 decode_stimulus_neg[50 ] = 10'b01_0011_1001;
 decode_stimulus_neg[51 ] = 10'b11_0010_1001;
 decode_stimulus_neg[52 ] = 10'b00_1011_1001;
 decode_stimulus_neg[53 ] = 10'b10_1010_1001;
 decode_stimulus_neg[54 ] = 10'b01_1010_1001;
 decode_stimulus_neg[55 ] = 10'b11_1010_1001;
 decode_stimulus_neg[56 ] = 10'b11_0011_1001;
 decode_stimulus_neg[57 ] = 10'b10_0110_1001;
 decode_stimulus_neg[58 ] = 10'b01_0110_1001;
 decode_stimulus_neg[59 ] = 10'b11_0110_1001;
 decode_stimulus_neg[60 ] = 10'b00_1110_1001;
 decode_stimulus_neg[61 ] = 10'b10_1110_1001;
 decode_stimulus_neg[62 ] = 10'b01_1110_1001;
 decode_stimulus_neg[63 ] = 10'b10_1011_1001;
 decode_stimulus_neg[64 ] = 10'b10_0111_0101;
 decode_stimulus_neg[65 ] = 10'b01_1101_0101;
 decode_stimulus_neg[66 ] = 10'b10_1101_0101;
 decode_stimulus_neg[67 ] = 10'b11_0001_0101;
 decode_stimulus_neg[68 ] = 10'b11_0101_0101;
 decode_stimulus_neg[69 ] = 10'b10_1001_0101;
 decode_stimulus_neg[70 ] = 10'b01_1001_0101;
 decode_stimulus_neg[71 ] = 10'b11_1000_0101;
 decode_stimulus_neg[72 ] = 10'b11_1001_0101;
 decode_stimulus_neg[73 ] = 10'b10_0101_0101;
 decode_stimulus_neg[74 ] = 10'b01_0101_0101;
 decode_stimulus_neg[75 ] = 10'b11_0100_0101;
 decode_stimulus_neg[76 ] = 10'b00_1101_0101;
 decode_stimulus_neg[77 ] = 10'b10_1100_0101;
 decode_stimulus_neg[78 ] = 10'b01_1100_0101;
 decode_stimulus_neg[79 ] = 10'b01_0111_0101;
 decode_stimulus_neg[80 ] = 10'b01_1011_0101;
 decode_stimulus_neg[81 ] = 10'b10_0011_0101;
 decode_stimulus_neg[82 ] = 10'b01_0011_0101;
 decode_stimulus_neg[83 ] = 10'b11_0010_0101;
 decode_stimulus_neg[84 ] = 10'b00_1011_0101;
 decode_stimulus_neg[85 ] = 10'b10_1010_0101;
 decode_stimulus_neg[86 ] = 10'b01_1010_0101;
 decode_stimulus_neg[87 ] = 10'b11_1010_0101;
 decode_stimulus_neg[88 ] = 10'b11_0011_0101;
 decode_stimulus_neg[89 ] = 10'b10_0110_0101;
 decode_stimulus_neg[90 ] = 10'b01_0110_0101;
 decode_stimulus_neg[91 ] = 10'b11_0110_0101;
 decode_stimulus_neg[92 ] = 10'b00_1110_0101;
 decode_stimulus_neg[93 ] = 10'b10_1110_0101;
 decode_stimulus_neg[94 ] = 10'b01_1110_0101;
 decode_stimulus_neg[95 ] = 10'b10_1011_0101;
 decode_stimulus_neg[96 ] = 10'b10_0111_0011;
 decode_stimulus_neg[97 ] = 10'b01_1101_0011;
 decode_stimulus_neg[98 ] = 10'b10_1101_0011;
 decode_stimulus_neg[99 ] = 10'b11_0001_1100;
 decode_stimulus_neg[100] = 10'b11_0101_0011;
 decode_stimulus_neg[101] = 10'b10_1001_1100;
 decode_stimulus_neg[102] = 10'b01_1001_1100;
 decode_stimulus_neg[103] = 10'b11_1000_1100;
 decode_stimulus_neg[104] = 10'b11_1001_0011;
 decode_stimulus_neg[105] = 10'b10_0101_1100;
 decode_stimulus_neg[106] = 10'b01_0101_1100;
 decode_stimulus_neg[107] = 10'b11_0100_1100;
 decode_stimulus_neg[108] = 10'b00_1101_1100;
 decode_stimulus_neg[109] = 10'b10_1100_1100;
 decode_stimulus_neg[110] = 10'b01_1100_1100;
 decode_stimulus_neg[111] = 10'b01_0111_0011;
 decode_stimulus_neg[112] = 10'b01_1011_0011;
 decode_stimulus_neg[113] = 10'b10_0011_1100;
 decode_stimulus_neg[114] = 10'b01_0011_1100;
 decode_stimulus_neg[115] = 10'b11_0010_1100;
 decode_stimulus_neg[116] = 10'b00_1011_1100;
 decode_stimulus_neg[117] = 10'b10_1010_1100;
 decode_stimulus_neg[118] = 10'b01_1010_1100;
 decode_stimulus_neg[119] = 10'b11_1010_0011;
 decode_stimulus_neg[120] = 10'b11_0011_0011;
 decode_stimulus_neg[121] = 10'b10_0110_1100;
 decode_stimulus_neg[122] = 10'b01_0110_1100;
 decode_stimulus_neg[123] = 10'b11_0110_0011;
 decode_stimulus_neg[124] = 10'b00_1110_1100;
 decode_stimulus_neg[125] = 10'b10_1110_0011;
 decode_stimulus_neg[126] = 10'b01_1110_0011;
 decode_stimulus_neg[127] = 10'b10_1011_0011;
 decode_stimulus_neg[128] = 10'b10_0111_0010;
 decode_stimulus_neg[129] = 10'b01_1101_0010;
 decode_stimulus_neg[130] = 10'b10_1101_0010;
 decode_stimulus_neg[131] = 10'b11_0001_1101;
 decode_stimulus_neg[132] = 10'b11_0101_0010;
 decode_stimulus_neg[133] = 10'b10_1001_1101;
 decode_stimulus_neg[134] = 10'b01_1001_1101;
 decode_stimulus_neg[135] = 10'b11_1000_1101;
 decode_stimulus_neg[136] = 10'b11_1001_0010;
 decode_stimulus_neg[137] = 10'b10_0101_1101;
 decode_stimulus_neg[138] = 10'b01_0101_1101;
 decode_stimulus_neg[139] = 10'b11_0100_1101;
 decode_stimulus_neg[140] = 10'b00_1101_1101;
 decode_stimulus_neg[141] = 10'b10_1100_1101;
 decode_stimulus_neg[142] = 10'b01_1100_1101;
 decode_stimulus_neg[143] = 10'b01_0111_0010;
 decode_stimulus_neg[144] = 10'b01_1011_0010;
 decode_stimulus_neg[145] = 10'b10_0011_1101;
 decode_stimulus_neg[146] = 10'b01_0011_1101;
 decode_stimulus_neg[147] = 10'b11_0010_1101;
 decode_stimulus_neg[148] = 10'b00_1011_1101;
 decode_stimulus_neg[149] = 10'b10_1010_1101;
 decode_stimulus_neg[150] = 10'b01_1010_1101;
 decode_stimulus_neg[151] = 10'b11_1010_0010;
 decode_stimulus_neg[152] = 10'b11_0011_0010;
 decode_stimulus_neg[153] = 10'b10_0110_1101;
 decode_stimulus_neg[154] = 10'b01_0110_1101;
 decode_stimulus_neg[155] = 10'b11_0110_0010;
 decode_stimulus_neg[156] = 10'b00_1110_1101;
 decode_stimulus_neg[157] = 10'b10_1110_0010;
 decode_stimulus_neg[158] = 10'b01_1110_0010;
 decode_stimulus_neg[159] = 10'b10_1011_0010;
 decode_stimulus_neg[160] = 10'b10_0111_1010;
 decode_stimulus_neg[161] = 10'b01_1101_1010;
 decode_stimulus_neg[162] = 10'b10_1101_1010;
 decode_stimulus_neg[163] = 10'b11_0001_1010;
 decode_stimulus_neg[164] = 10'b11_0101_1010;
 decode_stimulus_neg[165] = 10'b10_1001_1010;
 decode_stimulus_neg[166] = 10'b01_1001_1010;
 decode_stimulus_neg[167] = 10'b11_1000_1010;
 decode_stimulus_neg[168] = 10'b11_1001_1010;
 decode_stimulus_neg[169] = 10'b10_0101_1010;
 decode_stimulus_neg[170] = 10'b01_0101_1010;
 decode_stimulus_neg[171] = 10'b11_0100_1010;
 decode_stimulus_neg[172] = 10'b00_1101_1010;
 decode_stimulus_neg[173] = 10'b10_1100_1010;
 decode_stimulus_neg[174] = 10'b01_1100_1010;
 decode_stimulus_neg[175] = 10'b01_0111_1010;
 decode_stimulus_neg[176] = 10'b01_1011_1010;
 decode_stimulus_neg[177] = 10'b10_0011_1010;
 decode_stimulus_neg[178] = 10'b01_0011_1010;
 decode_stimulus_neg[179] = 10'b11_0010_1010;
 decode_stimulus_neg[180] = 10'b00_1011_1010;
 decode_stimulus_neg[181] = 10'b10_1010_1010;
 decode_stimulus_neg[182] = 10'b01_1010_1010;
 decode_stimulus_neg[183] = 10'b11_1010_1010;
 decode_stimulus_neg[184] = 10'b11_0011_1010;
 decode_stimulus_neg[185] = 10'b10_0110_1010;
 decode_stimulus_neg[186] = 10'b01_0110_1010;
 decode_stimulus_neg[187] = 10'b11_0110_1010;
 decode_stimulus_neg[188] = 10'b00_1110_1010;
 decode_stimulus_neg[189] = 10'b10_1110_1010;
 decode_stimulus_neg[190] = 10'b01_1110_1010;
 decode_stimulus_neg[191] = 10'b10_1011_1010;
 decode_stimulus_neg[192] = 10'b10_0111_0110;
 decode_stimulus_neg[193] = 10'b01_1101_0110;
 decode_stimulus_neg[194] = 10'b10_1101_0110;
 decode_stimulus_neg[195] = 10'b11_0001_0110;
 decode_stimulus_neg[196] = 10'b11_0101_0110;
 decode_stimulus_neg[197] = 10'b10_1001_0110;
 decode_stimulus_neg[198] = 10'b01_1001_0110;
 decode_stimulus_neg[199] = 10'b11_1000_0110;
 decode_stimulus_neg[200] = 10'b11_1001_0110;
 decode_stimulus_neg[201] = 10'b10_0101_0110;
 decode_stimulus_neg[202] = 10'b01_0101_0110;
 decode_stimulus_neg[203] = 10'b11_0100_0110;
 decode_stimulus_neg[204] = 10'b00_1101_0110;
 decode_stimulus_neg[205] = 10'b10_1100_0110;
 decode_stimulus_neg[206] = 10'b01_1100_0110;
 decode_stimulus_neg[207] = 10'b01_0111_0110;
 decode_stimulus_neg[208] = 10'b01_1011_0110;
 decode_stimulus_neg[209] = 10'b10_0011_0110;
 decode_stimulus_neg[210] = 10'b01_0011_0110;
 decode_stimulus_neg[211] = 10'b11_0010_0110;
 decode_stimulus_neg[212] = 10'b00_1011_0110;
 decode_stimulus_neg[213] = 10'b10_1010_0110;
 decode_stimulus_neg[214] = 10'b01_1010_0110;
 decode_stimulus_neg[215] = 10'b11_1010_0110;
 decode_stimulus_neg[216] = 10'b11_0011_0110;
 decode_stimulus_neg[217] = 10'b10_0110_0110;
 decode_stimulus_neg[218] = 10'b01_0110_0110;
 decode_stimulus_neg[219] = 10'b11_0110_0110;
 decode_stimulus_neg[220] = 10'b00_1110_0110;
 decode_stimulus_neg[221] = 10'b10_1110_0110;
 decode_stimulus_neg[222] = 10'b01_1110_0110;
 decode_stimulus_neg[223] = 10'b10_1011_0110;
 decode_stimulus_neg[224] = 10'b10_0111_0001;
 decode_stimulus_neg[225] = 10'b01_1101_0001;
 decode_stimulus_neg[226] = 10'b10_1101_0001;
 decode_stimulus_neg[227] = 10'b11_0001_1110;
 decode_stimulus_neg[228] = 10'b11_0101_0001;
 decode_stimulus_neg[229] = 10'b10_1001_1110;
 decode_stimulus_neg[230] = 10'b01_1001_1110;
 decode_stimulus_neg[231] = 10'b11_1000_1110;
 decode_stimulus_neg[232] = 10'b11_1001_0001;
 decode_stimulus_neg[233] = 10'b10_0101_1110;
 decode_stimulus_neg[234] = 10'b01_0101_1110;
 decode_stimulus_neg[235] = 10'b11_0100_1110;
 decode_stimulus_neg[236] = 10'b00_1101_1110;
 decode_stimulus_neg[237] = 10'b10_1100_1110;
 decode_stimulus_neg[238] = 10'b01_1100_1110;
 decode_stimulus_neg[239] = 10'b01_0111_0001;
 decode_stimulus_neg[240] = 10'b01_1011_0001;
 decode_stimulus_neg[241] = 10'b10_0011_0111;
 decode_stimulus_neg[242] = 10'b01_0011_0111;
 decode_stimulus_neg[243] = 10'b11_0010_1110;
 decode_stimulus_neg[244] = 10'b00_1011_0111;
 decode_stimulus_neg[245] = 10'b10_1010_1110;
 decode_stimulus_neg[246] = 10'b01_1010_1110;
 decode_stimulus_neg[247] = 10'b11_1010_0001;
 decode_stimulus_neg[248] = 10'b11_0011_0001;
 decode_stimulus_neg[249] = 10'b10_0110_1110;
 decode_stimulus_neg[250] = 10'b01_0110_1110;
 decode_stimulus_neg[251] = 10'b11_0110_0001;
 decode_stimulus_neg[252] = 10'b00_1110_1110;
 decode_stimulus_neg[253] = 10'b10_1110_0001;
 decode_stimulus_neg[254] = 10'b01_1110_0001;
 decode_stimulus_neg[255] = 10'b10_1011_0001;







 decode_stimulus_pos[0  ] = 10'b01_1000_1011 ;
 decode_stimulus_pos[1  ] = 10'b10_0010_1011 ;
 decode_stimulus_pos[2  ] = 10'b01_0010_1011 ;
 decode_stimulus_pos[3  ] = 10'b11_0001_0100 ;
 decode_stimulus_pos[4  ] = 10'b00_1010_1011 ;
 decode_stimulus_pos[5  ] = 10'b10_1001_0100 ;
 decode_stimulus_pos[6  ] = 10'b01_1001_0100 ;
 decode_stimulus_pos[7  ] = 10'b00_0111_0100 ;
 decode_stimulus_pos[8  ] = 10'b00_0110_1011 ;
 decode_stimulus_pos[9  ] = 10'b10_0101_0100 ;
 decode_stimulus_pos[10 ] = 10'b01_0101_0100 ;
 decode_stimulus_pos[11 ] = 10'b11_0100_0100 ;
 decode_stimulus_pos[12 ] = 10'b00_1101_0100 ;
 decode_stimulus_pos[13 ] = 10'b10_1100_0100 ;
 decode_stimulus_pos[14 ] = 10'b01_1100_0100 ;
 decode_stimulus_pos[15 ] = 10'b10_1000_1011 ;
 decode_stimulus_pos[16 ] = 10'b10_0100_1011 ;
 decode_stimulus_pos[17 ] = 10'b10_0011_0100 ;
 decode_stimulus_pos[18 ] = 10'b01_0011_0100 ;
 decode_stimulus_pos[19 ] = 10'b11_0010_0100 ;
 decode_stimulus_pos[20 ] = 10'b00_1011_0100 ;
 decode_stimulus_pos[21 ] = 10'b10_1010_0100 ;
 decode_stimulus_pos[22 ] = 10'b01_1010_0100 ;
 decode_stimulus_pos[23 ] = 10'b00_0101_1011 ;
 decode_stimulus_pos[24 ] = 10'b00_1100_1011 ;
 decode_stimulus_pos[25 ] = 10'b10_0110_0100 ;
 decode_stimulus_pos[26 ] = 10'b01_0110_0100 ;
 decode_stimulus_pos[27 ] = 10'b00_1001_1011 ;
 decode_stimulus_pos[28 ] = 10'b00_1110_0100 ;
 decode_stimulus_pos[29 ] = 10'b01_0001_1011 ;
 decode_stimulus_pos[30 ] = 10'b10_0001_1011 ;
 decode_stimulus_pos[31 ] = 10'b01_0100_1011 ;
 decode_stimulus_pos[32 ] = 10'b01_1000_1001 ;
 decode_stimulus_pos[33 ] = 10'b10_0010_1001 ;
 decode_stimulus_pos[34 ] = 10'b01_0010_1001 ;
 decode_stimulus_pos[35 ] = 10'b11_0001_1001 ;
 decode_stimulus_pos[36 ] = 10'b00_1010_1001 ;
 decode_stimulus_pos[37 ] = 10'b10_1001_1001 ;
 decode_stimulus_pos[38 ] = 10'b01_1001_1001 ;
 decode_stimulus_pos[39 ] = 10'b00_0111_1001 ;
 decode_stimulus_pos[40 ] = 10'b00_0110_1001 ;
 decode_stimulus_pos[41 ] = 10'b10_0101_1001 ;
 decode_stimulus_pos[42 ] = 10'b01_0101_1001 ;
 decode_stimulus_pos[43 ] = 10'b11_0100_1001 ;
 decode_stimulus_pos[44 ] = 10'b00_1101_1001 ;
 decode_stimulus_pos[45 ] = 10'b10_1100_1001 ;
 decode_stimulus_pos[46 ] = 10'b01_1100_1001 ;
 decode_stimulus_pos[47 ] = 10'b10_1000_1001 ;
 decode_stimulus_pos[48 ] = 10'b10_0100_1001 ;
 decode_stimulus_pos[49 ] = 10'b10_0011_1001 ;
 decode_stimulus_pos[50 ] = 10'b01_0011_1001 ;
 decode_stimulus_pos[51 ] = 10'b11_0010_1001 ;
 decode_stimulus_pos[52 ] = 10'b00_1011_1001 ;
 decode_stimulus_pos[53 ] = 10'b10_1010_1001 ;
 decode_stimulus_pos[54 ] = 10'b01_1010_1001 ;
 decode_stimulus_pos[55 ] = 10'b00_0101_1001 ;
 decode_stimulus_pos[56 ] = 10'b00_1100_1001 ;
 decode_stimulus_pos[57 ] = 10'b10_0110_1001 ;
 decode_stimulus_pos[58 ] = 10'b01_0110_1001 ;
 decode_stimulus_pos[59 ] = 10'b00_1001_1001 ;
 decode_stimulus_pos[60 ] = 10'b00_1110_1001 ;
 decode_stimulus_pos[61 ] = 10'b01_0001_1001 ;
 decode_stimulus_pos[62 ] = 10'b10_0001_1001 ;
 decode_stimulus_pos[63 ] = 10'b01_0100_1001 ;
 decode_stimulus_pos[64 ] = 10'b01_1000_0101 ;
 decode_stimulus_pos[65 ] = 10'b10_0010_0101 ;
 decode_stimulus_pos[66 ] = 10'b01_0010_0101 ;
 decode_stimulus_pos[67 ] = 10'b11_0001_0101 ;
 decode_stimulus_pos[68 ] = 10'b00_1010_0101 ;
 decode_stimulus_pos[69 ] = 10'b10_1001_0101 ;
 decode_stimulus_pos[70 ] = 10'b01_1001_0101 ;
 decode_stimulus_pos[71 ] = 10'b00_0111_0101 ;
 decode_stimulus_pos[72 ] = 10'b00_0110_0101 ;
 decode_stimulus_pos[73 ] = 10'b10_0101_0101 ;
 decode_stimulus_pos[74 ] = 10'b01_0101_0101 ;
 decode_stimulus_pos[75 ] = 10'b11_0100_0101 ;
 decode_stimulus_pos[76 ] = 10'b00_1101_0101 ;
 decode_stimulus_pos[77 ] = 10'b10_1100_0101 ;
 decode_stimulus_pos[78 ] = 10'b01_1100_0101 ;
 decode_stimulus_pos[79 ] = 10'b10_1000_0101 ;
 decode_stimulus_pos[80 ] = 10'b10_0100_0101 ;
 decode_stimulus_pos[81 ] = 10'b10_0011_0101 ;
 decode_stimulus_pos[82 ] = 10'b01_0011_0101 ;
 decode_stimulus_pos[83 ] = 10'b11_0010_0101 ;
 decode_stimulus_pos[84 ] = 10'b00_1011_0101 ;
 decode_stimulus_pos[85 ] = 10'b10_1010_0101 ;
 decode_stimulus_pos[86 ] = 10'b01_1010_0101 ;
 decode_stimulus_pos[87 ] = 10'b00_0101_0101 ;
 decode_stimulus_pos[88 ] = 10'b00_1100_0101 ;
 decode_stimulus_pos[89 ] = 10'b10_0110_0101 ;
 decode_stimulus_pos[90 ] = 10'b01_0110_0101 ;
 decode_stimulus_pos[91 ] = 10'b00_1001_0101 ;
 decode_stimulus_pos[92 ] = 10'b00_1110_0101 ;
 decode_stimulus_pos[93 ] = 10'b01_0001_0101 ;
 decode_stimulus_pos[94 ] = 10'b10_0001_0101 ;
 decode_stimulus_pos[95 ] = 10'b01_0100_0101 ;
 decode_stimulus_pos[96 ] = 10'b01_1000_1100 ;
 decode_stimulus_pos[97 ] = 10'b10_0010_1100 ;
 decode_stimulus_pos[98 ] = 10'b01_0010_1100 ;
 decode_stimulus_pos[99 ] = 10'b11_0001_0011 ;
 decode_stimulus_pos[100] = 10'b00_1010_1100 ;
 decode_stimulus_pos[101] = 10'b10_1001_0011 ;
 decode_stimulus_pos[102] = 10'b01_1001_0011 ;
 decode_stimulus_pos[103] = 10'b00_0111_0011 ;
 decode_stimulus_pos[104] = 10'b00_0110_1100 ;
 decode_stimulus_pos[105] = 10'b10_0101_0011 ;
 decode_stimulus_pos[106] = 10'b01_0101_0011 ;
 decode_stimulus_pos[107] = 10'b11_0100_0011 ;
 decode_stimulus_pos[108] = 10'b00_1101_0011 ;
 decode_stimulus_pos[109] = 10'b10_1100_0011 ;
 decode_stimulus_pos[110] = 10'b01_1100_0011 ;
 decode_stimulus_pos[111] = 10'b10_1000_1100 ;
 decode_stimulus_pos[112] = 10'b10_0100_1100 ;
 decode_stimulus_pos[113] = 10'b10_0011_0011 ;
 decode_stimulus_pos[114] = 10'b01_0011_0011 ;
 decode_stimulus_pos[115] = 10'b11_0010_0011 ;
 decode_stimulus_pos[116] = 10'b00_1011_0011 ;
 decode_stimulus_pos[117] = 10'b10_1010_0011 ;
 decode_stimulus_pos[118] = 10'b01_1010_0011 ;
 decode_stimulus_pos[119] = 10'b00_0101_1100 ;
 decode_stimulus_pos[120] = 10'b00_1100_1100 ;
 decode_stimulus_pos[121] = 10'b10_0110_0011 ;
 decode_stimulus_pos[122] = 10'b01_0110_0011 ;
 decode_stimulus_pos[123] = 10'b00_1001_1100 ;
 decode_stimulus_pos[124] = 10'b00_1110_0011 ;
 decode_stimulus_pos[125] = 10'b01_0001_1100 ;
 decode_stimulus_pos[126] = 10'b10_0001_1100 ;
 decode_stimulus_pos[127] = 10'b01_0100_1100 ;
 decode_stimulus_pos[128] = 10'b01_1000_1101 ;
 decode_stimulus_pos[129] = 10'b10_0010_1101 ;
 decode_stimulus_pos[130] = 10'b01_0010_1101 ;
 decode_stimulus_pos[131] = 10'b11_0001_0010 ;
 decode_stimulus_pos[132] = 10'b00_1010_1101 ;
 decode_stimulus_pos[133] = 10'b10_1001_0010 ;
 decode_stimulus_pos[134] = 10'b01_1001_0010 ;
 decode_stimulus_pos[135] = 10'b00_0111_0010 ;
 decode_stimulus_pos[136] = 10'b00_0110_1101 ;
 decode_stimulus_pos[137] = 10'b10_0101_0010 ;
 decode_stimulus_pos[138] = 10'b01_0101_0010 ;
 decode_stimulus_pos[139] = 10'b11_0100_0010 ;
 decode_stimulus_pos[140] = 10'b00_1101_0010 ;
 decode_stimulus_pos[141] = 10'b10_1100_0010 ;
 decode_stimulus_pos[142] = 10'b01_1100_0010 ;
 decode_stimulus_pos[143] = 10'b10_1000_1101 ;
 decode_stimulus_pos[144] = 10'b10_0100_1101 ;
 decode_stimulus_pos[145] = 10'b10_0011_0010 ;
 decode_stimulus_pos[146] = 10'b01_0011_0010 ;
 decode_stimulus_pos[147] = 10'b11_0010_0010 ;
 decode_stimulus_pos[148] = 10'b00_1011_0010 ;
 decode_stimulus_pos[149] = 10'b10_1010_0010 ;
 decode_stimulus_pos[150] = 10'b01_1010_0010 ;
 decode_stimulus_pos[151] = 10'b00_0101_1101 ;
 decode_stimulus_pos[152] = 10'b00_1100_1101 ;
 decode_stimulus_pos[153] = 10'b10_0110_0010 ;
 decode_stimulus_pos[154] = 10'b01_0110_0010 ;
 decode_stimulus_pos[155] = 10'b00_1001_1101 ;
 decode_stimulus_pos[156] = 10'b00_1110_0010 ;
 decode_stimulus_pos[157] = 10'b01_0001_1101 ;
 decode_stimulus_pos[158] = 10'b10_0001_1101 ;
 decode_stimulus_pos[159] = 10'b01_0100_1101 ;
 decode_stimulus_pos[160] = 10'b01_1000_1010 ;
 decode_stimulus_pos[161] = 10'b10_0010_1010 ;
 decode_stimulus_pos[162] = 10'b01_0010_1010 ;
 decode_stimulus_pos[163] = 10'b11_0001_1010 ;
 decode_stimulus_pos[164] = 10'b00_1010_1010 ;
 decode_stimulus_pos[165] = 10'b10_1001_1010 ;
 decode_stimulus_pos[166] = 10'b01_1001_1010 ;
 decode_stimulus_pos[167] = 10'b00_0111_1010 ;
 decode_stimulus_pos[168] = 10'b00_0110_1010 ;
 decode_stimulus_pos[169] = 10'b10_0101_1010 ;
 decode_stimulus_pos[170] = 10'b01_0101_1010 ;
 decode_stimulus_pos[171] = 10'b11_0100_1010 ;
 decode_stimulus_pos[172] = 10'b00_1101_1010 ;
 decode_stimulus_pos[173] = 10'b10_1100_1010 ;
 decode_stimulus_pos[174] = 10'b01_1100_1010 ;
 decode_stimulus_pos[175] = 10'b10_1000_1010 ;
 decode_stimulus_pos[176] = 10'b10_0100_1010 ;
 decode_stimulus_pos[177] = 10'b10_0011_1010 ;
 decode_stimulus_pos[178] = 10'b01_0011_1010 ;
 decode_stimulus_pos[179] = 10'b11_0010_1010 ;
 decode_stimulus_pos[180] = 10'b00_1011_1010 ;
 decode_stimulus_pos[181] = 10'b10_1010_1010 ;
 decode_stimulus_pos[182] = 10'b01_1010_1010 ;
 decode_stimulus_pos[183] = 10'b00_0101_1010 ;
 decode_stimulus_pos[184] = 10'b00_1100_1010 ;
 decode_stimulus_pos[185] = 10'b10_0110_1010 ;
 decode_stimulus_pos[186] = 10'b01_0110_1010 ;
 decode_stimulus_pos[187] = 10'b00_1001_1010 ;
 decode_stimulus_pos[188] = 10'b00_1110_1010 ;
 decode_stimulus_pos[189] = 10'b01_0001_1010 ;
 decode_stimulus_pos[190] = 10'b10_0001_1010 ;
 decode_stimulus_pos[191] = 10'b01_0100_1010 ;
 decode_stimulus_pos[192] = 10'b01_1000_0110 ;
 decode_stimulus_pos[193] = 10'b10_0010_0110 ;
 decode_stimulus_pos[194] = 10'b01_0010_0110 ;
 decode_stimulus_pos[195] = 10'b11_0001_0110 ;
 decode_stimulus_pos[196] = 10'b00_1010_0110 ;
 decode_stimulus_pos[197] = 10'b10_1001_0110 ;
 decode_stimulus_pos[198] = 10'b01_1001_0110 ;
 decode_stimulus_pos[199] = 10'b00_0111_0110 ;
 decode_stimulus_pos[200] = 10'b00_0110_0110 ;
 decode_stimulus_pos[201] = 10'b10_0101_0110 ;
 decode_stimulus_pos[202] = 10'b01_0101_0110 ;
 decode_stimulus_pos[203] = 10'b11_0100_0110 ;
 decode_stimulus_pos[204] = 10'b00_1101_0110 ;
 decode_stimulus_pos[205] = 10'b10_1100_0110 ;
 decode_stimulus_pos[206] = 10'b01_1100_0110 ;
 decode_stimulus_pos[207] = 10'b10_1000_0110 ;
 decode_stimulus_pos[208] = 10'b10_0100_0110 ;
 decode_stimulus_pos[209] = 10'b10_0011_0110 ;
 decode_stimulus_pos[210] = 10'b01_0011_0110 ;
 decode_stimulus_pos[211] = 10'b11_0010_0110 ;
 decode_stimulus_pos[212] = 10'b00_1011_0110 ;
 decode_stimulus_pos[213] = 10'b10_1010_0110 ;
 decode_stimulus_pos[214] = 10'b01_1010_0110 ;
 decode_stimulus_pos[215] = 10'b00_0101_0110 ;
 decode_stimulus_pos[216] = 10'b00_1100_0110 ;
 decode_stimulus_pos[217] = 10'b10_0110_0110 ;
 decode_stimulus_pos[218] = 10'b01_0110_0110 ;
 decode_stimulus_pos[219] = 10'b00_1001_0110 ;
 decode_stimulus_pos[220] = 10'b00_1110_0110 ;
 decode_stimulus_pos[221] = 10'b01_0001_0110 ;
 decode_stimulus_pos[222] = 10'b10_0001_0110 ;
 decode_stimulus_pos[223] = 10'b01_0100_0110 ;
 decode_stimulus_pos[224] = 10'b01_1000_1110 ;
 decode_stimulus_pos[225] = 10'b10_0010_1110 ;
 decode_stimulus_pos[226] = 10'b01_0010_1110 ;
 decode_stimulus_pos[227] = 10'b11_0001_0001 ;
 decode_stimulus_pos[228] = 10'b00_1010_1110 ;
 decode_stimulus_pos[229] = 10'b10_1001_0001 ;
 decode_stimulus_pos[230] = 10'b01_1001_0001 ;
 decode_stimulus_pos[231] = 10'b00_0111_0001 ;
 decode_stimulus_pos[232] = 10'b00_0110_1110 ;
 decode_stimulus_pos[233] = 10'b10_0101_0001 ;
 decode_stimulus_pos[234] = 10'b01_0101_0001 ;
 decode_stimulus_pos[235] = 10'b11_0100_1000 ;
 decode_stimulus_pos[236] = 10'b00_1101_0001 ;
 decode_stimulus_pos[237] = 10'b10_1100_1000 ;
 decode_stimulus_pos[238] = 10'b01_1100_1000 ;
 decode_stimulus_pos[239] = 10'b10_1000_1110 ;
 decode_stimulus_pos[240] = 10'b10_0100_1110 ;
 decode_stimulus_pos[241] = 10'b10_0011_0001 ;
 decode_stimulus_pos[242] = 10'b01_0011_0001 ;
 decode_stimulus_pos[243] = 10'b11_0010_0001 ;
 decode_stimulus_pos[244] = 10'b00_1011_0001 ;
 decode_stimulus_pos[245] = 10'b10_1010_0001 ;
 decode_stimulus_pos[246] = 10'b01_1010_0001 ;
 decode_stimulus_pos[247] = 10'b00_0101_1110 ;
 decode_stimulus_pos[248] = 10'b00_1100_1110 ;
 decode_stimulus_pos[249] = 10'b10_0110_0001 ;
 decode_stimulus_pos[250] = 10'b01_0110_0001 ;
 decode_stimulus_pos[251] = 10'b00_1001_1110 ;
 decode_stimulus_pos[252] = 10'b00_1110_0001 ;
 decode_stimulus_pos[253] = 10'b01_0001_1110 ;
 decode_stimulus_pos[254] = 10'b10_0001_1110 ;
 decode_stimulus_pos[255] = 10'b01_0100_1110 ;



















































































































































































































































































































































































































































































































       
endtask


endclass
  
endpackage



