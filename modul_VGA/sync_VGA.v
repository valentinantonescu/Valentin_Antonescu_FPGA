module sync_VGA(input clk,
			  input rst,
			  output display_enable,
			  output reg hsync=0,
			  output reg vsync=0,
			  output [9:0] x_pos,
			  output [9:0] y_pos);
			  
			  reg [10:0] counter_h=0;
			  reg [9:0] counter_v=0;
			  reg active_h;
			  reg active_v;
			  
			  assign display_enable=(active_h && active_v);
			  assign x_pos=display_enable?counter_h[9:0]:10'bz;
			  assign y_pos=display_enable?counter_v:10'bz;
			  
			  always@(posedge clk)
			  begin
					
					counter_h<=counter_h+1;
					
					if(counter_h>799)
						active_h<=0;
					else active_h<=1;
						
					if(counter_h>855 && counter_h<975)
						hsync<=1;
					else hsync<=0;
						
					if(counter_h==1039)
					begin
						counter_h<=0;
						counter_v<=counter_v+1;
					end
					
					if(counter_v>599)
						active_v<=0;
					else active_v<=1;
					
					if(counter_v>636 && counter_v<642)
						vsync<=1;
					else vsync<=0;
					
					if(counter_v==665)
					begin
						
						counter_h<=0;
						counter_v<=0;
						
					end
					
					if(~rst)
					begin
						
						counter_h<=0;
						counter_v<=0;
					 
					end
					
					end
					
endmodule
				