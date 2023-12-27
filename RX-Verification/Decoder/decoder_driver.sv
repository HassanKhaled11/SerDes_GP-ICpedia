package decoder_driver_pkg;

  import decoder_sequence_item_pkg::*;
  import uvm_pkg::*;
  `include "uvm_macros.svh"



  class decoder_driver extends uvm_driver #(decoder_sequence_item);

    `uvm_component_utils(decoder_driver);

    virtual Decoder_if dec_vif;
    decoder_sequence_item stim_seq_item;



    function new(string name = "decoder_driver", uvm_component parent = null);
      super.new(name, parent);
    endfunction


    function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      `uvm_info("DECODER_DRIVER", "BUILD_PHASE", UVM_HIGH);
      // if(!uvm_config_db #(virtual dec_if) :: get(this , "" , "dec_if" , dec_vif))
      // 		`uvm_fatal("DRIVER","failed to read interface through driver");
    endfunction

    function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      // my_shift_driver_vif = shift_config_obj_driver.tx_vif;
    endfunction
    task run_phase(uvm_phase phase);
      super.run_phase(phase);
      forever begin
        stim_seq_item = decoder_sequence_item::type_id::create("stim_seq_item", this);

        seq_item_port.get_next_item(stim_seq_item);
        `uvm_info("MY_DRIVER", "here_data start", UVM_HIGH);
        dec_vif.Rst_n   = stim_seq_item.Rst_n;
        dec_vif.Data_in = stim_seq_item.Data_in;

        `uvm_info(
            "MY_DRIVER",
            $sformatf(
                "rst_n = %d , Data_in = 0x%h , Data_Out = %d,DecodeError=%d,DisparityError=%d,RxDataK=%d",
                dec_vif.Rst_n, dec_vif.Data_in, dec_vif.Data_out, dec_vif.DecodeError,
                dec_vif.DisparityError, dec_vif.RxDataK), UVM_HIGH);
        @(negedge dec_vif.CLK);
        seq_item_port.item_done(stim_seq_item);


      end
    endtask : run_phase





  endclass
endpackage
