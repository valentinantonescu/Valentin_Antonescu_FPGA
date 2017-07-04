module top(input clk,
			  input rst,
			  input en,
			  input [2:0] clk_sel,
			  input cpol,
			  input cpha,
			  input [7:0] data_in,
			  output [7:0] data_out);
			  
			  reg [7:0] data;
			  reg sck;
			  reg ss;
			  reg miso;
			  reg mosi;
			 
			master_SPI master(.data_in(data_in),
									.data_out(data),
									.clk(clk),
									.sck(sck),
									.en(en),
									.rst(rst),
									.clk_sel(clk_sel),
									.ss(ss),
									.mosi(mosi),
									.miso(miso));
								
			spave_SPI slave()
									