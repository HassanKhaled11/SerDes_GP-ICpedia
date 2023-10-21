module golden_model (

input clk , 
input      [3:0] A , 
input      [3:0] B ,
output reg [3:0] out 
);



always @(posedge clk) begin
	out <= A & B ;
end

endmodule