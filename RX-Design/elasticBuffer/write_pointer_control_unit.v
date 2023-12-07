module write_pointer_control (
    // data_in,
    gray_read_pointer,
    buffer_mode,
    write_clk,
    rst_n,
    ////outputs/////
    overflow,
    // underflow,
    skp_added,
    skp_removed,
    data_out,
    // loopback_tx,
    write_address,
    gray_write_pointer

);

  parameter DATA_WIDTH = 10;
  parameter BUFFER_DEPTH = 16;

  localparam max_buffer_addr = $clog2(BUFFER_DEPTH);


  // input [DATA_WIDTH-1:0] data_in;
  input write_clk;
  input buffer_mode;
  input rst_n;
  input [max_buffer_addr:0] gray_read_pointer;

  output reg overflow;
  output skp_added, skp_removed;
  output [DATA_WIDTH-1:0] data_out;
  output reg [max_buffer_addr:0] write_address;
  output [max_buffer_addr:0] gray_write_pointer;


  wire delete;
  //has pointers had additional bit to indicate if full or empty
  reg [max_buffer_addr:0] write_pointer;
  wire full_val;

  binToGray #(max_buffer_addr + 1) bin_gray_write (
      write_address,
      gray_read_pointer
  );

  always @(posedge write_clk or negedge rst_n) begin
    if (!rst_n) write_address <= 0;
    else if (!delete && !overflow) begin
      write_address = (write_address == {max_buffer_addr - 1{1'b1}}) ? 4'b0 : write_address + 1;
    end
  end
  //   assign full_val = ((gray_read_pointer[max_buffer_addr] !=gray_read_pointer[max_buffer_addr] ) &&
  // (gray_read_pointer[max_buffer_addr-1] !=gray_read_pointer[max_buffer_addr-1]) &&
  // (gray_read_pointer[max_buffer_addr-2:0]==gray_read_pointer[max_buffer_addr-2:0]));

  assign full_val = (gray_write_pointer=={~gray_read_pointer[max_buffer_addr:max_buffer_addr-1],
gray_read_pointer[max_buffer_addr-2:0]});
  always @(posedge write_clk or negedge rst_n) begin
    if (!rst_n) overflow <= 1'b0;
    else overflow <= full_val;
  end

endmodule
