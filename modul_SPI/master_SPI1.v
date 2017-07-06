module master_SPI1
					 (input clk,
					  output sck,
					  input rst,
					  output busy,
					  input en,
					  input cpol,
					  input [3:0] addr,
					  output ss,				  
					  input [2:0] clk_sel,
					  input [7:0] data_in,
					  output reg [7:0] data_out,
					  output reg mosi,
					  input miso);
					  
					  reg [7:0] data, data_out_r;
					  reg mosi_r, miso_r, sck_r, sck_g, ss_r;
					  reg [2:0] ctr_r, ctr;
					  reg [1:0] state;
					  reg [7:0] clk_div;
					  reg [3:0] addr_r;
					  
					  
					  assign busy=(state!=reset_state);
					  assign ss=(state==reset_state);
					  assign sck=(clk_div[clk_sel]);
					  
					  localparam reset_state=2'b01,
									 idle_state=2'b10,
									 running_state=2'b11;

					  always@(posedge clk)
					  begin
					  clk_div<=clk_div+1'b1;
					  end
					  
					  always@(state) begin miso_r=miso;
											 mosi_r=mosi;
											 data_out_r=data_out;
											 ctr_r=ctr;
											 sck_r=sck;
											 sck_g=sck;
											 addr_r=addr;
									 end
					  
					  always@(posedge sck) begin
					  
					  case(state)
					  
					  reset_state: if(~rst) state<=idle_state;
					  else state<=reset_state;
					  
					  idle_state: if(~en) begin
					  if(cpol)
					  if(sck) state<=running_state;
					  else sck_g<=~sck;
					  else if(sck==0) state<=running_state;
					  else sck_g<=~sck;
					  end
					  else state<=idle_state;
					  
					  running_state:
									begin
									if(ctr==3'h7)
									begin
									state<=idle_state;
									data_out_r<=data;
									ctr<=3'h0;
									end
									if(rst) state<=reset_state;
									end
						
						endcase  end
						
						always@(posedge sck) begin
						
						case(state)
						
						running_state: begin
									
									mosi_r<=data_in[7];
									data<={data_in[6:0],miso_r};									
									ctr_r<=ctr_r+1'b1;
									data[0]<=miso_r;
									data_out_r<=data;
									end
									
						idle_state:  begin
										 data<=data_in;
										 end
						
						reset_state: data_out_r<=8'h0;
						
						endcase  end
endmodule
