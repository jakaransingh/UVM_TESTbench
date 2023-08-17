class rd_agt_top extends uvm_agent;

  `uvm_component_utils(rd_agt_top)

   rd_agent r_agt[];
   env_config e_cfg;
  
   function new(string name = "rd_agt_top" , uvm_component parent);
    super.new(name,parent);
   endfunction

   extern function void build_phase(uvm_phase phase);
   extern function void connect_phase(uvm_phase phase);

endclass
   
   function void rd_agt_top::build_phase(uvm_phase phase);
         super.build_phase(phase);
    
     if(!uvm_config_db#(env_config)::get(this,"","env_config",e_cfg))
       `uvm_fatal("RD_AGT_TOP","YOUR GET METHOD IS NOT WORKING")

     if(e_cfg.has_rd_agt)
      begin
       r_agt = new[e_cfg.no_of_rd_agt];
       foreach(r_agt[i])
       begin
       r_agt[i] = rd_agent::type_id::create($sformatf("r_agt[%0d]",i),this);
       uvm_config_db#(rd_config)::set(this,/*$sformatf("r_agt[%0d]",i)*/"*","rd_config",e_cfg.r_cfg[i]);
       end 
      end
      
    endfunction

function void rd_agt_top::connect_phase(uvm_phase phase);
  uvm_top.print_topology();
  endfunction
