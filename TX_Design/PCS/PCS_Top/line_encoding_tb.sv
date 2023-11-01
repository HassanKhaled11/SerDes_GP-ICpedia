/*Test plan:
-testing each element in the array the positive and negative encoding
-testing the disparity 
-checking the disparity toggles with each transmission
-check the reset doesn't affect the toggling
-enable_pma is high in the next clock cycle after the enable is high
*/

`timescale 1ps / 1ps
module line_encoding_tb ();
  import line_encoding_pkg::*;

  //associative arrays to store the values of encoding and compare them(golden model)
  logic [7:0] pos_encoding [bits_10];
  logic [7:0] neg_encoding [bits_10];

  //signals to to test the encoding block (line_coding_8_10)
  reg         enable;
  reg   [7:0] data;
  reg   [3:0] TXDataK;
  wire  [9:0] data_out_pos;
  wire  [9:0] data_out_neg;

  //reference out for comparison encoding block (line_coding_8_10)
  logic [7:0] data_out_ref;

  //signals to test the encoding after FSM
  reg         Bit_Rate_10;
  reg         Rst;
  wire        enable_PMA;
  wire  [9:0] data_out;

  int error_count, correct_count;
  int error_disparity_count, correct_disparity_count;
  int TESTS = 2000;

  //to store the last disparity to check it toggles
  disparity curr_disparity;

  line_encoding_transaction line_tr;
  line_coding_8_10 encoding_tb (
      .enable(enable),
      .TXDataK(TXDataK),
      .data(data),
      .encoded_data_pos(data_out_pos),
      .encoded_data_neg(data_out_neg)
  );

  Encoding final_encoding (
      .data(data),
      .enable(enable),
      .Bit_Rate_10(Bit_Rate_10),
      .Rst(Rst),
      .TXDataK(TXDataK),
      // input TxElecIdle          ,
      // input TxDetectRx_Loopback ,
      // input Tx_Compilance       ,				
      .enable_PMA(enable_PMA),
      .data_out(data_out)
  );

  bind Encoding assertion_encoding assertion_inst (
      Bit_Rate_10,
      Rst,
      enable_PMA,
      data_out,
      enable,
      data,
      TXDataK
  );

  initial begin
    Bit_Rate_10 = 0;
    forever #1000 Bit_Rate_10 = ~Bit_Rate_10;
  end

  initial begin
    correct_count           = 0;
    error_count             = 0;
    correct_disparity_count = 0;
    error_disparity_count   = 0;
    curr_disparity          = negative;
    line_tr                 = new();
    golden_model();
    for (int i = 0; i < TESTS; i++) begin
      assert (line_tr.randomize());
      //change the disparity after writting
      assign_signals();
      @(negedge Bit_Rate_10);
      line_tr.cvr_line.sample();
      //check on the output with the golden model
      check_val();
      check_disparity();
      if (Rst && enable) begin
        curr_disparity = (curr_disparity == negative) ? positive : negative;
      end
    end
    #1000;
    $display("correct count : ", correct_count, ", error count : ", error_count);
    $display("correct disparity count : ", correct_disparity_count, ", error disparity count : ",
             error_disparity_count);

    $stop;
  end

  task assign_signals();
    data    = line_tr.data;
    enable  = line_tr.enable;
    Rst     = line_tr.Rst;
    TXDataK = line_tr.TXDataK;

  endtask  //

  task check_val();
    if (enable == 0) begin
      data_out_ref = 8'b0;
    end else begin
      data_out_ref = line_tr.data;
    end
    if (neg_encoding.exists(data_out_neg) && pos_encoding.exists(data_out_pos)) begin
      if (neg_encoding[data_out_neg] !== data_out_ref || pos_encoding[data_out_pos] !== data_out_ref) begin
        error_count++;
        $display("neg_encoding[%0b]: %0d, pos_encoding[%0b]: %0d,data_ref: %0b", data_out_neg,
                 neg_encoding[data_out_neg], data_out_pos, pos_encoding[data_out_pos],
                 data_out_ref);
      end else correct_count++;

    end else begin
      error_count++;
      $display("NOT_FOUND!!!! data_in: (%0d)%0b, data_out_pos: %0b, data_out_neg: %0b", data, data,
               data_out_pos, data_out_pos);
    end

  endtask  //

  task check_disparity();
    if (enable == 0) begin
      data_out_ref = 8'b0;
    end else begin
      data_out_ref = line_tr.data;
    end
    if (curr_disparity == negative && neg_encoding.exists(data_out)) begin
      if (neg_encoding[data_out] !== data_out_ref) begin
        error_disparity_count++;
        $display("neg_encoding[%0b]: %0d,data_ref: %0b", data_out, neg_encoding[data_out],
                 data_out_ref);
      end else correct_disparity_count++;
    end else if (curr_disparity == positive && pos_encoding.exists(data_out)) begin
      if (pos_encoding[data_out] !== data_out_ref) begin
        error_disparity_count++;
        $display("pos_encoding[%0b]: %0d,data_ref: %0b", data_out, pos_encoding[data_out],
                 data_out_ref);
      end else correct_disparity_count++;
    end else begin
      error_disparity_count++;
      $display(
          "%0t,not in both!! disparity: %s, neg_encoding[%0b]: %0d, pos_encoding[%0b]: %0d,data_ref: (%0d)%0b",
          $time, curr_disparity, data_out, neg_encoding[data_out], data_out,
          pos_encoding[data_out], data_out_ref, data_out_ref);
    end

  endtask  //

  // task reset_task();
  //   Rst = 0;
  //   assign_signals();
  //   line_tr.cvr_line.sample();
  //   if (Rst && enable) begin
  //     curr_disparity = (curr_disparity == negative) ? positive : negative;
  //   end
  //   @(negedge Bit_Rate_10);
  //   Rst = 1;
  //   @(negedge Bit_Rate_10);
  // endtask  //

  task golden_model();
    ///////////////////////////////////////////
    /////////////negative encoding/////////////
    ///////////////////////////////////////////

    // data - negative
    neg_encoding[10'b10_0111_0100] = 8'b0000_0000;  //0
    neg_encoding[10'b01_1101_0100] = 8'b0000_0001;  //1
    neg_encoding[10'b10_1101_0100] = 8'b0000_0010;  //2
    neg_encoding[10'b11_0001_1011] = 8'b0000_0011;  //3
    neg_encoding[10'b11_0101_0100] = 8'b0000_0100;  //4
    neg_encoding[10'b10_1001_1011] = 8'b0000_0101;  //5
    neg_encoding[10'b01_1001_1011] = 8'b0000_0110;  //6
    neg_encoding[10'b11_1000_1011] = 8'b0000_0111;  //7
    neg_encoding[10'b11_1001_0100] = 8'b0000_1000;  //8
    neg_encoding[10'b10_0101_1011] = 8'b0000_1001;  //9
    neg_encoding[10'b01_0101_1011] = 8'b0000_1010;  //10
    neg_encoding[10'b11_0100_1011] = 8'b0000_1011;  //11
    neg_encoding[10'b00_1101_1011] = 8'b0000_1100;  //12
    neg_encoding[10'b10_1100_1011] = 8'b0000_1101;  //13
    neg_encoding[10'b01_1100_1011] = 8'b0000_1110;  //14
    neg_encoding[10'b01_0111_0100] = 8'b0000_1111;  //15
    neg_encoding[10'b01_1011_0100] = 8'b0001_0000;  //16
    neg_encoding[10'b10_0011_1011] = 8'b0001_0001;  //17
    neg_encoding[10'b01_0011_1011] = 8'b0001_0010;  //18
    neg_encoding[10'b11_0010_1011] = 8'b0001_0011;  //19
    neg_encoding[10'b00_1011_1011] = 8'b0001_0100;  //20
    neg_encoding[10'b10_1010_1011] = 8'b0001_0101;  //21
    neg_encoding[10'b01_1010_1011] = 8'b0001_0110;  //22
    neg_encoding[10'b11_1010_0100] = 8'b0001_0111;  //23
    neg_encoding[10'b11_0011_0100] = 8'b0001_1000;  //24
    neg_encoding[10'b10_0110_1011] = 8'b0001_1001;  //25
    neg_encoding[10'b01_0110_1011] = 8'b0001_1010;  //26
    neg_encoding[10'b11_0110_0100] = 8'b0001_1011;  //27
    neg_encoding[10'b00_1110_1011] = 8'b0001_1100;  //28
    neg_encoding[10'b10_1110_0100] = 8'b0001_1101;  //29
    neg_encoding[10'b01_1110_0100] = 8'b0001_1110;  //30
    neg_encoding[10'b10_1011_0100] = 8'b0001_1111;  //31
    neg_encoding[10'b10_0111_1001] = 8'b0010_0000;  //32
    neg_encoding[10'b01_1101_1001] = 8'b0010_0001;  //33
    neg_encoding[10'b10_1101_1001] = 8'b0010_0010;  //34
    neg_encoding[10'b11_0001_1001] = 8'b0010_0011;  //35
    neg_encoding[10'b11_0101_1001] = 8'b0010_0100;  //36
    neg_encoding[10'b10_1001_1001] = 8'b0010_0101;  //37
    neg_encoding[10'b01_1001_1001] = 8'b0010_0110;  //38
    neg_encoding[10'b11_1000_1001] = 8'b0010_0111;  //39
    neg_encoding[10'b11_1001_1001] = 8'b0010_1000;  //40
    neg_encoding[10'b10_0101_1001] = 8'b0010_1001;  //41
    neg_encoding[10'b01_0101_1001] = 8'b0010_1010;  //42
    neg_encoding[10'b11_0100_1001] = 8'b0010_1011;  //43
    neg_encoding[10'b00_1101_1001] = 8'b0010_1100;  //44
    neg_encoding[10'b10_1100_1001] = 8'b0010_1101;  //45
    neg_encoding[10'b01_1100_1001] = 8'b0010_1110;  //46
    neg_encoding[10'b01_0111_1001] = 8'b0010_1111;  //47
    neg_encoding[10'b01_1011_1001] = 8'b0011_0000;  //48
    neg_encoding[10'b10_0011_1001] = 8'b0011_0001;  //49
    neg_encoding[10'b01_0011_1001] = 8'b0011_0010;  //50
    neg_encoding[10'b11_0010_1001] = 8'b0011_0011;  //51
    neg_encoding[10'b00_1011_1001] = 8'b0011_0100;  //52
    neg_encoding[10'b10_1010_1001] = 8'b0011_0101;  //53
    neg_encoding[10'b01_1010_1001] = 8'b0011_0110;  //54
    neg_encoding[10'b11_1010_1001] = 8'b0011_0111;  //55
    neg_encoding[10'b11_0011_1001] = 8'b0011_1000;  //56
    neg_encoding[10'b10_0110_1001] = 8'b0011_1001;  //57
    neg_encoding[10'b01_0110_1001] = 8'b0011_1010;  //58
    neg_encoding[10'b11_0110_1001] = 8'b0011_1011;  //59
    neg_encoding[10'b00_1110_1001] = 8'b0011_1100;  //60
    neg_encoding[10'b10_1110_1001] = 8'b0011_1101;  //61
    neg_encoding[10'b01_1110_1001] = 8'b0011_1110;  //62
    neg_encoding[10'b10_1011_1001] = 8'b0011_1111;  //63
    neg_encoding[10'b10_0111_0101] = 8'b0100_0000;  //64
    neg_encoding[10'b01_1101_0101] = 8'b0100_0001;  //65
    neg_encoding[10'b10_1101_0101] = 8'b0100_0010;  //66
    neg_encoding[10'b11_0001_0101] = 8'b0100_0011;  //67
    neg_encoding[10'b11_0101_0101] = 8'b0100_0100;  //68
    neg_encoding[10'b10_1001_0101] = 8'b0100_0101;  //69
    neg_encoding[10'b01_1001_0101] = 8'b0100_0110;  //70
    neg_encoding[10'b11_1000_0101] = 8'b0100_0111;  //71
    neg_encoding[10'b11_1001_0101] = 8'b0100_1000;  //72
    neg_encoding[10'b10_0101_0101] = 8'b0100_1001;  //73
    neg_encoding[10'b01_0101_0101] = 8'b0100_1010;  //74
    neg_encoding[10'b11_0100_0101] = 8'b0100_1011;  //75
    neg_encoding[10'b00_1101_0101] = 8'b0100_1100;  //76
    neg_encoding[10'b10_1100_0101] = 8'b0100_1101;  //77
    neg_encoding[10'b01_1100_0101] = 8'b0100_1110;  //78
    neg_encoding[10'b01_0111_0101] = 8'b0100_1111;  //79
    neg_encoding[10'b01_1011_0101] = 8'b0101_0000;  //80
    neg_encoding[10'b10_0011_0101] = 8'b0101_0001;  //81
    neg_encoding[10'b01_0011_0101] = 8'b0101_0010;  //82
    neg_encoding[10'b11_0010_0101] = 8'b0101_0011;  //83
    neg_encoding[10'b00_1011_0101] = 8'b0101_0100;  //84
    neg_encoding[10'b10_1010_0101] = 8'b0101_0101;  //85
    neg_encoding[10'b01_1010_0101] = 8'b0101_0110;  //86
    neg_encoding[10'b11_1010_0101] = 8'b0101_0111;  //87
    neg_encoding[10'b11_0011_0101] = 8'b0101_1000;  //88
    neg_encoding[10'b10_0110_0101] = 8'b0101_1001;  //89
    neg_encoding[10'b01_0110_0101] = 8'b0101_1010;  //90
    neg_encoding[10'b11_0110_0101] = 8'b0101_1011;  //91
    neg_encoding[10'b00_1110_0101] = 8'b0101_1100;  //92
    neg_encoding[10'b10_1110_0101] = 8'b0101_1101;  //93
    neg_encoding[10'b01_1110_0101] = 8'b0101_1110;  //94
    neg_encoding[10'b10_1011_0101] = 8'b0101_1111;  //95
    neg_encoding[10'b10_0111_0011] = 8'b0110_0000;  //96
    neg_encoding[10'b01_1101_0011] = 8'b0110_0001;  //97
    neg_encoding[10'b10_1101_0011] = 8'b0110_0010;  //98
    neg_encoding[10'b11_0001_1100] = 8'b0110_0011;  //99
    neg_encoding[10'b11_0101_0011] = 8'b0110_0100;  //100
    neg_encoding[10'b10_1001_1100] = 8'b0110_0101;  //101
    neg_encoding[10'b01_1001_1100] = 8'b0110_0110;  //102
    neg_encoding[10'b11_1000_1100] = 8'b0110_0111;  //103
    neg_encoding[10'b11_1001_0011] = 8'b0110_1000;  //104
    neg_encoding[10'b10_0101_1100] = 8'b0110_1001;  //105
    neg_encoding[10'b01_0101_1100] = 8'b0110_1010;  //106
    neg_encoding[10'b11_0100_1100] = 8'b0110_1011;  //107
    neg_encoding[10'b00_1101_1100] = 8'b0110_1100;  //108
    neg_encoding[10'b10_1100_1100] = 8'b0110_1101;  //109
    neg_encoding[10'b01_1100_1100] = 8'b0110_1110;  //110
    neg_encoding[10'b01_0111_0011] = 8'b0110_1111;  //111
    neg_encoding[10'b01_1011_0011] = 8'b0111_0000;  //112
    neg_encoding[10'b10_0011_1100] = 8'b0111_0001;  //113
    neg_encoding[10'b01_0011_1100] = 8'b0111_0010;  //114
    neg_encoding[10'b11_0010_1100] = 8'b0111_0011;  //115
    neg_encoding[10'b00_1011_1100] = 8'b0111_0100;  //116
    neg_encoding[10'b10_1010_1100] = 8'b0111_0101;  //117
    neg_encoding[10'b01_1010_1100] = 8'b0111_0110;  //118
    neg_encoding[10'b11_1010_0011] = 8'b0111_0111;  //119
    neg_encoding[10'b11_0011_0011] = 8'b0111_1000;  //120
    neg_encoding[10'b10_0110_1100] = 8'b0111_1001;  //121
    neg_encoding[10'b01_0110_1100] = 8'b0111_1010;  //122
    neg_encoding[10'b11_0110_0011] = 8'b0111_1011;  //123
    neg_encoding[10'b00_1110_1100] = 8'b0111_1100;  //124
    neg_encoding[10'b10_1110_0011] = 8'b0111_1101;  //125
    neg_encoding[10'b01_1110_0011] = 8'b0111_1110;  //126
    neg_encoding[10'b10_1011_0011] = 8'b0111_1111;  //127
    neg_encoding[10'b10_0111_0010] = 8'b1000_0000;  //128
    neg_encoding[10'b01_1101_0010] = 8'b1000_0001;  //129
    neg_encoding[10'b10_1101_0010] = 8'b1000_0010;  //130
    neg_encoding[10'b11_0001_1101] = 8'b1000_0011;  //131
    neg_encoding[10'b11_0101_0010] = 8'b1000_0100;  //132
    neg_encoding[10'b10_1001_1101] = 8'b1000_0101;  //133
    neg_encoding[10'b01_1001_1101] = 8'b1000_0110;  //134
    neg_encoding[10'b11_1000_1101] = 8'b1000_0111;  //135
    neg_encoding[10'b11_1001_0010] = 8'b1000_1000;  //136
    neg_encoding[10'b10_0101_1101] = 8'b1000_1001;  //137
    neg_encoding[10'b01_0101_1101] = 8'b1000_1010;  //138
    neg_encoding[10'b11_0100_1101] = 8'b1000_1011;  //139
    neg_encoding[10'b00_1101_1101] = 8'b1000_1100;  //140
    neg_encoding[10'b10_1100_1101] = 8'b1000_1101;  //141
    neg_encoding[10'b01_1100_1101] = 8'b1000_1110;  //142
    neg_encoding[10'b01_0111_0010] = 8'b1000_1111;  //143
    neg_encoding[10'b01_1011_0010] = 8'b1001_0000;  //144
    neg_encoding[10'b10_0011_1101] = 8'b1001_0001;  //145
    neg_encoding[10'b01_0011_1101] = 8'b1001_0010;  //146
    neg_encoding[10'b11_0010_1101] = 8'b1001_0011;  //147
    neg_encoding[10'b00_1011_1101] = 8'b1001_0100;  //148
    neg_encoding[10'b10_1010_1101] = 8'b1001_0101;  //149
    neg_encoding[10'b01_1010_1101] = 8'b1001_0110;  //150
    neg_encoding[10'b11_1010_0010] = 8'b1001_0111;  //151
    neg_encoding[10'b11_0011_0010] = 8'b1001_1000;  //152
    neg_encoding[10'b10_0110_1101] = 8'b1001_1001;  //153
    neg_encoding[10'b01_0110_1101] = 8'b1001_1010;  //154
    neg_encoding[10'b11_0110_0010] = 8'b1001_1011;  //155
    neg_encoding[10'b00_1110_1101] = 8'b1001_1100;  //156
    neg_encoding[10'b10_1110_0010] = 8'b1001_1101;  //157
    neg_encoding[10'b01_1110_0010] = 8'b1001_1110;  //158
    neg_encoding[10'b10_1011_0010] = 8'b1001_1111;  //159
    neg_encoding[10'b10_0111_1010] = 8'b1010_0000;  //160
    neg_encoding[10'b01_1101_1010] = 8'b1010_0001;  //161
    neg_encoding[10'b10_1101_1010] = 8'b1010_0010;  //162
    neg_encoding[10'b11_0001_1010] = 8'b1010_0011;  //163
    neg_encoding[10'b11_0101_1010] = 8'b1010_0100;  //164
    neg_encoding[10'b10_1001_1010] = 8'b1010_0101;  //165
    neg_encoding[10'b01_1001_1010] = 8'b1010_0110;  //166
    neg_encoding[10'b11_1000_1010] = 8'b1010_0111;  //167
    neg_encoding[10'b11_1001_1010] = 8'b1010_1000;  //168
    neg_encoding[10'b10_0101_1010] = 8'b1010_1001;  //169
    neg_encoding[10'b01_0101_1010] = 8'b1010_1010;  //170
    neg_encoding[10'b11_0100_1010] = 8'b1010_1011;  //171
    neg_encoding[10'b00_1101_1010] = 8'b1010_1100;  //172
    neg_encoding[10'b10_1100_1010] = 8'b1010_1101;  //173
    neg_encoding[10'b01_1100_1010] = 8'b1010_1110;  //174
    neg_encoding[10'b01_0111_1010] = 8'b1010_1111;  //175
    neg_encoding[10'b01_1011_1010] = 8'b1011_0000;  //176
    neg_encoding[10'b10_0011_1010] = 8'b1011_0001;  //177
    neg_encoding[10'b01_0011_1010] = 8'b1011_0010;  //178
    neg_encoding[10'b11_0010_1010] = 8'b1011_0011;  //179
    neg_encoding[10'b00_1011_1010] = 8'b1011_0100;  //180
    neg_encoding[10'b10_1010_1010] = 8'b1011_0101;  //181
    neg_encoding[10'b01_1010_1010] = 8'b1011_0110;  //182
    neg_encoding[10'b11_1010_1010] = 8'b1011_0111;  //183
    neg_encoding[10'b11_0011_1010] = 8'b1011_1000;  //184
    neg_encoding[10'b10_0110_1010] = 8'b1011_1001;  //185
    neg_encoding[10'b01_0110_1010] = 8'b1011_1010;  //186
    neg_encoding[10'b11_0110_1010] = 8'b1011_1011;  //187
    neg_encoding[10'b00_1110_1010] = 8'b1011_1100;  //188
    neg_encoding[10'b10_1110_1010] = 8'b1011_1101;  //189
    neg_encoding[10'b01_1110_1010] = 8'b1011_1110;  //190
    neg_encoding[10'b10_1011_1010] = 8'b1011_1111;  //191
    neg_encoding[10'b10_0111_0110] = 8'b1100_0000;  //192
    neg_encoding[10'b01_1101_0110] = 8'b1100_0001;  //193
    neg_encoding[10'b10_1101_0110] = 8'b1100_0010;  //194
    neg_encoding[10'b11_0001_0110] = 8'b1100_0011;  //195
    neg_encoding[10'b11_0101_0110] = 8'b1100_0100;  //196
    neg_encoding[10'b10_1001_0110] = 8'b1100_0101;  //197
    neg_encoding[10'b01_1001_0110] = 8'b1100_0110;  //198
    neg_encoding[10'b11_1000_0110] = 8'b1100_0111;  //199
    neg_encoding[10'b11_1001_0110] = 8'b1100_1000;  //200
    neg_encoding[10'b10_0101_0110] = 8'b1100_1001;  //201
    neg_encoding[10'b01_0101_0110] = 8'b1100_1010;  //202
    neg_encoding[10'b11_0100_0110] = 8'b1100_1011;  //203
    neg_encoding[10'b00_1101_0110] = 8'b1100_1100;  //204
    neg_encoding[10'b10_1100_0110] = 8'b1100_1101;  //205
    neg_encoding[10'b01_1100_0110] = 8'b1100_1110;  //206
    neg_encoding[10'b01_0111_0110] = 8'b1100_1111;  //207
    neg_encoding[10'b01_1011_0110] = 8'b1101_0000;  //208
    neg_encoding[10'b10_0011_0110] = 8'b1101_0001;  //209
    neg_encoding[10'b01_0011_0110] = 8'b1101_0010;  //210
    neg_encoding[10'b11_0010_0110] = 8'b1101_0011;  //211
    neg_encoding[10'b00_1011_0110] = 8'b1101_0100;  //212
    neg_encoding[10'b10_1010_0110] = 8'b1101_0101;  //213
    neg_encoding[10'b01_1010_0110] = 8'b1101_0110;  //214
    neg_encoding[10'b11_1010_0110] = 8'b1101_0111;  //215
    neg_encoding[10'b11_0011_0110] = 8'b1101_1000;  //216
    neg_encoding[10'b10_0110_0110] = 8'b1101_1001;  //217
    neg_encoding[10'b01_0110_0110] = 8'b1101_1010;  //218
    neg_encoding[10'b11_0110_0110] = 8'b1101_1011;  //219
    neg_encoding[10'b00_1110_0110] = 8'b1101_1100;  //220
    neg_encoding[10'b10_1110_0110] = 8'b1101_1101;  //221
    neg_encoding[10'b01_1110_0110] = 8'b1101_1110;  //222
    neg_encoding[10'b10_1011_0110] = 8'b1101_1111;  //223
    neg_encoding[10'b10_0111_0001] = 8'b1110_0000;  //224
    neg_encoding[10'b01_1101_0001] = 8'b1110_0001;  //225
    neg_encoding[10'b10_1101_0001] = 8'b1110_0010;  //226
    neg_encoding[10'b11_0001_1110] = 8'b1110_0011;  //227
    neg_encoding[10'b11_0101_0001] = 8'b1110_0100;  //228
    neg_encoding[10'b10_1001_1110] = 8'b1110_0101;  //229
    neg_encoding[10'b01_1001_1110] = 8'b1110_0110;  //230
    neg_encoding[10'b11_1000_1110] = 8'b1110_0111;  //231
    neg_encoding[10'b11_1001_0001] = 8'b1110_1000;  //232
    neg_encoding[10'b10_0101_1110] = 8'b1110_1001;  //233
    neg_encoding[10'b01_0101_1110] = 8'b1110_1010;  //234
    neg_encoding[10'b11_0100_1110] = 8'b1110_1011;  //235
    neg_encoding[10'b00_1101_1110] = 8'b1110_1100;  //236
    neg_encoding[10'b10_1100_1110] = 8'b1110_1101;  //237
    neg_encoding[10'b01_1100_1110] = 8'b1110_1110;  //238
    neg_encoding[10'b01_0111_0001] = 8'b1110_1111;  //239
    neg_encoding[10'b01_1011_0001] = 8'b1111_0000;  //240
    neg_encoding[10'b10_0011_0111] = 8'b1111_0001;  //241
    neg_encoding[10'b01_0011_0111] = 8'b1111_0010;  //242
    neg_encoding[10'b11_0010_1110] = 8'b1111_0011;  //243
    neg_encoding[10'b00_1011_0111] = 8'b1111_0100;  //244
    neg_encoding[10'b10_1010_1110] = 8'b1111_0101;  //245
    neg_encoding[10'b01_1010_1110] = 8'b1111_0110;  //246
    neg_encoding[10'b11_1010_0001] = 8'b1111_0111;  //247
    neg_encoding[10'b11_0011_0001] = 8'b1111_1000;  //248
    neg_encoding[10'b10_0110_1110] = 8'b1111_1001;  //249
    neg_encoding[10'b01_0110_1110] = 8'b1111_1010;  //250
    neg_encoding[10'b11_0110_0001] = 8'b1111_1011;  //251
    neg_encoding[10'b00_1110_1110] = 8'b1111_1100;  //252
    neg_encoding[10'b10_1110_0001] = 8'b1111_1101;  //253
    neg_encoding[10'b01_1110_0001] = 8'b1111_1110;  //254
    neg_encoding[10'b10_1011_0001] = 8'b1111_1111;  //255

    ///////////////////////////////////////////
    /////////////positive encoding/////////////
    ///////////////////////////////////////////

    // data - positive
    pos_encoding[10'b01_1000_1011] = 8'b0000_0000;  //0
    pos_encoding[10'b10_0010_1011] = 8'b0000_0001;  //1
    pos_encoding[10'b01_0010_1011] = 8'b0000_0010;  //2
    pos_encoding[10'b11_0001_0100] = 8'b0000_0011;  //3
    pos_encoding[10'b00_1010_1011] = 8'b0000_0100;  //4
    pos_encoding[10'b10_1001_0100] = 8'b0000_0101;  //5
    pos_encoding[10'b01_1001_0100] = 8'b0000_0110;  //6
    pos_encoding[10'b00_0111_0100] = 8'b0000_0111;  //7
    pos_encoding[10'b00_0110_1011] = 8'b0000_1000;  //8
    pos_encoding[10'b10_0101_0100] = 8'b0000_1001;  //9
    pos_encoding[10'b01_0101_0100] = 8'b0000_1010;  //10
    pos_encoding[10'b11_0100_0100] = 8'b0000_1011;  //11
    pos_encoding[10'b00_1101_0100] = 8'b0000_1100;  //12
    pos_encoding[10'b10_1100_0100] = 8'b0000_1101;  //13
    pos_encoding[10'b01_1100_0100] = 8'b0000_1110;  //14
    pos_encoding[10'b10_1000_1011] = 8'b0000_1111;  //15
    pos_encoding[10'b10_0100_1011] = 8'b0001_0000;  //16
    pos_encoding[10'b10_0011_0100] = 8'b0001_0001;  //17
    pos_encoding[10'b01_0011_0100] = 8'b0001_0010;  //18
    pos_encoding[10'b11_0010_0100] = 8'b0001_0011;  //19
    pos_encoding[10'b00_1011_0100] = 8'b0001_0100;  //20
    pos_encoding[10'b10_1010_0100] = 8'b0001_0101;  //21
    pos_encoding[10'b01_1010_0100] = 8'b0001_0110;  //22
    pos_encoding[10'b00_0101_1011] = 8'b0001_0111;  //23
    pos_encoding[10'b00_1100_1011] = 8'b0001_1000;  //24
    pos_encoding[10'b10_0110_0100] = 8'b0001_1001;  //25
    pos_encoding[10'b01_0110_0100] = 8'b0001_1010;  //26
    pos_encoding[10'b00_1001_1011] = 8'b0001_1011;  //27
    pos_encoding[10'b00_1110_0100] = 8'b0001_1100;  //28
    pos_encoding[10'b01_0001_1011] = 8'b0001_1101;  //29
    pos_encoding[10'b10_0001_1011] = 8'b0001_1110;  //30
    pos_encoding[10'b01_0100_1011] = 8'b0001_1111;  //31
    pos_encoding[10'b01_1000_1001] = 8'b0010_0000;  //32
    pos_encoding[10'b10_0010_1001] = 8'b0010_0001;  //33
    pos_encoding[10'b01_0010_1001] = 8'b0010_0010;  //34
    pos_encoding[10'b11_0001_1001] = 8'b0010_0011;  //35
    pos_encoding[10'b00_1010_1001] = 8'b0010_0100;  //36
    pos_encoding[10'b10_1001_1001] = 8'b0010_0101;  //37
    pos_encoding[10'b01_1001_1001] = 8'b0010_0110;  //38
    pos_encoding[10'b00_0111_1001] = 8'b0010_0111;  //39
    pos_encoding[10'b00_0110_1001] = 8'b0010_1000;  //40
    pos_encoding[10'b10_0101_1001] = 8'b0010_1001;  //41
    pos_encoding[10'b01_0101_1001] = 8'b0010_1010;  //42
    pos_encoding[10'b11_0100_1001] = 8'b0010_1011;  //43
    pos_encoding[10'b00_1101_1001] = 8'b0010_1100;  //44
    pos_encoding[10'b10_1100_1001] = 8'b0010_1101;  //45
    pos_encoding[10'b01_1100_1001] = 8'b0010_1110;  //46
    pos_encoding[10'b10_1000_1001] = 8'b0010_1111;  //47
    pos_encoding[10'b10_0100_1001] = 8'b0011_0000;  //48
    pos_encoding[10'b10_0011_1001] = 8'b0011_0001;  //49
    pos_encoding[10'b01_0011_1001] = 8'b0011_0010;  //50
    pos_encoding[10'b11_0010_1001] = 8'b0011_0011;  //51
    pos_encoding[10'b00_1011_1001] = 8'b0011_0100;  //52
    pos_encoding[10'b10_1010_1001] = 8'b0011_0101;  //53
    pos_encoding[10'b01_1010_1001] = 8'b0011_0110;  //54
    pos_encoding[10'b00_0101_1001] = 8'b0011_0111;  //55
    pos_encoding[10'b00_1100_1001] = 8'b0011_1000;  //56
    pos_encoding[10'b10_0110_1001] = 8'b0011_1001;  //57
    pos_encoding[10'b01_0110_1001] = 8'b0011_1010;  //58
    pos_encoding[10'b00_1001_1001] = 8'b0011_1011;  //59
    pos_encoding[10'b00_1110_1001] = 8'b0011_1100;  //60
    pos_encoding[10'b01_0001_1001] = 8'b0011_1101;  //61
    pos_encoding[10'b10_0001_1001] = 8'b0011_1110;  //62
    pos_encoding[10'b01_0100_1001] = 8'b0011_1111;  //63
    pos_encoding[10'b01_1000_0101] = 8'b0100_0000;  //64
    pos_encoding[10'b10_0010_0101] = 8'b0100_0001;  //65
    pos_encoding[10'b01_0010_0101] = 8'b0100_0010;  //66
    pos_encoding[10'b11_0001_0101] = 8'b0100_0011;  //67
    pos_encoding[10'b00_1010_0101] = 8'b0100_0100;  //68
    pos_encoding[10'b10_1001_0101] = 8'b0100_0101;  //69
    pos_encoding[10'b01_1001_0101] = 8'b0100_0110;  //70
    pos_encoding[10'b00_0111_0101] = 8'b0100_0111;  //71
    pos_encoding[10'b00_0110_0101] = 8'b0100_1000;  //72
    pos_encoding[10'b10_0101_0101] = 8'b0100_1001;  //73
    pos_encoding[10'b01_0101_0101] = 8'b0100_1010;  //74
    pos_encoding[10'b11_0100_0101] = 8'b0100_1011;  //75
    pos_encoding[10'b00_1101_0101] = 8'b0100_1100;  //76
    pos_encoding[10'b10_1100_0101] = 8'b0100_1101;  //77
    pos_encoding[10'b01_1100_0101] = 8'b0100_1110;  //78
    pos_encoding[10'b10_1000_0101] = 8'b0100_1111;  //79
    pos_encoding[10'b10_0100_0101] = 8'b0101_0000;  //80
    pos_encoding[10'b10_0011_0101] = 8'b0101_0001;  //81
    pos_encoding[10'b01_0011_0101] = 8'b0101_0010;  //82
    pos_encoding[10'b11_0010_0101] = 8'b0101_0011;  //83
    pos_encoding[10'b00_1011_0101] = 8'b0101_0100;  //84
    pos_encoding[10'b10_1010_0101] = 8'b0101_0101;  //85
    pos_encoding[10'b01_1010_0101] = 8'b0101_0110;  //86
    pos_encoding[10'b00_0101_0101] = 8'b0101_0111;  //87
    pos_encoding[10'b00_1100_0101] = 8'b0101_1000;  //88
    pos_encoding[10'b10_0110_0101] = 8'b0101_1001;  //89
    pos_encoding[10'b01_0110_0101] = 8'b0101_1010;  //90
    pos_encoding[10'b00_1001_0101] = 8'b0101_1011;  //91
    pos_encoding[10'b00_1110_0101] = 8'b0101_1100;  //92
    pos_encoding[10'b01_0001_0101] = 8'b0101_1101;  //93
    pos_encoding[10'b10_0001_0101] = 8'b0101_1110;  //94
    pos_encoding[10'b01_0100_0101] = 8'b0101_1111;  //95
    pos_encoding[10'b01_1000_1100] = 8'b0110_0000;  //96
    pos_encoding[10'b10_0010_1100] = 8'b0110_0001;  //97
    pos_encoding[10'b01_0010_1100] = 8'b0110_0010;  //98
    pos_encoding[10'b11_0001_0011] = 8'b0110_0011;  //99
    pos_encoding[10'b00_1010_1100] = 8'b0110_0100;  //100
    pos_encoding[10'b10_1001_0011] = 8'b0110_0101;  //101
    pos_encoding[10'b01_1001_0011] = 8'b0110_0110;  //102
    pos_encoding[10'b00_0111_0011] = 8'b0110_0111;  //103
    pos_encoding[10'b00_0110_1100] = 8'b0110_1000;  //104
    pos_encoding[10'b10_0101_0011] = 8'b0110_1001;  //105
    pos_encoding[10'b01_0101_0011] = 8'b0110_1010;  //106
    pos_encoding[10'b11_0100_0011] = 8'b0110_1011;  //107
    pos_encoding[10'b00_1101_0011] = 8'b0110_1100;  //108
    pos_encoding[10'b10_1100_0011] = 8'b0110_1101;  //109
    pos_encoding[10'b01_1100_0011] = 8'b0110_1110;  //110
    pos_encoding[10'b10_1000_1100] = 8'b0110_1111;  //111
    pos_encoding[10'b10_0100_1100] = 8'b0111_0000;  //112
    pos_encoding[10'b10_0011_0011] = 8'b0111_0001;  //113
    pos_encoding[10'b01_0011_0011] = 8'b0111_0010;  //114
    pos_encoding[10'b11_0010_0011] = 8'b0111_0011;  //115
    pos_encoding[10'b00_1011_0011] = 8'b0111_0100;  //116
    pos_encoding[10'b10_1010_0011] = 8'b0111_0101;  //117
    pos_encoding[10'b01_1010_0011] = 8'b0111_0110;  //118
    pos_encoding[10'b00_0101_1100] = 8'b0111_0111;  //119
    pos_encoding[10'b00_1100_1100] = 8'b0111_1000;  //120
    pos_encoding[10'b10_0110_0011] = 8'b0111_1001;  //121
    pos_encoding[10'b01_0110_0011] = 8'b0111_1010;  //122
    pos_encoding[10'b00_1001_1100] = 8'b0111_1011;  //123
    pos_encoding[10'b00_1110_0011] = 8'b0111_1100;  //124
    pos_encoding[10'b01_0001_1100] = 8'b0111_1101;  //125
    pos_encoding[10'b10_0001_1100] = 8'b0111_1110;  //126
    pos_encoding[10'b01_0100_1100] = 8'b0111_1111;  //127
    pos_encoding[10'b01_1000_1101] = 8'b1000_0000;  //128
    pos_encoding[10'b10_0010_1101] = 8'b1000_0001;  //129
    pos_encoding[10'b01_0010_1101] = 8'b1000_0010;  //130
    pos_encoding[10'b11_0001_0010] = 8'b1000_0011;  //131
    pos_encoding[10'b00_1010_1101] = 8'b1000_0100;  //132
    pos_encoding[10'b10_1001_0010] = 8'b1000_0101;  //133
    pos_encoding[10'b01_1001_0010] = 8'b1000_0110;  //134
    pos_encoding[10'b00_0111_0010] = 8'b1000_0111;  //135
    pos_encoding[10'b00_0110_1101] = 8'b1000_1000;  //136
    pos_encoding[10'b10_0101_0010] = 8'b1000_1001;  //137
    pos_encoding[10'b01_0101_0010] = 8'b1000_1010;  //138
    pos_encoding[10'b11_0100_0010] = 8'b1000_1011;  //139
    pos_encoding[10'b00_1101_0010] = 8'b1000_1100;  //140
    pos_encoding[10'b10_1100_0010] = 8'b1000_1101;  //141
    pos_encoding[10'b01_1100_0010] = 8'b1000_1110;  //142
    pos_encoding[10'b10_1000_1101] = 8'b1000_1111;  //143
    pos_encoding[10'b10_0100_1101] = 8'b1001_0000;  //144
    pos_encoding[10'b10_0011_0010] = 8'b1001_0001;  //145
    pos_encoding[10'b01_0011_0010] = 8'b1001_0010;  //146
    pos_encoding[10'b11_0010_0010] = 8'b1001_0011;  //147
    pos_encoding[10'b00_1011_0010] = 8'b1001_0100;  //148
    pos_encoding[10'b10_1010_0010] = 8'b1001_0101;  //149
    pos_encoding[10'b01_1010_0010] = 8'b1001_0110;  //150
    pos_encoding[10'b00_0101_1101] = 8'b1001_0111;  //151
    pos_encoding[10'b00_1100_1101] = 8'b1001_1000;  //152
    pos_encoding[10'b10_0110_0010] = 8'b1001_1001;  //153
    pos_encoding[10'b01_0110_0010] = 8'b1001_1010;  //154
    pos_encoding[10'b00_1001_1101] = 8'b1001_1011;  //155
    pos_encoding[10'b00_1110_0010] = 8'b1001_1100;  //156
    pos_encoding[10'b01_0001_1101] = 8'b1001_1101;  //157
    pos_encoding[10'b10_0001_1101] = 8'b1001_1110;  //158
    pos_encoding[10'b01_0100_1101] = 8'b1001_1111;  //159
    pos_encoding[10'b01_1000_1010] = 8'b1010_0000;  //160
    pos_encoding[10'b10_0010_1010] = 8'b1010_0001;  //161
    pos_encoding[10'b01_0010_1010] = 8'b1010_0010;  //162
    pos_encoding[10'b11_0001_1010] = 8'b1010_0011;  //163
    pos_encoding[10'b00_1010_1010] = 8'b1010_0100;  //164
    pos_encoding[10'b10_1001_1010] = 8'b1010_0101;  //165
    pos_encoding[10'b01_1001_1010] = 8'b1010_0110;  //166
    pos_encoding[10'b00_0111_1010] = 8'b1010_0111;  //167
    pos_encoding[10'b00_0110_1010] = 8'b1010_1000;  //168
    pos_encoding[10'b10_0101_1010] = 8'b1010_1001;  //169
    pos_encoding[10'b01_0101_1010] = 8'b1010_1010;  //170
    pos_encoding[10'b11_0100_1010] = 8'b1010_1011;  //171
    pos_encoding[10'b00_1101_1010] = 8'b1010_1100;  //172
    pos_encoding[10'b10_1100_1010] = 8'b1010_1101;  //173
    pos_encoding[10'b01_1100_1010] = 8'b1010_1110;  //174
    pos_encoding[10'b10_1000_1010] = 8'b1010_1111;  //175
    pos_encoding[10'b10_0100_1010] = 8'b1011_0000;  //176
    pos_encoding[10'b10_0011_1010] = 8'b1011_0001;  //177
    pos_encoding[10'b01_0011_1010] = 8'b1011_0010;  //178
    pos_encoding[10'b11_0010_1010] = 8'b1011_0011;  //179
    pos_encoding[10'b00_1011_1010] = 8'b1011_0100;  //180
    pos_encoding[10'b10_1010_1010] = 8'b1011_0101;  //181
    pos_encoding[10'b01_1010_1010] = 8'b1011_0110;  //182
    pos_encoding[10'b00_0101_1010] = 8'b1011_0111;  //183
    pos_encoding[10'b00_1100_1010] = 8'b1011_1000;  //184
    pos_encoding[10'b10_0110_1010] = 8'b1011_1001;  //185
    pos_encoding[10'b01_0110_1010] = 8'b1011_1010;  //186
    pos_encoding[10'b00_1001_1010] = 8'b1011_1011;  //187
    pos_encoding[10'b00_1110_1010] = 8'b1011_1100;  //188
    pos_encoding[10'b01_0001_1010] = 8'b1011_1101;  //189
    pos_encoding[10'b10_0001_1010] = 8'b1011_1110;  //190
    pos_encoding[10'b01_0100_1010] = 8'b1011_1111;  //191
    pos_encoding[10'b01_1000_0110] = 8'b1100_0000;  //192
    pos_encoding[10'b10_0010_0110] = 8'b1100_0001;  //193
    pos_encoding[10'b01_0010_0110] = 8'b1100_0010;  //194
    pos_encoding[10'b11_0001_0110] = 8'b1100_0011;  //195
    pos_encoding[10'b00_1010_0110] = 8'b1100_0100;  //196
    pos_encoding[10'b10_1001_0110] = 8'b1100_0101;  //197
    pos_encoding[10'b01_1001_0110] = 8'b1100_0110;  //198
    pos_encoding[10'b00_0111_0110] = 8'b1100_0111;  //199
    pos_encoding[10'b00_0110_0110] = 8'b1100_1000;  //200
    pos_encoding[10'b10_0101_0110] = 8'b1100_1001;  //201
    pos_encoding[10'b01_0101_0110] = 8'b1100_1010;  //202
    pos_encoding[10'b11_0100_0110] = 8'b1100_1011;  //203
    pos_encoding[10'b00_1101_0110] = 8'b1100_1100;  //204
    pos_encoding[10'b10_1100_0110] = 8'b1100_1101;  //205
    pos_encoding[10'b01_1100_0110] = 8'b1100_1110;  //206
    pos_encoding[10'b10_1000_0110] = 8'b1100_1111;  //207
    pos_encoding[10'b10_0100_0110] = 8'b1101_0000;  //208
    pos_encoding[10'b10_0011_0110] = 8'b1101_0001;  //209
    pos_encoding[10'b01_0011_0110] = 8'b1101_0010;  //210
    pos_encoding[10'b11_0010_0110] = 8'b1101_0011;  //211
    pos_encoding[10'b00_1011_0110] = 8'b1101_0100;  //212
    pos_encoding[10'b10_1010_0110] = 8'b1101_0101;  //213
    pos_encoding[10'b01_1010_0110] = 8'b1101_0110;  //214
    pos_encoding[10'b00_0101_0110] = 8'b1101_0111;  //215
    pos_encoding[10'b00_1100_0110] = 8'b1101_1000;  //216
    pos_encoding[10'b10_0110_0110] = 8'b1101_1001;  //217
    pos_encoding[10'b01_0110_0110] = 8'b1101_1010;  //218
    pos_encoding[10'b00_1001_0110] = 8'b1101_1011;  //219
    pos_encoding[10'b00_1110_0110] = 8'b1101_1100;  //220
    pos_encoding[10'b01_0001_0110] = 8'b1101_1101;  //221
    pos_encoding[10'b10_0001_0110] = 8'b1101_1110;  //222
    pos_encoding[10'b01_0100_0110] = 8'b1101_1111;  //223
    pos_encoding[10'b01_1000_1110] = 8'b1110_0000;  //224
    pos_encoding[10'b10_0010_1110] = 8'b1110_0001;  //225
    pos_encoding[10'b01_0010_1110] = 8'b1110_0010;  //226
    pos_encoding[10'b11_0001_0001] = 8'b1110_0011;  //227
    pos_encoding[10'b00_1010_1110] = 8'b1110_0100;  //228
    pos_encoding[10'b10_1001_0001] = 8'b1110_0101;  //229
    pos_encoding[10'b01_1001_0001] = 8'b1110_0110;  //230
    pos_encoding[10'b00_0111_0001] = 8'b1110_0111;  //231
    pos_encoding[10'b00_0110_1110] = 8'b1110_1000;  //232
    pos_encoding[10'b10_0101_0001] = 8'b1110_1001;  //233
    pos_encoding[10'b01_0101_0001] = 8'b1110_1010;  //234
    pos_encoding[10'b11_0100_1000] = 8'b1110_1011;  //235
    pos_encoding[10'b00_1101_0001] = 8'b1110_1100;  //236
    pos_encoding[10'b10_1100_1000] = 8'b1110_1101;  //237
    pos_encoding[10'b01_1100_1000] = 8'b1110_1110;  //238
    pos_encoding[10'b10_1000_1110] = 8'b1110_1111;  //239
    pos_encoding[10'b10_0100_1110] = 8'b1111_0000;  //240
    pos_encoding[10'b10_0011_0001] = 8'b1111_0001;  //241
    pos_encoding[10'b01_0011_0001] = 8'b1111_0010;  //242
    pos_encoding[10'b11_0010_0001] = 8'b1111_0011;  //243
    pos_encoding[10'b00_1011_0001] = 8'b1111_0100;  //244
    pos_encoding[10'b10_1010_0001] = 8'b1111_0101;  //245
    pos_encoding[10'b01_1010_0001] = 8'b1111_0110;  //246
    pos_encoding[10'b00_0101_1110] = 8'b1111_0111;  //247
    pos_encoding[10'b00_1100_1110] = 8'b1111_1000;  //248
    pos_encoding[10'b10_0110_0001] = 8'b1111_1001;  //249
    pos_encoding[10'b01_0110_0001] = 8'b1111_1010;  //250
    pos_encoding[10'b00_1001_1110] = 8'b1111_1011;  //251
    pos_encoding[10'b00_1110_0001] = 8'b1111_1100;  //252
    pos_encoding[10'b01_0001_1110] = 8'b1111_1101;  //253
    pos_encoding[10'b10_0001_1110] = 8'b1111_1110;  //254
    pos_encoding[10'b01_0100_1110] = 8'b1111_1111;  //255


    ///////////////////////////////////////////
    /////////////commands encoding/////////////
    ///////////////////////////////////////////

    // special char - negative
    neg_encoding[10'b00_1111_0100] = 8'b0001_1100;
    neg_encoding[10'b00_1111_1001] = 8'b0011_1100;
    neg_encoding[10'b00_1111_0101] = 8'b0101_1100;
    neg_encoding[10'b00_1111_0011] = 8'b0111_1100;
    neg_encoding[10'b00_1111_0010] = 8'b1001_1100;
    neg_encoding[10'b00_1111_1010] = 8'b1011_1100;
    neg_encoding[10'b00_1111_0110] = 8'b1101_1100;
    neg_encoding[10'b00_1111_1000] = 8'b1111_1100;
    neg_encoding[10'b11_1010_1000] = 8'b1111_0111;
    neg_encoding[10'b11_0110_1000] = 8'b1111_1011;
    neg_encoding[10'b10_1110_1000] = 8'b1111_1101;
    neg_encoding[10'b01_1110_1000] = 8'b1111_1110;
    // special char - positive
    pos_encoding[10'b11_0000_1011] = 8'b0001_1100;
    pos_encoding[10'b11_0000_0110] = 8'b0011_1100;
    pos_encoding[10'b11_0000_1010] = 8'b0101_1100;
    pos_encoding[10'b11_0000_1100] = 8'b0111_1100;
    pos_encoding[10'b11_0000_1101] = 8'b1001_1100;
    pos_encoding[10'b11_0000_0101] = 8'b1011_1100;
    pos_encoding[10'b11_0000_1001] = 8'b1101_1100;
    pos_encoding[10'b11_0000_0111] = 8'b1111_1100;
    pos_encoding[10'b00_0101_0111] = 8'b1111_0111;
    pos_encoding[10'b00_1001_0111] = 8'b1111_1011;
    pos_encoding[10'b01_0001_0111] = 8'b1111_1101;
    pos_encoding[10'b10_0001_0111] = 8'b1111_1110;
  endtask  //
endmodule

