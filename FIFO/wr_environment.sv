class wr_environment;

wr_generator gen;
wr_driver drv;
wr_moniter mon;

mailbox #(wr_transaction) wr_gen2drv;
mailbox #(wr_transaction) wr_mon2scb;

virtual intf vif;

function new(virtual intf vif,
             mailbox #(wr_transaction) wr_mon2scb);

this.vif = vif;
this.wr_mon2scb = wr_mon2scb;

wr_gen2drv = new();

gen = new(wr_gen2drv);
drv = new(wr_gen2drv , vif);
mon = new(wr_mon2scb , vif);

endfunction


task run();

fork

gen.main();
drv.main();
mon.main();

join

endtask

endclass
