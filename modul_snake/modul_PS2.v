module modul_PS2 (input SCL,
						input SDA,
						input clk,
						input rst,
						output reg [4:0] direction,
						output data_valid,
						output reg rst_game=0);

						reg [10:0] data_out_reg=0;
						reg [7:0] data_out;
						reg [3:0] bit_counter;
						reg data_valid_reg;
						wire parity;

					   assign parity=data_out_reg[10]^data_out_reg[8]^
					   data_out_reg[7]^data_out_reg[6]^data_out_reg[5]^
					   data_out_reg[4]^data_out_reg[3]^data_out_reg[2]^
					   data_out_reg[1]^data_out_reg[0];

					   assign data_valid=data_valid_reg;

						always@(negedge SCL)
						begin

							data_out_reg[bit_counter]<=SDA;
							bit_counter<=bit_counter+1;

							if(bit_counter==10)
							begin
							
								bit_counter<=0;

								if(data_valid_reg)
								begin

									data_out<=data_out_reg[8:1];

								end
							end
						end

						always@(posedge clk)
							begin

								if(~rst)
									data_valid_reg<=0;

								if(parity==data_out_reg[9])
									data_valid_reg<=1;

							end
							
						always@(data_out)
						begin
						
						case(data_out)
						
						8'h1D: direction=5'b00010;
						8'h1C: direction=5'b00100;
						8'h1B: direction=5'b01000;
						8'h23: direction=5'b10000;
						default: direction=direction;
						
						endcase
						
						end
endmodule