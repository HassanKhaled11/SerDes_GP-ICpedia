package my_sequence_pkg;

  import uvm_pkg::*;
  `include "uvm_macros.svh"

  import my_sequence_item_pkg::*;


  class my_sequence extends uvm_sequence #(my_sequence_item);

    `uvm_object_utils(my_sequence);

    int              fd;
    my_sequence_item stim_seq_item;

    function new(string name = "my_sequence");
      super.new(name);
      `uvm_info("MY_SEQUENCE", "SEQ CREATED", UVM_MEDIUM);
      fd = $fopen("./MAC_TX_Data_Stim.hex", "w");
    endfunction


    task body();

      stim_seq_item = my_sequence_item::type_id::create("stim_seq_item");
      `uvm_info("MY_SEQUENCE", "BEFORE START ITEM", UVM_MEDIUM);

      // stim_seq_item.MAC_TX_Data_16c.constraint_mode (0);    
      // stim_seq_item.MAC_TX_Data_8c.constraint_mode  (0);
      // stim_seq_item.MAC_TX_DataK_16c.constraint_mode(0);    
      // stim_seq_item.MAC_TX_DataK_8c.constraint_mode (0);

      // stim_seq_item.MAC_TX_Data_32c.constraint_mode (0);    
      // stim_seq_item.MAC_TX_Data_8c.constraint_mode  (0);
      // stim_seq_item.MAC_TX_DataK_32c.constraint_mode(0);    
      // stim_seq_item.MAC_TX_DataK_8c.constraint_mode (0);

      // stim_seq_item.MAC_TX_Data_32c.constraint_mode (0);    
      // stim_seq_item.MAC_TX_Data_16c.constraint_mode  (0);
      // stim_seq_item.MAC_TX_DataK_32c.constraint_mode(0);    
      // stim_seq_item.MAC_TX_DataK_16c.constraint_mode (0);

    
      stim_seq_item.MAC_TX_Data_TSEQ.constraint_mode(1);
      stim_seq_item.MAC_TX_Data_32c.constraint_mode(0) ;

      repeat(2000) begin
        start_item(stim_seq_item);
        assert(stim_seq_item.randomize());

        if (stim_seq_item.MAC_TX_Data != 32'hbcbcbcbc && stim_seq_item.MAC_TX_Data != 32'h4A4A4A4A) begin
          //  `uvm_info("FILE_IN", "AFTER FINISH ITEM", UVM_DEBUG);
            $fwrite(fd, "%h\n", stim_seq_item.MAC_TX_Data);
        end
         finish_item(stim_seq_item);
         get_response(stim_seq_item);
      end


      stim_seq_item.MAC_TX_Data_TSEQ.constraint_mode(0);
      stim_seq_item.MAC_TX_Data_32c.constraint_mode(1) ;
      

      repeat (500) begin

        start_item(stim_seq_item);
        //`uvm_info("MY_SEQUENCE", "AFTER START ITEM", UVM_DEBUG);
        assert (stim_seq_item.randomize());

        if (stim_seq_item.MAC_TX_Data != 32'hbcbcbcbc) begin
          //  `uvm_info("FILE_IN", "AFTER FINISH ITEM", UVM_LOW);
            $fwrite(fd, "%h\n", stim_seq_item.MAC_TX_Data);
        end
    
        // finish_item (stim_seq_item);
        // get_response(stim_seq_item);
        // //`uvm_info("MY_SEQUENCE", "AFTER FINISH ITEM", UVM_MEDIUM);

        // stim_seq_item.MAC_TX_Data  = 32'hBCBC_BCBC;
        // stim_seq_item.MAC_Data_En  = 1'b1;
        // stim_seq_item.MAC_TX_DataK = 4'b1111;
        // stim_seq_item.RxPolarity   = 0;


        // finish_item(stim_seq_item);
        // get_response(stim_seq_item);
      

        // start_item(stim_seq_item);
 
        // stim_seq_item.MAC_TX_Data  = 32'hae456781;
        // stim_seq_item.MAC_Data_En  = 1'b1;
        // stim_seq_item.MAC_TX_DataK = 0;
        // stim_seq_item.RxPolarity   = 0;


        // if (stim_seq_item.MAC_TX_Data != 32'hbcbcbcbc && stim_seq_item.MAC_TX_Data != 32'h4A4A4A4A) begin
        //   //  `uvm_info("FILE_IN", "AFTER FINISH ITEM", UVM_DEBUG);
        //     $fwrite(fd, "%h\n", stim_seq_item.MAC_TX_Data);
        // end


        finish_item(stim_seq_item);
        get_response(stim_seq_item);


      end

      $fclose(fd);
    endtask
  endclass



endpackage
