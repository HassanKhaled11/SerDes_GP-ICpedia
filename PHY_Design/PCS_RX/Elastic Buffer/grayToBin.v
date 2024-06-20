module GrayToBinary #(
    parameter WIDTH = 4
) (
    input  [WIDTH-1:0] gray,
    output [WIDTH-1:0] binary
);
  /*
  assign binary[0] = gray[3] ^ gray[2] ^ gray[1] ^ gray[0];
  assign binary[1] = gray[3] ^ gray[2] ^ gray[1];
  assign binary[2] = gray[3] ^ gray[2];
  assign binary[3] = gray[3];
  */
  genvar i;
  generate
    for (i = 0; i < WIDTH; i = i + 1) begin
      assign binary[i] = ^(gray >> i);
    end
  endgenerate
endmodule
