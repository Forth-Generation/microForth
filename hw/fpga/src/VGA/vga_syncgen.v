module vga1280x1024(
	input wire px_clk,
	input wire rst,
	output wire hsync,
	output wire vsync,
	output wire blanking,
	output wire active,
	output wire screenend,
	output wire animate,
	output wire [11:0] x,
	output wire [10:0] y
);

localparam HS_STA = 16;
localparam HS_END = 16 + 144;
localparam HA_STA = 16 + 144 + 248;
localparam VS_STA = 1024 + 1;
localparam VS_END = 1024 + 1 + 3;
localparam VA_END = 1024;
localparam LINE = 1688;
localparam SCREEN = 1066;

reg [11:0] h_count;
reg [11:0] v_count;

assign hsync = ~((h_count >= HS_STA) & (h_count < HS_END));
assign vsync = ~((v_count >= VS_STA) & (v_count < VS_END));

assign x = (h_count < HA_STA) ? 0 : (h_count - HA_STA);
assign y = (v_count >= VA_END) ? (VA_END - 1) : (v_count);

assign blanking = ((h_count < HA_STA) | (v_count > VA_END - 1));

assign active = ~((h_count < HA_STA) | (v_count > VA_END - 1)); 

assign screenend = ((v_count == SCREEN - 1) & (h_count == LINE));

assign animate = ((v_count == VA_END - 1) & (h_count == LINE));

always @ (posedge px_clk)
begin
	if(rst)
	begin
		h_count <= 0;
		v_count <= 0;
	end
	
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

endmodule
