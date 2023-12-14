module elasticBuffer_tb ();
  parameter DATA_WIDTH = 10;
  parameter BUFFER_DEPTH = 16;
  reg write_clk;
  reg clk_read;
  reg rst_n;
  reg write_enable;
  reg read_enable;
  reg buffer_mode;
  reg [DATA_WIDTH-1:0] data_in;
  wire overflow;
  wire underflow;
  wire skp_added;
  wire Skp_Removed;
  wire [DATA_WIDTH-1:0] data_out;

  // Instantiate the DUT
  elasticBuffer #(DATA_WIDTH, BUFFER_DEPTH) DUT (
      .write_clk(write_clk),
      .read_clk(clk_read),
      .rst_n(rst_n),
      .buffer_mode(buffer_mode),
      .data_in(data_in),
      .write_enable(write_enable),
      .read_enable(read_enable),
      .overflow(overflow),
      .underflow(underflow),
      .Skp_Removed(Skp_Removed),
      .skp_added(skp_added),
      .data_out(data_out)
  );
  initial begin
    write_clk = 0;
    forever #2 write_clk = ~write_clk;

  end

  initial begin
    clk_read = 0;
    forever #3 clk_read = ~clk_read;
  end
  initial begin
    write_enable = 0;
    read_enable  = 0;
    #2 write_enable = ~write_enable;
    #5 write_enable = ~write_enable;
    #1 write_enable = ~write_enable;
    #3 write_enable = ~write_enable;
    #7 write_enable = ~write_enable;
    #1 write_enable = ~write_enable;
    #2 write_enable = ~write_enable;
    #5 write_enable = ~write_enable;
    #1 write_enable = ~write_enable;
    #3 write_enable = ~write_enable;
    #7 write_enable = ~write_enable;
    #1 write_enable = ~write_enable;
    #2 write_enable = ~write_enable;
    #5 write_enable = ~write_enable;
    #1 write_enable = ~write_enable;
    #3 write_enable = ~write_enable;

    #2 write_enable = ~write_enable;
    #5 write_enable = ~write_enable;
    #1 write_enable = ~write_enable;
    #3 write_enable = ~write_enable;
    #7 write_enable = ~write_enable;
    #1 write_enable = ~write_enable;
    #2 write_enable = ~write_enable;
    #5 write_enable = ~write_enable;
    #1 write_enable = ~write_enable;
    #3 write_enable = ~write_enable;
    #7 write_enable = ~write_enable;
    #1 write_enable = ~write_enable;
    #2 write_enable = ~write_enable;
    #5 write_enable = ~write_enable;
    #1 write_enable = ~write_enable;
    #3 write_enable = ~write_enable;

    #2 write_enable = ~write_enable;
    #5 write_enable = ~write_enable;
    #1 write_enable = ~write_enable;
    #3 write_enable = ~write_enable;
    #7 write_enable = ~write_enable;
    #1 write_enable = ~write_enable;
    #2 write_enable = ~write_enable;
    #5 write_enable = ~write_enable;
    #1 write_enable = ~write_enable;
    #3 write_enable = ~write_enable;
    #7 write_enable = ~write_enable;
    #1 write_enable = ~write_enable;
    #2 write_enable = ~write_enable;
    #5 write_enable = ~write_enable;
    #1 write_enable = ~write_enable;
    #3 write_enable = ~write_enable;

    #2 write_enable = ~write_enable;
    #5 write_enable = ~write_enable;
    #1 write_enable = ~write_enable;
    #3 write_enable = ~write_enable;
    #7 write_enable = ~write_enable;
    #1 write_enable = ~write_enable;
    #2 write_enable = ~write_enable;
    #5 write_enable = ~write_enable;
    #1 write_enable = ~write_enable;
    #3 write_enable = ~write_enable;
    #7 write_enable = ~write_enable;
    #1 write_enable = ~write_enable;
    #2 write_enable = ~write_enable;
    #5 write_enable = ~write_enable;
    #1 write_enable = ~write_enable;
    #3 write_enable = ~write_enable;

    #2 read_enable = ~read_enable;
    // write_enable = ~write_enable;
    #5 read_enable = ~read_enable;
    // write_enable = ~write_enable;
    #1 read_enable = ~read_enable;
    #3 read_enable = ~read_enable;
    #7 read_enable = ~read_enable;
    #1 read_enable = ~read_enable;
    #2 read_enable = ~read_enable;
    #5 read_enable = ~read_enable;
    #1 read_enable = ~read_enable;
    #3 read_enable = ~read_enable;
    #7 read_enable = ~read_enable;
    #1 read_enable = ~read_enable;
    #2 read_enable = ~read_enable;
    #5 read_enable = ~read_enable;
    #1 read_enable = ~read_enable;
    #3 read_enable = ~read_enable;
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
    @(negedge write_clk);
    data_in = 10'h2BB;
    @(negedge write_clk);
    data_in = 10'h1CC;
    @(negedge write_clk);
    data_in = 10'h3AA;
    @(negedge write_clk);
    data_in = 10'h111;
    @(negedge write_clk);
    @(negedge write_clk);
    data_in = 10'h092;
    @(negedge write_clk);
    data_in = 10'hAA;
    @(negedge write_clk);
    data_in = 10'h2BB;
    @(negedge write_clk);
    data_in = 10'h1CC;
    @(negedge write_clk);
    data_in = 10'h3AA;
    @(negedge write_clk);
    data_in = 10'h111;
    @(negedge write_clk);
    data_in = 10'h092;
    @(negedge write_clk);
    data_in = 10'hAA;
    @(negedge write_clk);
    data_in = 10'h2BB;
    @(negedge write_clk);
    data_in = 10'h1CC;
    @(negedge write_clk);
    data_in = 10'h3AA;
    @(negedge write_clk);
    data_in = 10'h111;
    @(negedge write_clk);
    @(negedge write_clk);
    data_in = 10'h092;
    @(negedge write_clk);
    @(negedge write_clk);
    data_in = 10'h3AA;
    @(negedge write_clk);
    data_in = 10'h111;
    @(negedge write_clk);
    data_in = 10'h092;
    @(negedge write_clk);
    data_in = 10'hAA;
    @(negedge write_clk);
    data_in = 10'h2BB;
    @(negedge write_clk);
    data_in = 10'h1CC;
    @(negedge write_clk);
    data_in = 10'h3AA;
    @(negedge write_clk);
    data_in = 10'h111;
    @(negedge write_clk);
    @(negedge write_clk);
    data_in = 10'h092;
    @(negedge write_clk);
    // // Read data from the buffer
    // buffer_mode = 1; // Set to read mode
    // #10;
    // buffer_mode = 0; // Set back to write mode
    // #10;


    // End simulation
    #200;
    $stop;
  end
endmodule
