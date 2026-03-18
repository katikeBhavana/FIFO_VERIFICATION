module fifo(
wr_clk,rd_clk,wr_data,rd_data,reset,
wr_en,rd_en,wr_ptr,rd_ptr,empty,full);

input wr_clk,rd_clk;
input [7:0] wr_data;
input reset;
input wr_en,rd_en;

output reg [7:0] rd_data;

// pointer bits = address bits + 1
output reg [4:0] wr_ptr;
output reg [4:0] rd_ptr;

output reg empty;
output reg full;

reg [7:0] mem [0:15];


// WRITE OPERATION
always @(posedge wr_clk or posedge reset)
begin
    if(reset)
        wr_ptr <= 0;
  
  
  //So register uninitialized → simulator shows x    
  //rd_data <= 0;
  //rd_data = 00
    //instead of xx.
  
  
  
    else if(wr_en && !full)
    begin
        mem[wr_ptr[3:0]] <= wr_data;   // use address bits
        wr_ptr <= wr_ptr + 1;
    end
end


// READ OPERATION
always @(posedge rd_clk or posedge reset)
begin
    if(reset)
        rd_ptr <= 0;
    else if(rd_en && !empty)
    begin
        rd_data <= mem[rd_ptr[3:0]];
        rd_ptr <= rd_ptr + 1;
    end
end


// BINARY → GRAY CONVERSION
wire [4:0] wr_ptr_gray;
wire [4:0] rd_ptr_gray;

assign wr_ptr_gray = (wr_ptr >> 1) ^ wr_ptr;
assign rd_ptr_gray = (rd_ptr >> 1) ^ rd_ptr;


// SYNCHRONIZERS (2 flip flops)
reg [4:0] wr_ptr_gray_rd_clk1, wr_ptr_gray_rd_clk2;
reg [4:0] rd_ptr_gray_wr_clk1, rd_ptr_gray_wr_clk2;


// READ PTR → WRITE CLOCK DOMAIN
always @(posedge wr_clk or posedge reset)
begin
    if(reset)
    begin
        rd_ptr_gray_wr_clk1 <= 0;
        rd_ptr_gray_wr_clk2 <= 0;
    end
    else
    begin
        rd_ptr_gray_wr_clk1 <= rd_ptr_gray;
        rd_ptr_gray_wr_clk2 <= rd_ptr_gray_wr_clk1;
    end
end


// WRITE PTR → READ CLOCK DOMAIN
always @(posedge rd_clk or posedge reset)
begin
    if(reset)
    begin
        wr_ptr_gray_rd_clk1 <= 0;
        wr_ptr_gray_rd_clk2 <= 0;
    end
    else
    begin
        wr_ptr_gray_rd_clk1 <= wr_ptr_gray;
        wr_ptr_gray_rd_clk2 <= wr_ptr_gray_rd_clk1;
    end
end


// FULL / EMPTY LOGIC
always @(*)
begin
    // EMPTY
    if(rd_ptr_gray == wr_ptr_gray_rd_clk2)
        empty = 1;
    else
        empty = 0;

    // FULL (2 MSB inverted comparison)
    if(wr_ptr_gray == {~rd_ptr_gray_wr_clk2[4:3], rd_ptr_gray_wr_clk2[2:0]})
        full = 1;
    else
        full = 0;
end

endmodule
