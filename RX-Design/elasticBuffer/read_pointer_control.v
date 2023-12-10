module read_pointer_control (
    // data_in,
    gray_write_pointer,
    buffer_mode,
    read_clk,
    rst_n,
    ////outputs/////
    empty,
    // underflow,
    skp_added,
    skp_removed,
    data_out,
    // loopback_tx,
    read_address,
    gray_read_pointer
);

  parameter DATA_WIDTH = 10;
  parameter BUFFER_DEPTH = 16;

  localparam max_buffer_addr = $clog2(BUFFER_DEPTH);

  reg delete;  ////////
  // input [DATA_WIDTH-1:0] data_in;
  input read_clk;
  input buffer_mode;
  input rst_n;
  input [max_buffer_addr:0] gray_write_pointer;

  output reg empty;
  output skp_added, skp_removed;
  output [DATA_WIDTH-1:0] data_out;
  output reg [max_buffer_addr:0] read_address;
  output [max_buffer_addr:0] gray_read_pointer;

  wire empty_val;

  // //has pointers had additional bit to indicate if full or empty
  // reg [max_buffer_addr:0] read_pointer;

  binToGray #(max_buffer_addr + 1) bin_gray_read (
      read_address,
      gray_read_pointer
  );

  always @(posedge read_clk or negedge rst_n) begin
    if (!rst_n) begin
      read_address <= 0;
      delete <= 0;
    end else if (!delete && !empty) read_address <= read_address + 1;
  end

  assign empty_val = (gray_read_pointer == gray_write_pointer);
  always @(posedge read_clk or negedge rst_n) begin
    if (!rst_n) empty <= 1'b0;
    else empty <= empty_val;
  end

endmodule
