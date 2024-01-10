module elastic_memory (
    data_in,
    write_clk,
    read_clk,
    read_pointer,
    write_pointer,
    data_out,
    // rd_en,
    full,
    empty,
    insert,
    // wr_en
);
  parameter DATA_WIDTH = 10;
  parameter BUFFER_DEPTH = 16;

  localparam max_buffer_addr = $clog2(BUFFER_DEPTH);

  input read_clk, write_clk;
  input full, empty;
  input [DATA_WIDTH-1:0] data_in;
  input [max_buffer_addr-1:0] read_pointer;
  input [max_buffer_addr-1:0] write_pointer;
  // input rd_en, wr_en;
  input insert;
  output [DATA_WIDTH-1:0] data_out;

  reg [DATA_WIDTH-1:0] buffer[0:BUFFER_DEPTH-1];

  //reading
  assign data_out = buffer[read_pointer];
  // always @(*) begin
  //   if(empty)begin
  //     data_out<=//end
  //   end
  // end


  //writing
  always @(posedge write_clk) begin
    if ( !full) begin
      buffer[write_pointer] <= data_in;
    end
  end
endmodule
