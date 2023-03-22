`timescale 1ns / 1ps

`define ST_IDLE 	3'b000	//idle
`define ST_START	3'b001	//start
`define ST_STOP	3'b010	//stop
`define ST_PAUSE	3'b100	//pause
 
module timer(
    input clk,
	 input   [2:0] ctrl,
	 output [15:0] sec
    );
 
	reg  [2:0] state_reg, state_nxt;
	reg [31:0] cnt_reg, cnt_nxt;
	reg [15:0] sec_reg, sec_nxt;
	
	assign sec = sec_reg;
	
	always @ (posedge clk) begin
		
		cnt_reg <= cnt_nxt;
		sec_reg <= sec_nxt;
		state_reg <= state_nxt;
		
	end
		
	always @ (*) begin
	
		cnt_nxt = cnt_reg;
		sec_nxt = sec_reg;
		state_nxt = state_reg;
		
		case (state_reg)
		
			`ST_IDLE: begin
				if (ctrl[0]==1)
					state_nxt = `ST_START;
				else if (ctrl[1]==1)
					state_nxt = `ST_STOP;
				else if (ctrl[2]==1)
					state_nxt = `ST_PAUSE;
			end
			
			`ST_START: begin
				
				cnt_nxt = cnt_reg + 1;
				
				if (cnt_reg == 49_999_999) begin
					  sec_nxt = sec_reg + 1;
					  cnt_nxt = 0;
				end				
				 
				if (ctrl[0]==1)
					state_nxt = `ST_START;
				else if (ctrl[1]==1)
					state_nxt = `ST_STOP;
				else if (ctrl[2]==1)
					state_nxt = `ST_PAUSE;
			end
			
			`ST_STOP: begin
				cnt_nxt = 0;
				sec_nxt = 0;
		 
				if (ctrl[0]==1)
					state_nxt = `ST_START;
				else if (ctrl[1]==1)
					state_nxt = `ST_STOP;
				else if (ctrl[2]==1)
					state_nxt = `ST_PAUSE;
			end
			
			`ST_PAUSE: begin
				cnt_nxt = cnt_reg;
				if (ctrl[0]==1)
					state_nxt = `ST_START;
				else if (ctrl[1]==1)
					state_nxt = `ST_STOP;
				else if (ctrl[2]==1)
					state_nxt = `ST_PAUSE;
			end
		
		endcase
	
	end
 
endmodule
