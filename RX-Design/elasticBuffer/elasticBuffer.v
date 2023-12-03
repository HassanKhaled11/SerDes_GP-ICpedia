module elasticBuffer (
    data_in,
    buffer_mode,
    clk_write,
    clk_read,
    overflow,
    skp_added_removed,
    data_out,
    // loopback_tx,
    rst_n
);
  parameter DATA_WIDTH = 10;
  parameter BUFFER_DEPTH = 16;
  input clk_write;
  input clk_read;
  input rst_n;
  input buffer_mode;  //0:nominal half full ,1:nominal empty buffer
  input [DATA_WIDTH-1:0] data_in;
  // output loopback_tx;
  output reg overflow;
  output skp_added_removed;
  output  reg [DATA_WIDTH-1:0] data_out;

  localparam max_buffer_addr = $clog2(BUFFER_DEPTH);
  reg [     DATA_WIDTH-1:0] buffer        [0:BUFFER_DEPTH-1];
  reg [max_buffer_addr-1:0] read_pointer;
  reg [max_buffer_addr-1:0] write_pointer;
  reg [max_buffer_addr-1:0] count;

  localparam buffer_limit = (BUFFER_DEPTH) / 2;


  //writing
  always @(posedge clk_write) begin
    if (!rst_n) begin
      write_pointer <= 0;
    end else if (buffer_mode == 0) begin
      buffer[write_pointer] <= data_in;
      write_pointer <= write_pointer + 1;


    end

  end

  //reading
  always @(posedge clk_read) begin
    if (!rst_n) begin
      read_pointer <= 0;
    end else begin
      data_out <= buffer[read_pointer];
      read_pointer <= read_pointer + 1;
    end
  end

  //making a counter
  always @(*) begin
    if (!rst_n) begin
      count <= 0;
      overflow <= 0;
    end else begin
      count <= (write_pointer>read_pointer)? (write_pointer - read_pointer):(read_pointer - write_pointer);
      if (count > buffer_limit) begin
        overflow = 1'b1;
      end else overflow = 1'b0;
    end
  end

endmodule
