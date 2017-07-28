module modul_PS2 (input SCL,
						input SDA,
						input clk,
						output reg [2:0] direction);

						reg [10:0] data_out_reg;
						reg [2:0] last_direction;
						reg [7:0] data_out;
						reg [3:0] bit_counter;
						reg data_valid, data_ack;
						
						parameter w=3'b011,a=3'b010,s=3'b001,d=3'b000, rst=3'b100;
						
						initial
						begin
						
							direction=rst;
							last_direction=rst;
							
						end

						always@(negedge SCL)
						begin
							
							data_out_reg[10:0]<={SDA, data_out_reg[10:1]};
							
							if(bit_counter==10)
							begin
								
								data_ack<=1;
								bit_counter<=0;
								
							end
								
							else begin
							
								bit_counter<=bit_counter+1;
								data_ack<=0;
							
							end

						end
						

						always@(posedge clk)
						begin

							if(data_ack==1)
								data_valid<=1;

							if(data_valid)
							begin
							
								data_out<=data_out_reg[8:1];
							
								case(data_out)

								8'h1D:
								begin
								
									if(last_direction!=s)
									begin
									
										direction<=w;
										last_direction<=direction;
										
									end
									
									else if(last_direction==s)
									direction<=last_direction;
									
								end
								
								8'h1C:
								begin
								
									if(last_direction!=d)
									begin
									
										direction<=a;
										last_direction<=direction;
										
									end
									
									else if(last_direction==d)
									direction<=last_direction;
									
								end
								
								8'h1B:
								begin
								
									if(last_direction!=w)
									begin
									
										direction<=s;
										last_direction<=direction;
										
									end
									
									else if(last_direction==w)
									direction<=last_direction;
									
								end
								
								8'h23:
								begin
								
									if(last_direction!=a)
									begin
									
										direction<=d;
										last_direction<=direction;
										
									end
									
									else if(last_direction==a)
									direction<=last_direction;
									
								end
								
								8'h29: direction<=rst;
								
								default: direction<=direction; 

								endcase
							
							end
							
						end

endmodule
