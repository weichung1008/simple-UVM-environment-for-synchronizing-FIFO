class my_cov extends uvm_subscriber#(my_trans);
  `uvm_component_utils(my_cov)
  
  my_trans my_cov_tr;
  
  covergroup cg;
    option.per_instance=1;
    option.comment="coverpoint of my transaction";
    cp_ctl_wr_en: coverpoint my_cov_tr.wr_en;
    cp_ctl_rd_en: coverpoint my_cov_tr.rd_en;
    cp_data_in: coverpoint my_cov_tr.data_in // no semicolon, ";"
    {
      bins d_in[4]={[0:32767]}; // separate 32768 into 4 bins
      bins d_in_5={[32768:$]};  // others
    }
    cp_data_out: coverpoint my_cov_tr.data_out // no semicolon, ";"
    {
      bins d_out[4]={[0:32767]}; // separate 32768 into 4 bins
      bins d_out_5={[32768:$]};  // others
    }
    cp_full: coverpoint my_cov_tr.full;
    cp_empty: coverpoint my_cov_tr.empty;
    cp_interrupt: coverpoint my_cov_tr.interrupt;
  endgroup
  
  function new(string name="my_cov", uvm_component parent);
    super.new(name, parent);
    cg=new;
  endfunction
  
  virtual function void write(my_trans tr);
    my_cov_tr=tr;
    `uvm_info("coverage transaction", $sformatf("my_cov_tr %s", my_cov_tr.sprint()), UVM_HIGH)
    cg.sample();
  endfunction
  
  virtual function void report_phase(uvm_phase phase);
    
    `uvm_info(get_full_name(), $sformatf("functional get_coverage = %.2f %%", cg.get_coverage()), UVM_LOW)
    `uvm_info(get_full_name(), $sformatf("functional get_inst_coverage = %.2f %%", cg.get_inst_coverage()), UVM_LOW)
    `uvm_info(get_full_name(), $sformatf("functional $get_coverage = %.2f %%", $get_coverage()), UVM_LOW)
    
    `uvm_info("", $sformatf("-----------------------Coverage Report-----------------------"), UVM_LOW)
    `uvm_info("", $sformatf("wr en................ %f", cg.cp_ctl_wr_en.get_coverage), UVM_LOW)
    `uvm_info("", $sformatf("rd en................ %f", cg.cp_ctl_rd_en.get_coverage), UVM_LOW)
    `uvm_info("", $sformatf("data in.............. %f", cg.cp_data_in.get_coverage), UVM_LOW)
    `uvm_info("", $sformatf("data out............. %f", cg.cp_data_out.get_coverage), UVM_LOW)
    `uvm_info("", $sformatf("full................. %f", cg.cp_full.get_coverage), UVM_LOW)
    `uvm_info("", $sformatf("empty................ %f", cg.cp_empty.get_coverage), UVM_LOW)
    `uvm_info("", $sformatf("interrupt............ %f", cg.cp_interrupt.get_coverage), UVM_LOW)
    `uvm_info("", $sformatf("Total Coverag........ %f",$get_coverage), UVM_LOW)
    
  endfunction
  
endclass
