module clk_VGA(input master_clk,
					output reg VGA_clk);

	reg VGA_clk_reg;

	always@(posedge master_clk)
	begin
		VGA_clk_reg <= ~VGA_clk_reg; 
		VGA_clk <= VGA_clk_reg;
	end
endmodule
