module decode_tb();
reg CLK;
reg Rst_n;
reg [9:0] Data_in;
wire [7:0] Data_out;
wire DecodeError;
wire DisparityError;
wire RxDataK;
integer i;


decoder Dut(.*);

initial begin
    CLK = 0;
    forever #5 CLK = ~CLK;
end 
initial begin
    Rst_n = 1'b1;
    @(negedge CLK);
    Rst_n = 1'b0;
    @(negedge CLK);
    Rst_n = 1'b1;
    for(i = 0;i<100 ; i=i+1) begin
      Data_in = $random();
      @(negedge CLK);
    end
    repeat(2) @(negedge CLK);
    $stop();
end 
endmodule 