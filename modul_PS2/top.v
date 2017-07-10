module top(input rst,
			  input SCL,
			  input SDA,
			  input clk,
			  output data_valid,
			  output [6:0] ms_out,
			  output [6:0] ls_out);

			  wire [7:0] data_out;

			  slave2_PS2 PS2(.clk(clk),
								 .SDA(SDA),
								 .SCL(SCL),
								 .rst(rst),
								 .data_valid(data_valid),
								 .data_out(data_out));
						 
			  transcodor transcodor_ms(.s(data_out[7:4]),
												.q(ms_out));
			
			  transcodor transcodor_ls(.s(data_out[3:0]),
												.q(ls_out));
			
endmodule
