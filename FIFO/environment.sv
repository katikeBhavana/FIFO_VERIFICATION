class environment;

wr_environment wr_env;
rd_environment rd_env;

scoreboard scb;

mailbox #(wr_transaction) wr_mon2scb;
mailbox #(rd_transaction) rd_mon2scb;

virtual intf vif;

function new(virtual intf vif);

this.vif = vif;

wr_mon2scb = new();
rd_mon2scb = new();

wr_env = new(vif , wr_mon2scb);
rd_env = new(vif , rd_mon2scb);

scb = new(wr_mon2scb , rd_mon2scb);

endfunction


task run();

fork

wr_env.run();
rd_env.run();
scb.run();

join

endtask

endclass
