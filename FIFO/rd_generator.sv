class rd_generator;

rd_transaction tr;

  mailbox #(rd_transaction) rd_gen2drv;

  function new(mailbox #(rd_transaction) rd_gen2drv);

this.rd_gen2drv = rd_gen2drv;

endfunction

task main();
#100;   // wait until writes happen
  repeat(5)

begin

tr = new();

assert(tr.randomize());

rd_gen2drv.put(tr);

tr.display("RD_GENERATOR");

end

endtask

endclass
