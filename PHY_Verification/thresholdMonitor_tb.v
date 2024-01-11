module thresholdMonitorTB ();
  parameter BUFFER_DEPTH = 16;
  localparam max_buffer_addr = $clog2(BUFFER_DEPTH);

  reg [max_buffer_addr:0] gray_read_pointer;
  reg [max_buffer_addr:0] gray_write_pointer;
  wire delete_req;
  wire add_req;
  reg [max_buffer_addr:0] i, j;
  thresholdMonitor threshold_inst (
      gray_read_pointer,
      gray_write_pointer,
      delete_req,
      add_req
  );

  wire [max_buffer_addr:0] my_gray_read_pointer;
  wire [max_buffer_addr:0] my_gray_write_pointer;
  binToGray #(max_buffer_addr + 1) bin_gray_read (
      i,
      my_gray_read_pointer
  );

  binToGray #(max_buffer_addr + 1) bin_gray_write (
      j,
      my_gray_write_pointer
  );
  initial begin
    gray_write_pointer = my_gray_write_pointer;
    gray_read_pointer  = my_gray_read_pointer;
    #2;

    for (i = 0; i < 17; i = i + 1) begin
      for (j = 0; j < 17; j = j + 1) begin
        gray_write_pointer = my_gray_write_pointer;
        gray_read_pointer  = my_gray_read_pointer;
        #2;
      end
    end
    $stop;
  end
endmodule
