class my_env extends uvm_env;
  
  `uvm_component_utils(my_env)
  
  my_agent mst_agt;
  my_agent slv_agt;
  my_scb scb;
  my_cov slv_cov;
  
  function new(string name="my_env", uvm_component parent);
    super.new(name, parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    mst_agt=my_agent::type_id::create("mst_agt", this);
    slv_agt=my_agent::type_id::create("slv_agt", this);
    scb=my_scb::type_id::create("scb", this);
    slv_cov=my_cov::type_id::create("slv_cov", this);
    
    uvm_config_db#(uvm_active_passive_enum)::set(this, "mst_agt", "is_active", UVM_ACTIVE);
    uvm_config_db#(uvm_active_passive_enum)::set(this, "slv_agt", "is_active", UVM_PASSIVE);
  endfunction
  
  virtual function void connect_phase(uvm_phase phase);
    mst_agt.mon.mon_ap.connect(scb.imp_mst);
    slv_agt.mon.mon_ap.connect(scb.imp_slv);
    slv_agt.mon.mon_ap.connect(slv_cov.analysis_export);
  endfunction
  
endclass
