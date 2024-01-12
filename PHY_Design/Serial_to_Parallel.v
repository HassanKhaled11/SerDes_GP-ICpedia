
module Serial_to_Parallel #(
    parameter DATA_WIDTH = 10
) (

    input Recovered_Bit_Clk,

    input Ser_in,

    input Rst_n,

    input RxPolarity,

    //output K285,

    output reg [DATA_WIDTH-1:0] Data_Collected  //change

);

  // reg [3:0] count;
  // reg [9:0] collect_register;


  wire serial;


  assign serial = (RxPolarity) ? !Ser_in : Ser_in;


  always @(posedge Recovered_Bit_Clk or negedge Rst_n) begin : proc_
    if (~Rst_n) begin
      Data_Collected <= 0;
    end else begin
      Data_Collected <= {serial, Data_Collected[9:1]};
    end
  end


endmodule

