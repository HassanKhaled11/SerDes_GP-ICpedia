package Enc_Dec_RAL_pkg;

import uvm_pkg::*;
`include "uvm_macros.svh"

//import encoding_env_pkg::*;
//import decoder_env_pkg::*;



`define create(type , inst_name)  type::type_id::create(inst_name);


/*================================================================
==================== REGISTERS & REG_FIELDS ======================
==================================================================*/


class Enc_Data_In_Reg extends uvm_reg ;
 `uvm_object_utils(Enc_Data_In_Reg);


rand uvm_reg_field Enc_Data_In_Reg_f ;


// covergroup Enc_Data_In_Reg_cg();
// 	option.per_instance = 1;

// 	coverpoint Enc_Data_In_Reg_f.value[7:0];
// endgroup


function new(string name = "Enc_Data_In_Reg");
	super.new(name , 8 , UVM_CVR_FIELD_VALS);

	// if(has_coverage(UVM_CVR_FIELD_VALS))begin
	// 	Enc_Data_In_Reg_cg = new();
	// end
endfunction


//------- TWO FUNCS FOR COV ----

// virtual function void sample(uvm_reg_data_t data , uvm_reg_data_t byte_en , bit is_read , uvm_reg_map map);
//   Enc_Data_In_Reg_cg.sample();
// endfunction


// virtual function void sample_values();
//  super.sample_values();                      // TO ENSURE ANY CONFIGURATIONS IN BASE CLASS IS PRESERVED AS DEFAULT
//  Enc_Data_In_Reg_cg.sample();
// endfunction

//-----------------------------


virtual function void build();
	Enc_Data_In_Reg_f = uvm_reg_field::type_id::create("Enc_Data_In_Reg_f");
	Enc_Data_In_Reg_f.configure(
  								   .parent(this) ,
    					           .lsb_pos(0)   ,
    					           .size(8)      ,
    					           .access("RW") ,
    					           .volatile(0)  ,
    					           .reset('h0)   ,
    					           .has_reset(1) ,
    					           .is_rand(1)   ,
    					           .individually_accessible(1));
endfunction

endclass


//************************************



class Enc_Pos_Out_Reg extends uvm_reg ;
 `uvm_object_utils(Enc_Pos_Out_Reg);


rand uvm_reg_field Enc_Pos_Out_Reg_f ;


// covergroup Enc_Pos_Out_Reg_cg();
// 	option.per_instance = 1;

// 	coverpoint Enc_Pos_Out_Reg_f.value[9:0];
// endgroup


function new(string name = "Enc_Pos_Out_Reg");
	super.new(name , 10 , UVM_CVR_FIELD_VALS);

	// if(has_coverage(UVM_CVR_FIELD_VALS))begin
	// 	Enc_Pos_Out_Reg_cg = new();
	// end
endfunction


//------- TWO FUNCS FOR COV ----

// virtual function void sample(uvm_reg_data_t data , uvm_reg_data_t byte_en , bit is_read , uvm_reg_map map);
//   Enc_Pos_Out_Reg_cg.sample();
// endfunction


// virtual function void sample_values();
//  super.sample_values();                      // TO ENSURE ANY CONFIGURATIONS IN BASE CLASS IS PRESERVED AS DEFAULT
//  Enc_Pos_Out_Reg_cg.sample();
// endfunction

//-----------------------------


virtual function void build();
	Enc_Pos_Out_Reg_f = uvm_reg_field::type_id::create("Enc_Pos_Out_Reg_f");
	Enc_Pos_Out_Reg_f.configure(
  								   .parent(this) ,
    					           .lsb_pos(0)   ,
    					           .size(10)     ,
    					           .access("RW") ,
    					           .volatile(0)  ,
    					           .reset('h0)   ,
    					           .has_reset(1) ,
    					           .is_rand(1)   ,
    					           .individually_accessible(1));
endfunction

endclass


//************************************


class Enc_Neg_Out_Reg extends uvm_reg ;
 `uvm_object_utils(Enc_Neg_Out_Reg);


rand uvm_reg_field Enc_Neg_Out_Reg_f ;


// covergroup Enc_Neg_Out_Reg_cg();
// 	option.per_instance = 1;

// 	coverpoint Enc_Neg_Out_Reg_f.value[9:0];
// endgroup


function new(string name = "Enc_Neg_Out_Reg");
	super.new(name , 10 , UVM_CVR_FIELD_VALS);

	// if(has_coverage(UVM_CVR_FIELD_VALS))begin
	// 	Enc_Neg_Out_Reg_cg = new();
	// end
endfunction


//------- TWO FUNCS FOR COV ----

// virtual function void sample(uvm_reg_data_t data , uvm_reg_data_t byte_en , bit is_read , uvm_reg_map map);
//   Enc_Neg_Out_Reg_cg.sample();
// endfunction


// virtual function void sample_values();
//  super.sample_values();                      // TO ENSURE ANY CONFIGURATIONS IN BASE CLASS IS PRESERVED AS DEFAULT
//  Enc_Neg_Out_Reg_cg.sample();
// endfunction

//-----------------------------


virtual function void build();
	Enc_Neg_Out_Reg_f = uvm_reg_field::type_id::create("Enc_Neg_Out_Reg_f");
	Enc_Neg_Out_Reg_f.configure(
  								   .parent(this) ,
    					           .lsb_pos(0)   ,
    					           .size(10)     ,
    					           .access("RW") ,
    					           .volatile(0)  ,
    					           .reset('h0)   ,
    					           .has_reset(1) ,
    					           .is_rand(1)   ,
    					           .individually_accessible(1));
endfunction

endclass



//************************************


class TX_DataK_Reg extends uvm_reg ;
 `uvm_object_utils(TX_DataK_Reg);


rand uvm_reg_field TX_DataK_Reg_f ;


// covergroup TX_DataK_Reg_cg();
// 	option.per_instance = 1;

// 	coverpoint TX_DataK_Reg_f.value[0];
// endgroup


function new(string name = "TX_DataK_Reg");
	super.new(name , 1 , UVM_CVR_FIELD_VALS);

	// if(has_coverage(UVM_CVR_FIELD_VALS))begin
	// 	TX_DataK_Reg_cg = new();
	// end
endfunction


//------- TWO FUNCS FOR COV ----

// virtual function void sample(uvm_reg_data_t data , uvm_reg_data_t byte_en , bit is_read , uvm_reg_map map);
//   TX_DataK_Reg_cg.sample();
// endfunction


// virtual function void sample_values();
//  super.sample_values();                      // TO ENSURE ANY CONFIGURATIONS IN BASE CLASS IS PRESERVED AS DEFAULT
//  TX_DataK_Reg_cg.sample();
// endfunction

//-----------------------------


virtual function void build();
	TX_DataK_Reg_f = uvm_reg_field::type_id::create("TX_DataK_Reg_f");
	TX_DataK_Reg_f.configure(
  								   .parent(this) ,
    					           .lsb_pos(0)   ,
    					           .size(1)      ,
    					           .access("RW") ,
    					           .volatile(0)  ,
    					           .reset('h0)   ,
    					           .has_reset(1) ,
    					           .is_rand(1)   ,
    					           .individually_accessible(1));
endfunction

endclass



//************************************


class Enable_Reg extends uvm_reg ;
 `uvm_object_utils(Enable_Reg);


rand uvm_reg_field Enable_Reg_f ;


covergroup Enable_Reg_cg();
	option.per_instance = 1;

	coverpoint Enable_Reg_f.value[0];
endgroup


function new(string name = "Enable_Reg");
	super.new(name , 1 , UVM_CVR_FIELD_VALS);

	// if(has_coverage(UVM_CVR_FIELD_VALS))begin
	// 	Enable_Reg_cg = new();
	// end
endfunction


//------- TWO FUNCS FOR COV ----

// virtual function void sample(uvm_reg_data_t data , uvm_reg_data_t byte_en , bit is_read , uvm_reg_map map);
//   Enable_Reg_cg.sample();
// endfunction


// virtual function void sample_values();
//  super.sample_values();                      // TO ENSURE ANY CONFIGURATIONS IN BASE CLASS IS PRESERVED AS DEFAULT
//  Enable_Reg_cg.sample();
// endfunction

//-----------------------------


virtual function void build();
	Enable_Reg_f = uvm_reg_field::type_id::create("Enable_Reg_f");
	Enable_Reg_f.configure(
  								   .parent(this) ,
    					           .lsb_pos(0)   ,
    					           .size(1)      ,
    					           .access("RW") ,
    					           .volatile(0)  ,
    					           .reset('h0)   ,
    					           .has_reset(1) ,
    					           .is_rand(1)   ,
    					           .individually_accessible(1));
endfunction

endclass



//************************************


class Dec_Data_In_Reg extends uvm_reg ;
 `uvm_object_utils(Dec_Data_In_Reg);


rand uvm_reg_field Dec_Data_In_Reg_f ;


// covergroup Dec_Data_In_Reg_cg();
// 	option.per_instance = 1;

// 	coverpoint Dec_Data_In_Reg_f.value[9:0];
// endgroup


function new(string name = "Dec_Data_In_Reg");
	super.new(name , 10 , UVM_CVR_FIELD_VALS);

	// if(has_coverage(UVM_CVR_FIELD_VALS))begin
	// 	Dec_Data_In_Reg_cg = new();
	// end
endfunction


//------- TWO FUNCS FOR COV ----

// virtual function void sample(uvm_reg_data_t data , uvm_reg_data_t byte_en , bit is_read , uvm_reg_map map);
//   Dec_Data_In_Reg_cg.sample();
// endfunction


// virtual function void sample_values();
//  super.sample_values();                      // TO ENSURE ANY CONFIGURATIONS IN BASE CLASS IS PRESERVED AS DEFAULT
//  Dec_Data_In_Reg_cg.sample();
// endfunction

//-----------------------------


virtual function void build();
	Dec_Data_In_Reg_f = uvm_reg_field::type_id::create("Dec_Data_In_Reg_f");
	Dec_Data_In_Reg_f.configure(
  								   .parent(this) ,
    					           .lsb_pos(0)   ,
    					           .size(10)     ,
    					           .access("RW") ,
    					           .volatile(0)  ,
    					           .reset('h0)   ,
    					           .has_reset(1) ,
    					           .is_rand(1)   ,
    					           .individually_accessible(1));
endfunction

endclass



//************************************


class Dec_Data_Out_Reg extends uvm_reg ;
 `uvm_object_utils(Dec_Data_Out_Reg);


rand uvm_reg_field Dec_Data_Out_Reg_f ;


// covergroup Dec_Data_Out_Reg_cg();
// 	option.per_instance = 1;

// 	coverpoint Dec_Data_Out_Reg_f.value[7:0];
// endgroup


function new(string name = "Dec_Data_Out_Reg");
	super.new(name , 8 , UVM_CVR_FIELD_VALS);

	// if(has_coverage(UVM_CVR_FIELD_VALS))
	//    	Dec_Data_Out_Reg_cg = new();
	
endfunction


//------- TWO FUNCS FOR COV ----

// virtual function void sample(uvm_reg_data_t data , uvm_reg_data_t byte_en , bit is_read , uvm_reg_map map);
//   Dec_Data_Out_Reg_cg.sample();
// endfunction


// virtual function void sample_values();
//  super.sample_values();                      // TO ENSURE ANY CONFIGURATIONS IN BASE CLASS IS PRESERVED AS DEFAULT
//  Dec_Data_Out_Reg_cg.sample();
// endfunction

//-----------------------------


virtual function void build();
	Dec_Data_Out_Reg_f = uvm_reg_field::type_id::create("Dec_Data_Out_Reg_f");
	Dec_Data_Out_Reg_f.configure(
  								   .parent(this) ,
    					           .lsb_pos(0)   ,
    					           .size(8)      ,
    					           .access("RW") ,
    					           .volatile(0)  ,
    					           .reset('h0)   ,
    					           .has_reset(1) ,
    					           .is_rand(1)   ,
    					           .individually_accessible(1));
endfunction

endclass



//************************************


class Dec_Neg_Out_Reg extends uvm_reg ;
 `uvm_object_utils(Dec_Neg_Out_Reg);


rand uvm_reg_field Dec_Neg_Out_Reg_f ;


// covergroup Dec_Neg_Out_Reg_cg();
// 	option.per_instance = 1;

// 	coverpoint Dec_Neg_Out_Reg_f.value[7:0];
// endgroup


function new(string name = "Dec_Neg_Out_Reg");
	super.new(name , 8 , UVM_CVR_FIELD_VALS);

	// if(has_coverage(UVM_CVR_FIELD_VALS))begin
	// 	Dec_Neg_Out_Reg_cg = new();
	// end
endfunction


//------- TWO FUNCS FOR COV ----

// virtual function void sample(uvm_reg_data_t data , uvm_reg_data_t byte_en , bit is_read , uvm_reg_map map);
//   Dec_Neg_Out_Reg_cg.sample();
// endfunction


// virtual function void sample_values();
//  super.sample_values();                      // TO ENSURE ANY CONFIGURATIONS IN BASE CLASS IS PRESERVED AS DEFAULT
//  Dec_Neg_Out_Reg_cg.sample();
// endfunction

//-----------------------------


virtual function void build();
	Dec_Neg_Out_Reg_f = uvm_reg_field::type_id::create("Dec_Neg_Out_Reg_f");
	Dec_Neg_Out_Reg_f.configure(
  								   .parent(this) ,
    					           .lsb_pos(0)   ,
    					           .size(8)      ,
    					           .access("RW") ,
    					           .volatile(0)  ,
    					           .reset('h0)   ,
    					           .has_reset(1) ,
    					           .is_rand(1)   ,
    					           .individually_accessible(1));
endfunction

endclass


//************************************


class Dec_Pos_Out_Reg extends uvm_reg ;
 `uvm_object_utils(Dec_Pos_Out_Reg);


rand uvm_reg_field Dec_Pos_Out_Reg_f ;


// covergroup Dec_Pos_Out_Reg_cg();
// 	option.per_instance = 1;

// 	coverpoint Dec_Pos_Out_Reg_f.value[7:0];
// endgroup


function new(string name = "Dec_Pos_Out_Reg");
	super.new(name , 8 , UVM_CVR_FIELD_VALS);

	// if(has_coverage(UVM_CVR_FIELD_VALS))begin
	// 	Dec_Pos_Out_Reg_cg = new();
	// end
endfunction


//------- TWO FUNCS FOR COV ----

// virtual function void sample(uvm_reg_data_t data , uvm_reg_data_t byte_en , bit is_read , uvm_reg_map map);
//   Dec_Pos_Out_Reg_cg.sample();
// endfunction


// virtual function void sample_values();
//  super.sample_values();                      // TO ENSURE ANY CONFIGURATIONS IN BASE CLASS IS PRESERVED AS DEFAULT
//  Dec_Pos_Out_Reg_cg.sample();
// endfunction

//-----------------------------


virtual function void build();
	Dec_Pos_Out_Reg_f = uvm_reg_field::type_id::create("Dec_Pos_Out_Reg_f");
	Dec_Pos_Out_Reg_f.configure(
  								   .parent(this) ,
    					           .lsb_pos(0)   ,
    					           .size(8)      ,
    					           .access("RW") ,
    					           .volatile(0)  ,
    					           .reset('h0)   ,
    					           .has_reset(1) ,
    					           .is_rand(1)   ,
    					           .individually_accessible(1));
endfunction

endclass



//************************************


class Dec_CLK_Reg extends uvm_reg ;
 `uvm_object_utils(Dec_CLK_Reg);


rand uvm_reg_field Dec_CLK_Reg_f ;


// covergroup Dec_CLK_Reg_cg();
// 	option.per_instance = 1;

// 	coverpoint Dec_CLK_Reg_f.value[9:0];
// endgroup


function new(string name = "Dec_CLK_Reg");
	super.new(name , 1 , UVM_CVR_FIELD_VALS);

	// if(has_coverage(UVM_CVR_FIELD_VALS))begin
	// 	Dec_CLK_Reg_cg = new();
	// end
endfunction


//------- TWO FUNCS FOR COV ----

// virtual function void sample(uvm_reg_data_t data , uvm_reg_data_t byte_en , bit is_read , uvm_reg_map map);
//   Dec_CLK_Reg_cg.sample();
// endfunction


// virtual function void sample_values();
//  super.sample_values();                      // TO ENSURE ANY CONFIGURATIONS IN BASE CLASS IS PRESERVED AS DEFAULT
//  Dec_CLK_Reg_cg.sample();
// endfunction

//-----------------------------


virtual function void build();
	Dec_CLK_Reg_f = uvm_reg_field::type_id::create("Dec_CLK_Reg_f");
	Dec_CLK_Reg_f.configure(
  								   .parent(this) ,
    					           .lsb_pos(0)   ,
    					           .size(1)      ,
    					           .access("RW") ,
    					           .volatile(0)  ,
    					           .reset('h0)   ,
    					           .has_reset(1) ,
    					           .is_rand(1)   ,
    					           .individually_accessible(1));
endfunction

endclass



//************************************


class Dec_RST_Reg extends uvm_reg ;
 `uvm_object_utils(Dec_RST_Reg);


rand uvm_reg_field Dec_RST_Reg_f ;


// covergroup Dec_RST_Reg_cg();
// 	option.per_instance = 1;

// 	coverpoint Dec_RST_Reg_f.value[9:0];
// endgroup


function new(string name = "Dec_RST_Reg");
	super.new(name , 1 , UVM_CVR_FIELD_VALS);

	// if(has_coverage(UVM_CVR_FIELD_VALS))begin
	// 	Dec_RST_Reg_cg = new();
	// end
endfunction


//------- TWO FUNCS FOR COV ----

// virtual function void sample(uvm_reg_data_t data , uvm_reg_data_t byte_en , bit is_read , uvm_reg_map map);
//   Dec_RST_Reg_cg.sample();
// endfunction


// virtual function void sample_values();
//  super.sample_values();                      // TO ENSURE ANY CONFIGURATIONS IN BASE CLASS IS PRESERVED AS DEFAULT
//  Dec_RST_Reg_cg.sample();
// endfunction

//-----------------------------


virtual function void build();
	Dec_RST_Reg_f = uvm_reg_field::type_id::create("Dec_RST_Reg_f");
	Dec_RST_Reg_f.configure(
  								   .parent(this) ,
    					           .lsb_pos(0)   ,
    					           .size(1)      ,
    					           .access("RW") ,
    					           .volatile(0)  ,
    					           .reset('h0)   ,
    					           .has_reset(1) ,
    					           .is_rand(1)   ,
    					           .individually_accessible(1));
endfunction

endclass

/*================================================================
======================== REGISTER BLOCK ==========================
==================================================================*/


class Reg_Block  extends uvm_reg_block;
	`uvm_object_utils(Reg_Block);


Enc_Data_In_Reg  Enc_Data_In_Reg_inst ;
Enc_Pos_Out_Reg  Enc_Pos_Out_Reg_inst ;
Enc_Neg_Out_Reg  Enc_Neg_Out_Reg_inst ;

Dec_Data_In_Reg  Dec_Data_In_Reg_inst ;
Dec_Data_Out_Reg Dec_Data_Out_Reg_inst;
Dec_Pos_Out_Reg  Dec_Pos_Out_Reg_inst ;
Dec_Neg_Out_Reg  Dec_Neg_Out_Reg_inst ;
Dec_CLK_Reg      Dec_CLK_Reg_inst     ;
Dec_RST_Reg      Dec_RST_Reg_inst     ;

Enable_Reg       Enable_Reg_inst      ;
TX_DataK_Reg     TX_DataK_Reg_inst    ;



function new(string name = "Reg_Block");
	super.new(name , UVM_CVR_FIELD_VALS);
endfunction


virtual function void build();
	
	  Enc_Data_In_Reg_inst = `create(Enc_Data_In_Reg , "Enc_Data_In_Reg_inst");
	  Enc_Data_In_Reg_inst.build();
	  Enc_Data_In_Reg_inst.configure(this,null);
    Enc_Data_In_Reg_inst.set_coverage(UVM_CVR_FIELD_VALS);	  

    Enc_Pos_Out_Reg_inst = `create(Enc_Pos_Out_Reg, "Enc_Pos_Out_Reg_inst")
    Enc_Pos_Out_Reg_inst.build();
    Enc_Pos_Out_Reg_inst.configure(this,null);
    Enc_Pos_Out_Reg_inst.set_coverage(UVM_CVR_FIELD_VALS);	  


    Enc_Neg_Out_Reg_inst = `create(Enc_Neg_Out_Reg , "Enc_Neg_Out_Reg_inst");
    Enc_Neg_Out_Reg_inst.build();
    Enc_Neg_Out_Reg_inst.configure(this,null);
    Enc_Neg_Out_Reg_inst.set_coverage(UVM_CVR_FIELD_VALS);	  


    TX_DataK_Reg_inst = `create(TX_DataK_Reg , "TX_DataK_Reg_inst");
    TX_DataK_Reg_inst.build();
    TX_DataK_Reg_inst.configure(this,null);
    TX_DataK_Reg_inst.set_coverage(UVM_CVR_FIELD_VALS);	  
    

    Enable_Reg_inst = `create(Enable_Reg , "Enable_Reg_inst");
    Enable_Reg_inst.build();
    Enable_Reg_inst.configure(this,null);
    Enable_Reg_inst.set_coverage(UVM_CVR_FIELD_VALS);	  


    Dec_Data_In_Reg_inst = `create(Dec_Data_In_Reg , "Dec_Data_In_Reg_inst");
    Dec_Data_In_Reg_inst.build();
    Dec_Data_In_Reg_inst.configure(this,null);
    Dec_Data_In_Reg_inst.set_coverage(UVM_CVR_FIELD_VALS);    
  

    Dec_Neg_Out_Reg_inst = `create(Dec_Neg_Out_Reg , "Dec_Neg_Out_Reg_inst");
    Dec_Neg_Out_Reg_inst.build();
    Dec_Neg_Out_Reg_inst.configure(this,null);
    Dec_Neg_Out_Reg_inst.set_coverage(UVM_CVR_FIELD_VALS);	  

    

    Dec_Pos_Out_Reg_inst = `create(Dec_Pos_Out_Reg , "Dec_Pos_Out_Reg_inst");
    Dec_Pos_Out_Reg_inst.build();
    Dec_Pos_Out_Reg_inst.configure(this,null);
    Dec_Pos_Out_Reg_inst.set_coverage(UVM_CVR_FIELD_VALS);	  
   


    Dec_CLK_Reg_inst = `create(Dec_CLK_Reg , "Dec_CLK_Reg_inst");
    Dec_CLK_Reg_inst.build();
    Dec_CLK_Reg_inst.configure(this,null);    
    Dec_CLK_Reg_inst.set_coverage(UVM_CVR_FIELD_VALS);	  


    Dec_RST_Reg_inst = `create(Dec_RST_Reg , "Dec_RST_Reg_inst");
    Dec_RST_Reg_inst.build();
    Dec_RST_Reg_inst.configure(this,null);
    Dec_RST_Reg_inst.set_coverage(UVM_CVR_FIELD_VALS);	  


  // uvm_reg::include_coverage("*" , UVM_CVR_ALL);        // ENABLING COVERAGE


////////// DEFINE BACKDOOR ACCESS ///////////
   add_hdl_path ("top.DUT.PCS_U" , "RTL");

   Enc_Data_In_Reg_inst.add_hdl_path_slice("PCS_TX_U.Encoding_U.line_coding_8_10_U.data" , 0 , 8); // THIS IS SLICE OF THE PATH PREV LINE 


   TX_DataK_Reg_inst.add_hdl_path_slice("PCS_TX_U.Encoding_U.line_coding_8_10_U.TXDataK" , 0 , 1);


   Enable_Reg_inst.add_hdl_path_slice("PCS_TX_U.Encoding_U.line_coding_8_10_U.enable" , 0 , 1);


   Enc_Pos_Out_Reg_inst.add_hdl_path_slice("PCS_TX_U.Encoding_U.line_coding_8_10_U.encoded_data_pos" , 0 , 10);

   
   Enc_Neg_Out_Reg_inst.add_hdl_path_slice("PCS_TX_U.Encoding_U.line_coding_8_10_U.encoded_data_neg" , 0 , 10);

   
   Dec_Data_In_Reg_inst.add_hdl_path_slice("PCS_RX_U.decode.Data_in", 0 , 10);


   Dec_Neg_Out_Reg_inst.add_hdl_path_slice("PCS_RX_U.decode.encoded_data_N", 0 , 8);


   Dec_Pos_Out_Reg_inst.add_hdl_path_slice("PCS_RX_U.decode.encoded_data_P", 0 , 8);


   Dec_CLK_Reg_inst.add_hdl_path_slice("PCS_RX_U.decode.CLK", 0 , 1);   


   Dec_RST_Reg_inst.add_hdl_path_slice("PCS_RX_U.decode.Rst_n", 0 , 1);   

/////////////////////////////////////////////   
   
   default_map = create_map("default_map" , 0 , 4 , UVM_LITTLE_ENDIAN);   // NAME , BASE , nBYTES , FIRST BYTE LSB
   
   default_map.add_reg(Enc_Data_In_Reg_inst , 'h0 , "RW");
   default_map.add_reg(Enc_Pos_Out_Reg_inst , 'h4 , "RW");
   default_map.add_reg(Enc_Neg_Out_Reg_inst , 'h8 , "RW");
   default_map.add_reg(Enable_Reg_inst      , 'hC , "RW");
   default_map.add_reg(TX_DataK_Reg_inst    , 'hD , "RW");
   // default_map.add_reg(Dec_Data_In_Reg_inst , 'd16, "RW");
   // default_map.add_reg(Dec_Pos_Out_Reg_inst , 'd20, "RW");
   // default_map.add_reg(Dec_Neg_Out_Reg_inst , 'd24, "RW");
   // default_map.add_reg(Dec_CLK_Reg_inst , 'd28 , "RW"); 
   // default_map.add_reg(Dec_RST_Reg_inst , 'd32 , "RW"); 


   default_map.set_auto_predict(0);         //DISABLE IMPLICIT PREDICTION	
   
   lock_model();          // LOCK ANY ADDITIONAL BUILD

 endfunction

endclass 



endpackage
