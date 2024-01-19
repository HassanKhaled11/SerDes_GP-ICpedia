module Comma_Detection  (
    input clk,
    input rst_n,
    input [9:0] Data_Collected,
    output reg  RxValid,
    output reg  Comma_Pulse
);


reg Found_Comma;
wire Last_Comma;
reg [3:0] count ;
reg [2:0] symbol_count;
always @(*)begin
if ((Data_Collected==10'h0FA ||Data_Collected==10'h305)) begin 
  Found_Comma = 1;
end

else begin
 Found_Comma  = 0;
end

end

assign Last_Comma = ((symbol_count == 3'b100) && count == 0) ;

always @(posedge clk or negedge rst_n)begin
  if(!rst_n) begin
    count<=0;
    RxValid<=0;
    Comma_Pulse<=0;
    symbol_count <= 3'b000;
  end
  else if (Found_Comma == 1 && (count != 0 || Last_Comma == 0)) begin 
    count<=count+1;
      if(count== 9) begin
         count<=0  ;
         //RxValid<=1;
        // Comma_Pulse<=1;
         symbol_count <= symbol_count + 1;
      end

      // else  begin 
      //   RxValid<=0;
      //   Comma_Pulse<=0;
      // end
  end

  else if (Last_Comma == 1 || count != 0 || symbol_count != 0 ) begin 
    count<=count+1;
      if(count== 9) begin
         count<=0  ;
         RxValid<=1;
         Comma_Pulse<=1;
         symbol_count <= symbol_count - 1;
      end

      else  begin 
        RxValid<=0;
        Comma_Pulse<=0;
      end
  end

  else begin
      RxValid<=0;
      Comma_Pulse<=0;
    end
end


endmodule



// module Comma_Detection (
//     input Recovered_Bit_Clk,
//     input word_clk,
//     input rst_n,
//     input [9:0] Data_Collected,

//     output reg RxValid,
//     output reg Comma_Pulse
// );

//   reg Found_Comma;
//   reg flag;
//   reg temp_pulse;
//   reg [9:0] data_temp; 
 

//   always @(*) begin
//     if (Data_Collected == 10'h0FA || Data_Collected == 10'h305) begin
//       Found_Comma = 1;
//       RxValid     = 1;
//       flag        = 1;
//     end

//     else begin
//       Found_Comma = 0;
//       RxValid     = 0;
//       flag        = 0;
//     end

//   end


//   always @(posedge word_clk or negedge rst_n) begin
//     if (!rst_n) begin
//       Comma_Pulse <= 1'b0;
//     end else if (temp_pulse) begin
//       Comma_Pulse <= 1'b1;
//     end else begin
//       Comma_Pulse <= 0;
//     end
//   end


//  always @(posedge Recovered_Bit_Clk or negedge rst_n) begin 
//   if(~rst_n) begin
//     temp_pulse <= 0;
//   end 
//   else if(flag) begin
//     temp_pulse <= Found_Comma;
//   end
//   else begin
//     temp_pulse <= temp_pulse;
//   end
// end


// endmodule





// module Top (

//     input Recovered_Bit_Clk,
//     input word_clk,
//     input Ser_in,
//     input Rst_n,
//     input RxPolarity,
//     output reg [9:0] Data_Collected,
//     output reg RxValid,
//     output reg Comma_Pulse
// );

//   Serial_to_Parallel #(
//       .DATA_WIDTH(10)
//   ) duts (

//       .Recovered_Bit_Clk(Recovered_Bit_Clk),
//       .Ser_in(Ser_in),
//       .Rst_n(Rst_n),
//       .RxPolarity(RxPolarity),
//       .Data_Collected(Data_Collected)  //change

//   );


//   // Comma_Detection DUTC (
//   //     .word_clk(word_clk),
//   //     .Recovered_Bit_Clk(Recovered_Bit_Clk),
//   //     .rst_n(Rst_n),
//   //     .Data_Collected(Data_Collected),

//   //     .RxValid(RxValid),
//   //     .Comma_Pulse(Comma_Pulse)
//   // );


// Comma_Detection  Dutc(
//     .clk    (Recovered_Bit_Clk)     ,
//     .rst_n  (Rst_n)     ,
//     .Data_Collected(Data_Collected),
//     .RxValid(RxValid),
//     .Comma_Pulse(Comma_Pulse)
// );


// endmodule





// module comma_tb ();
//   reg Recovered_Bit_Clk;
//   reg word_clk;
//   reg Ser_in;
//   reg Rst_n;
//   reg RxPolarity;
//   wire [9:0] Data_Collected;
//   wire RxValid;
//   wire Comma_Pulse;



//   integer i;
//   reg [9:0] x;

//   Serial_to_Parallel #(
//       .DATA_WIDTH(10)
//   ) duts (

//       .Recovered_Bit_Clk(Recovered_Bit_Clk),
//       .Ser_in(Ser_in),
//       .Rst_n(Rst_n),
//       .RxPolarity(RxPolarity),
//       .Data_Collected(Data_Collected)  //change

//   );


//   // Comma_Detection DUTC (
//   //     .word_clk(word_clk),
//   //     .Recovered_Bit_Clk(Recovered_Bit_Clk),
//   //     .rst_n(Rst_n),
//   //     .Data_Collected(Data_Collected),

//   //     .RxValid(RxValid),
//   //     .Comma_Pulse(Comma_Pulse)
//   // );



// Comma_Detection Dutc (
//     .clk    (Recovered_Bit_Clk)     ,
//     .rst_n  (Rst_n)     ,
//     .Data_Collected(Data_Collected),
//     .RxValid(RxValid),
//     .Comma_Pulse(Comma_Pulse)
// );



//   initial begin
//     Recovered_Bit_Clk = 1;
//     forever #1 Recovered_Bit_Clk = ~Recovered_Bit_Clk;
//   end


//   initial begin
//     word_clk = 1;
//     forever #10 word_clk = ~word_clk;
//   end


//   initial begin
//     RxPolarity = 0;
//     Ser_in = 0;

//     Rst_n = 0;
//     #4;
//     Rst_n = 1;


//     repeat (100) begin
//       @(negedge word_clk);
//       x = $random();
//       send_coma();
//       send_data(x);
//     end


//     #1000;
//     $stop;

//   end

//   task send_coma();
//     begin
//       @(posedge Recovered_Bit_Clk);

//       Ser_in = 0;
//       #(2);

//       Ser_in = 1;
//       #(2);

//       Ser_in = 0;
//       #(2);

//       Ser_in = 1;
//       #(2);

//       Ser_in = 1;
//       #(2);

//       Ser_in = 1;
//       #(2);

//       Ser_in = 1;
//       #(2);

//       Ser_in = 1;
//       #(2);

//       Ser_in = 0;
//       #(2);

//       Ser_in = 0;
//       #(2);
//     end
//   endtask



//   task send_data(input [9:0] data);
//     begin
//       for (i = 0; i < 10; i = i + 1) begin
//         @(posedge Recovered_Bit_Clk);
//         Ser_in = data[i];
//       end
//     end

//   endtask

// endmodule