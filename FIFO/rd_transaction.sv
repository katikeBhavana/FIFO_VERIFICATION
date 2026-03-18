class rd_transaction;

rand bit rd_en;

bit [7:0] rd_data;
bit empty;
bit [4:0] rd_ptr;
  constraint c1{rd_en ==1'b1;}   // becomes slow read without con

function void display(string name);

$display("%s rd_en=%0d rd_data=%0d empty=%0d rd_ptr=%0d",
name,rd_en,rd_data,empty,rd_ptr);

endfunction

endclass
