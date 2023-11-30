module elasticBuffer_tb ();
  parameter DATA_WIDTH = 10;
  parameter BUFFER_DEPTH = 16;
  reg clk_write;
  reg clk_read;
  reg rst_n;
  reg buffer_mode;
  reg [DATA_WIDTH-1:0] data_in;
  wire loopback_tx;
  wire overflow;
  wire skp_added_removed;
  wire [DATA_WIDTH-1:0] data_out;

  // Instantiate the DUT
  elasticBuffer uut (
      .clk_write(clk_write),
      .clk_read(clk_read),
      .rst_n(rst_n),
      .buffer_mode(buffer_mode),
      .data_in(data_in),
      .loopback_tx(loopback_tx),
      .overflow(overflow),
      .skp_added_removed(skp_added_removed),
      .data_out(data_out)
  );

  initial begin
    clk_write = 0;
    forever #3 clk_write = ~clk_write;
  end

  initial begin
    clk_read = 0;
    forever #2 clk_read = ~clk_read;
  end

  initial begin
    // Initialize signals
    rst_n = 0;
    buffer_mode = 0;
    data_in = 0;

    #10 rst_n = 1;



    // Test scenario
    // Write data into the buffer
    data_in = 10'hAA;
    @(negedge clk_write);
    data_in = 10'h2BB;
    @(negedge clk_write);
    data_in = 10'h1CC;
    @(negedge clk_write);
    data_in = 10'h3AA;
    @(negedge clk_write);
    data_in = 10'h111;
    @(negedge clk_write);
    @(negedge clk_write);
    data_in = 10'h092;
    @(negedge clk_write);
    // // Read data from the buffer
    // buffer_mode = 1; // Set to read mode
    // #10;
    // buffer_mode = 0; // Set back to write mode
    // #10;


    // End simulation
    $stop;
  end
endmodule
