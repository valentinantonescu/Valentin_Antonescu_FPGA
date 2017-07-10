module top
			 (input clk,
			  input rst_ms,
			  input rst_sm,
			  input en_ms,
			  input en_sm,
			  input cpol,
			  input cpha,
			  input [2:0] clk_sel,
			  input [7:0] data_in_m,
			  input [7:0] data_in_s,
			  output [7:0] data_out_m,
			  output [7:0] data_out_s);

			  wire w_ss;
			  wire sck;
			  wire miso;
			  wire mosi;
			  wire busy;
			 
			master_SPI2 master(.data_in(data_in_m),
									.data_out(data_out_m),
									.clk(sck),
									.busy(busy),
									.en(en_ms),
									.cpol(cpol),
									.cpha(cpha),
									.rst(rst_ms),
									.ss(w_ss),
									.mosi(mosi),
									.miso(miso));

			slave_SPI2 slave(.data_in(data_in_s),
								 .data_out(data_out_s),
								 .clk(sck),
								 .busy(busy),
								 .ss(w_ss),
								 .en(en_ms),
								 .rst(rst_ms),
								 .mosi(mosi),
								 .miso(miso));
								 
			clk_gen generator(.en(en_ms),
								   .clk(clk),
									.sck(sck),
									.clk_sel(clk_sel));
								 	 
endmodule
									