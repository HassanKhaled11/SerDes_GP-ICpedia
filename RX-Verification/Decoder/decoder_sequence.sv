package decoder_sequence_pkg;

  import uvm_pkg::*;
  `include "uvm_macros.svh"
  import decoder_sequence_item_pkg::*;

  // import my_sequence_item_pkg::*;


  class reset_sequence extends uvm_sequence #(decoder_sequence_item);

    `uvm_object_utils(reset_sequence);

    decoder_sequence_item stim_seq_item;

    function new(string name = "reset_sequence");
      super.new(name);
    endfunction

    task body();
      stim_seq_item = decoder_sequence_item::type_id::create("stim_seq_item");
      start_item(stim_seq_item);
      stim_seq_item.Rst_n   = 1'b1;
      stim_seq_item.Data_in = $random;
      finish_item(stim_seq_item);
      get_response(stim_seq_item);
    endtask : body


  endclass


  class decoder_sequence extends uvm_sequence #(decoder_sequence_item);

    `uvm_object_utils(decoder_sequence);

    decoder_sequence_item stim_seq_item;

    function new(string name = "decoder_sequence");
      super.new(name);
      `uvm_info("DECODER_SEQUENCE", "SEQ CREATED", UVM_HIGH);
    endfunction


    task body();

      stim_seq_item = decoder_sequence_item::type_id::create("stim_seq_item");


      // stim_seq_item.data_detect.constraint_mode(0);

      repeat (100) begin

        `uvm_info("DECODER_SEQUENCE", "BEFORE START ITEM", UVM_HIGH);
        start_item(stim_seq_item);

        `uvm_info("DECODER_SEQUENCE", "AFTER START ITEM", UVM_HIGH);

        assert (stim_seq_item.randomize());

        finish_item(stim_seq_item);

        get_response(stim_seq_item);
        `uvm_info("MY_SEQUENCE", "AFTER FINISH ITEM", UVM_HIGH);
      end


    endtask


  endclass




endpackage
