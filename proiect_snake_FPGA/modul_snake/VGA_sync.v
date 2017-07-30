module VGA_sync(input VGA_clk,
					 output reg [9:0] x_pos=0, y_pos=0,
					 output reg display_enable,
					 output hsync, vsync);

	reg hsync_reg, vsync_reg; 
	
	integer h_front_porch = 640;
	integer h_sync = 656;
	integer h_back_porch = 752;
	integer whole_line = 800;

	integer v_front_porch = 480;
	integer v_sync = 490;
	integer v_back_porch = 492;
	integer whole_frame = 525; 

	always@(posedge VGA_clk)
	begin
		if(x_pos == whole_line)
			x_pos <= 0;
		else
			x_pos <= x_pos + 1;
	end

	always@(posedge VGA_clk)
	begin
		if(x_pos == whole_line)
		begin
			if(y_pos == whole_frame)
				y_pos <= 0;
			else
			y_pos <= y_pos + 1;
		end
	end
	
	always@(posedge VGA_clk)
	begin
		display_enable <= ((x_pos < h_front_porch) && (y_pos < v_front_porch)); 
	end

	always@(posedge VGA_clk)
	begin
		hsync_reg <= ((x_pos >= h_sync) && (x_pos < h_back_porch)); 
		vsync_reg <= ((y_pos >= v_sync) && (y_pos < v_back_porch)); 
	end
 
	assign vsync = ~vsync_reg; 
	assign hsync= ~hsync_reg;

endmodule		