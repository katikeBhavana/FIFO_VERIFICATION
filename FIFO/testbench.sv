`include "interface.sv"

`include "wr_transaction.sv"
`include "rd_transaction.sv"

`include "wr_generator.sv"
`include "rd_generator.sv"

`include "wr_driver.sv"
`include "rd_driver.sv"

`include "wr_moniter.sv"
`include "rd_moniter.sv"

`include "scoreboard.sv"

`include "wr_environment.sv"
`include "rd_environment.sv"

`include "environment.sv"

`include "test.sv"


module top_tb;

intf vif();

test t;


// DUT instantiation
fifo dut(

.wr_clk(vif.wr_clk),
.rd_clk(vif.rd_clk),
.wr_data(vif.wr_data),
.rd_data(vif.rd_data),
.reset(vif.reset),
.wr_en(vif.wr_en),
.rd_en(vif.rd_en),
.wr_ptr(vif.wr_ptr),
.rd_ptr(vif.rd_ptr),
.empty(vif.empty),
.full(vif.full)

);


// Write clock
always #5 vif.wr_clk = ~vif.wr_clk;


// Read clock
always #7 vif.rd_clk = ~vif.rd_clk;


// Reset
initial
begin

vif.wr_clk = 0;
vif.rd_clk = 0;

vif.reset = 1;

#10
vif.reset = 0;

end


// Start test
initial
begin

t = new(vif);

t.run();

end


endmodule
