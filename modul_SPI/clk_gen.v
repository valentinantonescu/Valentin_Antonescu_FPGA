module clk_gen(input en,
					input clk,
					input [2:0] clk_sel,
					output reg sck);

					reg [7:0] cnt;

					always@(posedge clk)
					begin
					if(~en)
					cnt<=cnt+1'b1;
					end

					always@(clk)
					sck<=cnt[clk_sel];

					endmodule
					