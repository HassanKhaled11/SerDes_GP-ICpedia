module Slicers #(parameter Threshold = 0.5)
(
  input  Data           ,	
  input  clk_d          ,    // dn               
  input  clk_p          ,    // pn   (dn+90 )
  input  clk_d_n        ,    // dn-1 (dn+180)
  input  clk_p_n        ,    // pn-1 (pn+180)

  output d_slicer_out   ,
  output p_slicer_out   ,
  output d_slicer_n_out ,
  output p_slicer_n_out 

);



Slicer #(.Threshold(Threshold)) Slicer_data    (.data(Data) , .clk(clk_d)   , .data_out  (d_slicer_out));  // dn           
Slicer #(.Threshold(Threshold)) Slicer_Phase   (.data(Data) , .clk(clk_p)   , .data_out  (p_slicer_out));  // pn   (dn+90 )
Slicer #(.Threshold(Threshold)) Slicer_data_n  (.data(Data) , .clk(clk_d_n) , .data_out(d_slicer_n_out));  // dn-1 (dn+180)
Slicer #(.Threshold(Threshold)) Slicer_Phase_n (.data(Data) , .clk(clk_p_n) , .data_out(p_slicer_n_out));  // pn-1 (pn+180) 


endmodule



module Slicer #(parameter Threshold = 0.5)
(
  input  data     ,
  input  clk      , 
  output reg data_out  
);


always @(posedge clk)
begin
  if(data > Threshold) begin
   data_out = 1  ;  
  end 

  else begin
  	data_out = 0 ;
  end

end

endmodule


