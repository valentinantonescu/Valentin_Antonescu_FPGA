module top(input clk,
			  input rst,
			  input [2:0] clk_sel,
			  output hsync,
			  output vsync,
			  output busy,
			  output [17:0] addr,
			  input [7:0] data_in,
			  inout [7:0] data_sram_low,
			  inout [7:0] data_sram_high,
			  input rd_enable,
			  input wr_enable,
			  output [2:0] red,
			  output [2:0] blue,
			  output [1:0] green,
			  output red_bit3,
			  output blue_bit3,
			  output [1:0] green_bits23,
			  output wr_enable_sram,
			  output rd_enable_sram,
			  output chip_enable_sram,
			  output data_mask_high,
			  output data_mask_low,
			  output display_enable_out,
			  output [6:0] data_out_transcodor_ms,
			  output [6:0] data_out_transcodor_ls);
			  
			  wire [9:0] x_pos, y_pos;
			  wire display_enable;
			  wire sck;
			  	  
			  assign blue_bit3=0;
			  assign green_bits23=0;
			  assign red_bit3=0;
		  	  assign chip_enable_sram=0;
			  //assign rd_enable_sram=0;
			  assign wr_enable_sram=wr_enable;
			  assign rd_enable_sram=rd_enable;
			  assign data_sram_high=8'hz;
			  
			  sync_VGA sync1(.clk(clk),
								  .rst(rst),
								  .display_enable(display_enable),
								  .hsync(hsync),
								  .vsync(vsync),
								  .x_pos(x_pos),
								  .y_pos(y_pos));
								  
				memorie memorie1(.clk(clk),
									 .rd_enable(rd_enable),
									 .wr_enable(wr_enable),
									 .display_enable(display_enable),
									 .display_enable_out(display_enable_out),
									 .x_pos(x_pos),
									 .y_pos(y_pos),
									 .addr(addr),
									 .busy(busy),
									 .data_in(data_in),
									 .sram_low(data_sram_low),
									 .sram_high(data_sram_high),
									 .data_mask_sram_high(data_mask_high),
									 .data_mask_sram_low(data_mask_low),
									 .data_out({red,blue,green}));
									 
				//transcodor transcodor_ms(.s({red, blue[2]}),
					//						    .q(data_out_transcodor_ms));
											  
				//transcodor transcodor_ls(.s({blue[1:0], green}),
					//						    .q(data_out_transcodor_ls));
												 
				clk_gen generator(.clk(clk),
										.sck(sck),
										.clk_sel(clk_sel),
										.en(rd_enable));
									 
									  
endmodule
								  