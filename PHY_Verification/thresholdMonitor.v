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


  // wire threshold_flag;

  always @(*) begin
    if (gray_read_pointer[max_buffer_addr] == gray_write_pointer[max_buffer_addr]) begin
      add_req = 1;
      delete_req = 0;
    end else if (gray_read_pointer[max_buffer_addr] != gray_write_pointer[max_buffer_addr]) begin
      add_req = 0;
      delete_req = 1;
    end else begin
      add_req = 0;
      delete_req = 0;

    end
  end
  // assign threshold_flag = (gray_read_pointer[max_buffer_addr-1:max_buffer_addr-2] == ~gray_write_pointer[max_buffer_addr-1:max_buffer_addr-2] 
  // && gray_read_pointer[max_buffer_addr-3:0] == gray_write_pointer[max_buffer_addr-3:0]);


endmodule
