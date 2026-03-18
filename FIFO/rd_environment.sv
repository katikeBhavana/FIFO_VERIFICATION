class rd_environment;

rd_generator gen;
rd_driver drv;
rd_moniter mon;

mailbox #(rd_transaction) rd_gen2drv;
mailbox #(rd_transaction) rd_mon2scb;

virtual intf vif;

function new(virtual intf vif,
             mailbox #(rd_transaction) rd_mon2scb);

this.vif = vif;
this.rd_mon2scb = rd_mon2scb;

rd_gen2drv = new();

gen = new(rd_gen2drv);
drv = new(rd_gen2drv , vif);
mon = new(rd_mon2scb , vif);

endfunction


task run();

fork

gen.main();
drv.main();
mon.main();

join

endtask

endclass
