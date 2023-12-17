module synchronous_unit (
    rst_n,

    read_to_write_clk,
    gray_counter_read,
    gray_counter_read_out,

    write_to_read_clk,
    gray_counter_write,
    gray_counter_write_out
);
  parameter n = 4;
  input rst_n;
  input read_to_write_clk, write_to_read_clk;
  input [n:0] gray_counter_read, gray_counter_write;
  output reg [n:0] gray_counter_read_out, gray_counter_write_out;

  reg [n:0] gray_counter_read_reg1;
  reg [n:0] gray_counter_write_reg1;

  always @(posedge read_to_write_clk or negedge rst_n) begin
    if (!rst_n) begin
      gray_counter_read_reg1 <= 0;
      gray_counter_read_out  <= 0;
    end else begin
      gray_counter_read_reg1 <= gray_counter_read;
      gray_counter_read_out  <= gray_counter_read_reg1;
    end
  end

  always @(posedge write_to_read_clk or negedge rst_n) begin
    if (!rst_n) begin
      gray_counter_write_reg1 <= 0;
      gray_counter_write_out  <= 0;
    end else begin
      gray_counter_write_reg1 <= gray_counter_write;
      gray_counter_write_out  <= gray_counter_write_reg1;

    end
  end
endmodule
