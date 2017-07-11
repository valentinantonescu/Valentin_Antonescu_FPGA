module decodor_SPI1(input [3:0] in,
					input enable,
					output [15:0] out);

					reg [15:0] dec_out;

					always@(enable or in)
					begin
					dec_out=0;
					if(enable)
					begin
					case(in)
					4'h0 : dec_out = 16'hFFFE;
					4'h1 : dec_out = 16'hFFFD;
					4'h2 : dec_out = 16'hFFFB;
					4'h3 : dec_out = 16'hFFF7;
					4'h4 : dec_out = 16'hFFEF;
					4'h5 : dec_out = 16'hFFDF;
					4'h6 : dec_out = 16'hFFBF;
					4'h7 : dec_out = 16'hFF7F;
					4'h8 : dec_out = 16'hFEFF;
					4'h9 : dec_out = 16'hFDFF;
					4'h10 : dec_out = 16'hFBFF;
					4'h11 : dec_out = 16'hF7FF;
					4'h12 : dec_out = 16'hEFFF;
					4'h13 : dec_out = 16'hDFFF;
					4'h14 : dec_out = 16'hBFFF;
					4'h15 : dec_out = 16'h7FFF;
					endcase
					end
					end
					endmodule
					