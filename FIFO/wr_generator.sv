class wr_generator;

wr_transaction tr;
  mailbox #(wr_transaction) wr_gen2drv;

  function new(mailbox #(wr_transaction) wr_gen2drv); 
    
    // #(wr_transaction)  : datatpyes of storing in mailbox

this.wr_gen2drv = wr_gen2drv;

endfunction

task main();

  repeat(5)

begin

tr = new();
  
  assert(tr.randomize());

wr_gen2drv.put(tr);

tr.display("WR_GENERATOR");

end

endtask

endclass
