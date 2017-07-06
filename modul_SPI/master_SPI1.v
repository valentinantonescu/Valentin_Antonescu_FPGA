module master_SPI1
					 (input clk,
					  output sck,
					  input rst,
					  output busy,
					  input en,
					  input cpol,
					  input [3:0] addr,
					  output [3:0] ss,					  
					  input [2:0] clk_sel,
					  input [7:0] data_in,
					  output reg [7:0] data_out,
					  output reg mosi,
					  input miso);
					  
					  reg [7:0] data, data_out_r;
					  reg mosi_r, miso_r, sck_r, sck_g, ss_r;
					  reg [2:0] ctr_r, ctr_q, ctr;
					  reg [1:0] state;
					  reg [7:0] clk_div;
					  reg [3:0] addr_r;
					  
					  
					  assign busy=(state!=reset_state);
					  assign ss=(state==reset_state);
					  assign sck=(clk_div[clk_sel]);
					  
					  localparam reset_state=2'b00,
									 idle_state=2'b01,
									 running_state=2'b11;

					  always@(posedge clk)
					  begin
					  clk_div<=clk_div+1'b1;
					  end
					  
					  always@(*) begin miso_r=miso;
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
					  else if(~sck) state<=running_state;
					  else sck_g<=~sck;
					  end
					  else state<=idle_state;
					  
					  running_state:
									begin
									if(ctr==3'h0)
									begin
									state<=idle_state;
									data_out_r<=data;
									ctr<=3'h7;
									ctr_q<=3'h0;
									end
									if(rst) state<=reset_state;
									end
									
						default: state<=reset_state;
						
						endcase  end
						
						always@(state) begin
						
						case(state)
						
						running_state: begin
									data=data_in;
									mosi_r=data_in[ctr];
									data={data_in[6:0],miso_r};									
									ctr_r=ctr_r-1'b1;
									data[ctr_r-ctr_q]=miso_r;
									ctr_q=ctr_q+1'b1;
									data_out_r=data;
									end
									
						idle_state: data_out_r=8'h0;
						
						reset_state: data_out_r=8'h0;
						
						endcase  end
endmodule
