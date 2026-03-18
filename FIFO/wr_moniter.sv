class wr_moniter;

wr_transaction tr;

  mailbox #(wr_transaction) wr_mon2scb;

virtual intf vif;

  function new(mailbox #(wr_transaction) wr_mon2scb, virtual intf vif);

this.wr_mon2scb = wr_mon2scb;
this.vif = vif;

endfunction

task main();

forever

begin

@(posedge vif.wr_clk);

if(vif.wr_en)

begin

tr = new();

tr.wr_en = vif.wr_en;
tr.wr_data = vif.wr_data;
tr.full = vif.full;
tr.wr_ptr = vif.wr_ptr;

wr_mon2scb.put(tr);

tr.display("WR_MONITER");

end

end

endtask

endclass
