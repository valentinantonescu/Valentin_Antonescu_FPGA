module top(input clk,
			  input [7:0] data_in,
			  input rd_enable,
			  input wr_enable,
			  inout [7:0] sram,
			  inout [7:0] useless_data,
			  output wr_enable_sram,
			  output rd_enable_sram,
			  output chip_enable_sram,
			  output ub,
			  output lb,
			  output [17:0] addr,
			  output [6:0] data_out_transcodor_ms,
			  output [6:0] data_out_transcodor_ls);
			  
			  wire [7:0] data_in_transcodor;
			  
			  memorie memorie1(.clk(clk),
									 .rd_enable(rd_enable),
									 .wr_enable(wr_enable),
									 .addr(addr),
									 .data_in(data_in),
									 .sram(sram),
									 .data_out_transcodor(data_in_transcodor));
									 
				transcodor transcodor_ms(.s(data_in_transcodor[7:4]),
											    .q(data_out_transcodor_ms));
											  
				transcodor transcodor_ls(.s(data_in_transcodor[3:0]),
											    .q(data_out_transcodor_ls));
												 
				assign chip_enable_sram=0;
				assign ub=1;
				assign lb=0;
				assign wr_enable_sram=wr_enable;
				assign rd_enable_sram=rd_enable;
				assign useless_data=8'hz;
											  
endmodule
