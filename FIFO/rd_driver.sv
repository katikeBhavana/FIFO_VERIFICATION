class rd_driver;

rd_transaction tr;
  mailbox #(rd_transaction) rd_gen2drv;
virtual intf vif;

  function new(mailbox #(rd_transaction) rd_gen2drv, virtual intf vif);
this.rd_gen2drv = rd_gen2drv;
this.vif = vif;
endfunction

task main();

forever
begin

rd_gen2drv.get(tr);

@(posedge vif.rd_clk);

// Read only if FIFO not empty
if(!vif.empty)
vif.rd_en <= tr.rd_en;
else
vif.rd_en <= 0;

@(posedge vif.rd_clk);

vif.rd_en <= 0;

tr.display("RD_DRIVER");

end

endtask

endclass
