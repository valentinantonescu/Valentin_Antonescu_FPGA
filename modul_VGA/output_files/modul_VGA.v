module color_VGA(input clk,
					  input [9:0] x_pos,
					  input [9:0] y_pos,
					  input display_enable,
					  input [15:0] data_in,
					  input [15:0] addr_in,
					  output reg [3:0] red,
					  output reg [3:0] green,
					  output reg [3:0] blue);
					  
					  reg[11:0] memorie [0:65535];
					  
					  always@(posedge clk)
					  begin
							
							
							red<=memorie[addr_in][11:8];
							green<=memorie[addr_in][7:4];
							blue<=memorie[addr_in][3:0];
					  
					  