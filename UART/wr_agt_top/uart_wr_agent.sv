class wr_agent extends uvm_agent;

 `uvm_component_utils(wr_agent)
  
  wr_config w_cfg;
  wr_monitor w_mon;
  wr_sequencer w_seqrh;
  wr_driver w_drv;
  
  function new(string name = "wr_agent" , uvm_component parent);
  super.new(name,parent);
  endfunction

  extern function void build_phase(uvm_phase phase);
  extern function void connect_phase(uvm_phase phase);

endclass

  function void wr_agent::build_phase(uvm_phase phase);
  super.build_phase(phase);
  
  if(!uvm_config_db#(wr_config)::get(this,"","wr_config",w_cfg))
  `uvm_fatal("IN_WR_AGT","YOUR GET METHOD IS NOT WORKING")
   
   w_mon = wr_monitor::type_id::create("w_mon",this);
   
   if(w_cfg.is_active == UVM_ACTIVE)
   begin
    w_seqrh = wr_sequencer::type_id::create("w_seqrh",this);
    w_drv   = wr_driver::type_id::create("w_drv",this);
   end

  endfunction


  function void wr_agent::connect_phase(uvm_phase phase);
   super.connect_phase(phase);
   if(w_cfg.is_active == UVM_ACTIVE)
   w_drv.seq_item_port.connect(w_seqrh.seq_item_export);
  endfunction

     
    
   
