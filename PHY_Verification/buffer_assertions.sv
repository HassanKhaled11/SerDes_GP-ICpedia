module buffer_assertions #(parameter MAXBUFFERADR=5,DATAWIDTH=10 )
(
	input clk,
	input writeclk,
	input readclk,
	input rst,
	input [MAXBUFFERADR-1:0] read_pointer,
	input [MAXBUFFERADR-1:0] write_pointer,
	input [DATAWIDTH-1:0] 	 data_in	  	,
	input [DATAWIDTH-1:0]  	 data_out		,
	input empty,full,addreq,skpAdd,skpRemove,deletereq
);

default disable iff !rst;

//////////////////////////// check read data = 0f3 in case of empty or add req
property chk_write_empty;
	@(posedge readclk) empty or addreq |=> (data_out == 10'h0f3) and (read_pointer == $past(read_pointer,1));
endproperty

empty_addreq 	 : assert property(chk_write_empty) $display($stime,,,"\t\t %m PASS"); else $display("Error");
cvg_empty_addreq : cover  property(chk_write_empty);

//////////////////////////////// not occured

property chk_skp_add;
	@(posedge writeclk) !full and (data_in == 10'h0f9 or data_in == 10'h306)and !deletereq |-> $rose(skpAdd);
endproperty

add_skip     	 : assert property(chk_skp_add) $display($stime,,,"\t\t %m PASS"); else $display("Error");
cvg_addSkip 	 : cover  property(chk_skp_add);

property chk_skp_remove;
	@(posedge writeclk) !full and (data_in == 10'h0f9 or data_in == 10'h306)and deletereq |-> $rose(skpRemove);
endproperty

rmv_skip     	 : assert property(chk_skp_remove) $display($stime,,,"\t\t %m PASS"); else $display("Error");
cvg_rmvSkip 	 : cover  property(chk_skp_remove);

///////////////////////////////// done

property chk_increase_wrptr;
	@(posedge writeclk) !full and (data_in != 10'h0f9 and data_in != 10'h306) |->##[1:2] (write_pointer == $past(write_pointer,1) + 1);
endproperty

wrptr_incr    	 : assert property(chk_increase_wrptr) $display($stime,,,"\t\t %m PASS"); else $display("Error");
cvg_wptr_incr 	 : cover  property(chk_increase_wrptr);

///////////////////////////////// 

property chk_no_add_remov_skp;
	@(posedge writeclk) !full and (data_in != 10'h0f9 and data_in != 10'h306) |=> !skpAdd and !skpRemove;
endproperty

no_skp    	 : assert property(chk_no_add_remov_skp) $display($stime,,,"\t\t %m PASS"); else $display("Error");
cvg_no_skp 	 : cover  property(chk_no_add_remov_skp);

///////////////////////////////// passes for except last comma pulse for each seq

// property chk_wrt;
// 	@(negedge writeclk) !full |-> data_in == buffer.elastic_mem_inst.buffer[write_pointer-1];
// endproperty

// wrt_chk    	 : assert property(chk_wrt) $display($stime,,,"\t\t %m PASS"); else $display("Error");
// cvg_wrt_chk  : cover  property(chk_wrt);

property chk_wrt;
	logic[9:0] data;
	logic[4:0] ptr;
	@(posedge clk) ((!full && writeclk && (data_in != 10'h0f9) && (data_in != 10'h306)),data=data_in,ptr=write_pointer,$display($stime,"data=%h ,ptr=&h",data,ptr)) |=>  data == buffer.elastic_mem_inst.buffer[ptr-1];
endproperty

wrt_chk    	 : assert property(chk_wrt) $display($stime,,,"\t\t %m PASS"); else $display("Error");
cvg_wrt_chk  : cover  property(chk_wrt);

/////////////////////////////////////////////////////////////////////////////////////////////////
property chk_rd;
	@(posedge readclk) (!empty and !addreq) |->##1 $past(data_out,1) == buffer.elastic_mem_inst.buffer[$past(read_pointer,1)-1];
endproperty

rd_chk    	 : assert property(chk_rd) $display($stime,,,"\t\t %m PASS"); else $display("Error");
cvg_rd_chk  : cover  property(chk_rd);
//////////////////////////////////////////////////////////////////////////////////////////////////
property chk_rd_addr;
	@(posedge readclk) (!empty and !addreq) |->##1 (read_pointer == $past(read_pointer,1)+1);
endproperty

rdAddr_chk    	 : assert property(chk_rd_addr) $display($stime,,,"\t\t %m PASS"); else $display("Error");
cvg_rdAddr_chk   : cover  property(chk_rd_addr);


property chk_empty;
	@(posedge readclk) (read_pointer==write_pointer) |->##1 empty;
endproperty

empty_chk    	 : assert property(chk_empty) $display($stime,,,"\t\t %m PASS"); else $display("Error");
cvg_empty_chk    : cover  property(chk_empty);

////////////////////////////////////////////////////////////////////////

sequence rd_detect(ptr);
##[0:$] (!empty && !addreq && (read_pointer == ptr));
endsequence

property data_chk;
// int ptr , data;
logic [4:0] ptr;
logic [9:0] data;
 	@(posedge clk) ((writeclk&&!full && (data_in != 10'h0f9) && (data_in != 10'h306)),ptr=write_pointer,data=data_in,
	$display($stime,"\t Assertion Disp wr_ptr=%h , writeptr=%h data=%h ,data_in=%h", ptr,write_pointer, data,data_in)) 
	|=> @(negedge readclk) first_match(rd_detect(ptr),$display($stime,,," Assertion Disp FIRST_MATCH ptr=%h Compare data=%h data_out=%h", ptr, data, data_out) )
 	##0 (data_out === data); 
endproperty

dchk 	 : assert property(data_chk) else $display($stime,,,"FAIL: DATA CHECK");
cvg_dchk : cover  property(data_chk)  $display($stime,,,"PASS: DATA CHECK");

endmodule