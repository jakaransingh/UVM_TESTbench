class read_xtn extends uvm_sequence_item;

  `uvm_object_utils(read_xtn)
  
   logic WB_RST_I;
   logic [`WB_ADDR_I-1:0]WB_ADDR_I;
   logic [3:0]WB_SEL_I;
   logic [`WB_DAT_I-1:0]WB_DATA_I;
   logic [`WB_DAT_O-1:0]WB_DATA_O;
   logic WB_WE_I;
   logic WB_STB_I;
   logic WB_CYC_I;
   logic WB_ACK_O;

   function new(string name = "read_xtn");
    super.new(name);
   endfunction
 
  function void do_copy(uvm_object rhs);
   read_xtn rhs_;
   if(!$cast(rhs_,rhs))
    `uvm_fatal("READ_XTN_COPY","UNABLE TO CAST YOU TRANSACTION ITEM")
   super.do_copy(rhs);
   WB_RST_I  = rhs_. WB_RST_I;
   WB_ADDR_I = rhs_.WB_ADDR_I;
   WB_SEL_I  = rhs_.WB_SEL_I;
   WB_DATA_I = rhs_.WB_DATA_I;
   WB_DATA_O = rhs_.WB_DATA_O;
   WB_WE_I   = rhs_.WB_WE_I;
   WB_STB_I  = rhs_.WB_STB_I;
   WB_CYC_I  = rhs_.WB_CYC_I;
   WB_ACK_O  = rhs_.WB_ACK_O;
  endfunction
 
  function bit do_compare(uvm_object rhs,uvm_comparer comparer);
   read_xtn rhs_;
   if(!$cast(rhs_,rhs))
    begin
    `uvm_fatal("READ_XTN_COMAPER","UNABLE TO CAST THE TRANSACTION OBJECT")
      return 0;
    end

   return super.do_compare(rhs,comparer) &&
   WB_RST_I  == rhs_. WB_RST_I &&
   WB_ADDR_I == rhs_.WB_ADDR_I &&
   WB_SEL_I  == rhs_.WB_SEL_I &&
   WB_DATA_I == rhs_.WB_DATA_I &&
   WB_DATA_O == rhs_.WB_DATA_O &&
   WB_WE_I   == rhs_.WB_WE_I &&
   WB_STB_I  == rhs_.WB_STB_I &&
   WB_CYC_I  == rhs_.WB_CYC_I && 
   WB_ACK_O  == rhs_.WB_ACK_O ;

  endfunction

  function void do_print(uvm_printer printer);
   super.do_print(printer);
   printer.print_field("WB_RST_I"    , this.WB_RST_I     ,   1    ,          UVM_HEX);
   printer.print_field("WB_ADDR_I"   , this.WB_ADDR_I    ,  `WB_ADDR_I   ,   UVM_HEX);
   printer.print_field("WB_SEL_I"    , this.WB_SEL_I     ,   4           ,   UVM_HEX);
   printer.print_field("WB_DATA_I"   , this.WB_DATA_I    ,  `WB_DAT_I    ,    UVM_HEX);
   printer.print_field("WB_DATA_O"   , this.WB_DATA_O    ,  `WB_DAT_O    ,   UVM_HEX);
   printer.print_field("WB_WE_I"     , this.WB_WE_I      ,   1    ,          UVM_HEX);
   printer.print_field("WB_STB_I"    , this.WB_STB_I     ,   1    ,          UVM_HEX);
   printer.print_field("WB_CYC_I"    , this.WB_CYC_I     ,   1    ,          UVM_HEX);
   printer.print_field("WB_ACK_O"  , this.WB_ACK_O   ,       1    ,          UVM_HEX);
 
 endfunction
   
  
endclass

