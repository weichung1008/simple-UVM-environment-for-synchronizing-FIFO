`include "my_intf.sv"
`include "my_trans.sv"
`include "my_sequencer.sv"
`include "my_sequence.sv"
`include "my_driver.sv"
`include "my_monitor.sv"
`include "my_agent.sv"
`include "my_scb.sv"
`include "my_env.sv"
`include "my_test.sv"
`include "test_wr_only.sv"
`include "test_rd_only.sv"
`include "test_rd_wr.sv"
`include "test_rd_wr_con.sv"
`include "test_rd_wr_mix.sv"

module tb_sync_fifo;

	parameter WIDTH=16;

	bit wr_en, rd_en;
  bit [WIDTH-1:0]data_in;
  bit rst_n;
  bit clk;
  bit empty, full;
  bit [WIDTH-1:0]data_out;

  my_intf intf(clk, rst_n);
	
	sync_fifo(
		.wr_en     (intf.wr_en), 
    .rd_en     (intf.rd_en), 
    .data_in   (intf.data_in), 
    .rst_n     (intf.rst_n), 
    .clk       (intf.clk), 
    .empty     (intf.empty),
    .full      (intf.full),
    .data_out  (intf.data_out)
	);
  
  always #5 clk=~clk;
  
  initial begin
		clk=1'b1;
    rst_n=1'b0;
    #25 rst_n=1'b1;
	end
    
	initial begin
		display("%0t : uvm_config_db set block", $time);
    uvm_config_db#(vif)::set(null, "", "drv_vif", intf);
    uvm_config_db#(vif)::set(null, "", "mon_vif", intf);
	end
    
	initial begin
		$display("%0t : run_test block", $time); 
		run_test();
	end
  
	initial begin
		$display("%0t : dump block", $time);
		$dumpfile("dump.vcd");
		$dumpvars;
	end
  
endmodule
