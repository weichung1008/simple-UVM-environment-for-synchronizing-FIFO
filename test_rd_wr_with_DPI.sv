class test_rd_wr_with_DPI extends my_test;
  
  `uvm_component_utils(test_rd_wr_with_DPI)
  
  wr_seq_2 wseq;
  rd_seq_2 rseq;
  
  function new(string name="test_rd_wr_with_DPI", uvm_component parent);
    super.new(name, parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    wseq=wr_seq_2::type_id::create("wseq");
    rseq=rd_seq_2::type_id::create("rseq");
    uvm_config_db#(int)::set(null, "", "wr_repeat_num", 5);
    uvm_config_db#(int)::set(null, "", "rd_repeat_num", 5);
  endfunction
  
  virtual task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    wseq.start(env.mst_agt.seqr);
    rseq.start(env.mst_agt.seqr);
    phase.drop_objection(this);
    phase.phase_done.set_drain_time(this, 100);
  endtask
  
endclass
