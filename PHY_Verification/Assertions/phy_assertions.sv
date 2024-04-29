module phy_assertions #(parameter DATA_BUS_WIDTH=32) (
	input clk,    // Clock
	input rst_n,  // Asynchronous reset active low
	input [DATA_BUS_WIDTH-1:0] Data_in,
	input [DATA_BUS_WIDTH-1:0] Data_out,
	input enable
);

default disable iff !rst_n;

property data_phy_chk;

logic [DATA_BUS_WIDTH-1:0] data;

 	@(posedge clk) (enable,data=Data_in,$display($stime,"\t Assertion Disp data=%h ,data_in=%h",data,Data_in)) 
	|=> @(posedge clk) ##[0:$] (Data_out === data); 

endproperty

datachk 	 : assert property(data_phy_chk) else $display($stime,,,"FAIL: DATA CHECK");
cvg_datachk : cover  property(data_phy_chk)  $display($stime,,,"PASS: DATA CHECK");

endmodule : phy_assertions