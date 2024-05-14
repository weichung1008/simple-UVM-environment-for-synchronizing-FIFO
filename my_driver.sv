typedef class my_driver_callback;

class my_driver extends uvm_driver#(my_trans);
  
  `uvm_component_utils(my_driver)
  `uvm_register_cb(my_driver, my_driver_callback)
  
  vif drv_vif;
  my_trans drv_tr, tr_rsp;
  
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
      // callback hook
      `uvm_do_callbacks(my_driver, my_driver_callback, pre_print(this, drv_tr))
      drive();
      seq_item_port.item_done();
      `uvm_info("after item done", $sformatf("drv_tr.wr_en=%0b, drv_tr.rd_en=%0b, drv_tr.data_in=%0h", drv_tr.wr_en, drv_tr.rd_en, drv_tr.data_in), UVM_HIGH)
    end
  endtask
  
  virtual task reset();
    while(!drv_vif.rst_n) begin
      @(drv_vif.drv_cb);
      drv_vif.drv_cb.wr_en <= 1'b0;
      drv_vif.drv_cb.rd_en <= 1'b0;
      drv_vif.drv_cb.data_in <= 16'hffff;
      //@(drv_vif.drv_cb);
    end
  endtask
  
  virtual task drive();
    @(drv_vif.drv_cb); //recommand
    drv_vif.drv_cb.wr_en <= drv_tr.wr_en;
    drv_vif.drv_cb.rd_en <= drv_tr.rd_en;
    if(drv_tr.wr_en) begin
      drv_vif.drv_cb.data_in <= drv_tr.data_in;
      if(!drv_vif.drv_cb.full) begin
        `uvm_info("Push", "Push.", UVM_HIGH)
      end
      else begin
        `uvm_info("FIFO is full", "FIFO is full.", UVM_HIGH)
      end
    end
    else if(drv_tr.rd_en) begin
      if(!drv_vif.drv_cb.empty) begin
        `uvm_info("Pop", "Pop.", UVM_HIGH)
      end
      else begin
        `uvm_info("FIFO is empty", "FIFO is empty.", UVM_HIGH)
      end
    end
    if(drv_vif.interrupt) begin
      `uvm_info("ISR", "Drive specific data when an interrupt happens.", UVM_MEDIUM)
      drv_vif.drv_cb.data_in <= drv_tr.data_in;
    end
    `uvm_info("driver transaction", $sformatf("drv_tr %s", drv_tr.sprint()), UVM_HIGH)
  endtask
    
endclass
