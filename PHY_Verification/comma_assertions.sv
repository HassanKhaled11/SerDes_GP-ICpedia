module comma_assertions (
    input       clk,
    input       rst_n,
    input       rx_valid,
    input       comma_pulse,
    input [2:0] COMMA_NUMBER,
    input [1:0] cs,
    input [1:0] ns,
    input [9:0] data,
    input       count_rst,
    input [5:0] count
);

  default disable iff (!rst_n);
  default clocking clk_5G @(posedge clk);
  endclocking

  ///////////////////////// checking FSM ///////////////////////////
  sequence cs_data1(cs_, data_1, data_2);
    (cs == cs_) and(data == data_1 or data == data_2);
  // (cs == cs_) and (data != data_1 and data != data_2);
  endsequence

  sequence cs_data2(cs_, data_1, data_2);
    // (cs == cs_) and (data == data_1 or data == data_2);
    (cs == cs_) and(data != data_1 and data != data_2);
  endsequence

  //////////////////////////////////////////////////////////////
  ///////////////////////// check transition from idle to comma

  property chk_idle;
    // (cs == 2'b00) and (data == 10'h0fa or data == 10'h305) |-> (ns == 2'b01);
    cs_data1(
        2'b00, 10'h0fa, 10'h305
    ) and(COMMA_NUMBER != 1) |-> (ns == 2'b01);
  endproperty

  idle_to_comma :
  assert property (chk_idle)  //$display($stime,,, "\t\t %m PASS");
  else $display("Error");
  cvg_idle_to_comma :
  cover property (chk_idle);

  ///////////////////////// check transition from idle to data

  property chk_data;
    // (cs == 2'b00) and (data == 10'h0fa or data == 10'h305) |-> (ns == 2'b01);
    cs_data1(
        2'b00, 10'h0fa, 10'h305
    ) and(COMMA_NUMBER == 1) |-> (ns == 2'b10);
  endproperty

  idle_to_data :
  assert property (chk_data)  //$display($stime,,, "\t\t %m PASS");
  else $display("Error");
  cvg_idle_to_data :
  cover property (chk_data);

  //////////////////////////////////////////////////////////////
  ///////////////////////// check transition from idle to idle
  property chk_idle_s;
    // (cs == 2'b00) and (data != 10'h0fa and data != 10'h305) |-> (ns == 2'b00);
    cs_data2(
        2'b00, 10'h0fa, 10'h305
    ) |-> (ns == 2'b00);
  endproperty

  idle_to_idle :
  assert property (chk_idle_s)  //$display($stime,,, "\t\t %m PASS");
  else $display("Error");
  cvg_idle_to_idle :
  cover property (chk_idle_s);




  ////////////////////////////////////////////////////////////////
  ///////////////////////// check comma with count to interrupt comma or data states 
  ///////////////////////// and go back to idle state

  property check_comma9_to_idle;
    cs_data2(
        2'b01, 10'h0fa, 10'h305
    ) and(count == 9) |-> (ns == 2'b00);
  endproperty

  property check_comma19_to_idle;
    cs_data2(
        2'b01, 10'h0fa, 10'h305
    ) and(count == 19) |-> (ns == 2'b00);
  endproperty

  property check_comma29_to_idle;
    cs_data2(
        2'b01, 10'h0fa, 10'h305
    ) and(count == 29) |-> (ns == 2'b00);
  endproperty

  property check_comma39_to_idle;
    cs_data2(
        2'b10, 10'h0fa, 10'h305
    ) and(count == 39) |-> (ns == 2'b00);
  endproperty

  comma9_idle :
  assert property (check_comma9_to_idle)  //$display($stime,,, "\t\t %m PASS");
  else $display("Error");
  cvg_comma9_idle :
  cover property (check_comma9_to_idle);

  comma19_idle :
  assert property (check_comma19_to_idle)  //$display($stime,,, "\t\t %m PASS");
  else $display("Error");
  cvg_comma19_idle :
  cover property (check_comma19_to_idle);

  comma29_idle :
  assert property (check_comma29_to_idle)  //$display($stime,,, "\t\t %m PASS");
  else $display("Error");
  cvg_comma29_idle :
  cover property (check_comma29_to_idle);

  comma39_idle :
  assert property (check_comma39_to_idle)  //$display($stime,,, "\t\t %m PASS");
  else $display("Error");
  cvg_comma39_idle :
  cover property (check_comma39_to_idle);



  ////////////////////////////////////////////////////////////////
  ///////////////////////// check comma with count to get correct comma data and  
  ///////////////////////// and go back to comma state
  property check_comma9_to_comma;
    cs_data1(
        2'b01, 10'h0fa, 10'h305
    ) and(count == 9) and(COMMA_NUMBER == 4) |-> (ns == 2'b01);
  endproperty

  property check_comma19_to_comma;
    cs_data1(
        2'b01, 10'h0fa, 10'h305
    ) and(count == 19) and(COMMA_NUMBER == 4) |-> (ns == 2'b01);
  endproperty

  property check_comma29_to_comma;
    cs_data1(
        2'b01, 10'h0fa, 10'h305
    ) and(count == 29) and(COMMA_NUMBER == 4) |-> (ns == 2'b10);
  endproperty


  comma9_comma :
  assert property (check_comma9_to_comma)  //$display($stime,,, "\t\t %m PASS");
  else $display("Error");
  cvg_comma9_comma :
  cover property (check_comma9_to_comma);

  comma19_comma :
  assert property (check_comma19_to_comma)  //$display($stime,,, "\t\t %m PASS");
  else $display("Error");
  cvg_comma19_comma :
  cover property (check_comma19_to_comma);

  comma29_comma :
  assert property (check_comma29_to_comma)  //$display($stime,,, "\t\t %m PASS");
  else $display("Error");
  cvg_comma29_comma :
  cover property (check_comma29_to_comma);


  // comma9_idle 	: assert property()
  // cvg_comma9_idle : cover  property()
  //////////////////////////////////////////////////////////////////////////////////
  ///////////////////////// check correct collecting comma data across comma state
  ///////////////////////// Fails for cases no comma data collected so return back 
  ///////////////////////// to idle state when it should keep in comma state for 
  ///////////////////////// the selected number of commas

  property chk_comma_state;
    // (cs == 2'b00) and (data != 10'h0fa and data != 10'h305) |-> (ns == 2'b00);
    (cs == 2'b01 and($past(
        cs, 1
    ) == 2'b00)) |-> ##9 (data == 10'h0fa or data == 10'h305);
  endproperty

  comma_state :
  assert property (chk_comma_state)  //$display($stime,,, "\t\t %m PASS");
  else $display("Error");
  cvg_comma_state :
  cover property (chk_comma_state);

  //////////////////////////////////////////////////////////////////////////////////
  ///////////////////////// check number of comma data collected across comma state
  ///////////////////////// Fails for cases no comma data collected so return back 
  ///////////////////////// to idle state when it should keep in comma state for 
  ///////////////////////// the selected number of commas
  sequence comma_num_4;  // hard coded sequence for num of comma = 4
    ##9  (data == 10'h0fa or data == 10'h305)
##10 (data == 10'h0fa or data == 10'h305)
##10 (data == 10'h0fa or data == 10'h305);
  endsequence

  property chk_comma_data_4;
    // (cs == 2'b00) and (data != 10'h0fa and data != 10'h305) |-> (ns == 2'b00);
    (cs == 2'b01 and($past(
        cs, 1
    ) == 2'b00) and(COMMA_NUMBER == 4)) |-> comma_num_4;
  endproperty

  comma_data_4 :
  assert property (chk_comma_data_4)  //$display($stime,,, "\t\t %m PASS");
  else $display("Error");
  cvg_comma_data_4 :
  cover property (chk_comma_data_4);

  //////////////////////////////////////////////////////////////////////////////////
  sequence comma_num_2;  // hard coded sequence for num of comma = 2
    ##9  (data == 10'h0fa or data == 10'h305);
  endsequence

  property chk_comma_data_2;
    // (cs == 2'b00) and (data != 10'h0fa and data != 10'h305) |-> (ns == 2'b00);
    (cs == 2'b01 and($past(
        cs, 1
    ) == 2'b00) and(COMMA_NUMBER == 2)) |-> comma_num_2;
  endproperty

  comma_data_2 :
  assert property (chk_comma_data_2)  //$display($stime,,, "\t\t %m PASS");
  else $display("Error");
  cvg_comma_data_2 :
  cover property (chk_comma_data_2);


  /////////////////////////////////////////////////////////////////////////////////////
  ///////////////////////////// check rising first comma pulse occured in data state

  property chk_comma_pulse;
    // (cs == 2'b00) and (data != 10'h0fa and data != 10'h305) |-> (ns == 2'b00);
    (cs == 2'b10 and($past(
        cs, 1
    ) == 2'b01)) |-> ##9 $rose(
        comma_pulse
    );
  endproperty

  comma_first_pulse :
  assert property (chk_comma_pulse)  //$display($stime,,, "\t\t %m PASS");
  else $display("Error");
  cvg_comma_pulse :
  cover property (chk_comma_pulse);


  /////////////////////////////////////////////////////////////////////////////////////
  ///////////////////////////// check complete comma pulse occured in data state

  property chk_complete_comma_pulse;
    // (cs == 2'b00) and (data != 10'h0fa and data != 10'h305) |-> (ns == 2'b00);
    $rose(
        comma_pulse
    ) |=> $fell(
        comma_pulse
    );
  endproperty

  comma_complete_first_pulse :
  assert property (chk_complete_comma_pulse)  //$display($stime,,, "\t\t %m PASS");
  else $display("Error");
  cvg_complete_comma_pulse :
  cover property (chk_complete_comma_pulse);

  /////////////////////////////////////////////////////////////////////////////////////
  /////////////////////////////// check rising of 4 pulses across data state
  sequence pulse_4;  // hard coded sequence for num of comma = 4
    ##9 $rose(
        comma_pulse
    ) ##1 $fell(
        comma_pulse
    ) ##9 $rose(
        comma_pulse
    ) ##1 $fell(
        comma_pulse
    ) ##9 $rose(
        comma_pulse
    ) ##1 $fell(
        comma_pulse
    ) ##9 $rose(
        comma_pulse
    ) ##1 $fell(
        comma_pulse
    );
  endsequence
  property check_4_pulses;
    (cs == 2'b10 and($past(
        cs, 1
    ) == 2'b01) and COMMA_NUMBER == 4) |-> pulse_4;
  endproperty

  comma_4_pulses :
  assert property (check_4_pulses)  //$display($stime,,, "\t\t %m PASS");
  else $display("Error");
  cvg_comma_4_pulses :
  cover property (check_4_pulses);

  /////////////////////////////// check rising of 2 pulses across data state
  sequence pulse_2;  // hard coded sequence for num of comma = 2
    ##9 $rose(
        comma_pulse
    ) ##1 $fell(
        comma_pulse
    ) ##9 $rose(
        comma_pulse
    ) ##1 $fell(
        comma_pulse
    );
  endsequence
  property check_2_pulses;
    (cs == 2'b10 and($past(
        cs, 1
    ) == 2'b01) and(COMMA_NUMBER == 2)) |-> pulse_2;
  endproperty

  comma_2_pulses :
  assert property (check_2_pulses)  //$display($stime,,, "\t\t %m PASS");
  else $display("Error");
  cvg_comma_2_pulses :
  cover property (check_2_pulses);

  /////////////////////////////// check rising of 1 pulses across data state
  sequence pulse_1;  // hard coded sequence for num of comma = 1
    ##9 $rose(
        comma_pulse
    ) ##1 $fell(
        comma_pulse
    );
  endsequence
  property check_1_pulses;
    (cs == 2'b10 and($past(
        cs, 1
    ) == 2'b00) and(COMMA_NUMBER == 1)) |-> pulse_1;
  endproperty

  comma_1_pulses :
  assert property (check_1_pulses)  //$display($stime,,, "\t\t %m PASS");
  else $display("Error");
  cvg_comma_1_pulses :
  cover property (check_1_pulses);


  ///////////////////////////////////// using repeat opertors with parameter num of repetition
  property check_4_repeated_pulses;
    (cs == 2'b10 and($past(
        cs, 1
    ) == 2'b01) and(COMMA_NUMBER == 4)) |-> comma_pulse [-> 4];
  endproperty
  comma_4_repeated_pulses :
  assert property (check_4_repeated_pulses)  //$display($stime,,, "\t\t %m PASS");
  else $display("Error");
  cvg_comma_4_repeated_pulses :
  cover property (check_4_repeated_pulses);
  ////////////////////////////////////////////////////////////////////////////////////////////////

  property check_2_repeated_pulses;
    (cs == 2'b10 and($past(
        cs, 1
    ) == 2'b01) and(COMMA_NUMBER == 2)) |-> comma_pulse [-> 2];
  endproperty
  comma_2_repeated_pulses :
  assert property (check_2_repeated_pulses)  //$display($stime,,, "\t\t %m PASS");
  else $display("Error");
  cvg_comma_2_repeated_pulses :
  cover property (check_2_repeated_pulses);
  ////////////////////////////////////////////////////////////////////////////////////////////////

  property check_1_repeated_pulses;
    (cs == 2'b10 and($past(
        cs, 1
    ) == 2'b01) and(COMMA_NUMBER == 1)) |-> comma_pulse [-> 1];
  endproperty
  comma_1_repeated_pulses :
  assert property (check_1_repeated_pulses)  // $display($stime,,, "\t\t %m PASS");
  else $display("Error");
  cvg_comma_1_repeated_pulses :
  cover property (check_1_repeated_pulses);
  ////////////////////////////////////////////////////////////////////////////////////////////////
  /////////////////////////////////////////// check the count reset flag /////////////////////////
  property chek_cnt_rst1;
    (ns == 2'b01 and($past(
        ns, 1
    ) == 2'b00)) |-> $rose(
        count_rst
    ) ##1 $fell(
        count_rst
    );
  endproperty

  property chek_cnt_rst2;
    (ns == 2'b10 and($past(
        ns, 1
    ) == 2'b01)) |-> $rose(
        count_rst
    ) ##1 $fell(
        count_rst
    );
  endproperty

  cnt_rst_1 :
  assert property (chek_cnt_rst1)  // $display($stime,,, "\t\t %m PASS");
  else $display("Error");
  cvg_cnt_rst1 :
  cover property (chek_cnt_rst1);

  cnt_rst_2 :
  assert property (chek_cnt_rst2)  // $display($stime,,, "\t\t %m PASS");
  else $display("Error");
  cvg_cnt_rst2 :
  cover property (chek_cnt_rst2);



  ////////////////////////////////////////////// check rx valid signal //////////////////////////////
  property chk_rx_vld;
    $rose(
        comma_pulse
    ) |-> $rose(
        rx_valid
    );
  endproperty

  property chk_rx_vld_f;
    $rose(
        comma_pulse
    ) |=> $fell(
        rx_valid
    );
  endproperty

  property chk_rx_vld_c;
    (cs == 2'b10) and(count == 9 or count == 19 or count == 29 or count == 39) |-> $rose(
        rx_valid
    ) ##1 $fell(
        rx_valid
    );
  endproperty

  rxvalid_rising :
  assert property (chk_rx_vld)  // $display($stime,,, "\t\t %m PASS");
  else $display("Error");
  cvg_rxvalid_rising :
  cover property (chk_rx_vld);

  rxvalid_falling :
  assert property (chk_rx_vld_f)  // $display($stime,,, "\t\t %m PASS");
  else $display("Error");
  cvg_rxvalid_falling :
  cover property (chk_rx_vld_f);

  rxvalid_conut_chk :
  assert property (chk_rx_vld_c)  // $display($stime,,, "\t\t %m PASS");
  else $display("Error");
  cvg_rxvld_cnt_chk :
  cover property (chk_rx_vld_c);



endmodule
