module write_pointer_control (
    write_clk,
    data_in,
    gray_read_pointer,
  //  buffer_mode,
    rst_n,
    // write_enable,
    delete_req,
    ////outputs/////
    Skp_Added,
    overflow,
    Skp_Removed,
    write_address,
    gray_write_pointer
    // loopback_tx,

);

  parameter DATA_WIDTH = 10;
  parameter BUFFER_DEPTH = 16;

  localparam max_buffer_addr = $clog2(BUFFER_DEPTH);


  input [DATA_WIDTH-1:0] data_in;
  input write_clk;
  input delete_req;
  input rst_n;
  input [max_buffer_addr:0] gray_read_pointer;

  output reg overflow;
  output reg Skp_Removed;
  output reg Skp_Added;
  //  pointers has additional bit to indicate if full or empty
  output reg [max_buffer_addr:0] write_address;
  output [max_buffer_addr:0] gray_write_pointer;



  wire full_val;

  binToGray #(max_buffer_addr + 1) bin_gray_write (
      write_address,
      gray_write_pointer
  );

  always @(posedge write_clk or negedge rst_n) begin
   if (!rst_n) begin
      write_address <= 0;
      Skp_Removed   <= 0;
      Skp_Added     <= 0;
    end

     else if (!full_val) begin  //check not skp
      if (!(data_in == 10'b001111_1001 || data_in == 10'b110000_0110)) begin
        write_address <= write_address + 1;
        Skp_Removed   <= 0;
        Skp_Added     <= 0;
      end else if (!delete_req) begin
        write_address <= write_address + 1;
        Skp_Removed   <= 0;
        Skp_Added     <=1 ;
      end else begin
        Skp_Removed   <= 1;
        Skp_Added     <= 0;
        write_address <= write_address;
      end
    end
  end

  assign full_val = ((gray_read_pointer[max_buffer_addr] !=gray_write_pointer[max_buffer_addr] ) &&
  (gray_read_pointer[max_buffer_addr-1] !=gray_write_pointer[max_buffer_addr-1]) &&
  (gray_read_pointer[max_buffer_addr-2:0]==gray_write_pointer[max_buffer_addr-2:0]));

  // assign full_val = (gray_write_pointer=={~gray_read_pointer[max_buffer_addr:max_buffer_addr-1],
  // gray_read_pointer[max_buffer_addr-2:0]});


  always @(*) begin
    if (!rst_n) overflow = 1'b0;
    else overflow = full_val;
  end


endmodule
