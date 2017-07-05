module slave_SPI
           (input sck,
					  input mosi,
					  output reg miso,
					  input ss,
					  input rst,
					  input en,
					  input busy,
					  output irq,
					  input [7:0] data_in,
					  output reg [7:0] data_out);

					  reg [7:0] data;
					  reg [2:0] ctr;
					  reg [1:0] state;
					  reg ss_r;

					  localparam reset_state=2'b00,
									idle_state=2'b01,
									running_state=2'b11;

					  assign irq=(busy==1'b1);

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
									miso<=data_in[0];
									data<={mosi,data_in[6:0]};									
									ctr<=ctr+1'b1;
									if(ctr==3'b111)
									begin
									state<=idle_state;
									data_out<=data;
									end
									if(rst) state<=reset_state;
									end

							default:state<=reset_state;

						endcase
						
						end

						always@(posedge sck) begin
						if(rst)
						begin
						ctr<=3'b0;
						data<=8'b0;
						state<=reset_state;
						data_out<=8'b0;
						end
						else ss_r<=ss; end

endmodule									