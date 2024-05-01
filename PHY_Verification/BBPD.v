`timescale 1ns/1fs
module BBPD (
	input clk,    // Clock
	input clk_ref,

    `ifdef THREE_CLKS
      input clk_90 ,
      input clk_180,
    `endif 

	input Din, // serial data
	input rst_n,  // Asynchronous reset active low
	output  Up,Dn,
	output reg A
);

// reg B;
// reg T_ , T;



// always @(posedge clk or negedge rst_n) begin
// 	if(!rst_n) begin
// 		A <= 1'b0;
// 		B <= 1'b0;
// 		T <= 1'b0;
// 	end else begin
// 		B <= Din;
// 		A <= B;
// 		T <= T_;
// 	end
// end





// always @(negedge clk or negedge rst_n) begin
// 	if(~rst_n) begin
// 		 T_<= 0;
// 	end else begin
// 		 T_<= Din;
// 	end
// end

// assign Up = A ^ T;
// assign Dn = B ^ T;




reg B , C;

always @(posedge clk or negedge rst_n) begin
	if(!rst_n) begin
	  A <= 0 ;	
	end

	else begin
		A <= Din;
	end
  
end

always @(posedge clk_90 or negedge rst_n) begin
	if(!rst_n) begin
	  B <= 0 ;	
	end

	else begin
		B <= Din;
	end
end

always @(posedge clk_180 or negedge rst_n) begin
 	if(!rst_n) begin
	  C <= 0 ;	
	end

	else begin
		C <= Din;
	end
end


assign Up =  A ^ B ;
assign Dn =  B ^ C ;


// reg clear ;


// always @(posedge clk or negedge rst_n) begin
// 	if(~rst_n) begin
// 		A <= 0;
// 	end else begin
// 		A <= Din;
// 	end
// end


// /////////////////////////////
// /////////// UP //////////////
// /////////////////////////////
// always @(posedge clk_ref or posedge clear or negedge rst_n) begin
	
// if(!rst_n) begin
// 	Up <= 0;
// end

// else if(clear) begin
// 	Up <= 0;
// end  


// else begin
// 	Up <= 1'b1;
// end 

// end



// /////////////////////////////
// /////////// DN //////////////
// /////////////////////////////
// always @(posedge clk or posedge clear or negedge rst_n) begin
	
// if(!rst_n) begin
// 	Dn <= 0;
// end

// else if(clear) begin
// 	Dn <= 0;
// end  

// else begin
// 	Dn <= 1'b1;
// end 

// end

// always@(*) begin
// 	clear = Up & Dn;
// end 



endmodule




/*



A    T    B    -->  Description

--------------------------------------

0    0    0    -->  no transition
0    0    1    -->  early
0    1    0    -->  shouldn't occur
0    1    1    -->  late
1    0    0    -->  late
1    0    1    -->  shouldn't occur
1    1    0    -->  early
1    1    1    -->  no transition



*/
