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
      6'b00_00_00: RxStatus <= 3'b000;   // NO ERROR
      6'b00_10_00: RxStatus <= 3'b001;   // Skp_Added
      6'b00_01_00: RxStatus <= 3'b010;   // Skp_Removed
      //6'b11_11_11: RxStatus <= 3'b011;  /////receiver detected ignored 
      //6'b00_xx_00: RxStatus <= 3'b011; 
 
      6'bxx_xx_1x: RxStatus <= 3'b100;  // Decode ERROR - Disparity_Error (OPTIONAL) 
      6'b10_xx_0x: RxStatus <= 3'b101;  // OVERFLOW
      6'b01_xx_0x: RxStatus <= 3'b110;  //UNDERFLOW
      6'b00_xx_01: RxStatus <= 3'b111;  //Disparity_Error
      default:     RxStatus <= 3'b000;  
    endcase 
 
  end 
endmodule