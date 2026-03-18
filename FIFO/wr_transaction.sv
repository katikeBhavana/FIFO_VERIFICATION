class wr_transaction;

rand bit wr_en;
rand bit [7:0] wr_data;

bit full;
  bit [4:0] wr_ptr;  // fifo genarates pointer inside .. it is output 
  
  constraint c1{wr_en ==1'b1;} //FIFO sometimes not write . without constraint scb mismatch


function void display(string name);

$display("%s wr_en=%0d wr_data=%0d full=%0d wr_ptr=%0d",
name,wr_en,wr_data,full,wr_ptr);

endfunction

endclass
