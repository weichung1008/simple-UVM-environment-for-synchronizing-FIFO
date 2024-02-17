class test_rd_wr_con extends my_test;
  
  `uvm_component_utils(test_rd_wr_con)
  
  rd_wr_con_seq rwseq;
  
  function new(string name="test_rd_wr_con", uvm_component parent);
    super.new(name, parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    rwseq=rd_wr_con_seq::type_id::create("rwseq");
    uvm_config_db#(int)::set(null, "", "repeat_num", 13);
  endfunction
  
  virtual task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    rwseq.start(env.mst_agt.seqr);
    phase.drop_objection(this);
    phase.phase_done.set_drain_time(this, 50);
  endtask
  
endclass
