module PongSprite
#( parameter XSIZE = 16,
	parameter XLOC_INITIAL = 0,
	parameter YLOC_INITIAL = 0,
   parameter YSIZE = 16,
	parameter SCALE = 1,
	parameter SPRITE_MEM_LOC = 9'h0a0
)
(
	input px_clk,
	input rst,
	input wire  [15:0] data_in,
	input wire  x_loc_en,
	input wire  y_loc_en,
	input wire  mem_addr_wren,
	input wire  linebegin,
	input wire  [11:0] h_addr, 
	input wire  [10:0] v_addr,
	input wire  line_en,
	
	output reg sprite_on, 
	output wire [8:0] mem_addr
);

	reg [8:0] sprite_mem_start;
	reg [11:0] x_loc;
	reg [10:0] y_loc;
	wire[11:0] x_rel_addr;
	wire[10:0] y_rel_addr;
	wire sprite_onN;
	wire inBox;
	wire inX;
	wire inY;
	wire inc_x;
	wire inc_y;
	
	reg[15:0] line;
	reg[3:0] x_scale_cnt;
	reg[2:0] y_scale_cnt;
	reg[3:0] sprite_data_x_sel;
	reg[3:0] sprite_data_y_sel;
	
	assign x_rel_addr = h_addr - x_loc;
	assign y_rel_addr = v_addr - y_loc;
	assign inc_x = (x_scale_cnt == (SCALE-1));
	assign inc_y = (y_scale_cnt == (SCALE-1));
	
	assign inX = ((x_rel_addr < XSIZE*SCALE) && ~x_rel_addr[11]);
	assign inY = ((y_rel_addr < YSIZE*SCALE) && ~y_rel_addr[10]);
	
	
	assign inBox = inX & inY;
	
	assign sprite_onN = inBox & line[sprite_data_x_sel];
	
	assign mem_addr = sprite_mem_start + {5'b0,sprite_data_y_sel};
	
	always @(posedge px_clk) begin
		if(rst) begin
			x_scale_cnt <= 3'b0; y_scale_cnt <= 3'b0;
			sprite_on <= 1'b0; 
			line <= 16'b0;
//			update_x <= 1'b0; 
//			update_y <= 1'b0;
			sprite_mem_start <= SPRITE_MEM_LOC;
			x_loc <= XLOC_INITIAL; 
			y_loc <= YLOC_INITIAL;
			sprite_data_y_sel <= 0;
			sprite_data_x_sel <= 15;
		end else begin
		
			if(line_en) begin
				line <= data_in;
			end
			else begin
				line <= line;
			end
			sprite_on <= sprite_onN;
			if(x_loc_en) begin
				x_loc <= data_in[11:0];
			end
			if(y_loc_en) begin
				y_loc <= data_in[10:0];
			end
			
			if(inX) begin
				if(inc_x)  x_scale_cnt <= 3'b0;	
				else x_scale_cnt <= x_scale_cnt +1;
			end
			else x_scale_cnt <= 3'b0;
			
			if(x_rel_addr == 12'hffff) begin
				sprite_data_x_sel <= 15;
			end
			else begin
				if(inc_x) sprite_data_x_sel <= sprite_data_x_sel - 1;
				else sprite_data_x_sel <= sprite_data_x_sel;
			end
			
			if(inY && (linebegin == 1)) begin
				if(inc_y)  y_scale_cnt <= 3'b0;	
				else y_scale_cnt <= y_scale_cnt +1;
			end
			else y_scale_cnt <= 3'b0;
			
			if(~inY) sprite_data_y_sel <= 0;
			else sprite_data_y_sel <= sprite_data_y_sel + {{3{1'b0}},((inc_y) && (linebegin == 1))};
			
			
			//sprite_mem_start <= 9'h0a0;
			if(mem_addr_wren) sprite_mem_start <= data_in[8:0];	
			else sprite_mem_start <= sprite_mem_start;
//			if(screenbegin) begin
//				x_loc <= update_x ? x_N_loc : x_loc;
//				y_loc <= update_y ? y_N_loc : y_loc;
//			end
//			
//			case({x_N_loc_en,(update_x&screenbegin)})
//				2'b10, 2'b11 : update_x <= 1'b1;
//				2'b01 : update_x <= 1'b0;
//				default : update_x <= update_x;
//			endcase
//			
//			case({y_N_loc_en,(update_y&screenbegin)})
//				2'b10,2'b11 : update_y <= 1'b1;
//				2'b01 : update_y <= 1'b0;
//				default : update_y <= update_y;
//			endcase
			
			
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
