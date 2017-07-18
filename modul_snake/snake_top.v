module snake_top(input start,
					  input clk,
					  input rst_ps2,
					  input SCL,
					  input SDA,
					  output data_valid_ps2,
					  output reg [3:0] red, green, blue,
					  output hsync, vsync);
	
	wire [9:0] x_pos;
	wire [9:0] y_pos;
	reg [9:0] apple_x;
	reg [8:0] apple_y;
	wire [9:0]random_x;
	wire [8:0]random_y;
	wire display_enable;
	wire VGA_clk;
	wire r;
	wire g;
	wire b;
	wire [4:0] direction;
	wire lethal, non_lethal;
	reg bad_collision, good_collision, game_over;
	reg apple_in_x, apple_in_y, apple, border, found;
	integer apple_count, counter1, counter2, counter3;
	reg [6:0] size;
	reg [9:0] snake_x [0:127];
	reg [8:0] snake_y [0:127];
	reg [9:0] snake_head_x;
	reg [9:0] snake_head_y;
	reg snake_head;
	reg snake_body;
	wire update_clk;
	integer max_size = 16;
	

	clk_VGA reduce1(clk, VGA_clk); 
	update_clk update1(clk, update_clk);
	
	VGA_sync sync1(VGA_clk, x_pos, y_pos, display_enable, hsync, vsync);	
	
	modul_PS2 PS2(SCL, SDA, clk, rst_ps2, direction, data_valid_ps2);
	
	modul_random random1(VGA_clk, random_x, random_y);


	always @(posedge VGA_clk)
	begin
	
		border <= (((x_pos>=0) && (x_pos<6) || (x_pos>=635)
		&& (x_pos<641)) || ((y_pos>=0) &&
		(y_pos<6) || (y_pos>=475) && (y_pos<481)));
		
	end
	
	always@(posedge VGA_clk)
	begin
	
		apple_count = apple_count+1;
		
		if(apple_count == 1)
		begin
		
			apple_x <= 20;
			apple_y <= 20;
			
		end
		
		else
		begin
		
			if(good_collision)
			begin
			
				if((random_x<10) || (random_x>630) || (random_y<10) || (random_y>470))
				begin
				
					apple_x <= 40;
					apple_y <= 30;
					
				end
				
				else
				begin
				
					apple_x <= random_x;
					apple_y <= random_y;
					
				end
			end
			
			else if(~start)
			begin
			
				if((random_x<10) || (random_x>630) || (random_y<10) || (random_y>470))
				begin
				
					apple_x <=340;
					apple_y <=430;
					
				end
				
				else
				begin
				
					apple_x <= random_x;
					apple_y <= random_y;
					
				end
			end
		end
	end
	
	always @(posedge VGA_clk)
	begin
	
		apple_in_x <= (x_pos > apple_x && x_pos < (apple_x + 10));
		apple_in_y <= (y_pos > apple_y && y_pos < (apple_y + 10));
		apple = (apple_in_x && apple_in_y);
		
	end
	
	always@(posedge update_clk)
	begin
	
		if(start)
		begin
		
			for(counter1 = 127; counter1 > 0; counter1 = counter1 - 1)
			begin
			
				if(counter1 <= size - 1)
				begin
				
					snake_x[counter1] = snake_x[counter1 - 1];
					snake_y[counter1] = snake_y[counter1 - 1];
					
				end
			end
			
			case(direction)
			
				5'b00010: snake_y[0] <= (snake_y[0] - 10);
				5'b00100: snake_x[0] <= (snake_x[0] - 10);
				5'b01000: snake_y[0] <= (snake_y[0] + 10);
				5'b10000: snake_x[0] <= (snake_x[0] + 10);
			
			endcase	
		end
		
		else if(~start)
		begin
		
			for(counter3 = 1; counter3 < 128; counter3 = counter3+1)
			begin
			
				snake_x[counter3] = 700;
				snake_y[counter3] = 500;
				
			end
		end
	end
	
		
	always@(posedge VGA_clk)
	begin
	
		found = 0;
		
		for(counter2 = 1; counter2 < size; counter2 = counter2 + 1)
		begin
		
			if(~found)
			begin
			
				snake_body = ((x_pos > snake_x[counter2]
				&& x_pos < snake_x[counter2]+10)
				&& (y_pos > snake_y[counter2]
				&& y_pos < snake_y[counter2]+10));
				found = snake_body;
				
			end
		end
	end
	
	always@(posedge VGA_clk)
	begin	
	
		snake_head = (x_pos > snake_x[0]
		&& x_pos < (snake_x[0]+10))
		&& (y_pos > snake_y[0]
		&& y_pos < (snake_y[0]+10));
		
	end
		
	assign lethal = border || snake_body;
	assign non_lethal = snake_head && apple;
	
	always @(posedge VGA_clk)
		if(non_lethal && snake_head)
		begin
		
				good_collision<=1;
				size = size+1;
				
		end
		
		else if(~start)
			size = 1;										
		else
			good_collision=0;
		
	always @(posedge VGA_clk)
		if(lethal && snake_head) bad_collision<=1;
		
		else bad_collision<=0;
		
	always @(posedge VGA_clk)
		if(bad_collision) game_over<=1;
		
		else if(~start) game_over<=0;
								
	assign r = (display_enable && (apple || game_over));
	assign g = (display_enable && ((snake_head || snake_body) && ~game_over));
	assign b = (display_enable && (border && ~game_over) );
	
	always@(posedge VGA_clk)
	begin
	
		red={4{r}};
		green={4{g}};
		blue={4{b}};
		
	end 

endmodule
