class test_rd_wr_mix extends my_test;
  
  `uvm_component_utils(test_rd_wr_mix)
  
  rd_wr_mix_seq mix_seq;
  
  function new(string name="test_rd_wr_mix", uvm_component parent);
    super.new(name, parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    mix_seq=rd_wr_mix_seq::type_id::create("mix_seq");
    uvm_config_db#(int)::set(null, "", "repeat_num", 15);
  endfunction
  
  virtual task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    mix_seq.start(env.mst_agt.seqr);
    phase.drop_objection(this);
    phase.phase_done.set_drain_time(this, 50);
  endtask
  
endclass
