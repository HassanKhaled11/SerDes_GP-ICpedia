module GasKet_RX (
    input             clk_to_get,
    input             PCLK,
    input             Rst_n,
    input             Rx_Datak,
    input      [ 5:0] width,
    input      [ 7:0] Data_in,
    output reg [31:0] Data_out
);

  
  reg [31:0] data_out;
  reg [1:0] count;
  reg [3:0] flag;
  reg [31:0]temp_reg;

  always @(posedge clk_to_get or negedge Rst_n) begin
    if (!Rst_n) begin
      count <= 3'b01;
    end 
	else if((width == 6'd8 && count == 2'b00) || (width == 6'd16 && count == 2'b01) || (width == 6'd32 && count == 2'b11) || Rx_Datak) begin
      count <= 2'b00;
    end else begin
      count <= count + 1'b1;
    end
  end

  always @(posedge clk_to_get or negedge Rst_n) begin
    if (!Rst_n) begin
      data_out <= 32'b0;
    end else begin

      case (count)
        2'b00: begin 
          data_out[7 :0] <= Data_in;
          if(Data_in == 8'h7c) flag[0] <= 0 ;
          else flag[0] <= 1 ; 
        end
        
        2'b01:begin 
          data_out[15:8] <= Data_in;
          if(Data_in == 8'h7c) flag[1] <= 0 ;
          else flag[1] <= 1 ;
        end   
        
        2'b10:begin
          data_out[23:16] <= Data_in; 
          if(Data_in == 8'h7c) flag[2] <= 0 ;
          else flag[2] <= 1 ;           
        end
        
        2'b11:begin 
          data_out[31:24] <= Data_in;
          if(Data_in == 8'h7c) flag[3] <= 0 ;
          else flag[3] <= 1 ;            
        end
      
      endcase
    end
  end


 always @(posedge clk_to_get or negedge Rst_n) begin
   if(~Rst_n) begin
    temp_reg <= 0;
   end

   else if(width == 6'd8 && flag[0]) begin
    temp_reg <= {24'b0,data_out[7:0]};
   end

  else if (width == 6'd16 && (&flag[1:0])) begin
    temp_reg <= {24'b0,data_out[15:0]};
   end
  
  else if(width == 6'd32 && &flag) begin
    temp_reg <= data_out;
   end
  
   else 
    temp_reg <= 0;
 end

  always @(posedge PCLK or negedge Rst_n) begin
    if (!Rst_n) Data_out <= 32'b0;
    else begin
      Data_out <= temp_reg;
    end 
  end

endmodule
