module memorie(input clk,
					input wr_enable,
					input rd_enable,
					input [7:0] data_in,
					input [7:0] data_in_sram,
					output reg [17:0] addr,
					inout [7:0] sram,
					output reg [7:0] data_out_transcodor);
					
					reg [17:0] counter=0;
					
					assign sram=(~wr_enable & rd_enable)?data_in:8'bz;
					
					always@(posedge clk)
					begin
						
						counter<=counter+1;
						addr<=counter;
						
						if(~rd_enable & wr_enable)
							data_out_transcodor<=sram;
							
					end
					
endmodule
							
						