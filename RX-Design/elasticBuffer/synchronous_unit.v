module synchronous_unit (
    read_to_write_clk,
    gray_counter_read,
    gray_counter_read_out,

    write_to_read_clk,
    gray_counter_write,
    gray_counter_write_out
);
  parameter n = 4;
  input read_to_write_clk, write_to_read_clk;
  input [n:0] gray_counter_read, gray_counter_write;
  output reg [n:0] gray_counter_read_out, gray_counter_write_out;

  reg [n:0] gray_counter_read_reg1, gray_counter_read_reg2;
  reg [n:0] gray_counter_write_reg1, gray_counter_write_reg2;

  always @(posedge read_to_write_clk) begin
    gray_counter_read_reg1 <= gray_counter_read;
    gray_counter_read_reg2 <= gray_counter_read_reg1;
    gray_counter_read_out  <= gray_counter_read_reg2;
  end

  always @(posedge write_to_read_clk) begin
    gray_counter_write_reg1 <= gray_counter_write;
    gray_counter_write_reg2 <= gray_counter_write_reg1;
    gray_counter_write_out  <= gray_counter_write_reg2;
  end
endmodule

// module synchronous_unit (
//     data_in,
//     write_pointer,
//     read_pointer,
//     // delete_skp,
//     // add_skp,
//     // insert_skp,
//     empty,
//     read_clk,
//     write_clk
// );
//   parameter DATA_WIDTH = 10;
//   parameter BUFFER_DEPTH = 16;

//   input [DATA_WIDTH-1:0] data_in;
//   input read_clk, write_clk;

//   //has additional bit to indicate if full or empty
//   reg [max_buffer_addr:0] read_pointer;
//   reg [max_buffer_addr:0] write_pointer;
//   always @(posedge read_clk or posedge write_clk) begin

//     if (read_pointer == write_pointer) begin
//       empty = 1;
//       full  = 0;
//     end  //all same except the MSB
//     else if (read_pointer[max_buffer_addr-1:0] == write_pointer[max_buffer_addr-1:0]) begin
//       full  = 1;
//       empty = 0;
//     end else begin
//       full  = 0;
//       empty = 0;
//     end
//   end



// endmodule
