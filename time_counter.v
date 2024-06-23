module time_counter(clk, rst_n, g_end, y_end, r_end, fsm_g, fsm_y, fsm_r);
	//input
	input clk;
	input rst_n;
	input fsm_g;
	input fsm_y;
	input fsm_r;
	output wire g_end;
	output wire y_end;
	output wire r_end;

parameter GREEN_TIME = 29;
parameter YELLOW_TIME = 4;
parameter RED_TIME = 2;

reg [7:0] clk_counter;
wire clr_counter;
// resgister
always @(posedge clk or negedge rst_n)
begin
	if(~rst_n)
		clk_counter[7:0] <= 8'd0;
	else if(clr_counter)
		clk_counter[7:0] <= 8'd0;
	else
		clk_counter[7:0] <= clk_counter[7:0] + 1'b1;
end
assign g_end = fsm_g & (clk_counter[7:0] == GREEN_TIME);
assign y_end = fsm_y & (clk_counter[7:0] == YELLOW_TIME);
assign r_end = fsm_r & (clk_counter[7:0] == RED_TIME);
//
assign clr_counter =  g_end | y_end | r_end;
endmodule
