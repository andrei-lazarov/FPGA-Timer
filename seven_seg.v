
module seven_seg(
	input				clk,
	input	[15:0]	sec,
	output [3:0]	enable,
	output [6:0]	sev
   );
	 
	reg [3:0] enable_reg;
	assign enable = enable_reg;
	reg [6:0] sev_reg;
	assign sev = sev_reg;
	reg [3:0] hex_digit;
	 
	reg [1:0] select_digit_reg, select_digit_nxt;
	reg [31:0] cnt_reg, cnt_nxt;
	 
	always @ (posedge clk) begin
		select_digit_reg <= select_digit_nxt;
		cnt_reg <= cnt_nxt;
	end
	 
	always @ (*) begin
	 
	 	if (select_digit_reg == 3 & cnt_reg == 199_999)
			select_digit_nxt = 0;
		else if (cnt_reg == 199_999) 
			select_digit_nxt = select_digit_reg + 1;
		else
			select_digit_nxt = select_digit_reg;
	
		cnt_nxt = cnt_reg + 1;
		
		if (cnt_reg == 199_999)
			cnt_nxt = 0;
	 
		case (select_digit_reg)
			0 : begin
				enable_reg = 4'b1110;
				hex_digit = sec[3:0];
			end
			
			1 : begin
				enable_reg = 4'b1101;
				hex_digit = sec[7:4];
			end
		
			2 : begin
				enable_reg = 4'b1011;
				hex_digit = sec[11:8];
			end
			
			3 : begin
				enable_reg = 4'b0111;
				hex_digit = sec[15:12];
			end
			
		endcase
	end

   always @(*)
      case (hex_digit)
          4'b0001 : sev_reg = 7'b1111001;   // 1
          4'b0010 : sev_reg = 7'b0100100;   // 2
          4'b0011 : sev_reg = 7'b0110000;   // 3
          4'b0100 : sev_reg = 7'b0011001;   // 4
          4'b0101 : sev_reg = 7'b0010010;   // 5
          4'b0110 : sev_reg = 7'b0000010;   // 6
          4'b0111 : sev_reg = 7'b1111000;   // 7
          4'b1000 : sev_reg = 7'b0000000;   // 8
          4'b1001 : sev_reg = 7'b0010000;   // 9
          4'b1010 : sev_reg = 7'b0001000;   // A
          4'b1011 : sev_reg = 7'b0000011;   // b
          4'b1100 : sev_reg = 7'b1000110;   // C
          4'b1101 : sev_reg = 7'b0100001;   // d
          4'b1110 : sev_reg = 7'b0000110;   // E
          4'b1111 : sev_reg = 7'b0001110;   // F
          default : sev_reg = 7'b1000000;   // 0
      endcase
				
endmodule
