class my_trans extends uvm_sequence_item;
  
  rand bit wr_en;
  rand bit rd_en;
  rand bit [15:0]data_in;
       bit [15:0]data_out;
       bit empty;
       bit full;
       bit interrupt;

  `uvm_object_utils_begin(my_trans)
    `uvm_field_int(wr_en, UVM_ALL_ON)
    `uvm_field_int(rd_en, UVM_ALL_ON)
    `uvm_field_int(data_in, UVM_ALL_ON)
    `uvm_field_int(data_out, UVM_ALL_ON)
    `uvm_field_int(empty, UVM_ALL_ON)
    `uvm_field_int(full, UVM_ALL_ON)
    `uvm_field_int(interrupt, UVM_ALL_ON)
  `uvm_object_utils_end
  
  function new(string name="my_trans");
    super.new(name);
  endfunction

  
  constraint data_in_dist
  {
    data_in dist {[0:8191]:/1, [8192:16383]:/1, [16384:24575]:/1, [24576:32767]:/1, [32768:$]:/1};
  }
  
endclass
