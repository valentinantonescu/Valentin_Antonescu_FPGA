module top(input clk,
			  input rst,
			  output hsync,
			  output vsync,
			  output [17:0] addr,
			  input [7:0] data_in,
			  inout [7:0] data_sram_low,
			  inout [7:0] data_sram_high,
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
			  input wr_rd_enable);
			  
			  wire [9:0] x_pos, y_pos;
			  wire display_enable;
			  	  
			  assign blue_bit3=1'b0;
			  assign green_bits23=2'b0;
			  assign red_bit3=1'b0;
			  
			  sync_VGA sync1(.clk(clk),
								  .rst(rst),
								  .display_enable(display_enable),
								  .hsync(hsync),
								  .vsync(vsync),
								  .x_pos(x_pos),
								  .y_pos(y_pos));
								  
				color_VGA color1(.clk(clk),
									  .x_pos(x_pos),
									  .y_pos(y_pos),
									  .data_in(data_in),
									  .display_enable(display_enable),
									  .data_sram_low(data_sram_low),
									  .data_sram_high(data_sram_high),
									  .addr(addr),
									  .wr_enable(wr_rd_enable),
									  .rd_enable(~wr_rd_enable),
									  .wr_enable_sram(wr_enable_sram),
									  .rd_enable_sram(rd_enable_sram),
									  .data_mask_sram_high(data_mask_high),
									  .data_mask_sram_low(data_mask_low),
									  .chip_enable(chip_enable_sram),
									  .red(red),
									  .blue(blue),
									  .green(green));
									  
endmodule
									  
									  