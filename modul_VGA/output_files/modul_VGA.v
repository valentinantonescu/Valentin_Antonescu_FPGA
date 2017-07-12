module color_VGA(input clk,
					  input [9:0] x_pos,
					  input [9:0] y_pos,
					  input display_enable,
					  input [7:0] data_in,
					  output [7:0] data_out,
					  input [17:0] addr,
					  input wr_enable,
					  input rd_enable,
					  output chip_enable,
					  input data_mask,
					  output [2:0] red,
					  output [2:0] blue,
					  output [1:0] green);
					  
					  reg [17:0] counter=0;
					  reg [2:0] enable={wr_enable,rd_enable,data_mask};
					  
					  assign red=data_in[7:5];
					  assign blue=data_in[4:2];
					  assign green=data_in[1:0];
					  
					  always@(posedge clk)
					  begin
					  
							counter<=counter+1;
							case(enable)
							
							3'b100: begin
							
							
								
							end
								
							3'b101: begin
							
							
								
							end
							
							3'b010: begin
								
							
								
							end
							
							3'b011: begin
							
							
								
							end
							
							endcase
							
							if(counter<=18'b7FFFF)
								data_mask<=1;
							else
								data_mask<=0;
								
							
								
							
								
							
								

					  
					  