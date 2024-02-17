module sync_fifo#(
	parameter WIDTH=16,
	parameter DEPTH=8,
	parameter PTR_ADDR=3
)
(
	input wr_en,
	input rd_en,
	input [WIDTH-1:0]data_in,
	input rst_n,
	input clk,
	output empty,
	output full,
	output reg [WIDTH-1:0]data_out
);

	reg [WIDTH-1:0]fifo[DEPTH-1:0];
	reg [PTR_ADDR:0]wr_ptr, rd_ptr;
	
	assign full = ((wr_ptr-rd_ptr)==DEPTH);
	assign empty = (wr_ptr==rd_ptr);

	always@(posedge clk or negedge rst_n)
	begin
		if(!rst_n)
			wr_ptr <= 4'h0;
		else if(wr_en && !full)
			wr_ptr <= wr_ptr + 1'b1;
	end
	
	always@(posedge clk or negedge rst_n)
	begin
	  	if(!rst_n)
			rd_ptr <= 4'h0;
		else if(rd_en && !empty)
			rd_ptr <= rd_ptr + 1'b1;
	end
	
	always@(posedge clk or negedge rst_n)
	begin
		if(!rst_n)
			fifo[wr_ptr[PTR_ADDR-1:0]] <= 16'h0;
		else if (wr_en && !full)
			fifo[wr_ptr[PTR_ADDR-1:0]] <= data_in;
	end
	
  assign data_out = (rd_en & !empty) ? fifo[rd_ptr[PTR_ADDR-1:0]] : 16'h0;
	
endmodule
