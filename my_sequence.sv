class my_sequence extends uvm_sequence#(my_trans);
  
  `uvm_object_utils(my_sequence)
  
  int repeat_num;
  int wr_repeat_num, rd_repeat_num;
  my_trans tr;
  
  function new(string name="my_sequence");
    super.new(name);
  endfunction
  
endclass

class wr_seq extends my_sequence;
  
  `uvm_object_utils(wr_seq)
  
  function new(string name="wr_seq");
    super.new(name);
  endfunction
  
  virtual task pre_start();
    if(!(uvm_config_db#(int)::get(null, "", "wr_repeat_num", wr_repeat_num)))
      `uvm_fatal(get_type_name, "NO wr_repeat_num")
    else
      `uvm_info(get_full_name(), $sformatf("wr repeat num=%0d", wr_repeat_num), UVM_MEDIUM)
  endtask
  
  virtual task body();
    repeat(wr_repeat_num) begin
      `uvm_do_with(tr, {tr.wr_en==1; tr.rd_en==0;})
    end
  endtask
  
endclass
    
class rd_seq extends my_sequence;
  
  `uvm_object_utils(rd_seq)
  
  function new(string name="rd_seq");
    super.new(name);
  endfunction
  
  virtual task pre_start();
    if(!(uvm_config_db#(int)::get(null, "", "rd_repeat_num", rd_repeat_num)))
      `uvm_fatal(get_type_name, "NO rd_repeat_num")
    else
      `uvm_info(get_full_name(), $sformatf("rd repeat num=%0d", rd_repeat_num), UVM_MEDIUM)
  endtask
      
  virtual task body();
    repeat(rd_repeat_num) begin
      `uvm_do_with(tr, {tr.wr_en==0; tr.rd_en==1;})
    end
  endtask
  
endclass
    
class rd_wr_con_seq extends my_sequence;
  
  `uvm_object_utils(rd_wr_con_seq)
  
  function new(string name="rd_wr_con_seq");
    super.new(name);
  endfunction
  
  virtual task pre_start();
    if(!(uvm_config_db#(int)::get(null, "", "repeat_num", repeat_num)))
      `uvm_fatal(get_type_name, "NO rd_repeat_num")
    else
      `uvm_info(get_full_name(), $sformatf("repeat num=%0d", repeat_num), UVM_MEDIUM)
  endtask
  
  virtual task body();
    repeat(repeat_num) begin
      `uvm_do_with(tr, {tr.wr_en==1; tr.rd_en==1;})
    end
  endtask
  
endclass

class rd_wr_mix_seq extends my_sequence;
  
  `uvm_object_utils(rd_wr_mix_seq)
  
  function new(string name="rd_wr_mix_seq");
    super.new(name);
  endfunction
  
  virtual task pre_start();
    if(!(uvm_config_db#(int)::get(null, "", "repeat_num", repeat_num)))
      `uvm_fatal(get_type_name, "NO rd_repeat_num")
    else
      `uvm_info(get_full_name(), $sformatf("repeat num=%0d", repeat_num), UVM_MEDIUM)
  endtask
  
  virtual task body();
    repeat(repeat_num) begin
      `uvm_do(tr)
    end
  endtask
  
endclass
