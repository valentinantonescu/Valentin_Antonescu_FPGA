module slave_SPI1
					 (input clk,
					  input rst,
					  output busy,
					  input en,
					  output ss,
					  input cpol,
					  input [7:0] data_in,
					  output reg [7:0] data_out,
					  output reg mosi,
					  input miso);
					  
					  reg [7:0] data, data_out_r;
					  reg mosi_r, miso_r, clk_g, irq;
					  reg [2:0] ctr_r, ctr_q, ctr;
					  reg [1:0] state;
					  
					  assign busy=(state!=reset_state);
					  assign ss=(state==reset_state);
					  
					  localparam reset_state=2'b00,
									 idle_state=2'b01,
									 running_state=2'b11;
					  
					  always@(*) begin miso_r=miso;
											 mosi_r=mosi;
											 data_out_r=data_out;
											 ctr_r=ctr;
											 clk_g=clk;
											 irq=busy;
									 end
					  
					  always@(posedge clk) begin
					  
					  case(state)
					  
					  reset_state: if(~rst) state<=idle_state;
					  else state<=reset_state;
					  
					  idle_state: if(~en) begin
					  if(irq) state<=idle_state;
					  if(cpol)
					  if(clk) state<=running_state;
					  else clk_g<=~clk;
					  else if(~clk) state<=running_state;
					  else clk_g<=~clk;
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
									miso_r=data_in[ctr];
									data={mosi_r,data_in[6:0]};										
									ctr_r=ctr_r-1'b1;
									data[ctr-ctr_q]=mosi_r;
									ctr_q=ctr_q+1'b1;
									data_out_r=data;
									end
									
						idle_state: data_out_r=8'h0;
						
						reset_state: data_out_r=8'h0;
						
						endcase  end
endmodule
											
						

