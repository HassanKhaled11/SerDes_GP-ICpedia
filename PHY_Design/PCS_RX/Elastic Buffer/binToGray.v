module binToGray (
    binary,
    gray
);
  parameter COUNTER_WIDTH = 4;
  input [COUNTER_WIDTH-1:0] binary;
  output reg [COUNTER_WIDTH-1:0] gray;

  genvar i;
  generate
    for (i = 0; i < COUNTER_WIDTH; i = i + 1) begin
      // assign gray[i] = binary[i] ^ binary[i+1];
      always @(*) begin
        if (i != COUNTER_WIDTH - 1) gray[i] = binary[i] ^ binary[i+1];
        else gray[i] = binary[i];
      end
    end
  endgenerate

endmodule
