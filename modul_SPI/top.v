module top
			 (input clk,
			  input rst_ms,
			  input rst_sm,
			  input en_ms,
			  input en_sm,
			  input [3:0] addr,
			  input [2:0] clk_sel,
			  input [7:0] data_in,
			  output [7:0] data_out);
			  
			  wire [7:0] data;
			  wire [15:0] out_dec;
			  wire sck;
			  wire [3:0] w_ss;
			  wire miso;
			  wire mosi;
			  wire busy;
			  wire irq;
			 
			master_SPI1 master(.data_in(data_in),
									.data_out(data),
									.clk(clk),
									.sck(sck),
									.busy(busy),
									.en(en_ms),
									.rst(rst_ms),
									.clk_sel(clk_sel),
									.ss(w_ss),
									.mosi(mosi),
									.miso(miso));

			slave_SPI1 slave(.data_in(data),
								 .data_out(data_out),
								 .clk(sck),
								 .busy(busy),
								 .ss(out_dec[8]),
								 .en(en_sm),
								 .rst(rst_sm),
								 .mosi(mosi),
								 .miso(miso));
								 
			decodor_SPI1 decodor(.enable(en_ms),
										.in(w_ss),
										.out(out_dec));
								 	 
endmodule
									