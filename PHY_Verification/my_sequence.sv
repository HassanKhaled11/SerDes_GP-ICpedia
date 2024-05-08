package my_sequence_pkg;

  import uvm_pkg::*;
  `include "uvm_macros.svh"

  import my_sequence_item_pkg::*;

  class my_sequence_32 extends uvm_sequence #(my_sequence_item);

    `uvm_object_utils(my_sequence_32);

    int              fd;
    my_sequence_item stim_seq_item;

    function new(string name = "my_sequence_32");
      super.new(name);
      `uvm_info("MY_SEQUENCE_32", "SEQ CREATED", UVM_MEDIUM);
      fd = $fopen("./MAC_TX_Data_Stim.hex", "a");
    endfunction


    task body();

      stim_seq_item = my_sequence_item::type_id::create("stim_seq_item");
      `uvm_info("MY_SEQUENCE_32", "BEFORE START ITEM", UVM_MEDIUM);

      stim_seq_item.MAC_TX_Data_TSEQ.constraint_mode(1);
      stim_seq_item.MAC_TX_Data_32c.constraint_mode(0);

      repeat (1500) begin
        start_item(stim_seq_item);
        assert (stim_seq_item.randomize());

        if (stim_seq_item.MAC_TX_Data != 32'hbcbcbcbc && stim_seq_item.MAC_TX_Data != 32'h4A4A4A4A) begin
          //  `uvm_info("FILE_IN", "AFTER FINISH ITEM", UVM_DEBUG);
          $fwrite(fd, "%h\n", stim_seq_item.MAC_TX_Data);
        end
        finish_item(stim_seq_item);
        get_response(stim_seq_item);
      end


      stim_seq_item.MAC_TX_Data_TSEQ.constraint_mode(0);
      stim_seq_item.MAC_TX_Data_32c.constraint_mode(1);


      repeat (3000) begin

        start_item(stim_seq_item);
        //`uvm_info("MY_SEQUENCE", "AFTER START ITEM", UVM_DEBUG);
        assert (stim_seq_item.randomize());

        if (stim_seq_item.MAC_TX_Data != 32'hbcbcbcbc) begin
          //  `uvm_info("FILE_IN", "AFTER FINISH ITEM", UVM_LOW);
          $fwrite(fd, "%h\n", stim_seq_item.MAC_TX_Data);
        end

        finish_item(stim_seq_item);
        get_response(stim_seq_item);


      end

      $fclose(fd);
    endtask
  endclass


  class my_sequence_16 extends uvm_sequence #(my_sequence_item);

    `uvm_object_utils(my_sequence_16);

    int              fd;
    my_sequence_item stim_seq_item;

    function new(string name = "my_sequence_16");
      super.new(name);
      `uvm_info("MY_SEQUENCE_16", "SEQ CREATED", UVM_MEDIUM);
      fd = $fopen("./MAC_TX_Data_Stim.hex", "a");
    endfunction


    task body();

      stim_seq_item = my_sequence_item::type_id::create("stim_seq_item");
      `uvm_info("MY_SEQUENCE_16", "BEFORE START ITEM", UVM_MEDIUM);


      stim_seq_item.MAC_TX_Data_TSEQ.constraint_mode(1);
      stim_seq_item.MAC_TX_Data_32c.constraint_mode(0);

      repeat (1500) begin
        start_item(stim_seq_item);
        assert (stim_seq_item.randomize());

        if (stim_seq_item.MAC_TX_Data[15:0] != 16'hbcbc && stim_seq_item.MAC_TX_Data[15:0] != 16'h4A4A) begin
          //  `uvm_info("FILE_IN", "AFTER FINISH ITEM", UVM_DEBUG);
          $fwrite(fd, "%h\n", {16'b0, stim_seq_item.MAC_TX_Data[15:0]});
        end
        finish_item(stim_seq_item);
        get_response(stim_seq_item);
      end


      stim_seq_item.MAC_TX_Data_TSEQ.constraint_mode(0);
      stim_seq_item.MAC_TX_Data_32c.constraint_mode(1);


      repeat (750) begin

        start_item(stim_seq_item);
        //`uvm_info("MY_SEQUENCE", "AFTER START ITEM", UVM_DEBUG);
        assert (stim_seq_item.randomize());

        if (stim_seq_item.MAC_TX_Data[15:0] != 16'hbcbc) begin
          //  `uvm_info("FILE_IN", "AFTER FINISH ITEM", UVM_LOW);
          $fwrite(fd, "%h\n", {16'b0, stim_seq_item.MAC_TX_Data[15:0]});
        end
        finish_item(stim_seq_item);
        get_response(stim_seq_item);
      end
      stim_seq_item.MAC_Data_En_c.constraint_mode(0);
      stim_seq_item.MAC_Data_En.rand_mode(0);
      #1000;
      stim_seq_item.MAC_Data_En = 0;
      repeat (500) begin

        start_item(stim_seq_item);
        //`uvm_info("MY_SEQUENCE", "AFTER START ITEM", UVM_DEBUG);
        assert (stim_seq_item.randomize());

        if (stim_seq_item.MAC_TX_Data[15:0] != 16'hbcbc) begin
          //  `uvm_info("FILE_IN", "AFTER FINISH ITEM", UVM_LOW);
          $fwrite(fd, "%h\n", {16'b0, stim_seq_item.MAC_TX_Data[15:0]});
        end
        finish_item(stim_seq_item);
        get_response(stim_seq_item);
      end
      #3000;
      stim_seq_item.MAC_Data_En = 1;

      stim_seq_item.MAC_Data_En.rand_mode(1);
      stim_seq_item.MAC_Data_En_c.constraint_mode(1);
      repeat (3000) begin

        start_item(stim_seq_item);
        //`uvm_info("MY_SEQUENCE", "AFTER START ITEM", UVM_DEBUG);
        assert (stim_seq_item.randomize());

        if (stim_seq_item.MAC_TX_Data[15:0] != 16'hbcbc) begin
          //  `uvm_info("FILE_IN", "AFTER FINISH ITEM", UVM_LOW);
          $fwrite(fd, "%h\n", {16'b0, stim_seq_item.MAC_TX_Data[15:0]});
        end
        finish_item(stim_seq_item);
        get_response(stim_seq_item);
      end

      $fclose(fd);
    endtask
  endclass

  class my_sequence_8 extends uvm_sequence #(my_sequence_item);

    `uvm_object_utils(my_sequence_8);

    int              fd;
    my_sequence_item stim_seq_item;

    function new(string name = "my_sequence_8");
      super.new(name);
      `uvm_info("MY_SEQUENCE_8", "SEQ CREATED", UVM_MEDIUM);
      fd = $fopen("./MAC_TX_Data_Stim.hex", "a");
    endfunction


    task body();

      stim_seq_item = my_sequence_item::type_id::create("stim_seq_item");
      `uvm_info("MY_SEQUENCE_8", "BEFORE START ITEM", UVM_MEDIUM);

      stim_seq_item.MAC_TX_Data_TSEQ.constraint_mode(1);
      stim_seq_item.MAC_TX_Data_32c.constraint_mode(0);

      repeat (1500) begin
        start_item(stim_seq_item);
        assert (stim_seq_item.randomize());

        if (stim_seq_item.MAC_TX_Data[7:0] != 8'hbc && stim_seq_item.MAC_TX_Data[7:0] != 8'h4A) begin
          //  `uvm_info("FILE_IN", "AFTER FINISH ITEM", UVM_DEBUG);
          $fwrite(fd, "%h\n", {24'b0, stim_seq_item.MAC_TX_Data[7:0]});
        end
        finish_item(stim_seq_item);
        get_response(stim_seq_item);
      end


      stim_seq_item.MAC_TX_Data_TSEQ.constraint_mode(0);
      stim_seq_item.MAC_TX_Data_32c.constraint_mode(1);


      repeat (3000) begin

        start_item(stim_seq_item);
        //`uvm_info("MY_SEQUENCE", "AFTER START ITEM", UVM_DEBUG);
        assert (stim_seq_item.randomize());

        if (stim_seq_item.MAC_TX_Data[7:0] != 8'hbc) begin
          //  `uvm_info("FILE_IN", "AFTER FINISH ITEM", UVM_LOW);
          $fwrite(fd, "%h\n", {24'b0, stim_seq_item.MAC_TX_Data[7:0]});
        end


        finish_item(stim_seq_item);
        get_response(stim_seq_item);


      end

      $fclose(fd);
    endtask
  endclass


endpackage
