module color2_VGA(input clk,
					  input [9:0] x_pos,
					  input [9:0] y_pos,
					  input display_enable,
					  input [7:0] data_in,
					  inout [7:0] data_sram_low,
					  inout [7:0] data_sram_high,
					  output [17:0] addr,
					  input wr_enable,
					  input rd_enable,
					  output wr_enable_sram,
					  output rd_enable_sram,
					  output data_mask_sram_high,
					  output data_mask_sram_low,
					  output chip_enable,
					  output reg [2:0] red,
					  output reg [2:0] blue,
					  output reg [1:0] green);

					  reg [18:0] counter=0;
					  reg [7:0] data_out_high, data_out_low;

					  assign chip_enable=0;
					  assign data_mask_sram_high=~counter[18];
					  assign data_mask_sram_low=counter[18];
					  assign wr_enable_sram=wr_enable;
					  assign rd_enable_sram=rd_enable;
					  assign addr=(10'd800*y_pos+x_pos);
					  
					  assign data_sram_high=(rd_enable & ~wr_enable & ~data_mask_sram_high)?data_in:8'hz;
					  assign data_sram_low=(rd_enable & ~wr_enable & ~data_mask_sram_low)?data_in:8'hz;
					  
					  always@(posedge clk)
					  begin
							
								counter<=counter+1;
							
								if(counter==19'd480000)
									counter<=0;
							
								if(~rd_enable & wr_enable & ~data_mask_sram_high)
								begin

									red<=data_sram_high[7:5];
									blue<=data_sram_high[4:2];
									green<=data_sram_high[1:0];
									
								end
							
								if(~rd_enable & wr_enable & ~data_mask_sram_low)
								begin
									
									red<=data_sram_low[7:5];
									blue<=data_sram_low[4:2];
									green<=data_sram_low[1:0];
								
								end
							
							
						end
						
endmodule
								  