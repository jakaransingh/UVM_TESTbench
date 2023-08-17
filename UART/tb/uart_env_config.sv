class env_config extends uvm_object;

 `uvm_object_utils(env_config)
  
  int no_of_wr_agt;
  int no_of_rd_agt;
  bit has_scoreboard;
  bit has_rd_agt;
  bit has_wr_agt;
  wr_config w_cfg[];
  rd_config r_cfg[];
  
  function new(string name = "env_config" );
   super.new(name);
  endfunction

endclass
 
