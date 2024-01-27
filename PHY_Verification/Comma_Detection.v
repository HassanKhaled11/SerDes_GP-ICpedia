module Comma_Detection #(parameter COMMA_NUMBER = 4)(
              input clk,
              input rst_n,
              input [9:0] Data_Collected,
              output reg  RxValid,
              output reg  Comma_Pulse
            );

reg[1:0] cs , ns;
wire [5:0] CP1 , CP2 ;  /// ?????
reg  [5:0] count;
reg count_reset;
//reg[2:0] symbol_count;

localparam IDLE = 2'b00 ,
           COMMA = 2'b01,
           DATA = 2'b10 ;



assign CP1 = ((COMMA_NUMBER-2)*10 + 9);
assign CP2 = CP1 + 10 ;


always @(posedge clk or negedge rst_n) begin
  if(!rst_n) begin
    cs <= IDLE;
  end else begin
    cs <= ns;
  end
end

always @(*) begin
  case (cs)
    IDLE : begin
      if(Data_Collected==10'h0FA || Data_Collected==10'h305) begin
        ns = COMMA;
      end
      else 
        ns = IDLE;
    end 
    COMMA : begin
      case(count)
        6'd9 : begin
            if(Data_Collected!=10'h0FA && Data_Collected!=10'h305)
              ns = IDLE;
            else 
              ns = COMMA;
          end 
        
        6'd19 : begin
            if(Data_Collected!=10'h0FA && Data_Collected!=10'h305)
              ns = IDLE;
            else 
              ns = COMMA;
          end 

        6'd29 : begin
            if(Data_Collected!=10'h0FA && Data_Collected!=10'h305)
              ns = IDLE;
            else 
              ns = DATA;
          end 
        //6'd40 :
        default : ns = COMMA;
      endcase 
    end 
    DATA : begin 
        if(count == CP2)
          ns = IDLE;
        else 
          ns = DATA; 
    end 
    default : ns = IDLE;
  endcase
end

always @(*) begin
  case (cs)
    IDLE :begin
      Comma_Pulse = 0 ;
      count_reset = 0 ;
      RxValid     = 0 ;

      if(Data_Collected==10'h0FA || Data_Collected==10'h305)
      count_reset = 1'b1;
      else 
      count_reset = 1'b0;
    
    end 

    
    COMMA : begin 
      Comma_Pulse = 0 ;
      RxValid     = 0 ;

      if(count == CP1)
        count_reset = 1'b1;
      
      else 
        count_reset = 1'b0;
    end 
    

    DATA : begin 
        count_reset = 0 ;
      case(count)
        6'd9 : begin
            Comma_Pulse = 1'b1;
            RxValid = 1'b1;
          end 
        6'd19 : begin
            Comma_Pulse = 1'b1;
            RxValid = 1'b1;
          end 
        6'd29 : begin
            Comma_Pulse = 1'b1;
            RxValid = 1'b1;
          end 
        6'd39 : begin
            Comma_Pulse = 1'b1;
            RxValid = 1'b1;
          end 
        default : begin 
          Comma_Pulse = 1'b0;
          RxValid = 1'b0;
        end   
      endcase

    end  
    default : begin
      Comma_Pulse = 1'b0;
      count_reset = 1'b0;
      RxValid = 1'b0;
    end 
  endcase
end

always @(posedge clk or negedge rst_n) begin
  if(!rst_n)
    count <= 4'b0;
  else if(count_reset)
    count <= 4'b0;
  else 
    count <= count + 1'b1;
end
endmodule