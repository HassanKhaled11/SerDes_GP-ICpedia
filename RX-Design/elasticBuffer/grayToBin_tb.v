module grayToBinary_tb ();

  // Parameters
  parameter WIDTH = 4;

  // Inputs
  reg [WIDTH-1:0] gray;

  // Outputs
  wire [WIDTH-1:0] binary;
  integer i;
  // Instantiate GrayToBinary module
  GrayToBinary #(WIDTH) grayToBin_inst (
      .gray  (gray),
      .binary(binary)
  );

  // Stimulus generation
  initial begin
    // Loop through test cases
    for (i = 0; i < 16; i = i + 1) begin
      gray = i;
      #10;  // Wait for a few clock cycles

      // Print the test case number and input
      $display("Test Case %0d: gray = %b, binary = %b ", i + 1, gray, binary);
    end
    #10;
    $stop;
  end

endmodule
