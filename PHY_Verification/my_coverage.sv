package my_coverage_pkg;

  import uvm_pkg::*;
  `include "uvm_macros.svh"

  import my_sequence_item_pkg::*;

  class my_coverage extends uvm_component;

    `uvm_component_utils(my_coverage);

    uvm_analysis_export #(my_sequence_item)   cov_export;
    uvm_tlm_analysis_fifo #(my_sequence_item) cov_fifo;
    my_sequence_item                          data_to_cover;

    virtual BFM_if                            bfm_vif;
    virtual INTERNALS_if                      internals_if;



    ////////////////////////////////////////////////////////
    //////////////////// COVER GROUPS //////////////////////
    ////////////////////////////////////////////////////////

    covergroup PMA_COV_gp;

      TX_cp: coverpoint data_to_cover.TX_Out_P {
        bins TX_HIGH_BIT = {1'b1};
        bins TX_LOW_BIT = {1'b0};
        bins TRANS_10 = (1 => 0);
        bins TRANS_01 = (0 => 1);
        bins TRANS_11 = (1 => 1);
        bins TRANS_00 = (0 => 0);
      }

      MAC_TX_Data_cp: coverpoint data_to_cover.MAC_TX_Data {
        bins MAC_STIM_COMMA = {32'hBC_BC_BC_BC};
        bins MAC_STIM_TSEQ = {32'h4A_4A_4A_4A};
        bins MAC_STIM_DATA = default;
      }

      MAC_TX_DataK_cp: coverpoint data_to_cover.MAC_TX_DataK iff (bfm_vif.Reset_n) {
        bins FULL_CMD_PKT = {4'd15};
      }


      MAC_TX_Enable_cp: coverpoint internals_if.MAC_Data_En {
        bins ENABLE_H = {1'b1};
        bins ENABLE_L = {1'b1};
        bins ENABLE_HL = (1 => 0);
        bins ENABLE_LH = (0 => 1);
      }

    endgroup


    //.................................

    covergroup PCS_COV_gp;

      RX_DATA_cp: coverpoint data_to_cover.Rx_Data;


      Rx_Valid_cp: coverpoint data_to_cover.Rx_Valid {
        bins RX_VALID_H = {1'b1};
        bins RX_VALID_L = {1'b0};
        bins TRANS_HL = (1 => 0);
        bins TRANS_LH = (0 => 1);
      }


      Rx_status_cp: coverpoint data_to_cover.Rx_Status {
        bins STATUS_NO_ERROR = {3'b000};
        bins STATUS_SKP_ADDED = {3'b001};
        bins STATUS_SKP_REMOVED = {3'b010};
        bins STATUS_OVERFLOW = {3'b101};
        bins STATUS_UNDERFLOW = {3'b110};
        bins STATUS_DECODE_ERROR = {3'b100};
        bins STATUS_DISPARITY_ERROE = {3'b111};
      }


      COMMA_DETECTION_cp: coverpoint internals_if.COMMA_PULSE {
        bins COMMA_H = {1'b1};
        bins COMMA_L = {1'b1};
        bins COMMA_HL = (1 => 0);
        bins COMMA_LH = (0 => 1);
      }


      Decode_Error_cp: coverpoint internals_if.Decode_Error {
        bins DEC_ERR_H = {1'b1};
        bins DEC_ERR_L = {1'b1};
        bins DEC_ERR_HL = (1 => 0);
        bins DEC_ERR_LH = (0 => 1);
      }


      Disparity_Error_cp: coverpoint internals_if.Disparity_Error {
        bins Disparity_ERR_H = {1'b1};
        bins Disparity_ERR_L = {1'b1};
        bins Disparity_ERR_HL = (1 => 0);
        bins Disparity_ERR_LH = (0 => 1);
      }


    endgroup


    //...........................................

    covergroup CONFIG_gp;

      RESET_cp: coverpoint bfm_vif.Reset_n {
        bins RESET_HIGH = {1'b1};
        bins RESET_LOW = {1'b0};
        bins RST_TRANS_HL = (1 => 0);
        bins RST_TRANS_LH = (0 => 1);
      }


      DATA_BUS_WIDTH_cp: coverpoint internals_if.DataBusWidth {
        bins BUS_WIDTH_8 = {6'd8}; bins BUS_WIDTH_16 = {6'd16}; bins BUS_WIDTH_32 = {6'd32};
      }

    endgroup


    ////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////


    function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      cov_export    = new("cov_export", this);
      cov_fifo      = new("cov_fifo", this);
      data_to_cover = new("data_to_cover");

      if (!uvm_config_db#(virtual BFM_if)::get(this, "", "bfm_if", bfm_vif))
        `uvm_fatal("MY_TEST", "FATAL PUTTING BFM INTERFACE in CONFIG_DB");


      if (!uvm_config_db#(virtual INTERNALS_if)::get(this, "", "internals_if", internals_if))
        `uvm_fatal("MY_TEST", "FATAL PUTTING INTERNALS INTERFACE in CONFIG_DB");

    endfunction


    function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      cov_export.connect(cov_fifo.analysis_export);
    endfunction


    function new(string name = "my_coverage", uvm_component parent = null);
      super.new(name, parent);
      PMA_COV_gp = new();
      PCS_COV_gp = new();
      CONFIG_gp  = new();
    endfunction



    task run_phase(uvm_phase phase);
      super.run_phase(phase);
      forever begin
        @(internals_if.Bit_CLK);
        cov_fifo.get(data_to_cover);
        PMA_COV_gp.sample();
        PCS_COV_gp.sample();
        CONFIG_gp.sample();
      end
    endtask



  endclass
endpackage
