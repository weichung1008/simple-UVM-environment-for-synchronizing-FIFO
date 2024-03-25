class test_empty_interrupt extends my_test;
  
  `uvm_component_utils(test_empty_interrupt)
  
  wr_seq wseq;
  rd_seq rseq;
  my_isr_seq isr_seq;
  
  function new(string name="test_empty_interrupt", uvm_component parent);
    super.new(name, parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    wseq=wr_seq::type_id::create("wseq");
    rseq=rd_seq::type_id::create("rseq");
    isr_seq=my_isr_seq::type_id::create("isr_seq");
    uvm_config_db#(int)::set(null, "", "wr_repeat_num", 5);
    uvm_config_db#(int)::set(null, "", "rd_repeat_num", 6);
  endfunction
  
  virtual task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    fork
      isr_seq.start(env.mst_agt.seqr);
    join_none
    fork
      wseq.start(env.mst_agt.seqr);
      rseq.start(env.mst_agt.seqr);
    join
    phase.drop_objection(this);
    phase.phase_done.set_drain_time(this, 200);
  endtask
  
endclass
