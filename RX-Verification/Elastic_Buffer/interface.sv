interface BFM_if ;

parameter DATA_WIDTH = 10;
  // PORTS
  //inputs
  bit   write_clk;
  bit   read_clk;
  logic [DATA_WIDTH-1:0] data_in;
  logic buffer_mode;               //0:nominal half full ,1:nominal empty buffer
  logic write_enable;
  logic read_enable;
  logic rst_n;

  //OUTPUTS
  logic skp_added;
  logic Skp_Removed;
  logic overflow, underflow;
  logic [DATA_WIDTH-1:0] data_out;
  // output loopback_tx;

endinterface



interface  Internals_if;

  parameter BUFFER_WIDTH = 16;


  logic [$clog2(BUFFER_WIDTH):0]   write_address;
  logic [$clog2(BUFFER_WIDTH):0]   read_address;
  logic [$clog2(BUFFER_WIDTH):0]   gray_read_pointer;
  logic [$clog2(BUFFER_WIDTH):0]   gray_write_pointer;
 

endinterface 