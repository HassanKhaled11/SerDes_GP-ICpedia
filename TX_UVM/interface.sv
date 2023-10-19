interface TX_interface (
    clk
);
  input clk;
  logic reset;
  logic serial_in, direction, mode;
  logic [5:0] datain, dataout;
endinterface : TX_interface
