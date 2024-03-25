class my_isr_seq extends my_sequence;
  `uvm_object_utils(my_isr_seq)
  
  uvm_event int_e;
  
  function new(string name="my_isr_seq");
    super.new(name);
  endfunction
  
  virtual task pre_start();
    int_e=uvm_event_pool::get_global("T_INT");
    //int_e=uvm_event_pool::get_global("T_INT1"); // If the string name doesn't match the name in monitor, the event won't happen.
  endtask
  
  virtual task body();
      `uvm_info(get_full_name(), $sformatf("Wait INT"), UVM_MEDIUM)
      
      int_e.wait_trigger();
      `uvm_info("ISR start", "ISR", UVM_MEDIUM)
      
      grab();
      
      `uvm_do_with(tr, {tr.wr_en==0; tr.rd_en==0; tr.data_in==16'hffff;})
      `uvm_info("ISR", $sformatf("Specify wr_en, rd_en, and data_in on the interface"), UVM_MEDIUM)
      
      ungrab();
      
      int_e.reset();
      `uvm_info("ISR finished", "ISR", UVM_MEDIUM)
  endtask
  
endclass
