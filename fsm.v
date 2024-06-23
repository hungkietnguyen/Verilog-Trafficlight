module fsm(
	//input
	g_end, r_end, y_end, clk, rst_n,
	//output
	fsm_g, fsm_r, fsm_y, street_a, street_b
	);
//interface
input clk;
input rst_n;
input g_end;
input y_end;
input r_end;
output reg [2:0] street_a;
output reg [2:0] street_b;
output wire fsm_g;
output wire fsm_y;
output wire fsm_r;

reg[2:0] next_state, current_state;
//state code
localparam AG_BR = 3'd0;
localparam AY_BR = 3'd1;
localparam AR_BR1 = 3'd2;
localparam AR_BG = 3'd3;
localparam AR_BY = 3'd4;
localparam AR_BR2 = 3'd5;

// next state logic
always @(*)
begin
	case(current_state[2:0])
		AG_BR:
		begin
			if(g_end)
				next_state[2:0] = AY_BR;
			else
				next_state[2:0] = current_state[2:0];
		end
		AY_BR:
		begin
			if(y_end)
				next_state[2:0] = AR_BR1;
			else
				next_state[2:0] = current_state[2:0];
		end
		AR_BR1:
		begin
			if(r_end)
				next_state[2:0] = AR_BG;
			else
				next_state[2:0] = current_state[2:0];
		end
		AR_BG:
		begin
			if(g_end)
				next_state[2:0] = AR_BY;
		        else
				next_state[2:0] = current_state[2:0];
		end
		AR_BY:
		begin
			if(y_end)
				next_state[2:0] = AR_BR2;
			else
				next_state[2:0] = current_state[2:0];
		end
		AR_BR2:
		begin
			if(r_end)
				next_state[2:0] = AG_BR;
			else
				next_state[2:0] = current_state[2:0];
		end
		default: 	next_state[2:0] = current_state[2:0];
	endcase
end
	//register
	always @(posedge clk or negedge rst_n)
	begin
		if(~rst_n)
			current_state[2:0] <= AR_BR1;
		else
			current_state[2:0] <= next_state[2:0];
	end
	//output logic
	always @(*)
	begin
		case(current_state[2:0])
			AG_BR: street_a[2:0] = 3'b100;
			AY_BR: street_a[2:0] = 3'b010;
			default: street_a[2:0] = 3'b001;
		endcase
	end
	always @(*)
	begin
		case(current_state[2:0])
			AR_BG: street_b[2:0] = 3'b001;
			AR_BY: street_b[2:0] = 3'b010;
			default: street_b[2:0] = 3'b100;
		endcase
	end
	assign fsm_g = (current_state[2:0] == AG_BR) | (current_state[2:0] == AR_BG);
	assign fsm_y = (current_state[2:0] == AY_BR) | (current_state[2:0] == AR_BY);
	assign fsm_r = (current_state[2:0] == AR_BR1) | (current_state[2:0] == AR_BR2);
	endmodule




















