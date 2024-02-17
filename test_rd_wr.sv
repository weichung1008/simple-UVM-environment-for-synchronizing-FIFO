class test_rd_wr extends my_test;
  
  `uvm_component_utils(test_rd_wr)
  
  wr_seq wseq;
  rd_seq rseq;
  
  function new(string name="test_rd_wr", uvm_component parent);
    super.new(name, parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    wseq=wr_seq::type_id::create("wseq");
    rseq=rd_seq::type_id::create("rseq");
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
