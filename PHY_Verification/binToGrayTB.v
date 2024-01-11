module binToGray_tb ();

  // Parameters
  parameter COUNTER_WIDTH = 4;

  // Inputs
  reg [COUNTER_WIDTH-1:0] binary;

  // Outputs
  wire [COUNTER_WIDTH-1:0] gray;

  integer i;
  binToGray uut (
      .binary(binary),
      .gray  (gray)
  );


  initial begin

    // Loop through test cases
    for (i = 0; i < 16; i = i + 1) begin
      binary = i;
      #10;  // Wait for a few clock cycles
      // Print the test case number and input
      $display("Test Case %0d: binary = %b, gray = %b ", i + 1, binary, gray);
      // Print the expected output
      $display("\tExpected output: gray = %b (Binary %b XOR %b)", binary ^ (binary >> 1), binary,
               binary >> 1);
    end
    #10;
    $stop;
  end


endmodule
