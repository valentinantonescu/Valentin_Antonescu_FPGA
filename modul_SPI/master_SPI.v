module master_SPI
           (input clk,
					  output sck,
					  input rst,
					  output busy,
					  input en,
					  output ss,
					  input [2:0] clk_sel,
					  input [7:0] data_in,
					  output reg [7:0] data_out,
					  output reg mosi,
					  input miso);
					  
					  reg [7:0] data;
					  reg [2:0] ctr;
					  reg [1:0] state;
					  reg [7:0] clk_div;
					  
					  localparam reset_state=2'b00,
									     idle_state=2'b01,
									     running_state=2'b11;

					  always@(posedge clk)
					  begin
					  clk_div<=clk_div+1'b1;
					  end
					  
					  assign sck=clk_div[clk_sel];			
					  assign busy=(state!=reset_state);
					  assign ss=(state==reset_state);
					  
					  always@(posedge sck) begin
	
						 case(state)
						 									
						 idle_state: begin
									
									if(en)
									begin
									state<=running_state;
									end
									
									if(rst) state<=reset_state;
									end
									
						 running_state: begin
									
									data<=data_in;
									mosi<=data_in[7];
									data={data_in[6:0],miso};									
									ctr<=ctr+1'b1;
									if(ctr==3'b111)
									begin
									state<=idle_state;
									data_out<=data;
									end
									if(rst) state<=reset_state;
									end

						default: state<=reset_state;
						
						endcase
						
						end
						
						always@(posedge clk)
						if(rst)
						begin
						ctr<=3'b0;
						data<=8'b0;
						state<=reset_state;
						data_out<=8'b0;
						clk_div<=8'b0;
						end
						
endmodule
