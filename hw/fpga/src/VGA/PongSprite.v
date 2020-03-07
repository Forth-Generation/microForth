module PongSprite
#( parameter XSIZE = 20,
   parameter YSIZE = 20
)
(
	input px_clk,
	input rst,
	input wire  [15:0] data_in,
	input wire  x_N_loc_en,
	input wire  y_N_loc_en,
	input wire  screenbegin,
	input wire  [15:0] h_addr, 
	input wire  [15:0] v_addr,
	output reg sprite_on
);


	reg [15:0] x_N_loc; 
	reg [15:0] y_N_loc;
	reg [15:0] x_loc;
	reg [15:0] y_loc;
	reg update_x, update_y;
	wire[15:0] x_rel_addr, y_rel_addr;
	wire sprite_onN;

	assign x_rel_addr = h_addr- x_loc;
	assign y_rel_addr = v_addr - y_loc;

	assign sprite_onN = ((x_rel_addr < XSIZE) && ~x_rel_addr[15]) & ((y_rel_addr < YSIZE) && ~y_rel_addr[15]);

	always @(posedge px_clk) begin
		if(rst) begin
			sprite_on <= 1'b0; 
			x_N_loc <= 16'b0; 
			y_N_loc <= 16'b0; 
			update_x <= 1'b0; 
			update_y <= 1'b0;
			x_loc <= 16'b0; 
			y_loc <= 16'b0;
		end else begin
			sprite_on <= sprite_onN;
			if(x_N_loc_en) begin
				x_N_loc <= data_in;
			end
			if(y_N_loc_en) begin
				y_N_loc <= data_in;
			end
	
			if(screenbegin) begin
				x_loc <= update_x ? x_N_loc : x_loc;
				y_loc <= update_y ? y_N_loc : y_loc;
			end
			
			case({x_N_loc_en,(update_x&screenbegin)})
				2'b10, 2'b11 : update_x <= 1'b1;
				2'b01 : update_x <= 1'b0;
				default : update_x <= update_x;
			endcase
			
			case({y_N_loc_en,(update_y&screenbegin)})
				2'b10,2'b11 : update_y <= 1'b1;
				2'b01 : update_y <= 1'b0;
				default : update_y <= update_y;
			endcase
			
			
		end	

	end



/*
vga1280x1024 display (
	.px_clk			(px_clk),
	.rst 			(rst),
	.hsync			(VGA_HS),
	.vsync			(VGA_VS),
	.h_addr					(h_addr),
	.v_addr					(v_addr)
);

    wire sq_a, sq_b, sq_c, sq_d;
    assign sq_a = ((x > 120) & (y >  40) & (x < 280) & (y < 200)) ? 1 : 0;
    assign sq_b = ((x > 200) & (y > 120) & (x < 360) & (y < 280)) ? 1 : 0;
    assign sq_c = ((x > 280) & (y > 200) & (x < 440) & (y < 360)) ? 1 : 0;
    assign sq_d = ((x > 1000) & (y > 900) & (x < 1279) & (y < 1023)) ? 1 : 0;

    assign VGA_R[3] = sq_b;         // square b is red
    assign VGA_G[3] = sq_a | sq_d;  // squares a and d are green
    assign VGA_B[3] = sq_c;         // square c is blue
*/
endmodule
