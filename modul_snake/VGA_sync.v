module VGA_sync(input VGA_clk,
					 output reg [9:0] x_pos, y_pos,
					 output reg display_enable,
					 output hsync, vsync);

	reg hsync_reg, vsync_reg; 
	
	integer porchHF = 640; //start of horizntal front porch
	integer syncH = 656;//start of horizontal sync
	integer porchHB = 752; //start of horizontal back porch
	integer maxH = 800; //total length of line.

	integer porchVF = 480; //start of vertical front porch 
	integer syncV = 490; //start of vertical sync
	integer porchVB = 492; //start of vertical back porch
	integer maxV = 525; //total rows. 

	always@(posedge VGA_clk)
	begin
		if(x_pos === maxH)
			x_pos <= 0;
		else
			x_pos <= x_pos + 1;
	end

	always@(posedge VGA_clk)
	begin
		if(x_pos === maxH)
		begin
			if(y_pos === maxV)
				y_pos <= 0;
			else
			y_pos <= y_pos + 1;
		end
	end
	
	always@(posedge VGA_clk)
	begin
		display_enable <= ((x_pos < porchHF) && (y_pos < porchVF)); 
	end

	always@(posedge VGA_clk)
	begin
		hsync_reg <= ((x_pos >= syncH) && (x_pos < porchHB)); 
		vsync_reg <= ((y_pos >= syncV) && (y_pos < porchVB)); 
	end
 
	assign vsync = ~vsync_reg; 
	assign hsync= ~hsync_reg;

endmodule		
