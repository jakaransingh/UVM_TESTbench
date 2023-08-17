class rd_agent extends uvm_agent;

 `uvm_component_utils(rd_agent)
  
  rd_config r_cfg;
  rd_monitor r_mon;
  rd_sequencer r_seqrh;
  rd_driver r_drv;
  
  function new(string name = "rd_agent" , uvm_component parent);
  super.new(name,parent);
  endfunction

  extern function void build_phase(uvm_phase phase);
  extern function void connect_phase(uvm_phase phase);

endclass

  function void rd_agent::build_phase(uvm_phase phase);
  super.build_phase(phase);
  
  if(!uvm_config_db#(rd_config)::get(this,"","rd_config",r_cfg))
   `uvm_fatal("IN_RD_AGENT","YOUR GET METHOD IS NOT WORKING")
   
   r_mon = rd_monitor::type_id::create("r_mon",this);
   
   if(r_cfg.is_active == UVM_ACTIVE)
   begin
    r_seqrh = rd_sequencer::type_id::create("r_seqrh",this);
    r_drv   = rd_driver::type_id::create("r_drv",this);
   end

  endfunction


  function void rd_agent::connect_phase(uvm_phase phase);
   super.connect_phase(phase);
   if(r_cfg.is_active == UVM_ACTIVE)
   r_drv.seq_item_port.connect(r_seqrh.seq_item_export);
  endfunction

