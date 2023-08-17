class rd_config extends uvm_object;

  `uvm_object_utils(rd_config)
 
   virtual uart_if vif;
  
   uvm_active_passive_enum is_active ;
  
   static int data_received;
   
   static int data_transmitted;

   function new(string name = "rd_config");
    
   super.new(name);
   
   endfunction

endclass

