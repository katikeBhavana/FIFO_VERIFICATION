class rd_moniter;

rd_transaction tr;
  mailbox #(rd_transaction) rd_mon2scb;
virtual intf vif;

  function new(mailbox #(rd_transaction) rd_mon2scb, virtual intf vif);
this.rd_mon2scb = rd_mon2scb;
this.vif = vif;
endfunction

task main();

forever begin

@(posedge vif.rd_clk);

if(vif.rd_en)
begin

tr = new();

tr.rd_en = vif.rd_en;

@(posedge vif.rd_clk);

tr.rd_data = vif.rd_data;
tr.empty   = vif.empty;
tr.rd_ptr  = vif.rd_ptr;

rd_mon2scb.put(tr);

tr.display("RD_MONITER");

end

end

endtask

endclass
