package my_test_pkg;

  import uvm_pkg::*;
  `include "uvm_macros.svh"

  import my_env_pkg::*;
  import my_sequence_pkg::*;
  import my_config_db_pkg::*;


  import tx_gasket_env_pkg::*;
  import encoding_env_pkg::*;
  import tx_pma_env_pkg::*;
  import rx_s2p_env_pkg::*;
  import cdr_env_pkg::*;
  import ebuffer_env_pkg::*;
  import decoder_env_pkg::*;
  import rx_gasket_env_pkg::*;

  import Enc_Dec_RAL_pkg::*;
  

  class my_test extends uvm_test;

    `uvm_component_utils(my_test);

    my_env         env;

    //////// PASSIVE AGENTS ///////////
    tx_gasket_env  tx_gasket_env_inst;  
    encoding_env   encoding_env_inst;
    tx_pma_env     tx_pma_env_inst;
    rx_s2p_env     rx_s2p_env_inst;
    cdr_env        cdr_env_inst;
    ebuffer_env    ebuffer_env_inst;
    decoder_env    decoder_env_inst;
    rx_gasket_env  rx_gasket_env_inst;
    //////////////////////////////////

    
    //////// SEQUENCES ////////////// 
    my_sequence_32 main_seq_32;
    my_sequence_16 main_seq_16;
    my_sequence_8  main_seq_8;
    ////////////////////////////////


   ///////// BACKDOOR ACCESS  SEQ ///////
   encoder_reg_seq encoder_reg_seq_backdoor;
   /////////////////////////////////////            



   //////// CONFIGIGURATIONS ////////////
    my_config_db   cfg;
    tx_gasket_config_db tx_gasket_cfg;
    encoding_config_db  encoding_cfg;
    tx_pma_config_db    tx_pma_cfg;
    rx_s2p_config_db    rx_s2p_cfg;
    cdr_config_db       cdr_cfg;
    ebuffer_config_db   ebuffer_cfg;
    decoder_config_db   decoder_cfg;
    rx_gasket_config_db rx_gasket_cfg; 
   //////////////////////////////////////

    function new(string name = "my_test", uvm_component parent = null);
      super.new(name, parent);
    endfunction


    function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      `uvm_info("MY_TEST", "BUILD_PHASE", UVM_MEDIUM);

      env                = my_env::type_id::create("env", this);
      tx_gasket_env_inst = tx_gasket_env::type_id::create("tx_gasket_env_inst",this);
      encoding_env_inst  = encoding_env::type_id::create("encoding_env_inst",this);      
      tx_pma_env_inst = tx_pma_env::type_id::create("tx_pma_env_inst",this);
      rx_s2p_env_inst  = rx_s2p_env::type_id::create("rx_s2p_env_inst",this);
      cdr_env_inst  = cdr_env::type_id::create("cdr_env_inst",this);
      ebuffer_env_inst = ebuffer_env::type_id::create("ebuffer_env_inst",this);
      decoder_env_inst  = decoder_env::type_id::create("decoder_env_inst",this);
      rx_gasket_env_inst = rx_gasket_env::type_id::create("rx_gasket_env_inst",this);


//..... SEQUENCES
      main_seq_32        = my_sequence_32::type_id::create("main_seq_32", this);
      main_seq_16        = my_sequence_16::type_id::create("main_seq_16", this);
      main_seq_8         = my_sequence_8::type_id::create("main_seq_8", this);

      encoder_reg_seq_backdoor = encoder_reg_seq::type_id::create("encoder_reg_seq_backdoor");


//..... CONFIGURATIONS      
      cfg                = my_config_db::type_id::create("cfg", this);
      cfg.is_active      = UVM_ACTIVE;            //SET THE MAIN AGENT TO ACTIVE STATUS
      
      tx_gasket_cfg      = tx_gasket_config_db::type_id::create("tx_gasket_cfg", this);
      tx_gasket_cfg.is_active = UVM_PASSIVE;      

      encoding_cfg           = encoding_config_db::type_id::create("encoding_cfg", this);
      encoding_cfg.is_active = UVM_PASSIVE;     

      tx_pma_cfg      = tx_pma_config_db::type_id::create("tx_pma_cfg", this);
      tx_pma_cfg.is_active = UVM_PASSIVE;     

      rx_s2p_cfg      = rx_s2p_config_db::type_id::create("rx_s2p_cfg", this);
      rx_s2p_cfg.is_active = UVM_PASSIVE;     

      cdr_cfg      = cdr_config_db::type_id::create("cdr_cfg", this);
      cdr_cfg.is_active = UVM_PASSIVE;

      ebuffer_cfg      = ebuffer_config_db::type_id::create("ebuffer_cfg", this);
      ebuffer_cfg.is_active = UVM_PASSIVE;

      decoder_cfg      = decoder_config_db::type_id::create("decoder_cfg", this);
      decoder_cfg.is_active = UVM_PASSIVE;    

      rx_gasket_cfg      = rx_gasket_config_db::type_id::create("rx_gasket_cfg", this);
      rx_gasket_cfg.is_active = UVM_PASSIVE;         
              

      if (!uvm_config_db#(virtual BFM_if)::get(this, "", "bfm_if", cfg.dut_vif))
        `uvm_fatal("MY_TEST", "FATAL PUTTING BFM INTERFACE in CONFIG_DB");

      if (!uvm_config_db#(virtual INTERNALS_if)::get(this, "", "internals_if", cfg.internals_if))
        `uvm_fatal("MY_TEST", "FATAL PUTTING INTERNALS INTERFACE in CONFIG_DB");


      if (!uvm_config_db#(virtual PASSIVE_if)::get(this, "" , "passive_if" , tx_gasket_cfg.passive_vif)) begin
          `uvm_fatal("MY_TEST", "FATAL PUTTING tx_gasket_if in CONFIG_DB");
      end


      if (!uvm_config_db#(virtual PASSIVE_if)::get(this, "" , "passive_if" , encoding_cfg.passive_vif)) begin
          `uvm_fatal("MY_TEST", "FATAL PUTTING encoding_if in CONFIG_DB");
      end

      if (!uvm_config_db#(virtual PASSIVE_if)::get(this, "" , "passive_if" , tx_pma_cfg.passive_vif)) begin
          `uvm_fatal("MY_TEST", "FATAL PUTTING tx_pma_if in CONFIG_DB");
      end

      if (!uvm_config_db#(virtual PASSIVE_if)::get(this, "" , "passive_if" , cdr_cfg.passive_vif)) begin
          `uvm_fatal("MY_TEST", "FATAL PUTTING cdr_if in CONFIG_DB");
      end      

      if (!uvm_config_db#(virtual PASSIVE_if)::get(this, "" , "passive_if" , rx_s2p_cfg.passive_vif)) begin
          `uvm_fatal("MY_TEST", "FATAL PUTTING rx_s2p_if in CONFIG_DB");
      end

      if (!uvm_config_db#(virtual PASSIVE_if)::get(this, "" , "passive_if" , ebuffer_cfg.passive_vif)) begin
          `uvm_fatal("MY_TEST", "FATAL PUTTING ebuffer_if in CONFIG_DB");
      end

      if (!uvm_config_db#(virtual PASSIVE_if)::get(this, "" , "passive_if" , decoder_cfg.passive_vif)) begin
          `uvm_fatal("MY_TEST", "FATAL PUTTING decoder_if in CONFIG_DB");
      end      

      if (!uvm_config_db#(virtual PASSIVE_if)::get(this, "" , "passive_if" , rx_gasket_cfg.passive_vif)) begin
          `uvm_fatal("MY_TEST", "FATAL PUTTING  rx_gasket_if in CONFIG_DB");
      end


      uvm_config_db#(my_config_db)::set(this, "*", "CFG", cfg);
      uvm_config_db#(tx_gasket_config_db)::set(this, "*", "TX_GASKET_CFG", tx_gasket_cfg);
      uvm_config_db#(encoding_config_db)::set(this, "*", "ENCODING_CFG", encoding_cfg);
      uvm_config_db#(tx_pma_config_db)::set(this, "*", "TX_PMA_CFG", tx_pma_cfg);      
      uvm_config_db#(cdr_config_db)::set(this, "*", "CDR_CFG", cdr_cfg);
      uvm_config_db#(rx_s2p_config_db)::set(this, "*", "RX_S2P_CFG", rx_s2p_cfg);
      uvm_config_db#(ebuffer_config_db)::set(this, "*", "EBUFFER_CFG", ebuffer_cfg);
      uvm_config_db#(decoder_config_db)::set(this, "*", "DECODER_CFG", decoder_cfg);
      uvm_config_db#(rx_gasket_config_db)::set(this, "*", "RX_GASKET_CFG", rx_gasket_cfg);

    endfunction






    task run_phase(uvm_phase phase);
      phase.raise_objection(this);

      fork
        // begin
        //   `uvm_warning("MY_TEST","MAIN SEQ START");
        // end
        begin


          ///////////WIDTH = 32//////////////

          cfg.dut_vif.DataBusWidth = 6'd32;
          `uvm_warning("MY_TEST_32", "RESET");
          cfg.dut_vif.Reset_n = 0;
          #1000;
          cfg.dut_vif.Reset_n = 1;

          #4;
          `uvm_warning("MY_TEST_32", "MAIN TEST START..");
          main_seq_32.start(env.agent.sqr);


          
          `uvm_warning("BACKDOOR TEST", "ENCODING BACKDOOR TEST START..");
           //encoding_cfg.is_active = UVM_ACTIVE;
           encoder_reg_seq_backdoor.reg_block = encoding_env_inst.reg_block;
           encoder_reg_seq_backdoor.start(encoding_env_inst.agt.sequencer);



        //   ////////////WIDTH = 16////////////
        //   cfg.dut_vif.DataBusWidth = 6'd16;
        //   `uvm_warning("MY_TEST_16", "RESET");
        //   cfg.dut_vif.Reset_n = 0;
        //   #1000;
        //   cfg.dut_vif.Reset_n = 1;

        //   #4;
        //   `uvm_warning("MY_TEST_16", "MAIN TEST START..");
        //   main_seq_16.start(env.agent.sqr);

        //   #3000;
        //   cfg.dut_vif.MAC_Data_En = 0;
        //   #3000;
        //   cfg.dut_vif.MAC_Data_En  = 1;

        //   //////////WIDTH = 8////////////
        //   cfg.dut_vif.DataBusWidth = 6'd8;
        //   `uvm_warning("MY_TEST_8", "RESET");
        //   cfg.dut_vif.Reset_n = 0;
        //   #1000;
        //   cfg.dut_vif.Reset_n = 1;

        //   #4;
        //   `uvm_warning("MY_TEST_8", "MAIN TEST START..");
        //   main_seq_8.start(env.agent.sqr);
         end

      join

      phase.drop_objection(this);
      phase.phase_done.set_drain_time(this , 500);
      
    endtask


function void report_phase (uvm_phase phase);
  super.report_phase(phase);
  
    uvm_top.print_topology();

endfunction



  endclass
endpackage
