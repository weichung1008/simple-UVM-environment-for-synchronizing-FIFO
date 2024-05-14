class my_monitor extends uvm_monitor;
  
  `uvm_component_utils(my_monitor)
  
  vif mon_vif;
  my_trans mon_tr;
  uvm_analysis_port#(my_trans) mon_ap;
  
  uvm_event int_e;
  
  function new(string name="my_monitor", uvm_component parent);
    super.new(name, parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    mon_ap=new("mon_ap", this);
    if(!(uvm_config_db#(vif)::get(null, "", "mon_vif", mon_vif)))
      `uvm_fatal("Can not get", "NO mon_vif")
      
    int_e=uvm_event_pool::get_global("T_INT");
  endfunction
      
  virtual task run_phase(uvm_phase phase);
    forever begin      
      mon_tr = my_trans::type_id::create("mon_tr", this);
      
      mon_tr.wr_en = mon_vif.mon_cb.wr_en;
      mon_tr.rd_en = mon_vif.mon_cb.rd_en;
      mon_tr.empty = mon_vif.mon_cb.empty;
      mon_tr.full = mon_vif.mon_cb.full;
      mon_tr.data_in = mon_vif.mon_cb.data_in;
      mon_tr.data_out = mon_vif.mon_cb.data_out;
      mon_tr.interrupt = mon_vif.interrupt;
      `uvm_info("monitor before clock", $sformatf("mon_tr %s", mon_tr.sprint()), UVM_HIGH)
      @(mon_vif.mon_cb);
      `uvm_info("monitor after clock", $sformatf("mon_tr %s", mon_tr.sprint()), UVM_HIGH)
      mon_ap.write(mon_tr);
      fork
        begin
          @(posedge mon_vif.interrupt);
          int_e.trigger();
        end
      join_none
    end
  endtask
  
endclass
