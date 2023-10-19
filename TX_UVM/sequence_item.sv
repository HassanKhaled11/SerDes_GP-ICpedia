package sequence_item_pkg;
  import uvm_pkg::*;
  `include "uvm_macros.svh"
  class my_sequence_item extends uvm_sequence_item;
    `uvm_object_utils(my_sequence_item)
    rand bit reset;
    rand bit serial_in, direction, mode;
    rand bit [5:0] datain;
    logic [5:0] dataout;
    function new(string name = "my_sequence_item");
      super.new(name);
    endfunction  //new()

    function string convert2string();
      return $sformatf(
          "%s reset = 0b%0b, serial_in = 0b%0b, direction = 0b%0b, mode = 0b%0b, datain = 0b%0b, dataout = 0b%0b",
          super.convert2string(),
          reset,
          serial_in,
          direction,
          mode,
          datain,
          dataout

      );
    endfunction

    function string convert2string_stimulus();
      return $sformatf(
          "reset = 0b%0b, serial_in = 0b%0b, direction = 0b%0b, mode = 0b%0b, datain = 0b%0b",
          reset,
          serial_in,
          direction,
          mode,
          datain
      );
    endfunction
  endclass  //alu_main_seq  

endpackage
