module top
			 (input clk,
			  input rst_ms,
			  input rst_sm,
			  input en_ms,
			  input en_sm,
			  input [3:0] addr,
			  input [2:0] clk_sel,
			  input [7:0] data_in_m,
			  input [7:0] data_in_s,
			  output [7:0] data_out_m,
			  output [7:0] data_out_s);
			  
			  wire [15:0] out_dec;
			  wire sck;
			  wire [3:0] w_ss;
			  wire miso;
			  wire mosi;
			  wire busy;
			  wire irq;
			  reg q;
			  
			  always@(*)
			  q=(en_ms&&out_dec[8]);
			 
			master_SPI1 master(.data_in(data_in_m),
									.data_out(data_out_m),
									.clk(clk),
									.sck(sck),
									.busy(busy),
									.en(en_ms),
									.addr(4'h8),
									.rst(rst_ms),
									.clk_sel(clk_sel),
									.ss(w_ss),
									.mosi(mosi),
									.miso(miso));

			slave_SPI1 slave(.data_in(data_in_s),
								 .data_out(data_out_s),
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
									