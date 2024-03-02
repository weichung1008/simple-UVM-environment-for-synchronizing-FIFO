class test_rd_wr_with_cb extends my_test;
  
  `uvm_component_utils(test_rd_wr_with_cb)
  
  wr_seq wseq;
  rd_seq rseq;
  
  drv_print_cb dp_cb;
  
  function new(string name="test_rd_wr_with_cb", uvm_component parent);
    super.new(name, parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    wseq=wr_seq::type_id::create("wseq");
    rseq=rd_seq::type_id::create("rseq");
    uvm_config_db#(int)::set(null, "", "wr_repeat_num", 3);
    uvm_config_db#(int)::set(null, "", "rd_repeat_num", 3);
    dp_cb=drv_print_cb::type_id::create("dp_cb");
  endfunction
  
  function void start_of_simulation_phase(uvm_phase phase);
    uvm_callbacks#(my_driver, my_driver_callback)::add(env.mst_agt.drv, dp_cb);
  endfunction
  
  virtual task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    wseq.start(env.mst_agt.seqr);
    rseq.start(env.mst_agt.seqr);
    phase.drop_objection(this);
    phase.phase_done.set_drain_time(this, 100);
  endtask
  
endclassclass test_rd_wr_with_cb extends my_test;
  
  `uvm_component_utils(test_rd_wr_with_cb)
  
  wr_seq wseq;
  rd_seq rseq;
  
  drv_print_cb dp_cb;
  
  function new(string name="test_rd_wr_with_cb", uvm_component parent);
    super.new(name, parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    wseq=wr_seq::type_id::create("wseq");
    rseq=rd_seq::type_id::create("rseq");
    uvm_config_db#(int)::set(null, "", "wr_repeat_num", 3);
    uvm_config_db#(int)::set(null, "", "rd_repeat_num", 3);
    dp_cb=drv_print_cb::type_id::create("dp_cb");
  endfunction
  
  function void start_of_simulation_phase(uvm_phase phase);
    uvm_callbacks#(my_driver, my_driver_callback)::add(env.mst_agt.drv, dp_cb);
  endfunction
  
  virtual task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    wseq.start(env.mst_agt.seqr);
    rseq.start(env.mst_agt.seqr);
    phase.drop_objection(this);
    phase.phase_done.set_drain_time(this, 100);
  endtask
  
endclass
