class rd_monitor extends uvm_monitor;
 
 `uvm_component_utils(rd_monitor)

 function new(string name = "rd_monitor" , uvm_component parent);
  super.new(name,parent);
 endfunction

 extern task run_phase(uvm_phase phase);
 extern function void connect_phase(uvm_phase phase);

endclass
 
 function void rd_monitor::connect_phase(uvm_phase phase);
  

 endfunction

 task rd_monitor::run_phase(uvm_phase phase);
  


 endtask

