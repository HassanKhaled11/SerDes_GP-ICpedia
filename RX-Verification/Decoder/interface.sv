interface Decoder_if (
    input bit CLK
);

  // PORTS
  // logic       CLK;
  logic       Rst_n;
  logic [9:0] Data_in;
  logic [7:0] Data_out;
  logic       DecodeError;
  logic       DisparityError;
  logic       RxDataK;



endinterface

