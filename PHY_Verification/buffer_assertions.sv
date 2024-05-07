module buffer_assertions #(
    parameter MAXBUFFERADR = 5,
    DATAWIDTH = 10
) (
    input                    clk,
    input                    writeclk,
    input                    readclk,
    input                    rst,
    input [MAXBUFFERADR-1:0] read_pointer,
    input [MAXBUFFERADR-1:0] write_pointer,
    input [   DATAWIDTH-1:0] data_in,
    input [   DATAWIDTH-1:0] data_out,
    input                    empty,
    full,
    addreq,
    skpAdd,
    skpRemove,
    deletereq
);

  default disable iff !rst;

  //////////////////////////// check read data = 0f3 in case of empty or add req
  property chk_write_empty;
    @(posedge readclk) empty or addreq |=> (data_out == 10'h0f3) and(read_pointer == $past(
        read_pointer, 1
    ));
  endproperty

  empty_addreq :
  assert property (chk_write_empty)  // $display($stime,,, "\t\t %m PASS");
  else $display("Error");
  cvg_empty_addreq :
  cover property (chk_write_empty);

  //////////////////////////////// not occured

  property chk_skp_add;
    @(posedge writeclk) !full and (data_in == 10'h0f9 or data_in == 10'h306)and !deletereq |-> $rose(
        skpAdd
    );
  endproperty

  add_skip :
  assert property (chk_skp_add)  // $display($stime,,, "\t\t %m PASS");
  else $display("Error");
  cvg_addSkip :
  cover property (chk_skp_add);

  property chk_skp_remove;
    @(posedge writeclk) !full and(data_in == 10'h0f9 or data_in == 10'h306) and deletereq |-> $rose(
        skpRemove
    );
  endproperty

  rmv_skip :
  assert property (chk_skp_remove)  // $display($stime,,, "\t\t %m PASS");
  else $display("Error");
  cvg_rmvSkip :
  cover property (chk_skp_remove);

  ///////////////////////////////// done

  property chk_increase_wrptr;
    @(posedge writeclk) !full and (data_in != 10'h0f9 and data_in != 10'h306) |->##[1:2] (write_pointer == $past(
        write_pointer, 1
    ) + 1);
  endproperty

  wrptr_incr :
  assert property (chk_increase_wrptr)  // $display($stime,,, "\t\t %m PASS");
  else $display("Error");
  cvg_wptr_incr :
  cover property (chk_increase_wrptr);

  ///////////////////////////////// 

  property chk_no_add_remov_skp;
    @(posedge writeclk) !full and (data_in != 10'h0f9 and data_in != 10'h306) |=> !skpAdd and !skpRemove;
  endproperty

  no_skp :
  assert property (chk_no_add_remov_skp)  // $display($stime,,, "\t\t %m PASS");
  else $display("Error");
  cvg_no_skp :
  cover property (chk_no_add_remov_skp);





  property chk_empty;
    @(posedge readclk) (read_pointer == write_pointer) |-> ##1 empty;
  endproperty

  empty_chk :
  assert property (chk_empty)  // $display($stime,,, "\t\t %m PASS");
  else $display("Error");
  cvg_empty_chk :
  cover property (chk_empty);

  ////////////////////////////////////////////////////////////////////////

  sequence rd_detect(ptr); ##[0:$] (!empty && !addreq && (read_pointer == ptr)); endsequence


endmodule
