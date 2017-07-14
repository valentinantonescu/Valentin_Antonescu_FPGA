module memorie(input clk,
					input wr_enable,
					input rd_enable,
					input display_enable,
					output display_enable_out,
					output busy,
					input [9:0] x_pos, y_pos,
					input [7:0] data_in,
					output [17:0] addr,
					inout [7:0] sram_low,
					inout [7:0] sram_high,
					output data_mask_sram_high,
					output data_mask_sram_low,
					output reg [7:0] data_out);
					
					reg [18:0] counter=0;
					
					assign sram_low=(~wr_enable & rd_enable & ~data_mask_sram_low
					& ~display_enable)
					?data_in:8'bz;
					assign sram_high=(~wr_enable & rd_enable & ~data_mask_sram_high
					& ~display_enable)
					?data_in:8'bz;
					
					assign addr=10'd800*y_pos+x_pos;
					assign display_enable_out=display_enable;
					assign busy=~display_enable;
					assign data_mask_sram_high=~counter[18];
					assign data_mask_sram_low=counter[18];
					
					always@(posedge clk)
					begin
				
						counter<=counter+1;
						
						if(addr==18'd480000)
							counter<=0;

						if(~rd_enable & wr_enable & display_enable)
													
							if(counter[18]==1)
								data_out<=sram_high;
								else data_out<=sram_low;
							
					end
					
endmodule
							
						