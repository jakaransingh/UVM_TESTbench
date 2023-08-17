class wr_agt_top extends uvm_agent;
 
//import uart_test_pkg::*;
   //import uvm_pkg.sv
//	import uvm_pkg::*;
	
  `uvm_component_utils(wr_agt_top)

   wr_agent w_agt[];
   env_config e_cfg;
  
   function new(string name = "wr_agt_top" , uvm_component parent);
    super.new(name,parent);
   endfunction

   extern function void build_phase(uvm_phase phase);

endclass
   
   function void wr_agt_top::build_phase(uvm_phase phase);
     super.build_phase(phase);
    
     if(!uvm_config_db#(env_config)::get(this,"","env_config",e_cfg))
      `uvm_fatal("WRITE_AGT_TOP","YOUR GET METHOD IS NOT WORKING")
     if(e_cfg.has_wr_agt)
     begin
      w_agt = new[e_cfg.no_of_wr_agt];
      foreach(w_agt[i])
      begin
      w_agt[i] = wr_agent::type_id::create($sformatf("w_agt[%0d]",i),this);
      uvm_config_db#(wr_config)::set(this,$sformatf("w_agt[%0d]*",i),"wr_config",e_cfg.w_cfg[i]);
      end
     end 
      
    endfunction
    
      
