module slave_SPI(input sck,
					  input mosi,
					  output miso,
					  input ss,
					  input en,
					  input busy,
					  output irq,
					  input [7:0] data_in,
					  output [7:0] data_out);
					  
					  reg [7:0] data;
					  reg [2:0] ctr;
					  reg [1:0] state;
					  
					  parameter reset_state=2'b00,
									idle_state=2'b01,
									running_state=2'b11;
									
					  assign ss=(state==running_state||state==reset_state);
					  assign irq=(busy==1'b1);

					  case(state)
					  
					  idle_state: begin
									always@(posedge sck) begin
									if(en)
									begin
									state<=running_state;
									ctr<=3'b0;
									end
									if(rst) state<=reset_state;
									end
									end
					  
					  running_state: begin
									always@(posedge sck) begin
									data<=data_in;
									miso<=data_in[0];
									data={mosi,data_in[6:0]};									
									ctr<=ctr+1'b1;
									if(ctr==3'b111)
									begin
									state<=idle_state;
									data_out<=data;
									end
									if(rst) state<=reset_state;
									end
									end
									
						default: state=idle_state;
						
						endcase
						
						always@(posedge clk)
						if(rst)
						begin
						ctr<=3'b0;
						data<=8'b0;
						state<=reset_state;
						data_out<=8'b0;
						end
						
endmodule									