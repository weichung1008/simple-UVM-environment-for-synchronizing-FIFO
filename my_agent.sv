class my_agent extends uvm_agent;
  
  `uvm_component_utils(my_agent)
  
  my_sequencer seqr;
  my_driver    drv;
  my_monitor   mon;
  
  function new(string name="my_agent", uvm_component parent);
    super.new(name, parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    mon=my_monitor::type_id::create("mon", this);
    if(get_is_active()==UVM_ACTIVE) begin
      seqr=my_sequencer::type_id::create("seqr", this);
      drv=my_driver::type_id::create("drv", this);
    end
  endfunction
  
  virtual function void connect_phase(uvm_phase phase);
    if(get_is_active()==UVM_ACTIVE)
      drv.seq_item_port.connect(seqr.seq_item_export);
  endfunction
  
endclass
