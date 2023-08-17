class uart_env extends uvm_env;
 
 `uvm_component_utils(uart_env)
  
  env_config e_cfg;
  wr_agt_top w_top;
  rd_agt_top r_top; 
  uart_scoreboard u_sb;
  v_sequencer vseqrh;
  
  function new(string name = "uart_tb" , uvm_component parent);
   super.new(name,parent);
  endfunction

  extern function void build_phase(uvm_phase phase);
  extern function void connect_phase(uvm_phase phase); 
   
endclass

 function void uart_env::build_phase(uvm_phase phase); 
  super.build_phase(phase);
   
  if(!uvm_config_db#(env_config)::get(this,"","env_config",e_cfg))
   `uvm_fatal("UART_TB_BUILD_PHASE","YOUR GET METHOD IS NOT WORKING")
  
  w_top = wr_agt_top::type_id::create("w_top",this);
  r_top = rd_agt_top::type_id::create("r_top",this);
  
   vseqrh=v_sequencer::type_id::create("vseqrh",this);

  if(e_cfg.has_scoreboard)
   u_sb = uart_scoreboard::type_id::create("u_sb",this);
  
 endfunction
  
  function void uart_env::connect_phase(uvm_phase phase);
   super.connect_phase(phase);
   foreach(e_cfg.w_cfg[i])
    begin 
    vseqrh.wseqrh[i] = w_top.w_agt[i].w_seqrh;

    end
   foreach(e_cfg.r_cfg[i])
    begin
    vseqrh.rseqrh[i] = r_top.r_agt[i].r_seqrh;
    end

   if(e_cfg.has_scoreboard)
    begin
    // foreach(e_cfg.wcfg[i])
      //  w_top.w_agt[i].w_mon.agent_port.connect($sformatf("u_sb.master[%0d]_fifo.analysis_export",i));

      w_top.w_agt[0].w_mon.agent_port.connect(u_sb.master0_fifo.analysis_export);
      w_top.w_agt[1].w_mon.agent_port.connect(u_sb.master1_fifo.analysis_export);

        
    end
  
  endfunction

     
  
 
