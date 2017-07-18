module modul_random(input VGA_clk,
					     output reg [9:0] random_x,
						  output reg [8:0] random_y);

	reg [5:0] point_x, point_y = 10;

	always @(posedge VGA_clk)
		point_x <= point_x + 3;	
		
	always @(posedge VGA_clk)
		point_y <= point_y + 1;
		
	always @(posedge VGA_clk)
	begin	
	
		if(point_x>63)
			random_x <= 620;
		else if (point_x<2)
			random_x <= 20;
		else
			random_x <= (point_x * 9);
			
	end
	
	always @(posedge VGA_clk)
	begin
	
		if(point_y>47)
			random_y <= 460;
		else if (point_y<2)
			random_y <= 20;
		else
			random_y <= (point_y * 9);
			
	end
endmodule
