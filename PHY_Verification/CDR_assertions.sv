module CDR_assertions (
	input clk,    // Clock
	input rst_n,
	input MAC_EN,
	input TX_POS,
	input recoverd_data,
	input pi_clk
);

default disable iff !rst_n;

property chk_recover_data;  
	bit data;
	@(posedge clk) (MAC_EN,data=TX_POS,$display("Compare: data=%b , data_in=%b",data,TX_POS))|->##1 @(posedge pi_clk)  (data == recoverd_data); //@(posedge pi_clk)
endproperty

data_recover 	 : assert property(chk_recover_data) else $display($stime,,,"FAIL: DATA Recover"); 
cvg_data_recover : cover  property(chk_recover_data) $display($stime,,,"PASS: DATA Recover");


property chk_sampling; // @(posedge pi_clk) can be used instead of first_match($rose(pi_clk)) 
	@(posedge clk) (MAC_EN and (TX_POS != $past(TX_POS,1))) |->##1 $rose(pi_clk);
endproperty

sampling_chk 	 : assert property(chk_sampling) else $display($stime,,,"FAIL: DATA Recover"); 
cvg_sampling  	 : cover  property(chk_sampling) $display($stime,,,"PASS: DATA Recover");




endmodule