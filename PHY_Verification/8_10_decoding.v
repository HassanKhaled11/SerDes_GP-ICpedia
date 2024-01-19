module decoder(
  	input 			    CLK           ,
    input 			    Rst_n         ,
    input     [9:0] Data_in       ,
    output reg[7:0] Data_out      ,
    output reg   		DecodeError   ,
    output reg			DisparityError,
    output reg      RxDataK
);

reg [9:0] temp;
reg[7:0] encoded_data_N;
reg[7:0] encoded_data_P;
reg DecodeError_N,DecodeError_P;
reg RxDataK_N , RxDataK_P;
reg flag , flag_n , flag_p; 

always @(posedge CLK or negedge Rst_n) begin
  if (!Rst_n) begin
    flag <= 1'b0;
	  temp <= 10'b0; // cause decode error 
  end else begin
    flag <= ~flag;
	temp <= Data_in;
  end
end 

always @(*) begin
		RxDataK_N = 1'b0;
		DecodeError_N = 1'b0;
		flag_n = 1'b0 ;

		      case(temp) 
		      	10'b10_0111_0100 : begin encoded_data_N =  8'b0000_0000; flag_n = 1'b1; end //0
		      	10'b01_1101_0100 : begin encoded_data_N =  8'b0000_0001; flag_n = 1'b1; end //1
		      	10'b10_1101_0100 : begin encoded_data_N =  8'b0000_0010; flag_n = 1'b1; end //2
		      	10'b11_0001_1011 : begin encoded_data_N =  8'b0000_0011; flag_n = 1'b1; end //3
		      	10'b11_0101_0100 : begin encoded_data_N =  8'b0000_0100; flag_n = 1'b1; end //4
		      	10'b10_1001_1011 : begin encoded_data_N =  8'b0000_0101; flag_n = 1'b1; end //5
		      	10'b01_1001_1011 : begin encoded_data_N =  8'b0000_0110; flag_n = 1'b1; end //6
		      	10'b11_1000_1011 : begin encoded_data_N =  8'b0000_0111; flag_n = 1'b1; end //7
		      	10'b11_1001_0100 : begin encoded_data_N =  8'b0000_1000; flag_n = 1'b1; end //8
		      	10'b10_0101_1011 : begin encoded_data_N =  8'b0000_1001; flag_n = 1'b1; end //9
		      	10'b01_0101_1011 : begin encoded_data_N =  8'b0000_1010; flag_n = 1'b1; end //10
		      	10'b11_0100_1011 : begin encoded_data_N =  8'b0000_1011; flag_n = 1'b1; end //11
		      	10'b00_1101_1011 : begin encoded_data_N =  8'b0000_1100; flag_n = 1'b1; end //12
		      	10'b10_1100_1011 : begin encoded_data_N =  8'b0000_1101; flag_n = 1'b1; end //13
		      	10'b01_1100_1011 : begin encoded_data_N =  8'b0000_1110; flag_n = 1'b1; end //14
		      	10'b01_0111_0100 : begin encoded_data_N =  8'b0000_1111; flag_n = 1'b1; end //15
		      	10'b01_1011_0100 : begin encoded_data_N =  8'b0001_0000; flag_n = 1'b1; end //16
		      	10'b10_0011_1011 : begin encoded_data_N =  8'b0001_0001; flag_n = 1'b1; end //17
		      	10'b01_0011_1011 : begin encoded_data_N =  8'b0001_0010; flag_n = 1'b1; end //18
		      	10'b11_0010_1011 : begin encoded_data_N =  8'b0001_0011; flag_n = 1'b1; end //19
		      	10'b00_1011_1011 : begin encoded_data_N =  8'b0001_0100; flag_n = 1'b1; end //20
		      	10'b10_1010_1011 : begin encoded_data_N =  8'b0001_0101; flag_n = 1'b1; end //21
		      	10'b01_1010_1011 : begin encoded_data_N =  8'b0001_0110; flag_n = 1'b1; end //22
		      	10'b11_1010_0100 : begin encoded_data_N =  8'b0001_0111; flag_n = 1'b1; end //23
		      	10'b11_0011_0100 : begin encoded_data_N =  8'b0001_1000; flag_n = 1'b1; end //24
		      	10'b10_0110_1011 : begin encoded_data_N =  8'b0001_1001; flag_n = 1'b1; end //25
		      	10'b01_0110_1011 : begin encoded_data_N =  8'b0001_1010; flag_n = 1'b1; end //26
		      	10'b11_0110_0100 : begin encoded_data_N =  8'b0001_1011; flag_n = 1'b1; end //27
		      	10'b00_1110_1011 : begin encoded_data_N =  8'b0001_1100; flag_n = 1'b1; end //28
		      	10'b10_1110_0100 : begin encoded_data_N =  8'b0001_1101; flag_n = 1'b1; end //29
		      	10'b01_1110_0100 : begin encoded_data_N =  8'b0001_1110; flag_n = 1'b1; end //30
		      	10'b10_1011_0100 : begin encoded_data_N =  8'b0001_1111; flag_n = 1'b1; end //31
		      	10'b10_0111_1001 : begin encoded_data_N =  8'b0010_0000; flag_n = 1'b1; end //32
		      	10'b01_1101_1001 : begin encoded_data_N =  8'b0010_0001; flag_n = 1'b1; end //33
		      	10'b10_1101_1001 : begin encoded_data_N =  8'b0010_0010; flag_n = 1'b1; end //34
		      	10'b11_0001_1001 : begin encoded_data_N =  8'b0010_0011; flag_n = 1'b1; end //35
		      	10'b11_0101_1001 : begin encoded_data_N =  8'b0010_0100; flag_n = 1'b1; end //36
		      	10'b10_1001_1001 : begin encoded_data_N =  8'b0010_0101; flag_n = 1'b1; end //37
		      	10'b01_1001_1001 : begin encoded_data_N =  8'b0010_0110; flag_n = 1'b1; end //38
		      	10'b11_1000_1001 : begin encoded_data_N =  8'b0010_0111; flag_n = 1'b1; end //39
		      	10'b11_1001_1001 : begin encoded_data_N =  8'b0010_1000; flag_n = 1'b1; end //40
		      	10'b10_0101_1001 : begin encoded_data_N =  8'b0010_1001; flag_n = 1'b1; end //41
		      	10'b01_0101_1001 : begin encoded_data_N =  8'b0010_1010; flag_n = 1'b1; end //42
		      	10'b11_0100_1001 : begin encoded_data_N =  8'b0010_1011; flag_n = 1'b1; end //43
		      	10'b00_1101_1001 : begin encoded_data_N =  8'b0010_1100; flag_n = 1'b1; end //44
		      	10'b10_1100_1001 : begin encoded_data_N =  8'b0010_1101; flag_n = 1'b1; end //45
		      	10'b01_1100_1001 : begin encoded_data_N =  8'b0010_1110; flag_n = 1'b1; end //46
		      	10'b01_0111_1001 : begin encoded_data_N =  8'b0010_1111; flag_n = 1'b1; end //47
		      	10'b01_1011_1001 : begin encoded_data_N =  8'b0011_0000; flag_n = 1'b1; end //48
		      	10'b10_0011_1001 : begin encoded_data_N =  8'b0011_0001; flag_n = 1'b1; end //49
		      	10'b01_0011_1001 : begin encoded_data_N =  8'b0011_0010; flag_n = 1'b1; end //50
		      	10'b11_0010_1001 : begin encoded_data_N =  8'b0011_0011; flag_n = 1'b1; end //51
		      	10'b00_1011_1001 : begin encoded_data_N =  8'b0011_0100; flag_n = 1'b1; end //52
		      	10'b10_1010_1001 : begin encoded_data_N =  8'b0011_0101; flag_n = 1'b1; end //53
		      	10'b01_1010_1001 : begin encoded_data_N =  8'b0011_0110; flag_n = 1'b1; end //54
		      	10'b11_1010_1001 : begin encoded_data_N =  8'b0011_0111; flag_n = 1'b1; end //55
		      	10'b11_0011_1001 : begin encoded_data_N =  8'b0011_1000; flag_n = 1'b1; end //56
		      	10'b10_0110_1001 : begin encoded_data_N =  8'b0011_1001; flag_n = 1'b1; end //57
		      	10'b01_0110_1001 : begin encoded_data_N =  8'b0011_1010; flag_n = 1'b1; end //58
		      	10'b11_0110_1001 : begin encoded_data_N =  8'b0011_1011; flag_n = 1'b1; end //59
		      	10'b00_1110_1001 : begin encoded_data_N =  8'b0011_1100; flag_n = 1'b1; end //60
		      	10'b10_1110_1001 : begin encoded_data_N =  8'b0011_1101; flag_n = 1'b1; end //61
		      	10'b01_1110_1001 : begin encoded_data_N =  8'b0011_1110; flag_n = 1'b1; end //62
		      	10'b10_1011_1001 : begin encoded_data_N =  8'b0011_1111; flag_n = 1'b1; end //63
		      	10'b10_0111_0101 : begin encoded_data_N =  8'b0100_0000; flag_n = 1'b1; end //64
		      	10'b01_1101_0101 : begin encoded_data_N =  8'b0100_0001; flag_n = 1'b1; end //65
		      	10'b10_1101_0101 : begin encoded_data_N =  8'b0100_0010; flag_n = 1'b1; end //66
		      	10'b11_0001_0101 : begin encoded_data_N =  8'b0100_0011; flag_n = 1'b1; end //67
		      	10'b11_0101_0101 : begin encoded_data_N =  8'b0100_0100; flag_n = 1'b1; end //68
		      	10'b10_1001_0101 : begin encoded_data_N =  8'b0100_0101; flag_n = 1'b1; end //69
		      	10'b01_1001_0101 : begin encoded_data_N =  8'b0100_0110; flag_n = 1'b1; end //70
		      	10'b11_1000_0101 : begin encoded_data_N =  8'b0100_0111; flag_n = 1'b1; end //71
		      	10'b11_1001_0101 : begin encoded_data_N =  8'b0100_1000; flag_n = 1'b1; end //72
		      	10'b10_0101_0101 : begin encoded_data_N =  8'b0100_1001; flag_n = 1'b1; end //73
		      	10'b01_0101_0101 : begin encoded_data_N =  8'b0100_1010; flag_n = 1'b1; end //74
		      	10'b11_0100_0101 : begin encoded_data_N =  8'b0100_1011; flag_n = 1'b1; end //75
		      	10'b00_1101_0101 : begin encoded_data_N =  8'b0100_1100; flag_n = 1'b1; end //76
		      	10'b10_1100_0101 : begin encoded_data_N =  8'b0100_1101; flag_n = 1'b1; end //77
		      	10'b01_1100_0101 : begin encoded_data_N =  8'b0100_1110; flag_n = 1'b1; end //78
		      	10'b01_0111_0101 : begin encoded_data_N =  8'b0100_1111; flag_n = 1'b1; end //79
		      	10'b01_1011_0101 : begin encoded_data_N =  8'b0101_0000; flag_n = 1'b1; end //80
		      	10'b10_0011_0101 : begin encoded_data_N =  8'b0101_0001; flag_n = 1'b1; end //81
		      	10'b01_0011_0101 : begin encoded_data_N =  8'b0101_0010; flag_n = 1'b1; end //82
		      	10'b11_0010_0101 : begin encoded_data_N =  8'b0101_0011; flag_n = 1'b1; end //83
		      	10'b00_1011_0101 : begin encoded_data_N =  8'b0101_0100; flag_n = 1'b1; end //84
		      	10'b10_1010_0101 : begin encoded_data_N =  8'b0101_0101; flag_n = 1'b1; end //85
		      	10'b01_1010_0101 : begin encoded_data_N =  8'b0101_0110; flag_n = 1'b1; end //86
		      	10'b11_1010_0101 : begin encoded_data_N =  8'b0101_0111; flag_n = 1'b1; end //87
		      	10'b11_0011_0101 : begin encoded_data_N =  8'b0101_1000; flag_n = 1'b1; end //88
		      	10'b10_0110_0101 : begin encoded_data_N =  8'b0101_1001; flag_n = 1'b1; end //89
		      	10'b01_0110_0101 : begin encoded_data_N =  8'b0101_1010; flag_n = 1'b1; end //90
		      	10'b11_0110_0101 : begin encoded_data_N =  8'b0101_1011; flag_n = 1'b1; end //91
		      	10'b00_1110_0101 : begin encoded_data_N =  8'b0101_1100; flag_n = 1'b1; end //92
		      	10'b10_1110_0101 : begin encoded_data_N =  8'b0101_1101; flag_n = 1'b1; end //93
		      	10'b01_1110_0101 : begin encoded_data_N =  8'b0101_1110; flag_n = 1'b1; end //94
		      	10'b10_1011_0101 : begin encoded_data_N =  8'b0101_1111; flag_n = 1'b1; end //95
		      	10'b10_0111_0011 : begin encoded_data_N =  8'b0110_0000; flag_n = 1'b1; end //96
		      	10'b01_1101_0011 : begin encoded_data_N =  8'b0110_0001; flag_n = 1'b1; end //97
		      	10'b10_1101_0011 : begin encoded_data_N =  8'b0110_0010; flag_n = 1'b1; end //98
		      	10'b11_0001_1100 : begin encoded_data_N =  8'b0110_0011; flag_n = 1'b1; end //99
		      	10'b11_0101_0011 : begin encoded_data_N =  8'b0110_0100; flag_n = 1'b1; end //100
		      	10'b10_1001_1100 : begin encoded_data_N =  8'b0110_0101; flag_n = 1'b1; end //101
		      	10'b01_1001_1100 : begin encoded_data_N =  8'b0110_0110; flag_n = 1'b1; end //102
		      	10'b11_1000_1100 : begin encoded_data_N =  8'b0110_0111; flag_n = 1'b1; end //103
		      	10'b11_1001_0011 : begin encoded_data_N =  8'b0110_1000; flag_n = 1'b1; end //104
		      	10'b10_0101_1100 : begin encoded_data_N =  8'b0110_1001; flag_n = 1'b1; end //105
		      	10'b01_0101_1100 : begin encoded_data_N =  8'b0110_1010; flag_n = 1'b1; end //106
		      	10'b11_0100_1100 : begin encoded_data_N =  8'b0110_1011; flag_n = 1'b1; end //107
		      	10'b00_1101_1100 : begin encoded_data_N =  8'b0110_1100; flag_n = 1'b1; end //108
		      	10'b10_1100_1100 : begin encoded_data_N =  8'b0110_1101; flag_n = 1'b1; end //109
		      	10'b01_1100_1100 : begin encoded_data_N =  8'b0110_1110; flag_n = 1'b1; end //110
		      	10'b01_0111_0011 : begin encoded_data_N =  8'b0110_1111; flag_n = 1'b1; end //111
		      	10'b01_1011_0011 : begin encoded_data_N =  8'b0111_0000; flag_n = 1'b1; end //112
		      	10'b10_0011_1100 : begin encoded_data_N =  8'b0111_0001; flag_n = 1'b1; end //113
		      	10'b01_0011_1100 : begin encoded_data_N =  8'b0111_0010; flag_n = 1'b1; end //114
		      	10'b11_0010_1100 : begin encoded_data_N =  8'b0111_0011; flag_n = 1'b1; end //115
		      	10'b00_1011_1100 : begin encoded_data_N =  8'b0111_0100; flag_n = 1'b1; end //116
		      	10'b10_1010_1100 : begin encoded_data_N =  8'b0111_0101; flag_n = 1'b1; end //117
		      	10'b01_1010_1100 : begin encoded_data_N =  8'b0111_0110; flag_n = 1'b1; end //118
		      	10'b11_1010_0011 : begin encoded_data_N =  8'b0111_0111; flag_n = 1'b1; end //119
		      	10'b11_0011_0011 : begin encoded_data_N =  8'b0111_1000; flag_n = 1'b1; end //120
		      	10'b10_0110_1100 : begin encoded_data_N =  8'b0111_1001; flag_n = 1'b1; end //121
		      	10'b01_0110_1100 : begin encoded_data_N =  8'b0111_1010; flag_n = 1'b1; end //122
		      	10'b11_0110_0011 : begin encoded_data_N =  8'b0111_1011; flag_n = 1'b1; end //123
		      	10'b00_1110_1100 : begin encoded_data_N =  8'b0111_1100; flag_n = 1'b1; end //124
		      	10'b10_1110_0011 : begin encoded_data_N =  8'b0111_1101; flag_n = 1'b1; end //125
		      	10'b01_1110_0011 : begin encoded_data_N =  8'b0111_1110; flag_n = 1'b1; end //126
		      	10'b10_1011_0011 : begin encoded_data_N =  8'b0111_1111; flag_n = 1'b1; end //127
		      	10'b10_0111_0010 : begin encoded_data_N =  8'b1000_0000; flag_n = 1'b1; end //128
		      	10'b01_1101_0010 : begin encoded_data_N =  8'b1000_0001; flag_n = 1'b1; end //129
		      	10'b10_1101_0010 : begin encoded_data_N =  8'b1000_0010; flag_n = 1'b1; end //130
		      	10'b11_0001_1101 : begin encoded_data_N =  8'b1000_0011; flag_n = 1'b1; end //131
		      	10'b11_0101_0010 : begin encoded_data_N =  8'b1000_0100; flag_n = 1'b1; end //132
		      	10'b10_1001_1101 : begin encoded_data_N =  8'b1000_0101; flag_n = 1'b1; end //133
		      	10'b01_1001_1101 : begin encoded_data_N =  8'b1000_0110; flag_n = 1'b1; end //134
		      	10'b11_1000_1101 : begin encoded_data_N =  8'b1000_0111; flag_n = 1'b1; end //135
		      	10'b11_1001_0010 : begin encoded_data_N =  8'b1000_1000; flag_n = 1'b1; end //136
		      	10'b10_0101_1101 : begin encoded_data_N =  8'b1000_1001; flag_n = 1'b1; end //137
		      	10'b01_0101_1101 : begin encoded_data_N =  8'b1000_1010; flag_n = 1'b1; end //138
		      	10'b11_0100_1101 : begin encoded_data_N =  8'b1000_1011; flag_n = 1'b1; end //139
		      	10'b00_1101_1101 : begin encoded_data_N =  8'b1000_1100; flag_n = 1'b1; end //140
		      	10'b10_1100_1101 : begin encoded_data_N =  8'b1000_1101; flag_n = 1'b1; end //141
		      	10'b01_1100_1101 : begin encoded_data_N =  8'b1000_1110; flag_n = 1'b1; end //142
		      	10'b01_0111_0010 : begin encoded_data_N =  8'b1000_1111; flag_n = 1'b1; end //143
		      	10'b01_1011_0010 : begin encoded_data_N =  8'b1001_0000; flag_n = 1'b1; end //144
		      	10'b10_0011_1101 : begin encoded_data_N =  8'b1001_0001; flag_n = 1'b1; end //145
		      	10'b01_0011_1101 : begin encoded_data_N =  8'b1001_0010; flag_n = 1'b1; end //146
		      	10'b11_0010_1101 : begin encoded_data_N =  8'b1001_0011; flag_n = 1'b1; end //147
		      	10'b00_1011_1101 : begin encoded_data_N =  8'b1001_0100; flag_n = 1'b1; end //148
		      	10'b10_1010_1101 : begin encoded_data_N =  8'b1001_0101; flag_n = 1'b1; end //149
		      	10'b01_1010_1101 : begin encoded_data_N =  8'b1001_0110; flag_n = 1'b1; end //150
		      	10'b11_1010_0010 : begin encoded_data_N =  8'b1001_0111; flag_n = 1'b1; end //151
		      	10'b11_0011_0010 : begin encoded_data_N =  8'b1001_1000; flag_n = 1'b1; end //152
		      	10'b10_0110_1101 : begin encoded_data_N =  8'b1001_1001; flag_n = 1'b1; end //153
		      	10'b01_0110_1101 : begin encoded_data_N =  8'b1001_1010; flag_n = 1'b1; end //154
		      	10'b11_0110_0010 : begin encoded_data_N =  8'b1001_1011; flag_n = 1'b1; end //155
		      	10'b00_1110_1101 : begin encoded_data_N =  8'b1001_1100; flag_n = 1'b1; end //156
		      	10'b10_1110_0010 : begin encoded_data_N =  8'b1001_1101; flag_n = 1'b1; end //157
		      	10'b01_1110_0010 : begin encoded_data_N =  8'b1001_1110; flag_n = 1'b1; end //158
		      	10'b10_1011_0010 : begin encoded_data_N =  8'b1001_1111; flag_n = 1'b1; end //159
		      	10'b10_0111_1010 : begin encoded_data_N =  8'b1010_0000; flag_n = 1'b1; end //160
		      	10'b01_1101_1010 : begin encoded_data_N =  8'b1010_0001; flag_n = 1'b1; end //161
		      	10'b10_1101_1010 : begin encoded_data_N =  8'b1010_0010; flag_n = 1'b1; end //162
		      	10'b11_0001_1010 : begin encoded_data_N =  8'b1010_0011; flag_n = 1'b1; end //163
		      	10'b11_0101_1010 : begin encoded_data_N =  8'b1010_0100; flag_n = 1'b1; end //164
		      	10'b10_1001_1010 : begin encoded_data_N =  8'b1010_0101; flag_n = 1'b1; end //165
		      	10'b01_1001_1010 : begin encoded_data_N =  8'b1010_0110; flag_n = 1'b1; end //166
		      	10'b11_1000_1010 : begin encoded_data_N =  8'b1010_0111; flag_n = 1'b1; end //167
		      	10'b11_1001_1010 : begin encoded_data_N =  8'b1010_1000; flag_n = 1'b1; end //168
		      	10'b10_0101_1010 : begin encoded_data_N =  8'b1010_1001; flag_n = 1'b1; end //169
		      	10'b01_0101_1010 : begin encoded_data_N =  8'b1010_1010; flag_n = 1'b1; end //170
		      	10'b11_0100_1010 : begin encoded_data_N =  8'b1010_1011; flag_n = 1'b1; end //171
		      	10'b00_1101_1010 : begin encoded_data_N =  8'b1010_1100; flag_n = 1'b1; end //172
		      	10'b10_1100_1010 : begin encoded_data_N =  8'b1010_1101; flag_n = 1'b1; end //173
		      	10'b01_1100_1010 : begin encoded_data_N =  8'b1010_1110; flag_n = 1'b1; end //174
		      	10'b01_0111_1010 : begin encoded_data_N =  8'b1010_1111; flag_n = 1'b1; end //175
		      	10'b01_1011_1010 : begin encoded_data_N =  8'b1011_0000; flag_n = 1'b1; end //176
		      	10'b10_0011_1010 : begin encoded_data_N =  8'b1011_0001; flag_n = 1'b1; end //177
		      	10'b01_0011_1010 : begin encoded_data_N =  8'b1011_0010; flag_n = 1'b1; end //178
		      	10'b11_0010_1010 : begin encoded_data_N =  8'b1011_0011; flag_n = 1'b1; end //179
		      	10'b00_1011_1010 : begin encoded_data_N =  8'b1011_0100; flag_n = 1'b1; end //180
		      	10'b10_1010_1010 : begin encoded_data_N =  8'b1011_0101; flag_n = 1'b1; end //181
		      	10'b01_1010_1010 : begin encoded_data_N =  8'b1011_0110; flag_n = 1'b1; end //182
		      	10'b11_1010_1010 : begin encoded_data_N =  8'b1011_0111; flag_n = 1'b1; end //183
		      	10'b11_0011_1010 : begin encoded_data_N =  8'b1011_1000; flag_n = 1'b1; end //184
		      	10'b10_0110_1010 : begin encoded_data_N =  8'b1011_1001; flag_n = 1'b1; end //185
		      	10'b01_0110_1010 : begin encoded_data_N =  8'b1011_1010; flag_n = 1'b1; end //186
		      	10'b11_0110_1010 : begin encoded_data_N =  8'b1011_1011; flag_n = 1'b1; end //187
		      	10'b00_1110_1010 : begin encoded_data_N =  8'b1011_1100; flag_n = 1'b1; end //188
		      	10'b10_1110_1010 : begin encoded_data_N =  8'b1011_1101; flag_n = 1'b1; end //189
		      	10'b01_1110_1010 : begin encoded_data_N =  8'b1011_1110; flag_n = 1'b1; end //190
		      	10'b10_1011_1010 : begin encoded_data_N =  8'b1011_1111; flag_n = 1'b1; end //191
		      	10'b10_0111_0110 : begin encoded_data_N =  8'b1100_0000; flag_n = 1'b1; end //192
		      	10'b01_1101_0110 : begin encoded_data_N =  8'b1100_0001; flag_n = 1'b1; end //193
		      	10'b10_1101_0110 : begin encoded_data_N =  8'b1100_0010; flag_n = 1'b1; end //194
		      	10'b11_0001_0110 : begin encoded_data_N =  8'b1100_0011; flag_n = 1'b1; end //195
		      	10'b11_0101_0110 : begin encoded_data_N =  8'b1100_0100; flag_n = 1'b1; end //196
		      	10'b10_1001_0110 : begin encoded_data_N =  8'b1100_0101; flag_n = 1'b1; end //197
		      	10'b01_1001_0110 : begin encoded_data_N =  8'b1100_0110; flag_n = 1'b1; end //198
		      	10'b11_1000_0110 : begin encoded_data_N =  8'b1100_0111; flag_n = 1'b1; end //199
		      	10'b11_1001_0110 : begin encoded_data_N =  8'b1100_1000; flag_n = 1'b1; end //200
		      	10'b10_0101_0110 : begin encoded_data_N =  8'b1100_1001; flag_n = 1'b1; end //201
		      	10'b01_0101_0110 : begin encoded_data_N =  8'b1100_1010; flag_n = 1'b1; end //202
		      	10'b11_0100_0110 : begin encoded_data_N =  8'b1100_1011; flag_n = 1'b1; end //203
		      	10'b00_1101_0110 : begin encoded_data_N =  8'b1100_1100; flag_n = 1'b1; end //204
		      	10'b10_1100_0110 : begin encoded_data_N =  8'b1100_1101; flag_n = 1'b1; end //205
		      	10'b01_1100_0110 : begin encoded_data_N =  8'b1100_1110; flag_n = 1'b1; end //206
		      	10'b01_0111_0110 : begin encoded_data_N =  8'b1100_1111; flag_n = 1'b1; end //207
		      	10'b01_1011_0110 : begin encoded_data_N =  8'b1101_0000; flag_n = 1'b1; end //208
		      	10'b10_0011_0110 : begin encoded_data_N =  8'b1101_0001; flag_n = 1'b1; end //209
		      	10'b01_0011_0110 : begin encoded_data_N =  8'b1101_0010; flag_n = 1'b1; end //210
		      	10'b11_0010_0110 : begin encoded_data_N =  8'b1101_0011; flag_n = 1'b1; end //211
		      	10'b00_1011_0110 : begin encoded_data_N =  8'b1101_0100; flag_n = 1'b1; end //212
		      	10'b10_1010_0110 : begin encoded_data_N =  8'b1101_0101; flag_n = 1'b1; end //213
		      	10'b01_1010_0110 : begin encoded_data_N =  8'b1101_0110; flag_n = 1'b1; end //214
		      	10'b11_1010_0110 : begin encoded_data_N =  8'b1101_0111; flag_n = 1'b1; end //215
		      	10'b11_0011_0110 : begin encoded_data_N =  8'b1101_1000; flag_n = 1'b1; end //216
		      	10'b10_0110_0110 : begin encoded_data_N =  8'b1101_1001; flag_n = 1'b1; end //217
		      	10'b01_0110_0110 : begin encoded_data_N =  8'b1101_1010; flag_n = 1'b1; end //218
		      	10'b11_0110_0110 : begin encoded_data_N =  8'b1101_1011; flag_n = 1'b1; end //219
		      	10'b00_1110_0110 : begin encoded_data_N =  8'b1101_1100; flag_n = 1'b1; end //220
		      	10'b10_1110_0110 : begin encoded_data_N =  8'b1101_1101; flag_n = 1'b1; end //221
		      	10'b01_1110_0110 : begin encoded_data_N =  8'b1101_1110; flag_n = 1'b1; end //222
		      	10'b10_1011_0110 : begin encoded_data_N =  8'b1101_1111; flag_n = 1'b1; end //223
		      	10'b10_0111_0001 : begin encoded_data_N =  8'b1110_0000; flag_n = 1'b1; end //224
		      	10'b01_1101_0001 : begin encoded_data_N =  8'b1110_0001; flag_n = 1'b1; end //225
		      	10'b10_1101_0001 : begin encoded_data_N =  8'b1110_0010; flag_n = 1'b1; end //226
		      	10'b11_0001_1110 : begin encoded_data_N =  8'b1110_0011; flag_n = 1'b1; end //227
		      	10'b11_0101_0001 : begin encoded_data_N =  8'b1110_0100; flag_n = 1'b1; end //228
		      	10'b10_1001_1110 : begin encoded_data_N =  8'b1110_0101; flag_n = 1'b1; end //229
		      	10'b01_1001_1110 : begin encoded_data_N =  8'b1110_0110; flag_n = 1'b1; end //230
		      	10'b11_1000_1110 : begin encoded_data_N =  8'b1110_0111; flag_n = 1'b1; end //231
		      	10'b11_1001_0001 : begin encoded_data_N =  8'b1110_1000; flag_n = 1'b1; end //232
		      	10'b10_0101_1110 : begin encoded_data_N =  8'b1110_1001; flag_n = 1'b1; end //233
		      	10'b01_0101_1110 : begin encoded_data_N =  8'b1110_1010; flag_n = 1'b1; end //234
		      	10'b11_0100_1110 : begin encoded_data_N =  8'b1110_1011; flag_n = 1'b1; end //235
		      	10'b00_1101_1110 : begin encoded_data_N =  8'b1110_1100; flag_n = 1'b1; end //236
		      	10'b10_1100_1110 : begin encoded_data_N =  8'b1110_1101; flag_n = 1'b1; end //237
		      	10'b01_1100_1110 : begin encoded_data_N =  8'b1110_1110; flag_n = 1'b1; end //238
		      	10'b01_0111_0001 : begin encoded_data_N =  8'b1110_1111; flag_n = 1'b1; end //239
		      	10'b01_1011_0001 : begin encoded_data_N =  8'b1111_0000; flag_n = 1'b1; end //240
		      	10'b10_0011_0111 : begin encoded_data_N =  8'b1111_0001; flag_n = 1'b1; end //241
		      	10'b01_0011_0111 : begin encoded_data_N =  8'b1111_0010; flag_n = 1'b1; end //242
		      	10'b11_0010_1110 : begin encoded_data_N =  8'b1111_0011; flag_n = 1'b1; end //243
		      	10'b00_1011_0111 : begin encoded_data_N =  8'b1111_0100; flag_n = 1'b1; end //244
		      	10'b10_1010_1110 : begin encoded_data_N =  8'b1111_0101; flag_n = 1'b1; end //245
		      	10'b01_1010_1110 : begin encoded_data_N =  8'b1111_0110; flag_n = 1'b1; end //246
		      	10'b11_1010_0001 : begin encoded_data_N =  8'b1111_0111; flag_n = 1'b1; end //247
		      	10'b11_0011_0001 : begin encoded_data_N =  8'b1111_1000; flag_n = 1'b1; end //248
		      	10'b10_0110_1110 : begin encoded_data_N =  8'b1111_1001; flag_n = 1'b1; end //249
		      	10'b01_0110_1110 : begin encoded_data_N =  8'b1111_1010; flag_n = 1'b1; end //250
		      	10'b11_0110_0001 : begin encoded_data_N =  8'b1111_1011; flag_n = 1'b1; end //251
		      	10'b00_1110_1110 : begin encoded_data_N =  8'b1111_1100; flag_n = 1'b1; end //252
		      	10'b10_1110_0001 : begin encoded_data_N =  8'b1111_1101; flag_n = 1'b1; end //253
		      	10'b01_1110_0001 : begin encoded_data_N =  8'b1111_1110; flag_n = 1'b1; end //254
		      	10'b10_1011_0001 : begin encoded_data_N =  8'b1111_1111; flag_n = 1'b1; end //255
		      	// command 	 
		      	10'b00_1111_0100 : begin encoded_data_N =  8'b0001_1100; flag_n = 1'b1; RxDataK_N = 1'b1; end 
		      	10'b00_1111_1001 : begin encoded_data_N =  8'b0011_1100; flag_n = 1'b1; RxDataK_N = 1'b1; end 
		      	10'b00_1111_0101 : begin encoded_data_N =  8'b0101_1100; flag_n = 1'b1; RxDataK_N = 1'b1; end 
		      	10'b00_1111_0011 : begin encoded_data_N =  8'b0111_1100; flag_n = 1'b1; RxDataK_N = 1'b1; end 
		      	10'b00_1111_0010 : begin encoded_data_N =  8'b1001_1100; flag_n = 1'b1; RxDataK_N = 1'b1; end 
		      	10'b00_1111_1010 : begin encoded_data_N =  8'b1011_1100; flag_n = 1'b1; RxDataK_N = 1'b1; end 
		      	10'b00_1111_0110 : begin encoded_data_N =  8'b1101_1100; flag_n = 1'b1; RxDataK_N = 1'b1; end 
		      	10'b00_1111_1000 : begin encoded_data_N =  8'b1111_1100; flag_n = 1'b1; RxDataK_N = 1'b1; end 
		      	10'b11_1010_1000 : begin encoded_data_N =  8'b1111_0111; flag_n = 1'b1; RxDataK_N = 1'b1; end 
		      	10'b11_0110_1000 : begin encoded_data_N =  8'b1111_1011; flag_n = 1'b1; RxDataK_N = 1'b1; end 
		      	10'b10_1110_1000 : begin encoded_data_N =  8'b1111_1101; flag_n = 1'b1; RxDataK_N = 1'b1; end 
		      	10'b01_1110_1000 : begin encoded_data_N =  8'b1111_1110; flag_n = 1'b1; RxDataK_N = 1'b1; end  

		default : begin 
					RxDataK_N = 1'b0;
					encoded_data_N = 8'b0000_0000;
					flag_n = 1'b0;
					DecodeError_N = 1'b1; // error in decoding 
			end 

	endcase 

	end	




 always@(*)
  begin

   flag_p = 1'b0;
	 DecodeError_P = 1'b0;
	 RxDataK_P = 1'b0 ;

     case (temp)

			10'b01_1000_1011 : begin  encoded_data_P = 8'b0000_0000; flag_p = 1'b1; end  //0
			10'b10_0010_1011 : begin  encoded_data_P = 8'b0000_0001; flag_p = 1'b1; end  //1
			10'b01_0010_1011 : begin  encoded_data_P = 8'b0000_0010; flag_p = 1'b1; end  //2
			10'b11_0001_0100 : begin  encoded_data_P = 8'b0000_0011; flag_p = 1'b1; end  //3
			10'b00_1010_1011 : begin  encoded_data_P = 8'b0000_0100; flag_p = 1'b1; end  //4
			10'b10_1001_0100 : begin  encoded_data_P = 8'b0000_0101; flag_p = 1'b1; end  //5
			10'b01_1001_0100 : begin  encoded_data_P = 8'b0000_0110; flag_p = 1'b1; end  //6
			10'b00_0111_0100 : begin  encoded_data_P = 8'b0000_0111; flag_p = 1'b1; end  //7
			10'b00_0110_1011 : begin  encoded_data_P = 8'b0000_1000; flag_p = 1'b1; end  //8
			10'b10_0101_0100 : begin  encoded_data_P = 8'b0000_1001; flag_p = 1'b1; end  //9
			10'b01_0101_0100 : begin  encoded_data_P = 8'b0000_1010; flag_p = 1'b1; end  //10
			10'b11_0100_0100 : begin  encoded_data_P = 8'b0000_1011; flag_p = 1'b1; end  //11
			10'b00_1101_0100 : begin  encoded_data_P = 8'b0000_1100; flag_p = 1'b1; end  //12
			10'b10_1100_0100 : begin  encoded_data_P = 8'b0000_1101; flag_p = 1'b1; end  //13
			10'b01_1100_0100 : begin  encoded_data_P = 8'b0000_1110; flag_p = 1'b1; end  //14
			10'b10_1000_1011 : begin  encoded_data_P = 8'b0000_1111; flag_p = 1'b1; end  //15
			10'b10_0100_1011 : begin  encoded_data_P = 8'b0001_0000; flag_p = 1'b1; end  //16
			10'b10_0011_0100 : begin  encoded_data_P = 8'b0001_0001; flag_p = 1'b1; end  //17
			10'b01_0011_0100 : begin  encoded_data_P = 8'b0001_0010; flag_p = 1'b1; end  //18
			10'b11_0010_0100 : begin  encoded_data_P = 8'b0001_0011; flag_p = 1'b1; end  //19
			10'b00_1011_0100 : begin  encoded_data_P = 8'b0001_0100; flag_p = 1'b1; end  //20
			10'b10_1010_0100 : begin  encoded_data_P = 8'b0001_0101; flag_p = 1'b1; end  //21
			10'b01_1010_0100 : begin  encoded_data_P = 8'b0001_0110; flag_p = 1'b1; end  //22
			10'b00_0101_1011 : begin  encoded_data_P = 8'b0001_0111; flag_p = 1'b1; end  //23
			10'b00_1100_1011 : begin  encoded_data_P = 8'b0001_1000; flag_p = 1'b1; end  //24
			10'b10_0110_0100 : begin  encoded_data_P = 8'b0001_1001; flag_p = 1'b1; end  //25
			10'b01_0110_0100 : begin  encoded_data_P = 8'b0001_1010; flag_p = 1'b1; end  //26
			10'b00_1001_1011 : begin  encoded_data_P = 8'b0001_1011; flag_p = 1'b1; end  //27
			10'b00_1110_0100 : begin  encoded_data_P = 8'b0001_1100; flag_p = 1'b1; end  //28
			10'b01_0001_1011 : begin  encoded_data_P = 8'b0001_1101; flag_p = 1'b1; end  //29
			10'b10_0001_1011 : begin  encoded_data_P = 8'b0001_1110; flag_p = 1'b1; end  //30
			10'b01_0100_1011 : begin  encoded_data_P = 8'b0001_1111; flag_p = 1'b1; end  //31
			10'b01_1000_1001 : begin  encoded_data_P = 8'b0010_0000; flag_p = 1'b1; end  //32
			10'b10_0010_1001 : begin  encoded_data_P = 8'b0010_0001; flag_p = 1'b1; end  //33
			10'b01_0010_1001 : begin  encoded_data_P = 8'b0010_0010; flag_p = 1'b1; end  //34
			10'b11_0001_1001 : begin  encoded_data_P = 8'b0010_0011; flag_p = 1'b1; end  //35
			10'b00_1010_1001 : begin  encoded_data_P = 8'b0010_0100; flag_p = 1'b1; end  //36
			10'b10_1001_1001 : begin  encoded_data_P = 8'b0010_0101; flag_p = 1'b1; end  //37
			10'b01_1001_1001 : begin  encoded_data_P = 8'b0010_0110; flag_p = 1'b1; end  //38
			10'b00_0111_1001 : begin  encoded_data_P = 8'b0010_0111; flag_p = 1'b1; end  //39
			10'b00_0110_1001 : begin  encoded_data_P = 8'b0010_1000; flag_p = 1'b1; end  //40
			10'b10_0101_1001 : begin  encoded_data_P = 8'b0010_1001; flag_p = 1'b1; end  //41
			10'b01_0101_1001 : begin  encoded_data_P = 8'b0010_1010; flag_p = 1'b1; end  //42
			10'b11_0100_1001 : begin  encoded_data_P = 8'b0010_1011; flag_p = 1'b1; end  //43
			10'b00_1101_1001 : begin  encoded_data_P = 8'b0010_1100; flag_p = 1'b1; end  //44
			10'b10_1100_1001 : begin  encoded_data_P = 8'b0010_1101; flag_p = 1'b1; end  //45
			10'b01_1100_1001 : begin  encoded_data_P = 8'b0010_1110; flag_p = 1'b1; end  //46
			10'b10_1000_1001 : begin  encoded_data_P = 8'b0010_1111; flag_p = 1'b1; end  //47
			10'b10_0100_1001 : begin  encoded_data_P = 8'b0011_0000; flag_p = 1'b1; end  //48
			10'b10_0011_1001 : begin  encoded_data_P = 8'b0011_0001; flag_p = 1'b1; end  //49
			10'b01_0011_1001 : begin  encoded_data_P = 8'b0011_0010; flag_p = 1'b1; end  //50
			10'b11_0010_1001 : begin  encoded_data_P = 8'b0011_0011; flag_p = 1'b1; end  //51
			10'b00_1011_1001 : begin  encoded_data_P = 8'b0011_0100; flag_p = 1'b1; end  //52
			10'b10_1010_1001 : begin  encoded_data_P = 8'b0011_0101; flag_p = 1'b1; end  //53
			10'b01_1010_1001 : begin  encoded_data_P = 8'b0011_0110; flag_p = 1'b1; end  //54
			10'b00_0101_1001 : begin  encoded_data_P = 8'b0011_0111; flag_p = 1'b1; end  //55
			10'b00_1100_1001 : begin  encoded_data_P = 8'b0011_1000; flag_p = 1'b1; end  //56
			10'b10_0110_1001 : begin  encoded_data_P = 8'b0011_1001; flag_p = 1'b1; end  //57
			10'b01_0110_1001 : begin  encoded_data_P = 8'b0011_1010; flag_p = 1'b1; end  //58
			10'b00_1001_1001 : begin  encoded_data_P = 8'b0011_1011; flag_p = 1'b1; end  //59
			10'b00_1110_1001 : begin  encoded_data_P = 8'b0011_1100; flag_p = 1'b1; end  //60
			10'b01_0001_1001 : begin  encoded_data_P = 8'b0011_1101; flag_p = 1'b1; end  //61
			10'b10_0001_1001 : begin  encoded_data_P = 8'b0011_1110; flag_p = 1'b1; end  //62
			10'b01_0100_1001 : begin  encoded_data_P = 8'b0011_1111; flag_p = 1'b1; end  //63
			10'b01_1000_0101 : begin  encoded_data_P = 8'b0100_0000; flag_p = 1'b1; end  //64
			10'b10_0010_0101 : begin  encoded_data_P = 8'b0100_0001; flag_p = 1'b1; end  //65
			10'b01_0010_0101 : begin  encoded_data_P = 8'b0100_0010; flag_p = 1'b1; end  //66
			10'b11_0001_0101 : begin  encoded_data_P = 8'b0100_0011; flag_p = 1'b1; end  //67
			10'b00_1010_0101 : begin  encoded_data_P = 8'b0100_0100; flag_p = 1'b1; end  //68
			10'b10_1001_0101 : begin  encoded_data_P = 8'b0100_0101; flag_p = 1'b1; end  //69
			10'b01_1001_0101 : begin  encoded_data_P = 8'b0100_0110; flag_p = 1'b1; end  //70
			10'b00_0111_0101 : begin  encoded_data_P = 8'b0100_0111; flag_p = 1'b1; end  //71
			10'b00_0110_0101 : begin  encoded_data_P = 8'b0100_1000; flag_p = 1'b1; end  //72
			10'b10_0101_0101 : begin  encoded_data_P = 8'b0100_1001; flag_p = 1'b1; end  //73
			10'b01_0101_0101 : begin  encoded_data_P = 8'b0100_1010; flag_p = 1'b1; end  //74
			10'b11_0100_0101 : begin  encoded_data_P = 8'b0100_1011; flag_p = 1'b1; end  //75
			10'b00_1101_0101 : begin  encoded_data_P = 8'b0100_1100; flag_p = 1'b1; end  //76
			10'b10_1100_0101 : begin  encoded_data_P = 8'b0100_1101; flag_p = 1'b1; end  //77
			10'b01_1100_0101 : begin  encoded_data_P = 8'b0100_1110; flag_p = 1'b1; end  //78
			10'b10_1000_0101 : begin  encoded_data_P = 8'b0100_1111; flag_p = 1'b1; end  //79
			10'b10_0100_0101 : begin  encoded_data_P = 8'b0101_0000; flag_p = 1'b1; end  //80
			10'b10_0011_0101 : begin  encoded_data_P = 8'b0101_0001; flag_p = 1'b1; end  //81
			10'b01_0011_0101 : begin  encoded_data_P = 8'b0101_0010; flag_p = 1'b1; end  //82
			10'b11_0010_0101 : begin  encoded_data_P = 8'b0101_0011; flag_p = 1'b1; end  //83
			10'b00_1011_0101 : begin  encoded_data_P = 8'b0101_0100; flag_p = 1'b1; end  //84
			10'b10_1010_0101 : begin  encoded_data_P = 8'b0101_0101; flag_p = 1'b1; end  //85
			10'b01_1010_0101 : begin  encoded_data_P = 8'b0101_0110; flag_p = 1'b1; end  //86
			10'b00_0101_0101 : begin  encoded_data_P = 8'b0101_0111; flag_p = 1'b1; end  //87
			10'b00_1100_0101 : begin  encoded_data_P = 8'b0101_1000; flag_p = 1'b1; end  //88
			10'b10_0110_0101 : begin  encoded_data_P = 8'b0101_1001; flag_p = 1'b1; end  //89
			10'b01_0110_0101 : begin  encoded_data_P = 8'b0101_1010; flag_p = 1'b1; end  //90
			10'b00_1001_0101 : begin  encoded_data_P = 8'b0101_1011; flag_p = 1'b1; end  //91
			10'b00_1110_0101 : begin  encoded_data_P = 8'b0101_1100; flag_p = 1'b1; end  //92
			10'b01_0001_0101 : begin  encoded_data_P = 8'b0101_1101; flag_p = 1'b1; end  //93
			10'b10_0001_0101 : begin  encoded_data_P = 8'b0101_1110; flag_p = 1'b1; end  //94
			10'b01_0100_0101 : begin  encoded_data_P = 8'b0101_1111; flag_p = 1'b1; end  //95
			10'b01_1000_1100 : begin  encoded_data_P = 8'b0110_0000; flag_p = 1'b1; end  //96
			10'b10_0010_1100 : begin  encoded_data_P = 8'b0110_0001; flag_p = 1'b1; end  //97
			10'b01_0010_1100 : begin  encoded_data_P = 8'b0110_0010; flag_p = 1'b1; end  //98
			10'b11_0001_0011 : begin  encoded_data_P = 8'b0110_0011; flag_p = 1'b1; end  //99
			10'b00_1010_1100 : begin  encoded_data_P = 8'b0110_0100; flag_p = 1'b1; end  //100
			10'b10_1001_0011 : begin  encoded_data_P = 8'b0110_0101; flag_p = 1'b1; end  //101
			10'b01_1001_0011 : begin  encoded_data_P = 8'b0110_0110; flag_p = 1'b1; end  //102
			10'b00_0111_0011 : begin  encoded_data_P = 8'b0110_0111; flag_p = 1'b1; end  //103
			10'b00_0110_1100 : begin  encoded_data_P = 8'b0110_1000; flag_p = 1'b1; end  //104
			10'b10_0101_0011 : begin  encoded_data_P = 8'b0110_1001; flag_p = 1'b1; end  //105
			10'b01_0101_0011 : begin  encoded_data_P = 8'b0110_1010; flag_p = 1'b1; end  //106
			10'b11_0100_0011 : begin  encoded_data_P = 8'b0110_1011; flag_p = 1'b1; end  //107
			10'b00_1101_0011 : begin  encoded_data_P = 8'b0110_1100; flag_p = 1'b1; end  //108
			10'b10_1100_0011 : begin  encoded_data_P = 8'b0110_1101; flag_p = 1'b1; end  //109
			10'b01_1100_0011 : begin  encoded_data_P = 8'b0110_1110; flag_p = 1'b1; end  //110
			10'b10_1000_1100 : begin  encoded_data_P = 8'b0110_1111; flag_p = 1'b1; end  //111
			10'b10_0100_1100 : begin  encoded_data_P = 8'b0111_0000; flag_p = 1'b1; end  //112
			10'b10_0011_0011 : begin  encoded_data_P = 8'b0111_0001; flag_p = 1'b1; end  //113
			10'b01_0011_0011 : begin  encoded_data_P = 8'b0111_0010; flag_p = 1'b1; end  //114
			10'b11_0010_0011 : begin  encoded_data_P = 8'b0111_0011; flag_p = 1'b1; end  //115
			10'b00_1011_0011 : begin  encoded_data_P = 8'b0111_0100; flag_p = 1'b1; end  //116
			10'b10_1010_0011 : begin  encoded_data_P = 8'b0111_0101; flag_p = 1'b1; end  //117
			10'b01_1010_0011 : begin  encoded_data_P = 8'b0111_0110; flag_p = 1'b1; end  //118
			10'b00_0101_1100 : begin  encoded_data_P = 8'b0111_0111; flag_p = 1'b1; end  //119
			10'b00_1100_1100 : begin  encoded_data_P = 8'b0111_1000; flag_p = 1'b1; end  //120
			10'b10_0110_0011 : begin  encoded_data_P = 8'b0111_1001; flag_p = 1'b1; end  //121
			10'b01_0110_0011 : begin  encoded_data_P = 8'b0111_1010; flag_p = 1'b1; end  //122
			10'b00_1001_1100 : begin  encoded_data_P = 8'b0111_1011; flag_p = 1'b1; end  //123
			10'b00_1110_0011 : begin  encoded_data_P = 8'b0111_1100; flag_p = 1'b1; end  //124
			10'b01_0001_1100 : begin  encoded_data_P = 8'b0111_1101; flag_p = 1'b1; end  //125
			10'b10_0001_1100 : begin  encoded_data_P = 8'b0111_1110; flag_p = 1'b1; end  //126
			10'b01_0100_1100 : begin  encoded_data_P = 8'b0111_1111; flag_p = 1'b1; end  //127
			10'b01_1000_1101 : begin  encoded_data_P = 8'b1000_0000; flag_p = 1'b1; end  //128
			10'b10_0010_1101 : begin  encoded_data_P = 8'b1000_0001; flag_p = 1'b1; end  //129
			10'b01_0010_1101 : begin  encoded_data_P = 8'b1000_0010; flag_p = 1'b1; end  //130
			10'b11_0001_0010 : begin  encoded_data_P = 8'b1000_0011; flag_p = 1'b1; end  //131
			10'b00_1010_1101 : begin  encoded_data_P = 8'b1000_0100; flag_p = 1'b1; end  //132
			10'b10_1001_0010 : begin  encoded_data_P = 8'b1000_0101; flag_p = 1'b1; end  //133
			10'b01_1001_0010 : begin  encoded_data_P = 8'b1000_0110; flag_p = 1'b1; end  //134
			10'b00_0111_0010 : begin  encoded_data_P = 8'b1000_0111; flag_p = 1'b1; end  //135
			10'b00_0110_1101 : begin  encoded_data_P = 8'b1000_1000; flag_p = 1'b1; end  //136
			10'b10_0101_0010 : begin  encoded_data_P = 8'b1000_1001; flag_p = 1'b1; end  //137
			10'b01_0101_0010 : begin  encoded_data_P = 8'b1000_1010; flag_p = 1'b1; end  //138
			10'b11_0100_0010 : begin  encoded_data_P = 8'b1000_1011; flag_p = 1'b1; end  //139
			10'b00_1101_0010 : begin  encoded_data_P = 8'b1000_1100; flag_p = 1'b1; end  //140
			10'b10_1100_0010 : begin  encoded_data_P = 8'b1000_1101; flag_p = 1'b1; end  //141
			10'b01_1100_0010 : begin  encoded_data_P = 8'b1000_1110; flag_p = 1'b1; end  //142
			10'b10_1000_1101 : begin  encoded_data_P = 8'b1000_1111; flag_p = 1'b1; end  //143
			10'b10_0100_1101 : begin  encoded_data_P = 8'b1001_0000; flag_p = 1'b1; end  //144
			10'b10_0011_0010 : begin  encoded_data_P = 8'b1001_0001; flag_p = 1'b1; end  //145
			10'b01_0011_0010 : begin  encoded_data_P = 8'b1001_0010; flag_p = 1'b1; end  //146
			10'b11_0010_0010 : begin  encoded_data_P = 8'b1001_0011; flag_p = 1'b1; end  //147
			10'b00_1011_0010 : begin  encoded_data_P = 8'b1001_0100; flag_p = 1'b1; end  //148
			10'b10_1010_0010 : begin  encoded_data_P = 8'b1001_0101; flag_p = 1'b1; end  //149
			10'b01_1010_0010 : begin  encoded_data_P = 8'b1001_0110; flag_p = 1'b1; end  //150
			10'b00_0101_1101 : begin  encoded_data_P = 8'b1001_0111; flag_p = 1'b1; end  //151
			10'b00_1100_1101 : begin  encoded_data_P = 8'b1001_1000; flag_p = 1'b1; end  //152
			10'b10_0110_0010 : begin  encoded_data_P = 8'b1001_1001; flag_p = 1'b1; end  //153
			10'b01_0110_0010 : begin  encoded_data_P = 8'b1001_1010; flag_p = 1'b1; end  //154
			10'b00_1001_1101 : begin  encoded_data_P = 8'b1001_1011; flag_p = 1'b1; end  //155
			10'b00_1110_0010 : begin  encoded_data_P = 8'b1001_1100; flag_p = 1'b1; end  //156
			10'b01_0001_1101 : begin  encoded_data_P = 8'b1001_1101; flag_p = 1'b1; end  //157
			10'b10_0001_1101 : begin  encoded_data_P = 8'b1001_1110; flag_p = 1'b1; end  //158
			10'b01_0100_1101 : begin  encoded_data_P = 8'b1001_1111; flag_p = 1'b1; end  //159
			10'b01_1000_1010 : begin  encoded_data_P = 8'b1010_0000; flag_p = 1'b1; end  //160
			10'b10_0010_1010 : begin  encoded_data_P = 8'b1010_0001; flag_p = 1'b1; end  //161
			10'b01_0010_1010 : begin  encoded_data_P = 8'b1010_0010; flag_p = 1'b1; end  //162
			10'b11_0001_1010 : begin  encoded_data_P = 8'b1010_0011; flag_p = 1'b1; end  //163
			10'b00_1010_1010 : begin  encoded_data_P = 8'b1010_0100; flag_p = 1'b1; end  //164
			10'b10_1001_1010 : begin  encoded_data_P = 8'b1010_0101; flag_p = 1'b1; end  //165
			10'b01_1001_1010 : begin  encoded_data_P = 8'b1010_0110; flag_p = 1'b1; end  //166
			10'b00_0111_1010 : begin  encoded_data_P = 8'b1010_0111; flag_p = 1'b1; end  //167
			10'b00_0110_1010 : begin  encoded_data_P = 8'b1010_1000; flag_p = 1'b1; end  //168
			10'b10_0101_1010 : begin  encoded_data_P = 8'b1010_1001; flag_p = 1'b1; end  //169
			10'b01_0101_1010 : begin  encoded_data_P = 8'b1010_1010; flag_p = 1'b1; end  //170
			10'b11_0100_1010 : begin  encoded_data_P = 8'b1010_1011; flag_p = 1'b1; end  //171
			10'b00_1101_1010 : begin  encoded_data_P = 8'b1010_1100; flag_p = 1'b1; end  //172
			10'b10_1100_1010 : begin  encoded_data_P = 8'b1010_1101; flag_p = 1'b1; end  //173
			10'b01_1100_1010 : begin  encoded_data_P = 8'b1010_1110; flag_p = 1'b1; end  //174
			10'b10_1000_1010 : begin  encoded_data_P = 8'b1010_1111; flag_p = 1'b1; end  //175
			10'b10_0100_1010 : begin  encoded_data_P = 8'b1011_0000; flag_p = 1'b1; end  //176
			10'b10_0011_1010 : begin  encoded_data_P = 8'b1011_0001; flag_p = 1'b1; end  //177
			10'b01_0011_1010 : begin  encoded_data_P = 8'b1011_0010; flag_p = 1'b1; end  //178
			10'b11_0010_1010 : begin  encoded_data_P = 8'b1011_0011; flag_p = 1'b1; end  //179
			10'b00_1011_1010 : begin  encoded_data_P = 8'b1011_0100; flag_p = 1'b1; end  //180
			10'b10_1010_1010 : begin  encoded_data_P = 8'b1011_0101; flag_p = 1'b1; end  //181
			10'b01_1010_1010 : begin  encoded_data_P = 8'b1011_0110; flag_p = 1'b1; end  //182
			10'b00_0101_1010 : begin  encoded_data_P = 8'b1011_0111; flag_p = 1'b1; end  //183
			10'b00_1100_1010 : begin  encoded_data_P = 8'b1011_1000; flag_p = 1'b1; end  //184
			10'b10_0110_1010 : begin  encoded_data_P = 8'b1011_1001; flag_p = 1'b1; end  //185
			10'b01_0110_1010 : begin  encoded_data_P = 8'b1011_1010; flag_p = 1'b1; end  //186
			10'b00_1001_1010 : begin  encoded_data_P = 8'b1011_1011; flag_p = 1'b1; end  //187
			10'b00_1110_1010 : begin  encoded_data_P = 8'b1011_1100; flag_p = 1'b1; end  //188
			10'b01_0001_1010 : begin  encoded_data_P = 8'b1011_1101; flag_p = 1'b1; end  //189
			10'b10_0001_1010 : begin  encoded_data_P = 8'b1011_1110; flag_p = 1'b1; end  //190
			10'b01_0100_1010 : begin  encoded_data_P = 8'b1011_1111; flag_p = 1'b1; end  //191
			10'b01_1000_0110 : begin  encoded_data_P = 8'b1100_0000; flag_p = 1'b1; end  //192
			10'b10_0010_0110 : begin  encoded_data_P = 8'b1100_0001; flag_p = 1'b1; end  //193
			10'b01_0010_0110 : begin  encoded_data_P = 8'b1100_0010; flag_p = 1'b1; end  //194
			10'b11_0001_0110 : begin  encoded_data_P = 8'b1100_0011; flag_p = 1'b1; end  //195
			10'b00_1010_0110 : begin  encoded_data_P = 8'b1100_0100; flag_p = 1'b1; end  //196
			10'b10_1001_0110 : begin  encoded_data_P = 8'b1100_0101; flag_p = 1'b1; end  //197
			10'b01_1001_0110 : begin  encoded_data_P = 8'b1100_0110; flag_p = 1'b1; end  //198
			10'b00_0111_0110 : begin  encoded_data_P = 8'b1100_0111; flag_p = 1'b1; end  //199
			10'b00_0110_0110 : begin  encoded_data_P = 8'b1100_1000; flag_p = 1'b1; end  //200
			10'b10_0101_0110 : begin  encoded_data_P = 8'b1100_1001; flag_p = 1'b1; end  //201
			10'b01_0101_0110 : begin  encoded_data_P = 8'b1100_1010; flag_p = 1'b1; end  //202
			10'b11_0100_0110 : begin  encoded_data_P = 8'b1100_1011; flag_p = 1'b1; end  //203
			10'b00_1101_0110 : begin  encoded_data_P = 8'b1100_1100; flag_p = 1'b1; end  //204
			10'b10_1100_0110 : begin  encoded_data_P = 8'b1100_1101; flag_p = 1'b1; end  //205
			10'b01_1100_0110 : begin  encoded_data_P = 8'b1100_1110; flag_p = 1'b1; end  //206
			10'b10_1000_0110 : begin  encoded_data_P = 8'b1100_1111; flag_p = 1'b1; end  //207
			10'b10_0100_0110 : begin  encoded_data_P = 8'b1101_0000; flag_p = 1'b1; end  //208
			10'b10_0011_0110 : begin  encoded_data_P = 8'b1101_0001; flag_p = 1'b1; end  //209
			10'b01_0011_0110 : begin  encoded_data_P = 8'b1101_0010; flag_p = 1'b1; end  //210
			10'b11_0010_0110 : begin  encoded_data_P = 8'b1101_0011; flag_p = 1'b1; end  //211
			10'b00_1011_0110 : begin  encoded_data_P = 8'b1101_0100; flag_p = 1'b1; end  //212
			10'b10_1010_0110 : begin  encoded_data_P = 8'b1101_0101; flag_p = 1'b1; end  //213
			10'b01_1010_0110 : begin  encoded_data_P = 8'b1101_0110; flag_p = 1'b1; end  //214
			10'b00_0101_0110 : begin  encoded_data_P = 8'b1101_0111; flag_p = 1'b1; end  //215
			10'b00_1100_0110 : begin  encoded_data_P = 8'b1101_1000; flag_p = 1'b1; end  //216
			10'b10_0110_0110 : begin  encoded_data_P = 8'b1101_1001; flag_p = 1'b1; end  //217
			10'b01_0110_0110 : begin  encoded_data_P = 8'b1101_1010; flag_p = 1'b1; end  //218
			10'b00_1001_0110 : begin  encoded_data_P = 8'b1101_1011; flag_p = 1'b1; end  //219
			10'b00_1110_0110 : begin  encoded_data_P = 8'b1101_1100; flag_p = 1'b1; end  //220
			10'b01_0001_0110 : begin  encoded_data_P = 8'b1101_1101; flag_p = 1'b1; end  //221
			10'b10_0001_0110 : begin  encoded_data_P = 8'b1101_1110; flag_p = 1'b1; end  //222
			10'b01_0100_0110 : begin  encoded_data_P = 8'b1101_1111; flag_p = 1'b1; end  //223
			10'b01_1000_1110 : begin  encoded_data_P = 8'b1110_0000; flag_p = 1'b1; end  //224
			10'b10_0010_1110 : begin  encoded_data_P = 8'b1110_0001; flag_p = 1'b1; end  //225
			10'b01_0010_1110 : begin  encoded_data_P = 8'b1110_0010; flag_p = 1'b1; end  //226
			10'b11_0001_0001 : begin  encoded_data_P = 8'b1110_0011; flag_p = 1'b1; end  //227
			10'b00_1010_1110 : begin  encoded_data_P = 8'b1110_0100; flag_p = 1'b1; end  //228
			10'b10_1001_0001 : begin  encoded_data_P = 8'b1110_0101; flag_p = 1'b1; end  //229
			10'b01_1001_0001 : begin  encoded_data_P = 8'b1110_0110; flag_p = 1'b1; end  //230
			10'b00_0111_0001 : begin  encoded_data_P = 8'b1110_0111; flag_p = 1'b1; end  //231
			10'b00_0110_1110 : begin  encoded_data_P = 8'b1110_1000; flag_p = 1'b1; end  //232
			10'b10_0101_0001 : begin  encoded_data_P = 8'b1110_1001; flag_p = 1'b1; end  //233
			10'b01_0101_0001 : begin  encoded_data_P = 8'b1110_1010; flag_p = 1'b1; end  //234
			10'b11_0100_1000 : begin  encoded_data_P = 8'b1110_1011; flag_p = 1'b1; end  //235
			10'b00_1101_0001 : begin  encoded_data_P = 8'b1110_1100; flag_p = 1'b1; end  //236
			10'b10_1100_1000 : begin  encoded_data_P = 8'b1110_1101; flag_p = 1'b1; end  //237
			10'b01_1100_1000 : begin  encoded_data_P = 8'b1110_1110; flag_p = 1'b1; end  //238
			10'b10_1000_1110 : begin  encoded_data_P = 8'b1110_1111; flag_p = 1'b1; end  //239
			10'b10_0100_1110 : begin  encoded_data_P = 8'b1111_0000; flag_p = 1'b1; end  //240
			10'b10_0011_0001 : begin  encoded_data_P = 8'b1111_0001; flag_p = 1'b1; end  //241
			10'b01_0011_0001 : begin  encoded_data_P = 8'b1111_0010; flag_p = 1'b1; end  //242
			10'b11_0010_0001 : begin  encoded_data_P = 8'b1111_0011; flag_p = 1'b1; end  //243
			10'b00_1011_0001 : begin  encoded_data_P = 8'b1111_0100; flag_p = 1'b1; end  //244
			10'b10_1010_0001 : begin  encoded_data_P = 8'b1111_0101; flag_p = 1'b1; end  //245
			10'b01_1010_0001 : begin  encoded_data_P = 8'b1111_0110; flag_p = 1'b1; end  //246
			10'b00_0101_1110 : begin  encoded_data_P = 8'b1111_0111; flag_p = 1'b1; end  //247
			10'b00_1100_1110 : begin  encoded_data_P = 8'b1111_1000; flag_p = 1'b1; end  //248
			10'b10_0110_0001 : begin  encoded_data_P = 8'b1111_1001; flag_p = 1'b1; end  //249
			10'b01_0110_0001 : begin  encoded_data_P = 8'b1111_1010; flag_p = 1'b1; end  //250
			10'b00_1001_1110 : begin  encoded_data_P = 8'b1111_1011; flag_p = 1'b1; end  //251
			10'b00_1110_0001 : begin  encoded_data_P = 8'b1111_1100; flag_p = 1'b1; end  //252
			10'b01_0001_1110 : begin  encoded_data_P = 8'b1111_1101; flag_p = 1'b1; end  //253
			10'b10_0001_1110 : begin  encoded_data_P = 8'b1111_1110; flag_p = 1'b1; end  //254
			10'b01_0100_1110 : begin  encoded_data_P = 8'b1111_1111; flag_p = 1'b1; end  //255
			//command
			10'b11_0000_1011 : begin  encoded_data_P = 8'b0001_1100; flag_p = 1'b1; RxDataK_P = 1'b1; end
			10'b11_0000_0110 : begin  encoded_data_P = 8'b0011_1100; flag_p = 1'b1; RxDataK_P = 1'b1; end
			10'b11_0000_1010 : begin  encoded_data_P = 8'b0101_1100; flag_p = 1'b1; RxDataK_P = 1'b1; end
			10'b11_0000_1100 : begin  encoded_data_P = 8'b0111_1100; flag_p = 1'b1; RxDataK_P = 1'b1; end
			10'b11_0000_1101 : begin  encoded_data_P = 8'b1001_1100; flag_p = 1'b1; RxDataK_P = 1'b1; end
			10'b11_0000_0101 : begin  encoded_data_P = 8'b1011_1100; flag_p = 1'b1; RxDataK_P = 1'b1; end
			10'b11_0000_1001 : begin  encoded_data_P = 8'b1101_1100; flag_p = 1'b1; RxDataK_P = 1'b1; end
			10'b11_0000_0111 : begin  encoded_data_P = 8'b1111_1100; flag_p = 1'b1; RxDataK_P = 1'b1; end
			10'b00_0101_0111 : begin  encoded_data_P = 8'b1111_0111; flag_p = 1'b1; RxDataK_P = 1'b1; end
			10'b00_1001_0111 : begin  encoded_data_P = 8'b1111_1011; flag_p = 1'b1; RxDataK_P = 1'b1; end
			10'b01_0001_0111 : begin  encoded_data_P = 8'b1111_1101; flag_p = 1'b1; RxDataK_P = 1'b1; end
			10'b10_0001_0111 : begin  encoded_data_P = 8'b1111_1110; flag_p = 1'b1; RxDataK_P = 1'b1; end

			default : begin 
					RxDataK_P = 1'b0;
					encoded_data_P = 8'b0000_0000;
					DecodeError_P = 1'b1; // error in decoding 
					flag_p = 1'b0;
			  end 

	endcase 
end




always @(posedge CLK or negedge Rst_n) begin
	if(!Rst_n)
		Data_out <= 8'b0000_0000;
	else if(flag)
		Data_out <= encoded_data_P;
	else
	  Data_out <= encoded_data_N;	
end 


always @(posedge CLK or negedge Rst_n) begin
	if(!Rst_n) begin
	  DisparityError <= 0 ;
    DecodeError    <= 0 ;
    RxDataK        <= 0 ;
  end 
   
	else begin
	   if(flag_n && flag_p)
	      DisparityError <=  0 ;
	   else 
	      DisparityError <= ((!flag && flag_p) || (flag && flag_n)) ? 1'b1 : 1'b0;
   
    DecodeError    <= DecodeError_P & DecodeError_N                        ;
    RxDataK        <= (flag)? RxDataK_P : RxDataK_N                        ;
  end

end 


endmodule 