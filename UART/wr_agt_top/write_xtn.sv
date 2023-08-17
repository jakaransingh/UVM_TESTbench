class write_xtn extends uvm_sequence_item;

  `uvm_object_utils(write_xtn)
 
 //REGISTER LIST
   reg [7:0]THR[$];
   reg [7:0]RB[$];
   reg [7:0]IER;
   reg [7:0]IIR;
   reg [7:0]FCR;
   reg [7:0]LCR;
   reg [7:0]MC;
   reg [7:0]LS;
   reg [7:0]MS;
   reg [15:0]DLV;


  
        logic WB_RST_I;
   rand logic [`WB_ADDR_I-1:0]WB_ADDR_I;
        logic [3:0]WB_SEL_I;
   rand logic [`WB_DAT_I:0]WB_DAT_I;
        logic [`WB_DAT_O:0]WB_DAT_O;
   rand logic WB_WE_I;
        logic WB_STB_I;
        logic WB_CYC_I;
        logic WB_ACK_O;

 

   function new(string name = "write_xtn");
    super.new(name);
   endfunction
 
  function void do_copy(uvm_object rhs);    //whenever we call rhs --> child(some object of wrt_xtn) and now we use dynamic casting for pnt child-->parent-->child
   write_xtn rhs_;
   if(!$cast(rhs_,rhs))
    `uvm_fatal("WRITE_XTN_COPY","UNABLE TO CAST YOU TRANSACTION ITEM")
   super.do_copy(rhs);
   WB_RST_I  = rhs_. WB_RST_I;
   WB_ADDR_I = rhs_.WB_ADDR_I;
   WB_SEL_I  = rhs_.WB_SEL_I;
   WB_DAT_I = rhs_.WB_DAT_I;
   WB_DAT_O = rhs_.WB_DAT_O;
   WB_WE_I   = rhs_.WB_WE_I;
   WB_STB_I  = rhs_.WB_STB_I;
   WB_CYC_I  = rhs_.WB_CYC_I;
   WB_ACK_O  = rhs_.WB_ACK_O;
  endfunction
 
  function bit do_compare(uvm_object rhs,uvm_comparer comparer);
   write_xtn rhs_;
   if(!$cast(rhs_,rhs))
   begin
     `uvm_fatal("WRITE_XTN_COMAPER","UNABLE TO CAST THE TRANSACTION OBJECT")
      return 0;
   end

   return super.do_compare(rhs,comparer) &&
   WB_RST_I  == rhs_. WB_RST_I &&
   WB_ADDR_I == rhs_.WB_ADDR_I &&
   WB_SEL_I  == rhs_.WB_SEL_I &&
   WB_DAT_I == rhs_.WB_DAT_I &&
   WB_DAT_O == rhs_.WB_DAT_O &&
   WB_WE_I   == rhs_.WB_WE_I &&
   WB_STB_I  == rhs_.WB_STB_I &&
   WB_CYC_I  == rhs_.WB_CYC_I && 
   WB_ACK_O  == rhs_.WB_ACK_O ;

  endfunction

  function void do_print(uvm_printer printer);
   super.do_print(printer);
   printer.print_field("WB_RST_I"    ,   this.WB_RST_I     ,   1         ,   UVM_HEX);
   printer.print_field("WB_ADDR_I"   ,  this.WB_ADDR_I     ,`WB_ADDR_I   ,   UVM_BIN);
   printer.print_field("WB_SEL_I"    ,   this.WB_SEL_I     ,   4         ,   UVM_HEX);
   printer.print_field("WB_DATA_I"   , this.WB_DAT_I      ,`WB_DAT_I    ,   UVM_BIN);
   printer.print_field("WB_DATA_O"   ,  this.WB_DAT_O     ,`WB_DAT_O    ,   UVM_HEX);
   printer.print_field("WB_WE_I"     ,    this.WB_WE_I     ,   1         ,   UVM_HEX);
   printer.print_field("WB_STB_I"    ,   this.WB_STB_I     ,   1         ,   UVM_HEX);
   printer.print_field("WB_CYC_I"    ,   this.WB_CYC_I     ,   1         ,   UVM_HEX);
   printer.print_field("WB_ACK_O"  ,   this.WB_ACK_O       ,   1         ,   UVM_HEX);
   foreach(THR[i])
   printer.print_field($sformatf("THR[%0d]",i)  ,   this.THR[i]       ,   8         ,   UVM_BIN);
  foreach(RB[j])
  printer.print_field($sformatf("RB[%0d]",j)   ,   this.RB[j]       ,   8        ,   UVM_BIN);
 printer.print_field("IER"  ,   this.IER       ,   8         ,   UVM_HEX);
 printer.print_field("IIR"  ,   this.IIR       ,   8         ,   UVM_BIN);
 printer.print_field("FCR"  ,   this.FCR       ,   8        ,   UVM_HEX);
 printer.print_field("LCR"  ,   this.LCR       ,   8         ,   UVM_HEX);
 printer.print_field("LS"  ,   this.LS       ,   8         ,   UVM_BIN);
 printer.print_field("DLV"  ,   this.DLV       ,   8         ,   UVM_DEC);


 
 endfunction
   
  
endclass
   
   
 class write_xtn_6 extends write_xtn;
  `uvm_object_utils(write_xtn)

function new(string name = "write_xtn_6");
  super.new(name);
endfunction

 constraint e1{WB_DAT_I inside {[0:63]};}
endclass 
