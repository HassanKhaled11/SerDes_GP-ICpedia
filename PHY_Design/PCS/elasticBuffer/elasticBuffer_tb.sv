module elasticBuffer_tb ();
  parameter DATA_WIDTH = 10;
  parameter BUFFER_DEPTH = 16;
  reg write_clk;
  reg read_clk;
  reg [DATA_WIDTH-1:0] data_in;
  reg buffer_mode;
  // reg write_enable;
  // reg read_enable;
  // reg RxElecIdle;
  reg rst_n;
  //////////////////////////
  wire overflow;
  wire underflow;
  wire skp_added;
  wire Skp_Removed;
  wire [DATA_WIDTH-1:0] data_out;

  // Instantiate the DUT
  elasticBuffer #(DATA_WIDTH, BUFFER_DEPTH) DUT (
      .write_clk(write_clk),
      .read_clk(read_clk),
      .data_in(data_in),
      .buffer_mode(buffer_mode),
      // .write_enable(write_enable),
      // .read_enable(read_enable),
      .rst_n(rst_n),
      // .RxElecIdle(RxElecIdle),
      .overflow(overflow),
      .underflow(underflow),
      .Skp_Removed(Skp_Removed),
      .skp_added(skp_added),
      .data_out(data_out)
  );
  initial begin
    write_clk = 0;
    forever #5 write_clk = ~write_clk;

  end

  initial begin
    read_clk = 0;
    forever #5 read_clk = ~read_clk;
  end
  // initial begin
  //   write_enable = 0;
  //   read_enable  = 0;
  //   #2 write_enable = ~write_enable;
  //   #5 write_enable = ~write_enable;
  //   #1 write_enable = ~write_enable;
  //   #3 write_enable = ~write_enable;
  //   #7 write_enable = ~write_enable;
  //   #1 write_enable = ~write_enable;
  //   #2 write_enable = ~write_enable;
  //   #5 write_enable = ~write_enable;
  //   #1 write_enable = ~write_enable;
  //   #3 write_enable = ~write_enable;
  //   #7 write_enable = ~write_enable;
  //   #1 write_enable = ~write_enable;
  //   #2 write_enable = ~write_enable;
  //   #5 write_enable = ~write_enable;
  //   #1 write_enable = ~write_enable;
  //   #3 write_enable = ~write_enable;

  //   #2 write_enable = ~write_enable;
  //   #5 write_enable = ~write_enable;
  //   #1 write_enable = ~write_enable;
  //   #3 write_enable = ~write_enable;
  //   #7 write_enable = ~write_enable;
  //   #1 write_enable = ~write_enable;
  //   #2 write_enable = ~write_enable;
  //   #5 write_enable = ~write_enable;
  //   #1 write_enable = ~write_enable;
  //   #3 write_enable = ~write_enable;
  //   #7 write_enable = ~write_enable;
  //   #1 write_enable = ~write_enable;
  //   #2 write_enable = ~write_enable;
  //   #5 write_enable = ~write_enable;
  //   #1 write_enable = ~write_enable;
  //   #3 write_enable = ~write_enable;

  //   #2 write_enable = ~write_enable;
  //   #5 write_enable = ~write_enable;
  //   #1 write_enable = ~write_enable;
  //   #3 write_enable = ~write_enable;
  //   #7 write_enable = ~write_enable;
  //   #1 write_enable = ~write_enable;
  //   #2 write_enable = ~write_enable;
  //   #5 write_enable = ~write_enable;
  //   #1 write_enable = ~write_enable;
  //   #3 write_enable = ~write_enable;
  //   #7 write_enable = ~write_enable;
  //   #1 write_enable = ~write_enable;
  //   #2 write_enable = ~write_enable;
  //   #5 write_enable = ~write_enable;
  //   #1 write_enable = ~write_enable;
  //   #3 write_enable = ~write_enable;

  //   #2 write_enable = ~write_enable;
  //   #5 write_enable = ~write_enable;
  //   #1 write_enable = ~write_enable;
  //   #3 write_enable = ~write_enable;
  //   #7 write_enable = ~write_enable;
  //   #1 write_enable = ~write_enable;
  //   #2 write_enable = ~write_enable;
  //   #5 write_enable = ~write_enable;
  //   #1 write_enable = ~write_enable;
  //   #3 write_enable = ~write_enable;
  //   #7 write_enable = ~write_enable;
  //   #1 write_enable = ~write_enable;
  //   #2 write_enable = ~write_enable;
  //   #5 write_enable = ~write_enable;
  //   #1 write_enable = ~write_enable;
  //   #3 write_enable = ~write_enable;

  //   #2 read_enable = ~read_enable;
  //   // write_enable = ~write_enable;
  //   #5 read_enable = ~read_enable;
  //   // write_enable = ~write_enable;
  //   #1 read_enable = ~read_enable;
  //   #3 read_enable = ~read_enable;
  //   #7 read_enable = ~read_enable;
  //   #1 read_enable = ~read_enable;
  //   #2 read_enable = ~read_enable;
  //   #5 read_enable = ~read_enable;
  //   #1 read_enable = ~read_enable;
  //   #3 read_enable = ~read_enable;
  //   #7 read_enable = ~read_enable;
  //   #1 read_enable = ~read_enable;
  //   #2 read_enable = ~read_enable;
  //   #5 read_enable = ~read_enable;
  //   #1 read_enable = ~read_enable;
  //   #3 read_enable = ~read_enable;
  // end

  initial begin
    // Initialize signals
    // RxElecIdle = 1;
    rst_n = 0;
    buffer_mode = 0;
    data_in = 0;

    #15 rst_n = 1;



    // Test scenario
    // Write data into the buffer
    data_in = 10'hAA;
    @(negedge write_clk);
    data_in = 10'h2BB;
    @(negedge write_clk);
    data_in = 10'h1CC;
    @(negedge write_clk);
    // read_enable = 1;
    // RxElecIdle = 0;
    data_in = 10'h0F9;  ///////skp
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
    data_in = 10'h306;  ///////skp
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
    #300;
    $stop;
  end
endmodule
