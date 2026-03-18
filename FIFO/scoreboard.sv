class scoreboard;

  mailbox #(wr_transaction) wr_mon2scb;
  mailbox #(rd_transaction) rd_mon2scb;

  wr_transaction wr_tr;
  rd_transaction rd_tr;

  bit [7:0] queue[$];   // reference FIFO queue
  bit [7:0] exp_data;

  function new(mailbox #(wr_transaction) wr_mon2scb,
               mailbox #(rd_transaction) rd_mon2scb);

    this.wr_mon2scb = wr_mon2scb;
    this.rd_mon2scb = rd_mon2scb;

  endfunction


  // WRITE SIDE CHECK
  task write_check();

    forever begin

      wr_mon2scb.get(wr_tr);

      if(wr_tr.wr_en) begin

        queue.push_back(wr_tr.wr_data);

        $display("SCOREBOARD WRITE : data = %0d pushed to queue",
                 wr_tr.wr_data);

      end

    end

  endtask



  // READ SIDE CHECK
  task read_check();

    forever begin

      rd_mon2scb.get(rd_tr);

      if(rd_tr.rd_en) begin

        if(queue.size()!=0) begin

          exp_data = queue.pop_front();

          if(rd_tr.rd_data == exp_data)
            $display("PASS : rd_data = %0d matched", rd_tr.rd_data);

          else
            $display("FAIL : rd_data = %0d expected = %0d",
                     rd_tr.rd_data, exp_data);

        end

      end

    end

  endtask



  task run();

    fork
      write_check();
      read_check();
    join

  endtask

endclass
