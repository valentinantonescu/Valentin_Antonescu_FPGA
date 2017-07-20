module modul_PS2 (input SCL,
						input SDA,
						input clk,
						input rst,
						output reg [2:0] direction,
						output data_valid);

						reg [10:0] data_out_reg=0;
						reg [7:0] data_out=0;
						reg [3:0] bit_counter=0;
						reg data_valid_reg;
						//reg stop=1;
						//reg [3:0] timer=0;	
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

							case(data_out)

							8'h1D: direction<=3'b011;
							8'h1C: direction<=3'b010;
							8'h1B: direction<=3'b001;
							8'h23: direction<=3'b000;
							8'h29: direction<=3'b100;

							endcase

						end
						

						always@(posedge clk)
						begin

							if(parity==data_out_reg[9])
								data_valid_reg<=1;

							else data_valid_reg<=1'b0;

						end

endmodule
