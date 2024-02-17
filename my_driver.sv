class my_driver extends uvm_driver#(my_trans);
  
  `uvm_component_utils(my_driver)
  
  vif drv_vif;
  my_trans drv_tr;
  
  function new(string name="my_driver", uvm_component parent);
    super.new(name, parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!(uvm_config_db#(vif)::get(null, "", "drv_vif", drv_vif)))
      `uvm_fatal("Can not get", "NO drv_vif")
  endfunction
  
  virtual task run_phase(uvm_phase phase);
    forever begin
      reset();
      seq_item_port.get_next_item(drv_tr);
      `uvm_info(get_full_name, "after get next item", UVM_HIGH)
      drive();
      seq_item_port.item_done();
      `uvm_info("after item done", $sformatf("drv_tr.wr_en=%0b, drv_tr.rd_en=%0b, drv_tr.data_in=%0h", drv_tr.wr_en, drv_tr.rd_en, drv_tr.data_in), UVM_HIGH)
    end
  endtask
  
  virtual task reset();
    while(!drv_vif.rst_n) begin
      //@(drv_vif.drv_cb);
      drv_vif.drv_cb.wr_en <= 1'b0;
      drv_vif.drv_cb.rd_en <= 1'b0;
      drv_vif.drv_cb.data_in <= 16'hffff;
      @(drv_vif.drv_cb);
    end
  endtask
  
  virtual task drive();
    //@(drv_vif.drv_cb);
    if(drv_tr.wr_en) begin
      if(!drv_vif.drv_cb.full) begin
        drv_vif.drv_cb.wr_en <= drv_tr.wr_en;
        drv_vif.drv_cb.rd_en <= drv_tr.rd_en;
        drv_vif.drv_cb.data_in <= drv_tr.data_in;
      end
      else begin
        `uvm_info("FIFO is full", "FIFO is full.", UVM_MEDIUM)
      end
    end
    else if(drv_tr.rd_en) begin
      if(!drv_vif.drv_cb.empty) begin
        drv_vif.drv_cb.wr_en <= drv_tr.wr_en;
        drv_vif.drv_cb.rd_en <= drv_tr.rd_en;
      end
      else begin
        `uvm_info("FIFO is empty", "FIFO is empty.", UVM_MEDIUM)
      end
    end
    @(drv_vif.drv_cb);
  endtask
    
endclass
