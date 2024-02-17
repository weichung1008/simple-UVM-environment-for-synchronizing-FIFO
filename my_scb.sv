`uvm_analysis_imp_decl(_mst)
`uvm_analysis_imp_decl(_slv)

class my_scb extends uvm_scoreboard;
  
  `uvm_component_utils(my_scb)
  
  uvm_analysis_imp_mst#(my_trans,  my_scb) imp_mst;
  uvm_analysis_imp_slv#(my_trans,  my_scb) imp_slv;
  
  //uvm_analysis_imp#(my_trans, my_scb) imp_port; 
  
  my_trans mst_q[$];
  my_trans slv_q[$];
  my_trans scb_mst_tr, scb_slv_tr;
  
  function new(string name="my_scb", uvm_component parent);
    super.new(name, parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    imp_mst=new("imp_mst", this);
    imp_slv=new("imp_slv", this);
    //tr_q=new("tr_q", this);
  endfunction
  
  virtual function void write_mst(my_trans mst_tr);
    `uvm_info("scb write mst", $sformatf("mst_tr.data_in=%h", mst_tr.data_in), UVM_HIGH)
    if(mst_tr.wr_en)
      mst_q.push_back(mst_tr);
  endfunction
  
  virtual function void write_slv(my_trans slv_tr);
    `uvm_info("scb write slv", $sformatf("slv_tr.data_out=%h", slv_tr.data_out), UVM_HIGH)
    if(slv_tr.rd_en & !slv_tr.empty)
      slv_q.push_back(slv_tr);
  endfunction
  
  virtual task run_phase(uvm_phase phase);
    forever begin
      wait((mst_q.size()>0) && (slv_q.size()>0));
      
      foreach(mst_q[i])
        `uvm_info("debug", $sformatf("%d: mst_q.data_in=%h", i, mst_q[i].data_in), UVM_HIGH)
      foreach(slv_q[i])
        `uvm_info("debug", $sformatf("%d: slv_q.data_out=%h", i, slv_q[i].data_out), UVM_HIGH)
      
      scb_mst_tr=mst_q.pop_front();
      scb_slv_tr=slv_q.pop_front();
      `uvm_info(get_full_name(), "Compare output data from FIFO", UVM_MEDIUM)
      if(scb_mst_tr.data_in==scb_slv_tr.data_out)
        `uvm_info("compare pass", $sformatf("Correct. data in : %0h, data out : %0h", scb_mst_tr.data_in, scb_slv_tr.data_out), UVM_MEDIUM)
      else
        `uvm_info("compare fail", $sformatf("Wrong. data in : %0h, data out : %0h", scb_mst_tr.data_in, scb_slv_tr.data_out), UVM_MEDIUM)
    end
  endtask
  
endclass
