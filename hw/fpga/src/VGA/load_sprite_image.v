module load_sprite_image(
		input clk, rst,
		input loading_loc,
		input linebegin,
		input [8:0] mem_addr_0, mem_addr_1, mem_addr_2, mem_addr_3, mem_addr_4,
		
		output reg [8:0] mem_addr_out,
		output reg [4:0] load_en,
		output reg img_load_done
);
reg [2:0] cnt;


reg state_reg;

wire eq_max;
reg shft_en;
reg loading_loc1;
wire f_edge;
reg img_load_doneN;

parameter IDLE = 1'b0;
parameter LOAD = 1'b1;

assign eq_max = (cnt == 3'd5);
assign f_edge = loading_loc1 & ~loading_loc;

always @(posedge clk) begin
	if(rst) begin
		state_reg <= 1'b0;cnt<= 3'b0; load_en <= 5'b0; loading_loc1 <= 0; img_load_doneN <= 0; shft_en <= 0; img_load_done <= 0;
	end 
	else begin
	img_load_done <= img_load_doneN;
		case(state_reg)
			IDLE : begin
						casez({loading_loc,linebegin, f_edge})
								3'b1??			:  begin state_reg <= IDLE; shft_en <=0; end
								3'b01?			:  begin state_reg <= LOAD; shft_en <=0; end
								3'b000			:  begin state_reg <= IDLE; shft_en <=0; end
								3'b001         :  begin state_reg <= LOAD; shft_en <=0; end
								default			:  begin state_reg <= IDLE; shft_en <=0; end
						endcase
						img_load_doneN <= 0;
						
//						if(load_loc_done) begin
//							shft_en <= 1;
//							state_reg <= LOAD;
//						end
//						else begin
//							shft_en <= 0;
//							state_reg <= IDLE;
//						end
						
			end
			LOAD :  begin
							if(eq_max) begin
								shft_en <= 1; state_reg <= IDLE;
								img_load_doneN  <= 1;
							end
							else begin
								shft_en <= 1; state_reg <= LOAD;
								img_load_doneN <= 0;
							end
						end
			endcase
	end
//	
	loading_loc1 <= loading_loc;
//	
//	//counter
	if(state_reg == LOAD) cnt <= cnt+1;
	else cnt <= 3'b0;
	
//	if(1) cnt <= cnt+1;
//	else cnt <= 3'b0;
//	
//	//shft reg
		if(shft_en) begin
			if(load_en == 5'b00000) load_en[0] <= 1'b1;
			else load_en[0] <= 1'b0;
			load_en[4:1] <= load_en[3:0];
		end
//	
end


always @(posedge clk) begin
	case(cnt)
		5'd0 : mem_addr_out <= mem_addr_0;
		5'd1 : mem_addr_out <= mem_addr_1;
		5'd2 : mem_addr_out <= mem_addr_2;
		5'd3 : mem_addr_out <= mem_addr_3;
		5'd4 : mem_addr_out <= mem_addr_4;
		default : mem_addr_out <= 9'd0;
	endcase
end	


endmodule