package my_scoreboard_pkg;

  import uvm_pkg::*;
  `include "uvm_macros.svh"

  import my_sequence_item_pkg::*;
  import PARAMETERS_PKG::*;


  class my_scoreboard extends uvm_scoreboard;

    `uvm_component_utils(my_scoreboard);

    uvm_analysis_export #(my_sequence_item)            sb_export;
    uvm_tlm_analysis_fifo #(my_sequence_item)          sb_fifo;

    // uvm_analysis_imp      #(my_sequence_item , my_scoreboard) sb_export ;

    virtual BFM_if                                     bfm_vif;
    virtual INTERNALS_if                               internals_if;

    my_sequence_item                                   data_to_check;

    int                                                fd,                  fd2;
    int                                                correct_count;
    int                                                error_count;

    logic                                     [31 : 0] temp0;
    logic                                     [31 : 0] Queue_Data      [$];
    logic                                     [31 : 0] Queue_Expec_Data[$];

    logic                                     [ 9 : 0] Coma_collection;


    logic                                     [31 : 0] value1;
    logic                                     [31 : 0] value2;


    realtime                                           t1,                  t2,  t3, t4, t5, t6;


    function new(string name = "my_scoreboard", uvm_component parent = null);
      super.new(name, parent);
      fd = 0;
      fd2 = 0;
      t1 = 0;
      t2 = 0;
      t3 = 0;
      t4 = 0;
      t5 = 0;
      t6 = 0;
      Coma_collection = 10'h0;
      value1 = 0;
      value2 = 0;
    endfunction



    function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      sb_export     = new("sb_export", this);
      sb_fifo       = new("sb_fifo", this);
      data_to_check = new("data_to_check");

      if (!uvm_config_db#(virtual INTERNALS_if)::get(this, "", "internals_if", internals_if))
        `uvm_fatal("MY_TEST", "FATAL PUTTING INTERNALS INTERFACE in CONFIG_DB");

      if (!uvm_config_db#(virtual BFM_if)::get(this, "", "bfm_if", bfm_vif))
        `uvm_fatal("MY_TEST", "FATAL PUTTING INTERNALS INTERFACE in CONFIG_DB");

      `uvm_info("MY_SCOREBOARD", "BUILD_PHASE", UVM_MEDIUM);
    endfunction


    function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      sb_export.connect(sb_fifo.analysis_export);
    endfunction


    function void end_of_elaboration_phase(uvm_phase phase);
      super.end_of_elaboration_phase(phase);  //  OPEN FILE
      fd  = $fopen("./MAC_TX_Data_Stim.hex", "r");
      fd2 = $fopen("./PHY_OUT.hex", "a");
      Queue_Data.push_back(0);
    endfunction



    task run_phase(uvm_phase phase);
      super.run_phase(phase);


      forever begin  //Collect Outs in Queue after Comma Detection
        sb_fifo.get(data_to_check);
        @(internals_if.Bit_CLK);
        //`uvm_info("CAPTURED DATA",$sformatf(" DATA = %h",data_to_check.Rx_Data),UVM_MEDIUM) ;
        //`uvm_info("MY_SCOREBOARD","SOREBOARD's CAPTURING",UVM_MEDIUM);

        // !(data_to_check.Rx_Data[7:0] == 8'h7c || data_to_check.Rx_Data[15:8] == 8'h7c || data_to_check.Rx_Data[23:16] == 8'h7c || data_to_check.Rx_Data[31:24] == 8'h7c

        if (data_to_check.Rx_Data) begin
          if (Queue_Data[$] != data_to_check.Rx_Data) begin
            if ((internals_if.DataBusWidth==6'd32 && data_to_check.Rx_Data != 32'h4A4A_4A4A) || (internals_if.DataBusWidth==6'd16 && data_to_check.Rx_Data != 32'h0000_4A4A) || (internals_if.DataBusWidth==6'd8 && data_to_check.Rx_Data != 32'h0000_004A)) begin
              Queue_Data.push_back(data_to_check.Rx_Data);
              $fwrite(fd2, "%h\n", data_to_check.Rx_Data);
            end
          end
        end
      end

    endtask



    function void check_phase(uvm_phase phase);
      super.check_phase(phase);
      $fclose(fd2);
      fd2 = $fopen("./PHY_OUT.hex", "r");
    endfunction



    function void report_phase(uvm_phase phase);
      super.report_phase(phase);


      while (!$feof(
          fd2
      )) begin
        //$fgets(value1,fd);
        $fscanf(fd, "%h\n", value1);
        $fscanf(fd2, "%h\n", value2);

        if (value1 == value2) begin
          correct_count++;
          `uvm_info("CORRECT COUNT", $sformatf("ACTUAL DATA = %h , EXPECTED DATA = %h", value1,
                                               value2), UVM_LOW);
        end else begin
          error_count++;
          `uvm_info("WRONG COUNT", $sformatf("ACTUAL DATA = %h , EXPECTED DATA = %h", value1,
                                             value2), UVM_LOW);
        end

      end
      `uvm_info("CHECK_PHASE", $sformatf("QUEUE SIZE = %d , LAST ELEMENT = %h", Queue_Data.size(),
                                         Queue_Data[$]), UVM_MEDIUM);


      `uvm_info("CORRECT DATA", $sformatf("correct_count = %d", correct_count), UVM_LOW);
      `uvm_info("ERROR DATA  ", $sformatf("error_count = %d", error_count), UVM_LOW);

    endfunction



    function void final_phase(uvm_phase phase);
      super.final_phase(phase);
      $fclose(fd);  // CLOSE FILE
      $fclose(fd2);
    endfunction

  endclass

endpackage
