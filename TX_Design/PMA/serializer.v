module PMA(
  input fast_clk, // bit_rate/10
  input slow_clk, // bit_rate
  input [9:0] data_in, 
  input tx_data_enable, 
  output reg data_out);
  
  reg [9:1] tmep;
  
  always@(posedge fast_clk) begin
    temp = data_in;
  end
  
  always@(posedge slow_clk) begin
    if(tx_data_enable) begin
      data_out <= temp[0];
      temp <= tmep>>1;
    end
  end
endmodule
