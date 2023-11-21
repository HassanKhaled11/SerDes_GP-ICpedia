module line_coding_8_10  //#(parameter DATAWIDTH = 8)
(  // inut wire pclk,
    input wire enable,
    input wire [3:0] TXDataK,
    input wire [7:0] data,
    output reg [9:0] encoded_data_pos,
    output reg [9:0] encoded_data_neg
);

  always @(*) begin
    if (enable) begin
      case (data)  //////////// D0.0 --> D31.0
        8'b0000_0000: begin
          encoded_data_neg = 10'b100111_0100;
          encoded_data_pos = 10'b011000_1011;
        end
        8'b0000_0001: begin
          encoded_data_neg = 10'b011101_0100;
          encoded_data_pos = 10'b100010_1011;
        end
        8'b0000_0010: begin
          encoded_data_neg = 10'b101101_0100;
          encoded_data_pos = 10'b010010_1011;
        end
        8'b0000_0011: begin
          encoded_data_neg = 10'b110001_1011;
          encoded_data_pos = 10'b110001_0100;
        end
        8'b0000_0100: begin
          encoded_data_neg = 10'b110101_0100;
          encoded_data_pos = 10'b001010_1011;
        end
        8'b0000_0101: begin
          encoded_data_neg = 10'b101001_1011;
          encoded_data_pos = 10'b101001_0100;
        end
        8'b0000_0110: begin
          encoded_data_neg = 10'b011001_1011;
          encoded_data_pos = 10'b011001_0100;
        end
        8'b0000_0111: begin
          encoded_data_neg = 10'b111000_1011;
          encoded_data_pos = 10'b000111_0100;
        end
        8'b0000_1000: begin
          encoded_data_neg = 10'b111001_0100;
          encoded_data_pos = 10'b000110_1011;
        end
        8'b0000_1001: begin
          encoded_data_neg = 10'b100101_1011;
          encoded_data_pos = 10'b100101_0100;
        end
        8'b0000_1010: begin
          encoded_data_neg = 10'b010101_1011;
          encoded_data_pos = 10'b010101_0100;
        end
        8'b0000_1011: begin
          encoded_data_neg = 10'b110100_1011;
          encoded_data_pos = 10'b110100_0100;
        end
        8'b0000_1100: begin
          encoded_data_neg = 10'b001101_1011;
          encoded_data_pos = 10'b001101_0100;
        end
        8'b0000_1101: begin
          encoded_data_neg = 10'b101100_1011;
          encoded_data_pos = 10'b101100_0100;
        end
        8'b0000_1110: begin
          encoded_data_neg = 10'b011100_1011;
          encoded_data_pos = 10'b011100_0100;
        end
        8'b0000_1111: begin
          encoded_data_neg = 10'b010111_0100;
          encoded_data_pos = 10'b101000_1011;
        end
        8'b0001_0000: begin
          encoded_data_neg = 10'b011011_0100;
          encoded_data_pos = 10'b100100_1011;
        end
        8'b0001_0001: begin
          encoded_data_neg = 10'b100011_1011;
          encoded_data_pos = 10'b100011_0100;
        end
        8'b0001_0010: begin
          encoded_data_neg = 10'b010011_1011;
          encoded_data_pos = 10'b010011_0100;
        end
        8'b0001_0011: begin
          encoded_data_neg = 10'b110010_1011;
          encoded_data_pos = 10'b110010_0100;
        end
        8'b0001_0100: begin
          encoded_data_neg = 10'b001011_1011;
          encoded_data_pos = 10'b001011_0100;
        end
        8'b0001_0101: begin
          encoded_data_neg = 10'b101010_1011;
          encoded_data_pos = 10'b101010_0100;
        end
        8'b0001_0110: begin
          encoded_data_neg = 10'b011010_1011;
          encoded_data_pos = 10'b011010_0100;
        end
        8'b0001_0111: begin
          encoded_data_neg = 10'b111010_0100;
          encoded_data_pos = 10'b000101_1011;
        end
        8'b0001_1000: begin
          encoded_data_neg = 10'b110011_0100;
          encoded_data_pos = 10'b001100_1011;
        end
        8'b0001_1001: begin
          encoded_data_neg = 10'b100110_1011;
          encoded_data_pos = 10'b100110_0100;
        end
        8'b0001_1010: begin
          encoded_data_neg = 10'b010110_1011;
          encoded_data_pos = 10'b010110_0100;
        end
        8'b0001_1011: begin
          encoded_data_neg = 10'b110110_0100;
          encoded_data_pos = 10'b001001_1011;
        end
        8'b0001_1100: begin
          encoded_data_neg = 10'b001110_1011;
          encoded_data_pos = 10'b001110_0100;
        end
        8'b0001_1101: begin
          encoded_data_neg = 10'b101110_0100;
          encoded_data_pos = 10'b010001_1011;
        end
        8'b0001_1110: begin
          encoded_data_neg = 10'b011110_0100;
          encoded_data_pos = 10'b100001_1011;
        end
        8'b0001_1111: begin
          encoded_data_neg = 10'b101011_0100;
          encoded_data_pos = 10'b010100_1011;
        end
        //////////// D0.1 --> D31.1
        8'b0010_0000: begin
          encoded_data_neg = 10'b100111_1001;
          encoded_data_pos = 10'b011000_1001;
        end
        8'b0010_0001: begin
          encoded_data_neg = 10'b011101_1001;
          encoded_data_pos = 10'b100010_1001;
        end
        8'b0010_0010: begin
          encoded_data_neg = 10'b101101_1001;
          encoded_data_pos = 10'b010010_1001;
        end
        8'b0010_0011: begin
          encoded_data_neg = 10'b110001_1001;
          encoded_data_pos = 10'b110001_1001;
        end
        8'b0010_0100: begin
          encoded_data_neg = 10'b110101_1001;
          encoded_data_pos = 10'b001010_1001;
        end
        8'b0010_0101: begin
          encoded_data_neg = 10'b101001_1001;
          encoded_data_pos = 10'b101001_1001;
        end
        8'b0010_0110: begin
          encoded_data_neg = 10'b011001_1001;
          encoded_data_pos = 10'b011001_1001;
        end
        8'b0010_0111: begin
          encoded_data_neg = 10'b111000_1001;
          encoded_data_pos = 10'b000111_1001;
        end
        8'b0010_1000: begin
          encoded_data_neg = 10'b111001_1001;
          encoded_data_pos = 10'b000110_1001;
        end
        8'b0010_1001: begin
          encoded_data_neg = 10'b100101_1001;
          encoded_data_pos = 10'b100101_1001;
        end
        8'b0010_1010: begin
          encoded_data_neg = 10'b010101_1001;
          encoded_data_pos = 10'b010101_1001;
        end
        8'b0010_1011: begin
          encoded_data_neg = 10'b110100_1001;
          encoded_data_pos = 10'b110100_1001;
        end
        8'b0010_1100: begin
          encoded_data_neg = 10'b001101_1001;
          encoded_data_pos = 10'b001101_1001;
        end
        8'b0010_1101: begin
          encoded_data_neg = 10'b101100_1001;
          encoded_data_pos = 10'b101100_1001;
        end
        8'b0010_1110: begin
          encoded_data_neg = 10'b011100_1001;
          encoded_data_pos = 10'b011100_1001;
        end
        8'b0010_1111: begin
          encoded_data_neg = 10'b010111_1001;
          encoded_data_pos = 10'b101000_1001;
        end
        8'b0011_0000: begin
          encoded_data_neg = 10'b011011_1001;
          encoded_data_pos = 10'b100100_1001;
        end
        8'b0011_0001: begin
          encoded_data_neg = 10'b100011_1001;
          encoded_data_pos = 10'b100011_1001;
        end
        8'b0011_0010: begin
          encoded_data_neg = 10'b010011_1001;
          encoded_data_pos = 10'b010011_1001;
        end
        8'b0011_0011: begin
          encoded_data_neg = 10'b110010_1001;
          encoded_data_pos = 10'b110010_1001;
        end
        8'b0011_0100: begin
          encoded_data_neg = 10'b001011_1001;
          encoded_data_pos = 10'b001011_1001;
        end
        8'b0011_0101: begin
          encoded_data_neg = 10'b101010_1001;
          encoded_data_pos = 10'b101010_1001;
        end
        8'b0011_0110: begin
          encoded_data_neg = 10'b011010_1001;
          encoded_data_pos = 10'b011010_1001;
        end
        8'b0011_0111: begin
          encoded_data_neg = 10'b111010_1001;
          encoded_data_pos = 10'b000101_1001;
        end
        8'b0011_1000: begin
          encoded_data_neg = 10'b110011_1001;
          encoded_data_pos = 10'b001100_1001;
        end
        8'b0011_1001: begin
          encoded_data_neg = 10'b100110_1001;
          encoded_data_pos = 10'b100110_1001;
        end
        8'b0011_1010: begin
          encoded_data_neg = 10'b010110_1001;
          encoded_data_pos = 10'b010110_1001;
        end
        8'b0011_1011: begin
          encoded_data_neg = 10'b110110_1001;
          encoded_data_pos = 10'b001001_1001;
        end
        8'b0011_1100: begin
          encoded_data_neg = 10'b001110_1001;
          encoded_data_pos = 10'b001110_1001;
        end
        8'b0011_1101: begin
          encoded_data_neg = 10'b101110_1001;
          encoded_data_pos = 10'b010001_1001;
        end
        8'b0011_1110: begin
          encoded_data_neg = 10'b011110_1001;
          encoded_data_pos = 10'b100001_1001;
        end
        8'b0011_1111: begin
          encoded_data_neg = 10'b101011_1001;
          encoded_data_pos = 10'b010100_1001;
        end
        ///////////// D0.2 --> D31.2
        ////////////////////////////
        8'b0100_0000: begin
          encoded_data_neg = 10'b100111_0101;
          encoded_data_pos = 10'b011000_0101;
        end
        8'b0100_0001: begin
          encoded_data_neg = 10'b011101_0101;
          encoded_data_pos = 10'b100010_0101;
        end
        8'b0100_0010: begin
          encoded_data_neg = 10'b101101_0101;
          encoded_data_pos = 10'b010010_0101;
        end
        8'b0100_0011: begin
          encoded_data_neg = 10'b110001_0101;
          encoded_data_pos = 10'b110001_0101;
        end
        8'b0100_0100: begin
          encoded_data_neg = 10'b110101_0101;
          encoded_data_pos = 10'b001010_0101;
        end
        8'b0100_0101: begin
          encoded_data_neg = 10'b101001_0101;
          encoded_data_pos = 10'b101001_0101;
        end
        8'b0100_0110: begin
          encoded_data_neg = 10'b011001_0101;
          encoded_data_pos = 10'b011001_0101;
        end
        8'b0100_0111: begin
          encoded_data_neg = 10'b111000_0101;
          encoded_data_pos = 10'b000111_0101;
        end
        8'b0100_1000: begin
          encoded_data_neg = 10'b111001_0101;
          encoded_data_pos = 10'b000110_0101;
        end
        8'b0100_1001: begin
          encoded_data_neg = 10'b100101_0101;
          encoded_data_pos = 10'b100101_0101;
        end
        8'b0100_1010: begin
          encoded_data_neg = 10'b010101_0101;
          encoded_data_pos = 10'b010101_0101;
        end
        8'b0100_1011: begin
          encoded_data_neg = 10'b110100_0101;
          encoded_data_pos = 10'b110100_0101;
        end
        8'b0100_1100: begin
          encoded_data_neg = 10'b001101_0101;
          encoded_data_pos = 10'b001101_0101;
        end
        8'b0100_1101: begin
          encoded_data_neg = 10'b101100_0101;
          encoded_data_pos = 10'b101100_0101;
        end
        8'b0100_1110: begin
          encoded_data_neg = 10'b011100_0101;
          encoded_data_pos = 10'b011100_0101;
        end
        8'b0100_1111: begin
          encoded_data_neg = 10'b010111_0101;
          encoded_data_pos = 10'b101000_0101;
        end
        8'b0101_0000: begin
          encoded_data_neg = 10'b011011_0101;
          encoded_data_pos = 10'b100100_0101;
        end
        8'b0101_0001: begin
          encoded_data_neg = 10'b100011_0101;
          encoded_data_pos = 10'b100011_0101;
        end
        8'b0101_0010: begin
          encoded_data_neg = 10'b010011_0101;
          encoded_data_pos = 10'b010011_0101;
        end
        8'b0101_0011: begin
          encoded_data_neg = 10'b110010_0101;
          encoded_data_pos = 10'b110010_0101;
        end
        8'b0101_0100: begin
          encoded_data_neg = 10'b001011_0101;
          encoded_data_pos = 10'b001011_0101;
        end
        8'b0101_0101: begin
          encoded_data_neg = 10'b101010_0101;
          encoded_data_pos = 10'b101010_0101;
        end
        8'b0101_0110: begin
          encoded_data_neg = 10'b011010_0101;
          encoded_data_pos = 10'b011010_0101;
        end
        8'b0101_0111: begin
          encoded_data_neg = 10'b111010_0101;
          encoded_data_pos = 10'b000101_0101;
        end
        8'b0101_1000: begin
          encoded_data_neg = 10'b110011_0101;
          encoded_data_pos = 10'b001100_0101;
        end
        8'b0101_1001: begin
          encoded_data_neg = 10'b100110_0101;
          encoded_data_pos = 10'b100110_0101;
        end
        8'b0101_1010: begin
          encoded_data_neg = 10'b010110_0101;
          encoded_data_pos = 10'b010110_0101;
        end
        8'b0101_1011: begin
          encoded_data_neg = 10'b110110_0101;
          encoded_data_pos = 10'b001001_0101;
        end
        8'b0101_1100: begin
          encoded_data_neg = 10'b001110_0101;
          encoded_data_pos = 10'b001110_0101;
        end
        8'b0101_1101: begin
          encoded_data_neg = 10'b101110_0101;
          encoded_data_pos = 10'b010001_0101;
        end
        8'b0101_1110: begin
          encoded_data_neg = 10'b011110_0101;
          encoded_data_pos = 10'b100001_0101;
        end
        8'b0101_1111: begin
          encoded_data_neg = 10'b101011_0101;
          encoded_data_pos = 10'b010100_0101;
        end
        //////////// D0.3 --> D31.3
        ////////////////////////
        ////////////////////////
        8'b0110_0000: begin
          encoded_data_neg = 10'b100111_0011;
          encoded_data_pos = 10'b011000_1100;
        end
        8'b0110_0001: begin
          encoded_data_neg = 10'b011101_0011;
          encoded_data_pos = 10'b100010_1100;
        end
        8'b0110_0010: begin
          encoded_data_neg = 10'b101101_0011;
          encoded_data_pos = 10'b010010_1100;
        end
        8'b0110_0011: begin
          encoded_data_neg = 10'b110001_1100;
          encoded_data_pos = 10'b110001_0011;
        end
        8'b0110_0100: begin
          encoded_data_neg = 10'b110101_0011;
          encoded_data_pos = 10'b001010_1100;
        end
        8'b0110_0101: begin
          encoded_data_neg = 10'b101001_1100;
          encoded_data_pos = 10'b101001_0011;
        end
        8'b0110_0110: begin
          encoded_data_neg = 10'b011001_1100;
          encoded_data_pos = 10'b011001_0011;
        end
        8'b0110_0111: begin
          encoded_data_neg = 10'b111000_1100;
          encoded_data_pos = 10'b000111_0011;
        end
        8'b0110_1000: begin
          encoded_data_neg = 10'b111001_0011;
          encoded_data_pos = 10'b000110_1100;
        end
        8'b0110_1001: begin
          encoded_data_neg = 10'b100101_1100;
          encoded_data_pos = 10'b100101_0011;
        end
        8'b0110_1010: begin
          encoded_data_neg = 10'b010101_1100;
          encoded_data_pos = 10'b010101_0011;
        end
        8'b0110_1011: begin
          encoded_data_neg = 10'b110100_1100;
          encoded_data_pos = 10'b110100_0011;
        end
        8'b0110_1100: begin
          encoded_data_neg = 10'b001101_1100;
          encoded_data_pos = 10'b001101_0011;
        end
        8'b0110_1101: begin
          encoded_data_neg = 10'b101100_1100;
          encoded_data_pos = 10'b101100_0011;
        end
        8'b0110_1110: begin
          encoded_data_neg = 10'b011100_1100;
          encoded_data_pos = 10'b011100_0011;
        end
        8'b0110_1111: begin
          encoded_data_neg = 10'b010111_0011;
          encoded_data_pos = 10'b101000_1100;
        end
        8'b0111_0000: begin
          encoded_data_neg = 10'b011011_0011;
          encoded_data_pos = 10'b100100_1100;
        end
        8'b0111_0001: begin
          encoded_data_neg = 10'b100011_1100;
          encoded_data_pos = 10'b100011_0011;
        end
        8'b0111_0010: begin
          encoded_data_neg = 10'b010011_1100;
          encoded_data_pos = 10'b010011_0011;
        end
        8'b0111_0011: begin
          encoded_data_neg = 10'b110010_1100;
          encoded_data_pos = 10'b110010_0011;
        end
        8'b0111_0100: begin
          encoded_data_neg = 10'b001011_1100;
          encoded_data_pos = 10'b001011_0011;
        end
        8'b0111_0101: begin
          encoded_data_neg = 10'b101010_1100;
          encoded_data_pos = 10'b101010_0011;
        end
        8'b0111_0110: begin
          encoded_data_neg = 10'b011010_1100;
          encoded_data_pos = 10'b011010_0011;
        end
        8'b0111_0111: begin
          encoded_data_neg = 10'b111010_0011;
          encoded_data_pos = 10'b000101_1100;
        end
        8'b0111_1000: begin
          encoded_data_neg = 10'b110011_0011;
          encoded_data_pos = 10'b001100_1100;
        end
        8'b0111_1001: begin
          encoded_data_neg = 10'b100110_1100;
          encoded_data_pos = 10'b100110_0011;
        end
        8'b0111_1010: begin
          encoded_data_neg = 10'b010110_1100;
          encoded_data_pos = 10'b010110_0011;
        end
        8'b0111_1011: begin
          encoded_data_neg = 10'b110110_0011;
          encoded_data_pos = 10'b001001_1100;
        end
        8'b0111_1100: begin
          encoded_data_neg = 10'b001110_1100;
          encoded_data_pos = 10'b001110_0011;
        end
        8'b0111_1101: begin
          encoded_data_neg = 10'b101110_0011;
          encoded_data_pos = 10'b010001_1100;
        end
        8'b0111_1110: begin
          encoded_data_neg = 10'b011110_0011;
          encoded_data_pos = 10'b100001_1100;
        end
        8'b0111_1111: begin
          encoded_data_neg = 10'b101011_0011;
          encoded_data_pos = 10'b010100_1100;
        end
        ////////////////////  D0.4 --> D31.4
        ///////////////
        ///////////////
        ///////////////
        ///////////////
        8'b1000_0000: begin
          encoded_data_neg = 10'b100111_0010;
          encoded_data_pos = 10'b011000_1101;
        end
        8'b1000_0001: begin
          encoded_data_neg = 10'b011101_0010;
          encoded_data_pos = 10'b100010_1101;
        end
        8'b1000_0010: begin
          encoded_data_neg = 10'b101101_0010;
          encoded_data_pos = 10'b010010_1101;
        end
        8'b1000_0011: begin
          encoded_data_neg = 10'b110001_1101;
          encoded_data_pos = 10'b110001_0010;
        end
        8'b1000_0100: begin
          encoded_data_neg = 10'b110101_0010;
          encoded_data_pos = 10'b001010_1101;
        end
        8'b1000_0101: begin
          encoded_data_neg = 10'b101001_1101;
          encoded_data_pos = 10'b101001_0010;
        end
        8'b1000_0110: begin
          encoded_data_neg = 10'b011001_1101;
          encoded_data_pos = 10'b011001_0010;
        end
        8'b1000_0111: begin
          encoded_data_neg = 10'b111000_1101;
          encoded_data_pos = 10'b000111_0010;
        end
        8'b1000_1000: begin
          encoded_data_neg = 10'b111001_0010;
          encoded_data_pos = 10'b000110_1101;
        end
        8'b1000_1001: begin
          encoded_data_neg = 10'b100101_1101;
          encoded_data_pos = 10'b100101_0010;
        end
        8'b1000_1010: begin
          encoded_data_neg = 10'b010101_1101;
          encoded_data_pos = 10'b010101_0010;
        end  //()//
        8'b1000_1011: begin
          encoded_data_neg = 10'b110100_1101;
          encoded_data_pos = 10'b110100_0010;
        end
        8'b1000_1100: begin
          encoded_data_neg = 10'b001101_1101;
          encoded_data_pos = 10'b001101_0010;
        end
        8'b1000_1101: begin
          encoded_data_neg = 10'b101100_1101;
          encoded_data_pos = 10'b101100_0010;
        end
        8'b1000_1110: begin
          encoded_data_neg = 10'b011100_1101;
          encoded_data_pos = 10'b011100_0010;
        end
        8'b1000_1111: begin
          encoded_data_neg = 10'b010111_0010;
          encoded_data_pos = 10'b101000_1101;
        end
        8'b1001_0000: begin
          encoded_data_neg = 10'b011011_0010;
          encoded_data_pos = 10'b100100_1101;
        end
        8'b1001_0001: begin
          encoded_data_neg = 10'b100011_1101;
          encoded_data_pos = 10'b100011_0010;
        end
        8'b1001_0010: begin
          encoded_data_neg = 10'b010011_1101;
          encoded_data_pos = 10'b010011_0010;
        end
        8'b1001_0011: begin
          encoded_data_neg = 10'b110010_1101;
          encoded_data_pos = 10'b110010_0010;
        end
        8'b1001_0100: begin
          encoded_data_neg = 10'b001011_1101;
          encoded_data_pos = 10'b001011_0010;
        end
        8'b1001_0101: begin
          encoded_data_neg = 10'b101010_1101;
          encoded_data_pos = 10'b101010_0010;
        end
        8'b1001_0110: begin
          encoded_data_neg = 10'b011010_1101;
          encoded_data_pos = 10'b011010_0010;
        end
        8'b1001_0111: begin
          encoded_data_neg = 10'b111010_0010;
          encoded_data_pos = 10'b000101_1101;
        end
        8'b1001_1000: begin
          encoded_data_neg = 10'b110011_0010;
          encoded_data_pos = 10'b001100_1101;
        end
        8'b1001_1001: begin
          encoded_data_neg = 10'b100110_1101;
          encoded_data_pos = 10'b100110_0010;
        end
        8'b1001_1010: begin
          encoded_data_neg = 10'b010110_1101;
          encoded_data_pos = 10'b010110_0010;
        end
        8'b1001_1011: begin
          encoded_data_neg = 10'b110110_0010;
          encoded_data_pos = 10'b001001_1101;
        end
        8'b1001_1100: begin
          encoded_data_neg = 10'b001110_1101;
          encoded_data_pos = 10'b001110_0010;
        end
        8'b1001_1101: begin
          encoded_data_neg = 10'b101110_0010;
          encoded_data_pos = 10'b010001_1101;
        end
        8'b1001_1110: begin
          encoded_data_neg = 10'b011110_0010;
          encoded_data_pos = 10'b100001_1101;
        end
        8'b1001_1111: begin
          encoded_data_neg = 10'b101011_0010;
          encoded_data_pos = 10'b010100_1101;
        end
        //////////// D0.5 --> D31.5
        8'b1010_0000: begin
          encoded_data_neg = 10'b100111_1010;
          encoded_data_pos = 10'b011000_1010;
        end
        8'b1010_0001: begin
          encoded_data_neg = 10'b011101_1010;
          encoded_data_pos = 10'b100010_1010;
        end
        8'b1010_0010: begin
          encoded_data_neg = 10'b101101_1010;
          encoded_data_pos = 10'b010010_1010;
        end
        8'b1010_0011: begin
          encoded_data_neg = 10'b110001_1010;
          encoded_data_pos = 10'b110001_1010;
        end
        8'b1010_0100: begin
          encoded_data_neg = 10'b110101_1010;
          encoded_data_pos = 10'b001010_1010;
        end
        8'b1010_0101: begin
          encoded_data_neg = 10'b101001_1010;
          encoded_data_pos = 10'b101001_1010;
        end
        8'b1010_0110: begin
          encoded_data_neg = 10'b011001_1010;
          encoded_data_pos = 10'b011001_1010;
        end
        8'b1010_0111: begin
          encoded_data_neg = 10'b111000_1010;
          encoded_data_pos = 10'b000111_1010;
        end
        8'b1010_1000: begin
          encoded_data_neg = 10'b111001_1010;
          encoded_data_pos = 10'b000110_1010;
        end
        8'b1010_1001: begin
          encoded_data_neg = 10'b100101_1010;
          encoded_data_pos = 10'b100101_1010;
        end
        8'b1010_1010: begin
          encoded_data_neg = 10'b010101_1010;
          encoded_data_pos = 10'b010101_1010;
        end
        8'b1010_1011: begin
          encoded_data_neg = 10'b110100_1010;
          encoded_data_pos = 10'b110100_1010;
        end
        8'b1010_1100: begin
          encoded_data_neg = 10'b001101_1010;
          encoded_data_pos = 10'b001101_1010;
        end
        8'b1010_1101: begin
          encoded_data_neg = 10'b101100_1010;
          encoded_data_pos = 10'b101100_1010;
        end
        8'b1010_1110: begin
          encoded_data_neg = 10'b011100_1010;
          encoded_data_pos = 10'b011100_1010;
        end
        8'b1010_1111: begin
          encoded_data_neg = 10'b010111_1010;
          encoded_data_pos = 10'b101000_1010;
        end
        8'b1011_0000: begin
          encoded_data_neg = 10'b011011_1010;
          encoded_data_pos = 10'b100100_1010;
        end
        8'b1011_0001: begin
          encoded_data_neg = 10'b100011_1010;
          encoded_data_pos = 10'b100011_1010;
        end
        8'b1011_0010: begin
          encoded_data_neg = 10'b010011_1010;
          encoded_data_pos = 10'b010011_1010;
        end
        8'b1011_0011: begin
          encoded_data_neg = 10'b110010_1010;
          encoded_data_pos = 10'b110010_1010;
        end
        8'b1011_0100: begin
          encoded_data_neg = 10'b001011_1010;
          encoded_data_pos = 10'b001011_1010;
        end
        8'b1011_0101: begin
          encoded_data_neg = 10'b101010_1010;
          encoded_data_pos = 10'b101010_1010;
        end
        8'b1011_0110: begin
          encoded_data_neg = 10'b011010_1010;
          encoded_data_pos = 10'b011010_1010;
        end
        8'b1011_0111: begin
          encoded_data_neg = 10'b111010_1010;
          encoded_data_pos = 10'b000101_1010;
        end
        8'b1011_1000: begin
          encoded_data_neg = 10'b110011_1010;
          encoded_data_pos = 10'b001100_1010;
        end
        8'b1011_1001: begin
          encoded_data_neg = 10'b100110_1010;
          encoded_data_pos = 10'b100110_1010;
        end
        8'b1011_1010: begin
          encoded_data_neg = 10'b010110_1010;
          encoded_data_pos = 10'b010110_1010;
        end
        8'b1011_1011: begin
          encoded_data_neg = 10'b110110_1010;
          encoded_data_pos = 10'b001001_1010;
        end
        8'b1011_1100: begin
          encoded_data_neg = 10'b001110_1010;
          encoded_data_pos = 10'b001110_1010;
        end
        8'b1011_1101: begin
          encoded_data_neg = 10'b101110_1010;
          encoded_data_pos = 10'b010001_1010;
        end
        8'b1011_1110: begin
          encoded_data_neg = 10'b011110_1010;
          encoded_data_pos = 10'b100001_1010;
        end
        8'b1011_1111: begin
          encoded_data_neg = 10'b101011_1010;
          encoded_data_pos = 10'b010100_1010;
        end
        ///////////// D0.6 --> D31.6
        ////////////////////////////
        8'b1100_0000: begin
          encoded_data_neg = 10'b100111_0110;
          encoded_data_pos = 10'b011000_0110;
        end
        8'b1100_0001: begin
          encoded_data_neg = 10'b011101_0110;
          encoded_data_pos = 10'b100010_0110;
        end
        8'b1100_0010: begin
          encoded_data_neg = 10'b101101_0110;
          encoded_data_pos = 10'b010010_0110;
        end
        8'b1100_0011: begin
          encoded_data_neg = 10'b110001_0110;
          encoded_data_pos = 10'b110001_0110;
        end
        8'b1100_0100: begin
          encoded_data_neg = 10'b110101_0110;
          encoded_data_pos = 10'b001010_0110;
        end
        8'b1100_0101: begin
          encoded_data_neg = 10'b101001_0110;
          encoded_data_pos = 10'b101001_0110;
        end
        8'b1100_0110: begin
          encoded_data_neg = 10'b011001_0110;
          encoded_data_pos = 10'b011001_0110;
        end
        8'b1100_0111: begin
          encoded_data_neg = 10'b111000_0110;
          encoded_data_pos = 10'b000111_0110;
        end
        8'b1100_1000: begin
          encoded_data_neg = 10'b111001_0110;
          encoded_data_pos = 10'b000110_0110;
        end
        8'b1100_1001: begin
          encoded_data_neg = 10'b100101_0110;
          encoded_data_pos = 10'b100101_0110;
        end
        8'b1100_1010: begin
          encoded_data_neg = 10'b010101_0110;
          encoded_data_pos = 10'b010101_0110;
        end
        8'b1100_1011: begin
          encoded_data_neg = 10'b110100_0110;
          encoded_data_pos = 10'b110100_0110;
        end
        8'b1100_1100: begin
          encoded_data_neg = 10'b001101_0110;
          encoded_data_pos = 10'b001101_0110;
        end
        8'b1100_1101: begin
          encoded_data_neg = 10'b101100_0110;
          encoded_data_pos = 10'b101100_0110;
        end
        8'b1100_1110: begin
          encoded_data_neg = 10'b011100_0110;
          encoded_data_pos = 10'b011100_0110;
        end
        8'b1100_1111: begin
          encoded_data_neg = 10'b010111_0110;
          encoded_data_pos = 10'b101000_0110;
        end
        8'b1101_0000: begin
          encoded_data_neg = 10'b011011_0110;
          encoded_data_pos = 10'b100100_0110;
        end
        8'b1101_0001: begin
          encoded_data_neg = 10'b100011_0110;
          encoded_data_pos = 10'b100011_0110;
        end
        8'b1101_0010: begin
          encoded_data_neg = 10'b010011_0110;
          encoded_data_pos = 10'b010011_0110;
        end
        8'b1101_0011: begin
          encoded_data_neg = 10'b110010_0110;
          encoded_data_pos = 10'b110010_0110;
        end
        8'b1101_0100: begin
          encoded_data_neg = 10'b001011_0110;
          encoded_data_pos = 10'b001011_0110;
        end
        8'b1101_0101: begin
          encoded_data_neg = 10'b101010_0110;
          encoded_data_pos = 10'b101010_0110;
        end
        8'b1101_0110: begin
          encoded_data_neg = 10'b011010_0110;
          encoded_data_pos = 10'b011010_0110;
        end
        8'b1101_0111: begin
          encoded_data_neg = 10'b111010_0110;
          encoded_data_pos = 10'b000101_0110;
        end
        8'b1101_1000: begin
          encoded_data_neg = 10'b110011_0110;
          encoded_data_pos = 10'b001100_0110;
        end
        8'b1101_1001: begin
          encoded_data_neg = 10'b100110_0110;
          encoded_data_pos = 10'b100110_0110;
        end
        8'b1101_1010: begin
          encoded_data_neg = 10'b010110_0110;
          encoded_data_pos = 10'b010110_0110;
        end
        8'b1101_1011: begin
          encoded_data_neg = 10'b110110_0110;
          encoded_data_pos = 10'b001001_0110;
        end
        8'b1101_1100: begin
          encoded_data_neg = 10'b001110_0110;
          encoded_data_pos = 10'b001110_0110;
        end
        8'b1101_1101: begin
          encoded_data_neg = 10'b101110_0110;
          encoded_data_pos = 10'b010001_0110;
        end
        8'b1101_1110: begin
          encoded_data_neg = 10'b011110_0110;
          encoded_data_pos = 10'b100001_0110;
        end
        8'b1101_1111: begin
          encoded_data_neg = 10'b101011_0110;
          encoded_data_pos = 10'b010100_0110;
        end
        //////////// D0.7 --> D31.7
        ////////////////////////
        ////////////////////////
        8'b1110_0000: begin
          encoded_data_neg = 10'b100111_0001;
          encoded_data_pos = 10'b011000_1110;
        end
        8'b1110_0001: begin
          encoded_data_neg = 10'b011101_0001;
          encoded_data_pos = 10'b100010_1110;
        end
        8'b1110_0010: begin
          encoded_data_neg = 10'b101101_0001;
          encoded_data_pos = 10'b010010_1110;
        end
        8'b1110_0011: begin
          encoded_data_neg = 10'b110001_1110;
          encoded_data_pos = 10'b110001_0001;
        end
        8'b1110_0100: begin
          encoded_data_neg = 10'b110101_0001;
          encoded_data_pos = 10'b001010_1110;
        end
        8'b1110_0101: begin
          encoded_data_neg = 10'b101001_1110;
          encoded_data_pos = 10'b101001_0001;
        end
        8'b1110_0110: begin
          encoded_data_neg = 10'b011001_1110;
          encoded_data_pos = 10'b011001_0001;
        end
        8'b1110_0111: begin
          encoded_data_neg = 10'b111000_1110;
          encoded_data_pos = 10'b000111_0001;
        end
        8'b1110_1000: begin
          encoded_data_neg = 10'b111001_0001;
          encoded_data_pos = 10'b000110_1110;
        end
        8'b1110_1001: begin
          encoded_data_neg = 10'b100101_1110;
          encoded_data_pos = 10'b100101_0001;
        end
        8'b1110_1010: begin
          encoded_data_neg = 10'b010101_1110;
          encoded_data_pos = 10'b010101_0001;
        end
        8'b1110_1011: begin
          encoded_data_neg = 10'b110100_1110;
          encoded_data_pos = 10'b110100_1000;
        end
        8'b1110_1100: begin
          encoded_data_neg = 10'b001101_1110;
          encoded_data_pos = 10'b001101_0001;
        end
        8'b1110_1101: begin
          encoded_data_neg = 10'b101100_1110;
          encoded_data_pos = 10'b101100_1000;
        end
        8'b1110_1110: begin
          encoded_data_neg = 10'b011100_1110;
          encoded_data_pos = 10'b011100_1000;
        end
        8'b1110_1111: begin
          encoded_data_neg = 10'b010111_0001;
          encoded_data_pos = 10'b101000_1110;
        end
        8'b1111_0000: begin
          encoded_data_neg = 10'b011011_0001;
          encoded_data_pos = 10'b100100_1110;
        end
        8'b1111_0001: begin
          encoded_data_neg = 10'b100011_0111;
          encoded_data_pos = 10'b100011_0001;
        end
        8'b1111_0010: begin
          encoded_data_neg = 10'b010011_0111;
          encoded_data_pos = 10'b010011_0001;
        end
        8'b1111_0011: begin
          encoded_data_neg = 10'b110010_1110;
          encoded_data_pos = 10'b110010_0001;
        end
        8'b1111_0100: begin
          encoded_data_neg = 10'b001011_0111;
          encoded_data_pos = 10'b001011_0001;
        end
        8'b1111_0101: begin
          encoded_data_neg = 10'b101010_1110;
          encoded_data_pos = 10'b101010_0001;
        end
        8'b1111_0110: begin
          encoded_data_neg = 10'b011010_1110;
          encoded_data_pos = 10'b011010_0001;
        end
        8'b1111_0111: begin
          encoded_data_neg = 10'b111010_0001;
          encoded_data_pos = 10'b000101_1110;
        end
        8'b1111_1000: begin
          encoded_data_neg = 10'b110011_0001;
          encoded_data_pos = 10'b001100_1110;
        end
        8'b1111_1001: begin
          encoded_data_neg = 10'b100110_1110;
          encoded_data_pos = 10'b100110_0001;
        end
        8'b1111_1010: begin
          encoded_data_neg = 10'b010110_1110;
          encoded_data_pos = 10'b010110_0001;
        end
        8'b1111_1011: begin
          encoded_data_neg = 10'b110110_0001;
          encoded_data_pos = 10'b001001_1110;
        end
        8'b1111_1100: begin
          encoded_data_neg = 10'b001110_1110;
          encoded_data_pos = 10'b001110_0001;
        end
        8'b1111_1101: begin
          encoded_data_neg = 10'b101110_0001;
          encoded_data_pos = 10'b010001_1110;
        end
        8'b1111_1110: begin
          encoded_data_neg = 10'b011110_0001;
          encoded_data_pos = 10'b100001_1110;
        end
        8'b1111_1111: begin
          encoded_data_neg = 10'b101011_0001;
          encoded_data_pos = 10'b010100_1110;
        end
      endcase
    end else begin
      encoded_data_neg = 10'b100111_0100;
      encoded_data_pos = 10'b011000_1011;
    end

  end
endmodule
