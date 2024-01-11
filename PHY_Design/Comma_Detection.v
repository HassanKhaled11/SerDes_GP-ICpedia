module Comma_Detection  (
    //input [PARALLEL_DATA_WIDTH-1:0] Data_in,
    // input TXDataK,
    input clk,
    input rst_n,
    input [9:0] detect_comma,
    output reg RxValid,
    output reg Comma_pulse
);
reg internal;
wire pulse;
reg[1:0] count;
wire comma_flag;
always @(posedge clk or negedge rst_n) begin
  if(~rst_n) begin
    count <= 2'b00;
  end else if(detect_comma == 10'b001111_1010 || detect_comma == 10'b110000_0101) begin
    count <= count + 1;
  end 
end

always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
      internal <= 1'b0;
      RxValid <= 0;
      Comma_pulse <= 0;
    end else begin
      RxValid <= pulse;
      internal <= comma_flag;
      Comma_pulse <= pulse;
  end
end
assign pulse = internal && !comma_flag;


// un comment the following line for one comma sequence for 
//assign comma_flag = (detect_comma == 10'b00_1111_1010 || detect_comma == 10'b11_0000_0101) ? 1'b1 : 1'b0;


assign comma_flag = (count == 2'b11);
/*
 if (Data_in == 10'b001111_1010 || Data_in == 10'b110000_0101) begin
      RxValid = 1;
      Comma_pulse = 1;
    end else begin
      RxValid = 0;
      Comma_pulse = 0;
    end
*/

endmodule
