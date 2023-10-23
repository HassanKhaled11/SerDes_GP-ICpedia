package my_scoreboard_pkg;

import uvm_pkg::*;
`include "uvm_macros.svh"


import my_sequence_item_pkg::*;
import PARAMETERS_pkg::*;


class my_scoreboard extends uvm_scoreboard;

`uvm_component_utils(my_scoreboard);

uvm_analysis_export   #(my_sequence_item) sb_export ;
// uvm_analysis_imp      #(my_sequence_item , my_scoreboard) sb_export ;
uvm_tlm_analysis_fifo #(my_sequence_item) sb_fifo   ;

virtual golden_if    gm_vif;
my_sequence_item     data_to_check                 ;
my_sequence_item     data_to_check_prev            ;


logic [9:0] data_collect ;
int collect_counter ;
int correct_count   ;
int error_count     ;
int clk_correct_count   ;
int clk_error_count     ;


function new(string name = "my_scoreboard" , uvm_component parent = null);
	super.new(name,parent);
	collect_counter   = 0 ;
	correct_count     = 0 ;
	error_count       = 0 ;
    data_collect      = 0 ;
    clk_correct_count = 0 ;
    clk_error_count   = 0 ;
endfunction


function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	sb_export = new("sb_export" , this);
	sb_fifo   = new("sb_fifo"   , this);
    data_to_check = new ("data_to_check");
    data_to_check_prev = new ("data_to_check_prev");

	if(!uvm_config_db#(virtual golden_if)::get(this, "", "gm_if",gm_vif))
		`uvm_fatal("MY_SCOREBOARD" , "FAILED GETTING gm_if_db");

	`uvm_info("MY_SCOREBOARD","BUILD_PHASE",UVM_MEDIUM);

endfunction 


function void connect_phase(uvm_phase phase);
	super.connect_phase(phase);
 sb_export.connect(sb_fifo.analysis_export);	
endfunction



// function void write(my_sequence_item  pkt);
// 	data_to_check = pkt ;
// endfunction




task run_phase(uvm_phase phase);
	super.run_phase(phase);

fork
	begin
     /////////////////////////////////////////////////////////////////////////
    ////////////////////// CHECKING TX_OUT  /////////////////////////////////
    /////////////////////////////////////////////////////////////////////////        
        forever begin	

          `uvm_info("MY_SCOREBOARD" ,"Data recieved", UVM_MEDIUM);
          `uvm_info("MY_SCOREBOARD--" , $sformatf("rst = %d , Data_in = %d , tx_data_en = %d , TX_Out = %d",data_to_check.Rst_n , data_to_check.Data_in , data_to_check.Tx_Data_Enable , data_to_check.TX_Out) , UVM_MEDIUM);    
 	
          sb_fifo.get(data_to_check);
          data_to_check_prev = data_to_check ;

           @(posedge gm_vif.Bit_Rate_10);


          if(gm_vif.TX_Out == data_to_check_prev.TX_Out)  begin
             `uvm_info("SUCEEDED TEST" , $sformatf("SUCCEDDED TEST , Expected_OUT = %d ,Data_collected = %d",gm_vif.TX_Out , data_to_check_prev.TX_Out) , UVM_MEDIUM);
              correct_count ++ ;
          end


          else begin
          `uvm_info("FAILED TEST" , $sformatf("FAILED TEST , Expected_OUT = %d ,Data_collected = %d",gm_vif.TX_Out , data_to_check_prev.TX_Out) , UVM_MEDIUM);
              error_count++ ;
          end


        end
 
    end

    /////////////////////////////////////////////////////////////////////////
    ///////////////// CHECKING CLOCK PERIDO /////////////////////////////////
    /////////////////////////////////////////////////////////////////////////

    begin
      forever begin
    	time t1 ;
    	time t2 ;
    
    	@(posedge gm_vif.Bit_Rate_10) t1 = $realtime();
    	@(posedge gm_vif.Bit_Rate_10) t2 = $realtime();
    
    	if((t2 - t1) == CLOCK_PERIOD) begin
    		`uvm_info("SUCEEDED CLK_PEDIOD", $sformatf("CLOCK PERIOD CHECKING , RIGHT PERIOD = %f",t2 - t1) , UVM_MEDIUM);
    		clk_correct_count++;
    	end
    
        else begin
        	`uvm_info("FAILED CLK_PEDIOD"  , $sformatf("CLOCK PERIOD CHECKING , WRONG PERIOD = %f",t2 - t1) , UVM_MEDIUM);
            clk_error_count++;
        end                 
      end
    	
    end
    
join


endtask


function void report_phase(uvm_phase phase);
	super.report_phase(phase);
	`uvm_info("MY_SCOREBOARD"      , $sformatf("CORRECT_COUNT = %d",correct_count)       , UVM_MEDIUM);
	`uvm_info("MY_SCOREBOARD"      , $sformatf("ERROR_COUNT   = %d",error_count)         , UVM_MEDIUM);
	`uvm_info("MY_SCOREBOARD"      , $sformatf("CORRECT_COUNT = %d",clk_correct_count)   , UVM_MEDIUM);
	`uvm_info("MY_SCOREBOARD"      , $sformatf("ERROR_COUNT   = %d",clk_error_count)     , UVM_MEDIUM);
endfunction




endclass	
endpackage	