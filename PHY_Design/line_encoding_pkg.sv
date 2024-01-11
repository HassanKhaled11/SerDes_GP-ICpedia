package line_encoding_pkg;
  typedef enum bit {
    negative,
    positive
  } disparity;
  typedef logic [9:0] bits_10;
  //   typedef logic [7:0] bits_8;
  class line_encoding_transaction;
    rand logic [7:0] data;
    rand logic enable;
    rand logic [3:0] TXDataK;
    rand logic Rst;

    bit [7:0] line_command[] = '{
        8'h1C,
        8'h3C,
        8'h5C,
        8'h7C,
        8'h9C,
        8'hBC,
        8'hDC,
        8'hFC,
        8'hF7,
        8'hFB,
        8'hFD,
        8'hFE
    };
    // wire enable_PMA;
    // wire [9:0] data_out;
    // constraint Rst_con {
    //   Rst dist {
    //     1 := 99,
    //     0 := 1
    //   };
    // }
    constraint enable_con {
      enable dist {
        1 := 90,
        0 := 10
      };
    }

    constraint rst_con {
      Rst dist {
        1 := 95,
        0 := 5
      };
    }
    //to be only data

    constraint data_val {data inside {[0 : 255]};}
    //to be only cmd
    // constraint command_val {data inside {line_command};}
    covergroup cvr_line;
      option.auto_bin_max = 512;
      coverpoint data;
    endgroup

    function new();
      cvr_line = new();
    endfunction  //new()
  endclass  //line_encoding_transaction

endpackage
