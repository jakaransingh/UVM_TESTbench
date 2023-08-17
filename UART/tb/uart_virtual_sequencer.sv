class v_sequencer extends uvm_sequencer#(uvm_sequence_item);
  
 `uvm_component_utils(v_sequencer)
 
  wr_sequencer wseqrh[];
  rd_sequencer rseqrh[];
  env_config e_cfg;
  
  function new(string name = "v_sequencer" , uvm_component parent);
   super.new(name,parent);
  endfunction

  extern function void build_phase(uvm_phase phase);

endclass

  function void v_sequencer::build_phase(uvm_phase phase);
   super.build_phase(phase);
   if(!uvm_config_db#(env_config)::get(this,"","env_config",e_cfg))
    `uvm_fatal("IN_VIRTUAL_SEQUENCER","GET METHOD IS NOT WORKING")
 
     wseqrh = new[e_cfg.no_of_wr_agt];
     rseqrh = new[e_cfg.no_of_rd_agt];
  
   endfunction
