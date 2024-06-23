`timescale 1ns/1ps
module tb_fsm_traffic_light;
	reg clk;
	reg rst_n;

	wire [2:0] street_a;
	wire [2:0] street_b;

	fsm_traffic_light UUT(.clk(clk), .rst_n(rst_n), .street_a(street_a[2:0]), .street_b(street_b[2:0]));

	initial begin
		clk = 0;
		forever #10 clk =~clk;
	end
	initial begin
		rst_n = 1'b0;
		#20;
		rst_n = 1'b1;
	end
	endmodule
