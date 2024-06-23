module fsm_traffic_light(clk, rst_n, street_a, street_b);
	//input
	input clk;
	input rst_n;
	//output
	output [2:0] street_a;
	output [2:0] street_b;
wire fsm_g;
wire fsm_y;
wire fsm_r;
wire g_end;
wire y_end;
wire r_end;

time_counter cnt(. clk(clk), .rst_n(rst_n), .g_end(g_end), .y_end(y_end), .r_end(r_end), .fsm_g(fsm_g), .fsm_y(fsm_y), .fsm_r(fsm_r));
fsm fsm(. clk(clk), .rst_n(rst_n), .g_end(g_end), .y_end(y_end), .r_end(r_end), .fsm_g(fsm_g), .fsm_y(fsm_y), .fsm_r(fsm_r), .street_a(street_a[2:0]), .street_b(street_b[2:0]));

endmodule
