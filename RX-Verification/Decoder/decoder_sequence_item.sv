package decoder_sequence_item_pkg;

  import uvm_pkg::*;
  `include "uvm_macros.svh"


  class decoder_sequence_item extends uvm_sequence_item;

    `uvm_object_utils(decoder_sequence_item);


    function new(string name = "decoder_sequence_item");
      super.new(name);
    endfunction



    bit              CLK;
    rand logic       Rst_n;
    rand logic [9:0] Data_in;
    logic      [7:0] Data_out;
    logic            DecodeError;
    logic            DisparityError;
    logic            RxDataK;


    constraint Rst_n_c {
      Rst_n dist {
        1 :/ 95,
        0 :/ 5
      };
    }

    function string convert2string();
      return $sformatf(
          "%s rst_n = 0b%0b, data_in = 0b%0b, data_out = 0b%0b, DecodeError = 0b%0b, DisparityError = 0b%0b, RxDataK= 0b%0b",
          super.convert2string(),
          Rst_n,
          Data_in,
          Data_out,
          DecodeError,
          DisparityError,
          RxDataK
      );
    endfunction

  endclass
endpackage
