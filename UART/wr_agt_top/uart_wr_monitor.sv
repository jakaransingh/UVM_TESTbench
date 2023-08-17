class wr_monitor extends uvm_monitor;
 
 `uvm_component_utils(wr_monitor)
  
  uvm_analysis_port #(write_xtn) agent_port;

virtual uart_if.wrmon vif;
 wr_config w_cfg;

 function new(string name = "wr_monitor" , uvm_component parent);
  super.new(name,parent);
   agent_port = new("agent_port",this); 
 endfunction

 write_xtn w_xtn;
 extern function void build_phase(uvm_phase phase); 
 extern task run_phase(uvm_phase phase);
 extern function void connect_phase(uvm_phase phase);
 extern task collect_data();
endclass

 function void wr_monitor::build_phase(uvm_phase phase);
  super.build_phase(phase);
  if(!uvm_config_db#(wr_config)::get(this,"","wr_config",w_cfg) )
   `uvm_fatal("WR_MONITOR","YOUR GET METHOD IS NOT WORKING")
 
 endfunction
 
 function void wr_monitor::connect_phase(uvm_phase phase);
   vif = w_cfg.vif;

 endfunction

 task wr_monitor::run_phase(uvm_phase phase);
  w_xtn = write_xtn::type_id::create("w_xtn");
 forever
begin
 collect_data();
// $display("the values are !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@!!!!!!!!!!!!!!!!!!!!!!!!!!");
   w_xtn.print();
//   agent_port.write(w_xtn);

  end

 //$display("~~~~~~~~~~~~~~~~~~~~~~~~~~~`~~~~~~~~~~~~~~~~~~~~~~~~~~`~~~~~~~~~~~~~~~~~~");
 endtask

task wr_monitor::collect_data();            
   begin
    @(vif.wr_mon)
    wait(vif.wr_mon.WB_ACK_O)
	

  begin
    if(vif.wr_mon.WB_WE_I && (vif.wr_mon.WB_ADDR_I == 3))
    begin
    w_xtn.LCR = vif.wr_mon.WB_DAT_I;
    end
    
    if(vif.wr_mon.WB_WE_I && (w_xtn.LCR[7] == 1) && (vif.wr_mon.WB_ADDR_I == 0) )
    begin 
    w_xtn.DLV[7:0] = vif.wr_mon.WB_DAT_I;
    end

    if(vif.wr_mon.WB_WE_I && (w_xtn.LCR[7] == 1) && (vif.wr_mon.WB_ADDR_I == 1))
    begin
    w_xtn.DLV[15:8] = vif.wr_mon.WB_DAT_I;
    end
   
    if(vif.wr_mon.WB_WE_I  && (vif.wr_mon.WB_DAT_I[7] == 0) && (vif.wr_mon.WB_ADDR_I == 3))
    begin
    w_xtn.LCR = vif.wr_mon.WB_DAT_I;
    end
   
    if(vif.wr_mon.WB_WE_I && (w_xtn.LCR[7] == 0) && (vif.wr_mon.WB_ADDR_I == 2) )
    begin
    w_xtn.FCR = vif.wr_mon.WB_DAT_I;
    end
 
    if(vif.wr_mon.WB_WE_I && (vif.wr_mon.WB_ADDR_I == 1))
    begin
    w_xtn.IER =vif.wr_mon.WB_DAT_I; 
    end

    if(!w_xtn.LCR[7] && vif.wr_mon.WB_WE_I && (vif.wr_mon.WB_ADDR_I == 0 ) )
    begin
    w_xtn.THR.push_front(vif.wr_mon.WB_DAT_I); 
    end
   
   
    if(!w_xtn.LCR[7] && !vif.wr_mon.WB_WE_I && (vif.wr_mon.WB_ADDR_I == 0 ) )
    begin
     w_xtn.RB.push_front(vif.wr_mon.WB_DAT_O); 
    end

     if( !vif.wr_mon.WB_WE_I && (vif.wr_mon.WB_ADDR_I == 5 ) && (w_xtn.LCR[7] == 0) )
    begin
    w_xtn.LS = vif.wr_mon.WB_DAT_O;
    $display("!!!!!!!!!!!!!!!!!!!!@@@@@@@@@@@@@@@@@@@@@@@@@@@@@!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    w_xtn.print();
    $display("!!!!!!!!!!!!!!!!!!!!!!!!@@@@@@@@@@@@@@@@@@@@@@@@@@@!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!1");
    end


    if( !vif.wr_mon.WB_WE_I && (vif.wr_mon.WB_ADDR_I == 2 ) )
    begin
    w_xtn.IIR = vif.wr_mon.WB_DAT_O;
    end

   
   
  end
  
end
             
   
   agent_port.write(w_xtn);
    
endtask 
 
 
  
