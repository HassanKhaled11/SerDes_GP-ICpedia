package sequence_pkg;
  import sequence_item_pkg::*;
  import uvm_pkg::*;
  `include "uvm_macros.svh"

  class reset_seq extends uvm_sequence #(my_sequence_item);
    `uvm_object_utils(reset_seq)

    my_sequence_item seq_item;

    function new(string name = "reset_seq");
      super.new(name);
    endfunction  //new()

    task body();
      seq_item = my_sequence_item::type_id::create("seq_item");
      start_item(seq_item);
      seq_item.reset     = 1;
      seq_item.serial_in = 0;
      seq_item.direction = 0;
      seq_item.mode      = 0;
      seq_item.datain    = 0;
      finish_item(seq_item);
    endtask
  endclass  //alu_reset_seq     

  class main_seq extends uvm_sequence #(my_sequence_item);
    `uvm_object_utils(main_seq)

    my_sequence_item seq_item;
    function new(string name = "main_seq");
      super.new(name);
    endfunction  //new()

    task body();
      repeat (1000) begin
        seq_item = my_sequence_item::type_id::create("seq_item");
        start_item(seq_item);
        assert (seq_item.randomize());
        finish_item(seq_item);
      end
    endtask
  endclass  //alu_main_seq     

endpackage
