module testbench_PS2();
  
  reg SCL;
  reg SDA;
  reg clk;
  wire [2:0] direction;
  wire [7:0] data_out;
  wire [10:0] data_out_reg;
  wire data_valid;
  wire data_ack;
  
  modul_PS2 PS2_test(.SCL(SCL),
                     .SDA(SDA),
                     .clk(clk),
                     .direction(direction),
                     .data_out(data_out),
                     .data_out_reg(data_out_reg),
                     .data_valid(data_valid),
                     .data_ack(data_ack));
             
              
  initial begin clk=0;
    forever #5 clk=~clk;
  end
  
  initial begin SCL=1;
    forever #20 SCL=~SCL;
  end
  
  initial begin
         SDA=0;
    #120 SDA=1;
    #120 SDA=0;
    #120  SDA=1;
    #80 SDA=0;
    
    #40 SDA=1;
    #40 SDA=0;
    #40  SDA=1;
    #120  SDA=0;
    
    #200 $stop;
    
  end        
  
                     
  
endmodule