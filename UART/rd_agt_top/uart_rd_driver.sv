class rd_driver extends uvm_driver#(read_xtn);
 
 `uvm_component_utils(rd_driver)
  
  function new(string name = "rd_driver" , uvm_component parent);
   super.new(name,parent);
  endfunction

  extern task run_phase(uvm_phase phase);

endclass

 task rd_driver::run_phase(uvm_phase phase);
 super.run_phase(phase);
 


  endtask

