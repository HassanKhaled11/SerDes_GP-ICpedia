module thresholdMonitor (
    gray_read_pointer,
    gray_write_pointer,
    delete_req,
    add_req
);
  parameter BUFFER_DEPTH = 16;
  localparam max_buffer_addr = $clog2(BUFFER_DEPTH);

  input [max_buffer_addr:0] gray_read_pointer;
  input [max_buffer_addr:0] gray_write_pointer;
  output reg delete_req;
  output reg add_req;

  wire [max_buffer_addr:0] binary_read_pointer;
  wire [max_buffer_addr:0] binary_write_pointer;

  GrayToBinary #(max_buffer_addr + 1) gray_to_bin_write (
      .gray  (gray_write_pointer),
      .binary(binary_write_pointer)
  );
  GrayToBinary #(max_buffer_addr + 1) gray_to_bin_read (
      .gray  (gray_read_pointer),
      .binary(binary_read_pointer)
  );

  integer num_elements;
  always @* begin
    // Calculate the number of elements in the FIFO
    num_elements = binary_write_pointer - binary_read_pointer;
    if (num_elements < 0) num_elements = BUFFER_DEPTH + num_elements;

    // Check if the number of elements is greater than the threshold
    delete_req = (num_elements > 8);
    add_req = ~delete_req;
  end

  // always @(*) begin
  //   if (binary_read_pointer[max_buffer_addr-1] == binary_write_pointer[max_buffer_addr-1]  && binary_read_pointer[max_buffer_addr-1] == binary_write_pointer[max_buffer_addr-1]) begin
  //     add_req = 1;
  //     delete_req = 0;
  //   end else if (binary_read_pointer[max_buffer_addr-1] != binary_write_pointer[max_buffer_addr-1]) begin
  //     add_req = 0;
  //     delete_req = 1;
  //   end else begin
  //     add_req = 0;
  //     delete_req = 0;

  //   end
  // end


  // always @(*) begin
  //   if (gray_read_pointer[max_buffer_addr-1] == gray_write_pointer[max_buffer_addr-1]) begin
  //     add_req = 1;
  //     delete_req = 0;
  //   end else if (gray_read_pointer[max_buffer_addr-1] != gray_write_pointer[max_buffer_addr-1]) begin
  //     add_req = 0;
  //     delete_req = 1;
  //   end else begin
  //     add_req = 0;
  //     delete_req = 0;

  //   end
  // end

  // always @(*) begin
  //   if (gray_read_pointer[max_buffer_addr-1:max_buffer_addr-2] == gray_write_pointer[max_buffer_addr-1:max_buffer_addr-2]) begin
  //     add_req = 1;
  //     delete_req = 0;
  //   end else if (gray_read_pointer[max_buffer_addr-1:max_buffer_addr-2] != gray_write_pointer[max_buffer_addr-1:max_buffer_addr-2]) begin
  //     add_req = 0;
  //     delete_req = 1;
  //   end else begin
  //     add_req = 0;
  //     delete_req = 0;

  //   end
  // end


endmodule
