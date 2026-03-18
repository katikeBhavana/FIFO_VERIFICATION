interface intf;

logic wr_clk;
logic rd_clk;
logic reset;

logic wr_en;
logic rd_en;

logic [7:0] wr_data;
logic [7:0] rd_data;

logic full;
logic empty;

logic [4:0] wr_ptr;   
logic [4:0] rd_ptr;

endinterface
