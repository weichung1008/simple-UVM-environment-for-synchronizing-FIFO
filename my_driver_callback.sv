class my_driver_callback extends uvm_callback;
  `uvm_object_utils(my_driver_callback)
  
  function new(string name="my_driver_callback");
    super.new(name);
  endfunction
  
  virtual function pre_print(my_driver drv, my_trans tr);
  endfunction
  
endclass
