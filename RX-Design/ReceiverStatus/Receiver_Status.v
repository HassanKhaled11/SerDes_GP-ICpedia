module Reeceiver_Status (
    input Overflow,
    input Underflow,
    input Skp_Added,
    input Skp_Removed,
    input Decode_Error,
    input Disparity_Error,
    output reg [2:0] RxStatus
);
  always @(*) begin
    casex ({
      Overflow, Underflow, Skp_Added, Skp_Removed, Decode_Error, Disparity_Error
    })
      6'b00_00_00: RxStatus <= 3'b000;
      6'b00_10_00: RxStatus <= 3'b001;
      6'b00_01_00: RxStatus <= 3'b010;
      6'b11_11_11: RxStatus <= 3'b011;  /////receiver detected ignored
      //6'b00_xx_00: RxStatus <= 3'b011;

      6'b00_xx_11: RxStatus <= 3'b100;
      6'b10_00_00: RxStatus <= 3'b101;
      6'b01_00_00: RxStatus <= 3'b110;
      6'b00_xx_01: RxStatus <= 3'b111;
      default:     RxStatus <= 3'b000;
    endcase

  end
endmodule
