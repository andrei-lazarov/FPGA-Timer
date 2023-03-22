`timescale 1ns / 1ps

module top_module(
	input clk,
	input [2:0] ctrl,
	output [15:0] sec,
	output [3:0] enable,
	output [6:0] sev
	);
	
	timer t (
	.clk (clk),
	.ctrl (ctrl),
	.sec (sec)
	);
	
	seven_seg ss (
	.clk (clk),
	.sec (sec),
	.sev (sev),
	.enable (enable)
	);

endmodule
