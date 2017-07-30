module testbench_VGA();
  
  reg VGA_clk;
  wire [9:0] x_pos, y_pos;
  wire display_enable;
  wire hsync, vsync;
  
  VGA_sync VGA_test(.VGA_clk(VGA_clk),
                    .x_pos(x_pos),
                    .y_pos(y_pos),
                    .display_enable(display_enable),
                    .hsync(hsync),
                    .vsync(vsync));
  
  initial 
  begin VGA_clk=0;
    
    forever #5 VGA_clk=~VGA_clk;
    
  end
  
  initial
  begin

     #100000000 $stop;
     
  end

endmodule  
