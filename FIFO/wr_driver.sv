class wr_driver;

wr_transaction tr;

  mailbox #(wr_transaction) wr_gen2drv;

virtual intf vif;

  function new(mailbox #(wr_transaction) wr_gen2drv, virtual intf vif);

this.wr_gen2drv = wr_gen2drv;
this.vif = vif;

endfunction

task main();

forever

begin

wr_gen2drv.get(tr);

@(posedge vif.wr_clk);
  

//vif.wr_en <= tr.wr_en;

//vif.wr_data <= tr.wr_data;
  
  
if(!vif.full)
begin
    vif.wr_en   <= tr.wr_en;
    vif.wr_data <= tr.wr_data;
end
else
begin
    vif.wr_en <= 0;
end


@(posedge vif.wr_clk);

vif.wr_en <= 0;
  tr.display("WR_DRIVER");

end

endtask

endclass
