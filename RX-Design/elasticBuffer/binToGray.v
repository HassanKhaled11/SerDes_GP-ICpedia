module binToGray (
    binary,
    gray
);
  parameter COUNTER_WIDTH = 4;
  input [COUNTER_WIDTH-1:0] binary;
  output [COUNTER_WIDTH-1:0] gray;

  genvar i;
  generate
    for (i = 0; i < COUNTER_WIDTH - 1; i = i + 1) begin
      assign gray[i] = binary[i] ^ binary[i+1];
    end
  endgenerate

  assign gray[COUNTER_WIDTH-1] = binary[COUNTER_WIDTH-1];
endmodule
