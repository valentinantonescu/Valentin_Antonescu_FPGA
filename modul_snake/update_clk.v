module update_clk(input clk,
						input [4:0] speed,
						output reg update);
						
	reg [21:0] counter=0;
	wire [21:0] counter_stop=3600000;

	always@(posedge clk)
	begin
	
		counter <= counter+1;
		
		if(counter == counter_stop-(speed*15000))
		begin
		
			update <= ~update;
			counter <= 0;
			
		end
	end
	
endmodule
