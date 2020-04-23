module vga_sync_gen#(
	parameter HS_FP_WIDTH = 16,
	parameter HS_WIDTH = 144,
	parameter H_BP_WIDTH = 248,
	parameter HA_WIDTH = 1280,
	
	parameter VS_FP_WIDTH = 2,
	parameter VS_WIDTH = 3,
	parameter V_BP_WIDTH = 38,
	parameter VA_WIDTH = 1024
	
)(
	input wire px_clk,
	input wire rst,
	output reg hsync,
	output reg vsync,
	output wire screenbegin,
	output reg [11:0] h_addr,
	output reg [10:0] v_addr
);

localparam HS_STA = HS_FP_WIDTH;
localparam HS_END = HS_STA + HS_WIDTH;
localparam HA_STA = HS_STA + HS_WIDTH + H_BP_WIDTH;
localparam VS_STA = VA_WIDTH-1+VS_FP_WIDTH;//1024 + 1;
localparam VS_END = VA_WIDTH-1+VS_FP_WIDTH+VS_WIDTH;//1024 + 1 + 3;
localparam VA_END = VA_WIDTH;
localparam LINE = HS_STA+HS_WIDTH+H_BP_WIDTH+HA_WIDTH;
localparam SCREEN = VA_WIDTH-1+VS_FP_WIDTH+VS_WIDTH+V_BP_WIDTH;

wire [11:0] h_addrN;
wire [10:0] v_addrN;
wire hsyncN, vsyncN;
reg [11:0] h_count;
reg [11:0] v_count;

assign hsyncN = ~((h_count >= HS_STA) & (h_count < HS_END));
assign vsyncN = ~((v_count >= VS_STA) & (v_count < VS_END));

assign h_addrN = (h_count < HA_STA) ? 0 : (h_count - HA_STA);
assign v_addrN = (v_count >= VA_END) ? (1'b0) : (VA_END-1-v_count);

assign screenbegin = ((v_count == 12'b0) & (h_count == 12'b1));


always @ (posedge px_clk)
begin
	if(rst)
	begin
		h_count <= 0;
		v_count <= 0;
		hsync <= 0;
		vsync <= 0;
		h_addr <= 0;
		v_addr <= 0;
	end else begin
		hsync <= hsyncN;
		vsync <= vsyncN;
		h_addr <= h_addrN;
		v_addr <= v_addrN;
		if(h_count == LINE)
		begin
			h_count <= 0;
			v_count <= v_count + 1;
		end
		else
		begin
			h_count <= h_count + 1;
		end
	
		if(v_count == SCREEN)
		begin
		v_count <= 0;
		end
	end
end

endmodule
