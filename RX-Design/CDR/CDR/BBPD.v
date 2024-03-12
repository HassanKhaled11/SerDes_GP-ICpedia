`timescale 1ns/1fs
module BBPD (
	input clk,    // Clock
	input Din, // serial data
	input rst_n,  // Asynchronous reset active low
	output Up,Dn,
	output reg A
);
reg B;
reg T_ , T;
always @(posedge clk or negedge rst_n) begin
	if(!rst_n) begin
		A <= 1'b0;
		B <= 1'b0;
		T <= 1'b0;
	end else begin
		B <= Din;
		A <= B;
		T <= T_;
	end
end

always @(negedge clk or negedge rst_n) begin
	if(~rst_n) begin
		 T_<= 0;
	end else begin
		 T_<= Din;
	end
end

assign Up = A ^ T;
assign Dn = B ^ T;
endmodule