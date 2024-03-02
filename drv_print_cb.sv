class drv_print_cb extends my_driver_callback;
  `uvm_object_utils(drv_print_cb)

  function new(string name="drv_print_cb");
    super.new(name);
  endfunction
  
  function pre_print(my_driver drv, my_trans tr);
    `uvm_info(get_full_name(), "CB test", UVM_MEDIUM)
    tr.print();
  endfunction
  
endclass
