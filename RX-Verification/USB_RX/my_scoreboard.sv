package my_scoreboard_pkg;

import uvm_pkg::*             ;
`include "uvm_macros.svh"

import my_sequence_item_pkg::*;
import PARAMETERS_PKG::*      ;


class my_scoreboard extends uvm_scoreboard;

`uvm_component_utils(my_scoreboard);

uvm_analysis_export   #(my_sequence_item) sb_export ;
uvm_tlm_analysis_fifo #(my_sequence_item) sb_fifo   ;

 // uvm_analysis_imp      #(my_sequence_item , my_scoreboard) sb_export ;

virtual BFM_if bfm_vif                              ;
virtual INTERNALS_if internals_if                   ;

my_sequence_item     data_to_check                  ;

int fd ,fd2       ;
int correct_count ;
int error_count   ;

logic [31:0] temp0               ;
logic [31:0] Queue_Data [$]      ;
logic [31:0] Queue_Expec_Data[$] ;

logic [9 : 0] Coma_collection    ;

realtime t1,t2,t3,t4,t5,t6       ;

function new(string name = "my_scoreboard" , uvm_component parent = null);
	super.new(name,parent);
	fd = 0;
	fd2= 0;
	t1 = 0;
	t2 = 0;
	t3 = 0;
	t4 = 0;
	t5 = 0;
	t6 = 0;
	Coma_collection = 10'h0;
endfunction


  // function void write(my_sequence_item  pkt);
  // 	data_to_check = pkt ;
  // endfunction


function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	sb_export     = new("sb_export" , this);
	sb_fifo       = new("sb_fifo"   , this);
  data_to_check = new ("data_to_check");

    if(!uvm_config_db#(virtual INTERNALS_if)::get(this,"","internals_if", internals_if))
  `uvm_fatal("MY_TEST" , "FATAL PUTTING INTERNALS INTERFACE in CONFIG_DB");

   if(!uvm_config_db#(virtual BFM_if)::get(this,"","bfm_if", bfm_vif))
  `uvm_fatal("MY_TEST" , "FATAL PUTTING INTERNALS INTERFACE in CONFIG_DB");

	`uvm_info("MY_SCOREBOARD","BUILD_PHASE",UVM_MEDIUM);
endfunction 


function void connect_phase(uvm_phase phase);
	super.connect_phase(phase);
   sb_export.connect(sb_fifo.analysis_export);	
endfunction


// function void end_of_elaboration_phase (uvm_phase phase);
//   super.end_of_elaboration_phase (phase);                          //  OPEN FILE
//       fd  = $fopen("./MAC_TX_Data_Stim.hex","r");
//       fd2 = $fopen("./PHY_OUT.hex","w");
// endfunction



task run_phase(uvm_phase phase);
	super.run_phase(phase);

     forever begin                                     //Collect Outs in Queue after Comma Detection
        sb_fifo.get(data_to_check);
        //@(internals_if.Bit_CLK);
         `uvm_info("CAPTURED DATA",$sformatf(" DATA = %h",data_to_check.Rx_Data),UVM_MEDIUM) ;
    	   `uvm_info("MY_SCOREBOARD","SOREBOARD's CAPTURING",UVM_MEDIUM);
         //`uvm_info("MY_SCOREBOARD", "")

       end  

endtask




function void report_phase(uvm_phase phase);
	super.report_phase(phase);

endfunction



endclass	

endpackage	