module slave_SPI2	(input clk,
						 input cpol,
						 input cpha,
						 input en,
						 input rst,
						 output reg miso,
						 input [7:0] data_in,
						 input mosi,
						 output reg busy,
						 input ss,
						 output reg [7:0] data_out);
						 
						 reg [1:0] state;
						 reg [2:0] ctr=0;
						 reg [7:0] data;
						 
						 parameter reset_state=2'b01,
									  idle_state=2'b10,
									  running_state=2'b11;
										
						 always@(posedge clk) begin
						 
						 case(state)
						 
						 reset_state:
							if(~rst)
								state<=idle_state;
							else
								state<=reset_state;
						 
						 idle_state:
						 begin
						 
							ctr<=0;
							if(~en)
								state<=running_state;
							else
								state<=idle_state;
						 end
						 
						 running_state:
						 begin
						
							if(ctr==7)
							begin
								state<=idle_state;
							end
						 else
							begin
						 
								state<=running_state;
								ctr<=ctr+1;
							end
						 end
						 
						 endcase
						 end
						 
						 always@(posedge clk) begin
						 
						 case(state)
						 
						 reset_state: begin
										  busy<=1;
										  data_out<=8'h0;
										  end
										  
						 idle_state: begin
										 busy<=0;
										 data<=data_in;
										 end
										 
						 running_state: begin
											 if(~ss)
											 begin
											 busy<=1;
											 miso<=data_in[7];
											 data<={data[6:0], mosi};
											 data_out<=data;
											 end
											 end

					    endcase
						 end

endmodule
						