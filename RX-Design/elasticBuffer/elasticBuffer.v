module elasticBuffer (
    data_in,
    buffer_mode,
    write_clk,
    read_clk,
    overflow,
    underflow,
    skp_added,
    skp_removed,
    data_out,
    // loopback_tx,
    rst_n
);
  parameter DATA_WIDTH = 10;
  parameter BUFFER_DEPTH = 16;

  //inputs
  input write_clk;
  input read_clk;
  output skp_added;
  output skp_removed;
  input rst_n;
  input buffer_mode;  //0:nominal half full ,1:nominal empty buffer
  input [DATA_WIDTH-1:0] data_in;

  //outputs
  // output loopback_tx;
  output overflow, underflow;
  output [DATA_WIDTH-1:0] data_out;

  localparam max_buffer_addr = $clog2(BUFFER_DEPTH);
  wire [max_buffer_addr:0] gray_write_pointer;
  wire [max_buffer_addr:0] gray_read_pointer;
  wire [max_buffer_addr:0] write_address;
  wire [max_buffer_addr:0] read_address;

  wire [max_buffer_addr:0] sync_gray_read_out;
  wire [max_buffer_addr:0] sync_gray_write_out;
  // Instantiate write_pointer_control module
  write_pointer_control #(DATA_WIDTH, BUFFER_DEPTH) write_inst (
      //   .data_in(data_in),
      .gray_read_pointer(sync_gray_read_out),
      .write_clk(write_clk),
      .buffer_mode(buffer_mode),
      .rst_n(rst_n),
      .overflow(overflow),
      .skp_added(skp_added),
      .skp_removed(skp_removed),
      .data_out(data_out),
      .write_address(write_address),
      .gray_write_pointer(gray_write_pointer)
  );

  // Instantiate read_pointer_control module
  read_pointer_control #(DATA_WIDTH, BUFFER_DEPTH) read_inst (
      .gray_write_pointer(sync_gray_write_out),
      .buffer_mode(buffer_mode),
      .read_clk(read_clk),
      .rst_n(rst_n),
      .empty(underflow),
      .skp_added(skp_added),
      .skp_removed(skp_removed),
      .data_out(data_out),
      .read_address(read_address),
      .gray_read_pointer(gray_read_pointer)
  );
  elastic_memory #(DATA_WIDTH, BUFFER_DEPTH) elastic_mem_inst (
      .data_in(data_in),
      .write_clk(write_clk),
      .read_clk(read_clk),
      .read_pointer(read_address[max_buffer_addr-1:0]),
      .write_pointer(write_address[max_buffer_addr-1:0]),
      .data_out(data_out),
      .rd_en(rd_en),
      .full(overflow),
      .empty(underflow),
      .wr_en(wr_en)
  );
  synchronous_unit #(max_buffer_addr) sync_unit_inst (
      .read_to_write_clk(write_clk),
      .gray_counter_read(gray_read_pointer),
      .gray_counter_read_out(sync_gray_read_out),
      .write_to_read_clk(write_clk),
      .gray_counter_write(gray_write_pointer),
      .gray_counter_write_out(sync_gray_write_out)
  );
endmodule
