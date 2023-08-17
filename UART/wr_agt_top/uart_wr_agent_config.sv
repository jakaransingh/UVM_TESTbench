class wr_config extends uvm_object;

  `uvm_object_utils(wr_config)       // Registering the class to the uvm_factory
                                     // --> wrapper class around the component class that is used in the factory
                                     //     typedef my_object_registery #(wr_config,"wr_config") type_id;
                                     //  --> fuction to return the type_id (singleton)
                                     //      static function type_id get_type();
                                     //       return type_id::get();
                                     //      endfunction
                                     //  --> function to return name
                                     //     function string get_name();
                                     //      return "my_component";
                                     //     endfunction
  
   virtual uart_if vif;
  
   uvm_active_passive_enum is_active;   // used to define the is_active parameter of this config class that is ACTIVE(1) or PASSIVE(0)
  
   static int data_received;            // properties of the wr_config class used to passed to sequence(check)
   
   static int data_transmitted;         // properties of the wr_config class

   function new(string name = "wr_config"); // constructor function for wr_configg class
    
   super.new(name);
   
   endfunction

endclass

