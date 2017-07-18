module random_apple(input VGA_clk,
						  input pos_x, pos_y,
						  input start,
						  output apple);

	wire [9:0] apple_x;
	wire [8:0] apple_y;
	reg apple_in_x, apple_in_y;
	wire [9:0]random_x;
	wire [8:0]random_y;
	
	modul_random random1(VGA_clk, random_x, random_y);
	
	assign apple_x = 0;
	assign apple_y = 0;
	
	always @(negedge VGA_clk)
	begin
	
		apple_in_x <= (pos_x > apple_x && pos_x < (apple_x + 10));
		apple_in_y <= (pos_y > apple_y && pos_y < (apple_y + 10));
		
	end
	
	assign apple = apple_in_x && apple_in_y;
endmodule
