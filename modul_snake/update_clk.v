module update_clk(input clk,
						output reg update);
						
	reg [21:0]counter;	

	always@(posedge clk)
	begin
		counter <= counter + 1;
		if(counter == 1777777)
		begin
			update <= ~update;
			counter <= 0;
		end
		
	end
	
endmodule
