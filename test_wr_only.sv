class test_wr_only extends my_test;
  
  `uvm_component_utils(test_wr_only)
  
  wr_seq wseq;
  
  function new(string name="test_wr_only", uvm_component parent);
    super.new(name, parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    wseq=wr_seq::type_id::create("wseq");
    uvm_config_db#(int)::set(null, "", "wr_repeat_num", 4);
  endfunction
  
  virtual task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    wseq.start(env.mst_agt.seqr);
    phase.drop_objection(this);
    phase.phase_done.set_drain_time(this, 50);
  endtask
  
endclass
