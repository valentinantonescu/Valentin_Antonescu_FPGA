module slave_PS2(input SCL,
					  input SDA,
					  input clk,
					  input rst,
					  output reg [7:0] data_out,
					  output reg data_valid);
					  
					  wire parity;
					  reg state;
					  reg [2:0] bit_counter;
					  reg [7:0] data_out_reg;
					  
					  localparam inactive_state=2'b01,
									 active_state=2'b11,
									 parity_state=2'b10,
									 valid_state=2'b00;
					  
					  assign parity=data_out_reg[0]^data_out_reg[1]^
					  data_out_reg[2]^data_out_reg[3]^data_out_reg[4]^
					  data_out_reg[5]^data_out_reg[6]^data_out_reg[7];
					  
					  always@(negedge SCL) begin
					  
							  case(state)
							  
						inactive_state: begin
							  
							  if(SCL&&~SDA) begin
							  state<=active_state;
							  bit_counter<=3'h0;
							  end
							  else state<=inactive_state;
							  
							  if(~rst) state<=inactive_state;
							  
							  end
							  
						active_state: begin
							  
							  data_out_reg[bit_counter]<=SDA;
							  bit_counter<=bit_counter+1'b1;
							  
							  if(bit_counter==3'h7)
							  state<=parity_state;
							  
							  if(~rst) state<=inactive_state;
							  
							  end
							  
						parity_state: begin
							  
							  if(parity==SDA)
							  state<=valid_state;
							  
							  if(~rst) state<=inactive_state;
							  
							  end
							  
						valid_state: begin
						
								if(SDA)
								state<=inactive_state;
								data_out<=data_out_reg;
								
								end
								
						default: state<=inactive_state;
								
								endcase
								
								end
							  
						always@(posedge clk) begin
						
							if(state<=valid_state) begin
							data_valid<=1'b1;

							end
							
							end

endmodule
