interface my_intf(input logic clk, rst_n);
  
  parameter WIDTH=16;
 
  logic wr_en;
  logic rd_en;
  logic empty;
  logic full;
  logic [WIDTH-1:0]data_in;
  logic [WIDTH-1:0]data_out;
  logic interrupt;
  
  clocking drv_cb@(posedge clk);
    output wr_en;
    output rd_en;
    output data_in;
    input  empty;
    input  full;
    input  data_out;
  endclocking
  
  clocking mon_cb@(posedge clk);
    input wr_en;
    input rd_en;
    input empty;
    input full;
    input data_in;
    input data_out;
  endclocking
  
endinterface

typedef virtual my_intf vif;
