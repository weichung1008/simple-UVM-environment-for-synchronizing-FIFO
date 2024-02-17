class test_rd_only extends my_test;
  
  `uvm_component_utils(test_rd_only)
  
  rd_seq rseq;
  
  function new(string name="test_rd_only", uvm_component parent);
    super.new(name, parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    rseq=rd_seq::type_id::create("rseq");
    uvm_config_db#(int)::set(null, "", "rd_repeat_num", 3);
  endfunction
  
  virtual task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    rseq.start(env.mst_agt.seqr);
    phase.drop_objection(this);
    phase.phase_done.set_drain_time(this, 50);
  endtask
  
endclass
