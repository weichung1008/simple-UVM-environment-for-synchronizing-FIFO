class test_full extends my_test;
  
  `uvm_component_utils(test_full)
  
  wr_seq wseq;
  rd_seq rseq;
  
  function new(string name="test_full", uvm_component parent);
    super.new(name, parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    wseq=wr_seq::type_id::create("wseq");
    rseq=rd_seq::type_id::create("rseq");
    uvm_config_db#(int)::set(null, "", "wr_repeat_num", 11);
    uvm_config_db#(int)::set(null, "", "rd_repeat_num", 2);
  endfunction
  
  virtual task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    fork
      wseq.start(env.mst_agt.seqr);
      rseq.start(env.mst_agt.seqr);
    join
    phase.drop_objection(this);
    phase.phase_done.set_drain_time(this, 200);
  endtask
  
endclass
