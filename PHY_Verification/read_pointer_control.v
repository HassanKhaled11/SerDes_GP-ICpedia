module read_pointer_control (
    // data_in,
    read_clk,
    gray_write_pointer,
  //  buffer_mode,
    rst_n,
    data_out,
    add_req,

    ////outputs/////
    empty,
    insert,
    skp_added,
    // read_enable,
    read_address,
    gray_read_pointer
    // loopback_tx,
);

  parameter DATA_WIDTH = 10;
  parameter BUFFER_DEPTH = 16;

  localparam max_buffer_addr = $clog2(BUFFER_DEPTH);

  // input [DATA_WIDTH-1:0] data_in;
  input read_clk;
  // input read_enable;
//  input buffer_mode;
  input add_req;  //////////////
  input rst_n;
  input [max_buffer_addr:0] gray_write_pointer;
  input [DATA_WIDTH-1:0] data_out;  ////////////

  output reg empty;
  output reg insert;
  output reg skp_added;
  output reg [max_buffer_addr:0] read_address;
  output [max_buffer_addr:0] gray_read_pointer;

  wire empty_val;

  // //has pointers had additional bit to indicate if full or empty

  binToGray #(max_buffer_addr + 1) bin_gray_read (
      read_address,
      gray_read_pointer
  );

  always @(posedge read_clk or negedge rst_n) begin
    if (!rst_n) begin
      read_address <= 0;
      insert <= 0;
      skp_added <= 0;
    end else if (!empty) begin
      if (!(add_req && (data_out == 10'b001111_1001 || data_out == 10'b110000_0110))) begin  //skp
        read_address <= read_address + 1;
        insert <= 0;
        skp_added <= 0;
      end else begin
        insert <= 1;
        skp_added <= 1;
      end
    end
  end


  assign empty_val = (gray_read_pointer == gray_write_pointer);

  always @(posedge read_clk or negedge rst_n) begin
    if (!rst_n) empty <= 1'b1;
    else empty <= (gray_read_pointer == gray_write_pointer);
  end

endmodule
