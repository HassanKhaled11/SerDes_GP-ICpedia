module elasticBuffer (
    write_clk,
    read_clk,
    data_in,
    //buffer_mode,
    // write_enable,
    // read_enable,
    rst_n,
    ////////////////////
    overflow,
    underflow,
    skp_added,
    Skp_Removed,
    data_out
    // loopback_tx,
);
  parameter DATA_WIDTH = 10;
  parameter BUFFER_DEPTH = 16;

  //inputs
  input write_clk;
  input read_clk;
  input [DATA_WIDTH-1:0] data_in;
  //input buffer_mode;  //0:nominal half full ,1:nominal empty buffer
  //   input write_enable;
  //   input read_enable;
  input rst_n;

  //outputs
  // output loopback_tx;
  output skp_added;
  output Skp_Removed;
  output overflow, underflow;
  output [DATA_WIDTH-1:0] data_out;



  localparam max_buffer_addr = $clog2(BUFFER_DEPTH);
  wire [max_buffer_addr:0] gray_write_pointer;
  wire [max_buffer_addr:0] gray_read_pointer;
  wire [max_buffer_addr:0] write_address;
  wire [max_buffer_addr:0] read_address;

  wire [max_buffer_addr:0] sync_gray_read_out;
  wire [max_buffer_addr:0] sync_gray_write_out;
  wire delete_req;
  wire add_req;
  // Instantiate write_pointer_control module
  write_pointer_control #(DATA_WIDTH, BUFFER_DEPTH) write_inst (
      .write_clk(write_clk),
      .data_in(data_in),
      .gray_read_pointer(sync_gray_read_out),
      //.buffer_mode(buffer_mode),
      .rst_n(rst_n),
      .Skp_Added(skp_added),
      .delete_req(delete_req),
      .overflow(overflow),
      .Skp_Removed(Skp_Removed),
      .write_address(write_address),
      .gray_write_pointer(gray_write_pointer)
  );

  // Instantiate read_pointer_control module
  read_pointer_control #(DATA_WIDTH, BUFFER_DEPTH) read_inst (
      .read_clk(read_clk),
      .gray_write_pointer(sync_gray_write_out),
      //.buffer_mode(buffer_mode),
      .rst_n(rst_n),
      .data_out(data_out),
      .add_req(add_req),
      .empty(underflow),
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
      .full(overflow),
      .empty(underflow),
      .add_req (add_req)
  );

  synchronous_unit #(max_buffer_addr) sync_unit_inst (
      .rst_n(rst_n),
      .read_to_write_clk(write_clk),
      .gray_counter_read(gray_read_pointer),
      .gray_counter_read_out(sync_gray_read_out),
      .write_to_read_clk(read_clk),
      .gray_counter_write(gray_write_pointer),
      .gray_counter_write_out(sync_gray_write_out)
  );

  thresholdMonitor #(BUFFER_DEPTH) Threshold_Monitor_Inst (
      .gray_read_pointer(gray_read_pointer),
      .gray_write_pointer(gray_write_pointer),
      .delete_req(delete_req),
      .add_req(add_req)
  );
endmodule
