module top
       (input clk,
			  input rst_ms,
			  input rst_sm,
			  input en_ms,
			  input en_sm,
			  input [2:0] clk_sel,
			  input [7:0] data_in,
			  output [7:0] data_out);
			  
			  wire [7:0] data;
			  wire sck;
			  wire ss;
			  wire miso;
			  wire mosi;
			  wire busy;
			  wire irq;
			 
			master_SPI master(.data_in(data_in),
									.data_out(data),
									.clk(clk),
									.sck(sck),
									.busy(busy),
									.en(en_ms),
									.rst(rst_ms),
									.clk_sel(clk_sel),
									.ss(ss),
									.mosi(mosi),
									.miso(miso));

			spave_SPI slave(.data_in(data),
								 .data_out(data_out),
								 .busy(busy),
								 .irq(irq),
								 .ss(ss),
								 .en(en_sm),
								 .rst(rst_sm),
								 .mosi(mosi),
								 .miso(miso),
								 .sck(sck));
								 	 
endmodule
									