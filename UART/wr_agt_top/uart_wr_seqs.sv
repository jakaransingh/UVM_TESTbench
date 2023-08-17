class wr_base_seqs extends uvm_sequence#(write_xtn);
 
 `uvm_object_utils(wr_base_seqs)
 
 function new(string name = "wr_base_seqs");
  super.new(name);
 endfunction

endclass



class uart_seqs_1 extends wr_base_seqs;
 
 `uvm_object_utils(uart_seqs_1)
 function new(string name = "uart_seqs_1");
  super.new(name);
 endfunction

 task body();
   req = write_xtn::type_id::create("req");
   start_item(req);
      assert(req.randomize() with { WB_ADDR_I == 3 ; WB_WE_I == 1 ; WB_DAT_I == 8'b10000000; } )
    `uvm_info("loding_data_lcr",$sformatf("LOADING DATA IN LCR %s",req.sprint()),UVM_MEDIUM)
 // LCR SELECTION
   finish_item(req);
  
   start_item(req);
      assert(req.randomize() with { WB_WE_I == 1; WB_ADDR_I == 0 ; WB_DAT_I == 62 ;}) //LSB OF DLV
       `uvm_info("loading_data_in dlv 1",$sformatf("LOADING DATA IN DLV  %s",req.sprint()),UVM_MEDIUM)

   finish_item(req);
 
   start_item(req); 
      assert(req.randomize() with { WB_WE_I == 1; WB_ADDR_I == 1 ; WB_DAT_I == 0;})  //MSB OF DLV
      `uvm_info("loading_data_in dlv 2",$sformatf("LOADING DATA IN DLV %s",req.sprint()),UVM_MEDIUM)

   finish_item(req);

   start_item(req);
      assert(req.randomize() with {WB_WE_I == 1; WB_ADDR_I == 3 ; WB_DAT_I == 8'b00000011;})  //AGAIN SETTING LCR
          `uvm_info("UART_WR_SEQ",$sformatf("AGAIN IN lcr  %s",req.sprint()),UVM_MEDIUM)

   finish_item(req);

   start_item(req);
      assert(req.randomize() with {WB_WE_I == 1; WB_ADDR_I == 2 ; WB_DAT_I == 8'b00000110;})//FCR REGISTER
       `uvm_info("UART_WR_SEQ",$sformatf("fifo is being rest here %s",req.sprint()),UVM_MEDIUM)
   finish_item(req);

   start_item(req);
      assert(req.randomize() with {WB_WE_I == 1; WB_ADDR_I == 1 ; WB_DAT_I == 8'b00000001;})
    `uvm_info("UART_WR_SEQ",$sformatf("ier register %s",req.sprint()),UVM_MEDIUM)//SETTING UP THE IER REGISTER
   finish_item(req);
   
   start_item(req);
      assert(req.randomize() with {WB_WE_I == 1; WB_ADDR_I == 0  ;})  //SENDING RANDOMIZE DATA
       `uvm_info("UART_WR_SEQ",$sformatf("DATA IS RANDOMIZED HERE %s",req.sprint()),UVM_MEDIUM)

   finish_item(req);

    
   start_item(req);
      assert(req.randomize() with {WB_WE_I == 0; WB_ADDR_I == 2 ;}) // SELECTING iir REGISTER
   finish_item(req);

  get_response(req);
 
   if(req.IIR[3:1]== 3'b010)
 // repeat(5)
   begin
   start_item(req);
     assert(req.randomize() with {WB_WE_I == 0; WB_ADDR_I == 0 ;}) 
   finish_item(req);
   end
  
                                                                                                                                       
   endtask

endclass

class uart_seqs_2 extends  wr_base_seqs;

    `uvm_object_utils(uart_seqs_2)

 function new(string name = "uart_seqs_2");
  super.new(name);
 endfunction

task body();
req = write_xtn::type_id::create("req");
   start_item(req);
      assert(req.randomize() with { WB_ADDR_I == 3 ; WB_WE_I == 1 ; WB_DAT_I == 8'b10000000 ; } ) 
       `uvm_info("loding_data_lcr",$sformatf("LOADING DATA IN LCR %s",req.sprint()),UVM_MEDIUM)
   finish_item(req);
  
   start_item(req);
      assert(req.randomize() with { WB_WE_I == 1; WB_ADDR_I == 0 ; WB_DAT_I == 16 ;}) //LSB OF DLV
      `uvm_info("loading_data_in dlv 1",$sformatf("LOADING DATA IN DLV  %s",req.sprint()),UVM_MEDIUM)

   finish_item(req);
 
   start_item(req); 
      assert(req.randomize() with { WB_WE_I == 1; WB_ADDR_I == 1 ; WB_DAT_I == 0;})  //MSB OF DLV
       `uvm_info("loading_data_in dlv 2",$sformatf("LOADING DATA IN DLV %s",req.sprint()),UVM_MEDIUM)

   finish_item(req);

   start_item(req);
      assert(req.randomize() with {WB_WE_I == 1; WB_ADDR_I == 3 ; WB_DAT_I == 8'b00000011       ;})  //AGAIN LCR
      `uvm_info("UART_WR_SEQ",$sformatf("AGAIN IN lcr  %s",req.sprint()),UVM_MEDIUM)

   finish_item(req);

   start_item(req);
      assert(req.randomize() with {WB_WE_I == 1; WB_ADDR_I == 2 ; WB_DAT_I == 8'b01000110;})  //SETTING UP FCR
   finish_item(req);

   start_item(req);
      assert(req.randomize() with {WB_WE_I == 1; WB_ADDR_I == 1 ; WB_DAT_I == 8'b00000001;}) // IER
      `uvm_info("UART_WR_SEQ",$sformatf("fifo is being rest here %s",req.sprint()),UVM_MEDIUM)

   finish_item(req);

    repeat(5)
   begin
     start_item(req);
       assert(req.randomize() with {WB_WE_I == 1; WB_ADDR_I == 0 ;});// RANDOMIZING DATA
      `uvm_info("UART_WR_SEQ",$sformatf("DATA IS RANDOMIZED HERE %s",req.sprint()),UVM_MEDIUM)
    finish_item(req);
    end 
      
   start_item(req);
      assert(req.randomize() with {WB_WE_I == 0; WB_ADDR_I == 2 ; }) //GIVING THE ADDRESS FOR IIR SELECTION
   finish_item(req);
  
   get_response(req);
     // req.print();
      if(req.IIR[3:1]== 3'b010)
   repeat(5)
   begin
   start_item(req);
    assert(req.randomize() with {WB_WE_I == 0; WB_ADDR_I == 0 ;}) 
   finish_item(req);
   end


  endtask

 endclass

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                                                      //    TEST2 !!!!!!!!!!!!!! MULTIPLE READ AND WRITE !!!!!!!!!!!!
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  class uart_seqs_3 extends wr_base_seqs;
 
 `uvm_object_utils(uart_seqs_3)
 function new(string name = "uart_seqs_1");
  super.new(name);
 endfunction

 task body();
   req = write_xtn::type_id::create("req");
   start_item(req);
      assert(req.randomize() with { WB_ADDR_I == 3 ; WB_WE_I == 1 ; WB_DAT_I == 8'b10000000; } )
    `uvm_info("loding_data_lcr",$sformatf("LOADING DATA IN LCR %s",req.sprint()),UVM_MEDIUM)
 // LCR SELECTION
   finish_item(req);
  
   start_item(req);
      assert(req.randomize() with { WB_WE_I == 1; WB_ADDR_I == 0 ; WB_DAT_I == 62 ;}) //LSB OF DLV
       `uvm_info("loading_data_in dlv 1",$sformatf("LOADING DATA IN DLV  %s",req.sprint()),UVM_MEDIUM)

   finish_item(req);
 
   start_item(req); 
      assert(req.randomize() with { WB_WE_I == 1; WB_ADDR_I == 1 ; WB_DAT_I == 0;})  //MSB OF DLV
      `uvm_info("loading_data_in dlv 2",$sformatf("LOADING DATA IN DLV %s",req.sprint()),UVM_MEDIUM)

   finish_item(req);

   start_item(req);
      assert(req.randomize() with {WB_WE_I == 1; WB_ADDR_I == 3 ; WB_DAT_I == 8'b00000011;})  //AGAIN SETTING LCR
          `uvm_info("UART_WR_SEQ",$sformatf("AGAIN IN lcr  %s",req.sprint()),UVM_MEDIUM)

   finish_item(req);

   start_item(req);
      assert(req.randomize() with {WB_WE_I == 1; WB_ADDR_I == 2 ; WB_DAT_I == 8'b00000110;})//FCR REGISTER
       `uvm_info("UART_WR_SEQ",$sformatf("fifo is being rest here %s",req.sprint()),UVM_MEDIUM)
   finish_item(req);

   start_item(req);
      assert(req.randomize() with {WB_WE_I == 1; WB_ADDR_I == 1 ; WB_DAT_I == 8'b00000001;})
    `uvm_info("UART_WR_SEQ",$sformatf("ier register %s",req.sprint()),UVM_MEDIUM)
 //SETTING UP THE IER REGISTER
   finish_item(req);
   repeat(4)
   begin
   start_item(req);
      assert(req.randomize() with {WB_WE_I == 1; WB_ADDR_I == 0  ;})  //SENDING RANDOMIZE DATA
       `uvm_info("UART_WR_SEQ",$sformatf("DATA IS RANDOMIZED HERE %s",req.sprint()),UVM_MEDIUM)
   finish_item(req);
   end

   start_item(req);
      assert(req.randomize() with {WB_WE_I == 0; WB_ADDR_I == 2 ;}) // SELECTING iir REGISTER
   finish_item(req);
  
  get_response(req);
 
   if(req.IIR[3:1]== 3'b010)
   begin
   start_item(req);
     assert(req.randomize() with {WB_WE_I == 0; WB_ADDR_I == 0 ;}) 
   finish_item(req);
   end
  
                                                                                                                                       
   endtask
endclass

class uart_seqs_4 extends  wr_base_seqs;

    `uvm_object_utils(uart_seqs_4)

 function new(string name = "uart_seqs_2");
  super.new(name);
 endfunction

task body();
req = write_xtn::type_id::create("req");
   start_item(req);
      assert(req.randomize() with { WB_ADDR_I == 3 ; WB_WE_I == 1 ; WB_DAT_I == 8'b10000000 ; } ) 
       `uvm_info("loding_data_lcr",$sformatf("LOADING DATA IN LCR %s",req.sprint()),UVM_MEDIUM)
   finish_item(req);
  
   start_item(req);
      assert(req.randomize() with { WB_WE_I == 1; WB_ADDR_I == 0 ; WB_DAT_I == 16 ;}) //LSB OF DLV
      `uvm_info("loading_data_in dlv 1",$sformatf("LOADING DATA IN DLV  %s",req.sprint()),UVM_MEDIUM)

   finish_item(req);
 
   start_item(req); 
      assert(req.randomize() with { WB_WE_I == 1; WB_ADDR_I == 1 ; WB_DAT_I == 0;})  //MSB OF DLV
       `uvm_info("loading_data_in dlv 2",$sformatf("LOADING DATA IN DLV %s",req.sprint()),UVM_MEDIUM)

   finish_item(req);

   start_item(req);
      assert(req.randomize() with {WB_WE_I == 1; WB_ADDR_I == 3 ; WB_DAT_I == 8'b00000011       ;})  //AGAIN LCR
      `uvm_info("UART_WR_SEQ",$sformatf("AGAIN IN lcr  %s",req.sprint()),UVM_MEDIUM)

   finish_item(req);

   start_item(req);
      assert(req.randomize() with {WB_WE_I == 1; WB_ADDR_I == 2 ; WB_DAT_I == 8'b01000110;})  //SETTING UP FCR
   finish_item(req);

   start_item(req);
      assert(req.randomize() with {WB_WE_I == 1; WB_ADDR_I == 1 ; WB_DAT_I == 8'b00000001;}) // IER
      `uvm_info("UART_WR_SEQ",$sformatf("fifo is being rest here %s",req.sprint()),UVM_MEDIUM)

   finish_item(req);

    
  
     start_item(req);
       assert(req.randomize() with {WB_WE_I == 1; WB_ADDR_I == 0 ;});// RANDOMIZING DATA
      `uvm_info("UART_WR_SEQ",$sformatf("DATA IS RANDOMIZED HERE %s",req.sprint()),UVM_MEDIUM)
    finish_item(req);
  
   
   
   start_item(req);
      assert(req.randomize() with {WB_WE_I == 0; WB_ADDR_I == 2 ; }) //GIVING THE ADDRESS FOR IIR SELECTION
   finish_item(req);
  
   get_response(req);
     // req.print();
 
   if(req.IIR[3:1]== 3'b010)
   repeat(4)
   begin
   start_item(req);
    assert(req.randomize() with {WB_WE_I == 0; WB_ADDR_I == 0 ;}) 
   finish_item(req);
   end
  

  endtask
endclass

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////tset 3 !!!! HALF DUPLEX !!!!!!!!!!!!!!
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


 class uart_seqs_5 extends wr_base_seqs;
 
 `uvm_object_utils(uart_seqs_5)
 function new(string name = "uart_seqs_1");
  super.new(name);
 endfunction

 task body();
   req = write_xtn::type_id::create("req");
   start_item(req);
      assert(req.randomize() with { WB_ADDR_I == 3 ; WB_WE_I == 1 ; WB_DAT_I == 8'b10000000; } )
    `uvm_info("loding_data_lcr",$sformatf("LOADING DATA IN LCR %s",req.sprint()),UVM_MEDIUM)
 // LCR SELECTION
   finish_item(req);
  
   start_item(req);
      assert(req.randomize() with { WB_WE_I == 1; WB_ADDR_I == 0 ; WB_DAT_I == 62 ;}) //LSB OF DLV
       `uvm_info("loading_data_in dlv 1",$sformatf("LOADING DATA IN DLV  %s",req.sprint()),UVM_MEDIUM)

   finish_item(req);
 
   start_item(req); 
      assert(req.randomize() with { WB_WE_I == 1; WB_ADDR_I == 1 ; WB_DAT_I == 0;})  //MSB OF DLV
      `uvm_info("loading_data_in dlv 2",$sformatf("LOADING DATA IN DLV %s",req.sprint()),UVM_MEDIUM)

   finish_item(req);

   start_item(req);
      assert(req.randomize() with {WB_WE_I == 1; WB_ADDR_I == 3 ; WB_DAT_I == 8'b00000011;})  //AGAIN SETTING LCR
          `uvm_info("UART_WR_SEQ",$sformatf("AGAIN IN lcr  %s",req.sprint()),UVM_MEDIUM)

   finish_item(req);

   start_item(req);
      assert(req.randomize() with {WB_WE_I == 1; WB_ADDR_I == 2 ; WB_DAT_I == 8'b00000110;})//FCR REGISTER
       `uvm_info("UART_WR_SEQ",$sformatf("fifo is being rest here %s",req.sprint()),UVM_MEDIUM)
   finish_item(req);

   start_item(req);
      assert(req.randomize() with {WB_WE_I == 1; WB_ADDR_I == 1 ; WB_DAT_I == 8'b00000001;})
    `uvm_info("UART_WR_SEQ",$sformatf("ier register %s",req.sprint()),UVM_MEDIUM)
 //SETTING UP THE IER REGISTER
   finish_item(req);
   repeat(4)
   begin
   start_item(req);
      assert(req.randomize() with {WB_WE_I == 1; WB_ADDR_I == 0  ;})  //SENDING RANDOMIZE DATA
       `uvm_info("UART_WR_SEQ",$sformatf("DATA IS RANDOMIZED HERE %s",req.sprint()),UVM_MEDIUM)
   finish_item(req);
   end

   /* start_item(req);
      assert(req.randomize() with {WB_WE_I == 0; WB_ADDR_I == 2 ;}) // SELECTING iir REGISTER
   finish_item(req);
  
  get_response(req);

   if(req.IIR[3:1]== 3'b010)
   begin
   start_item(req);
     assert(req.randomize() with {WB_WE_I == 0; WB_ADDR_I == 0 ;}) 
   finish_item(req);
   end
  */
                                                                                                                                       
   endtask
endclass

class uart_seqs_6 extends  wr_base_seqs;

    `uvm_object_utils(uart_seqs_6)

 function new(string name = "uart_seqs_2");
  super.new(name);
 endfunction

task body();
req = write_xtn::type_id::create("req");
   start_item(req);
      assert(req.randomize() with { WB_ADDR_I == 3 ; WB_WE_I == 1 ; WB_DAT_I == 8'b10000000 ; } ) 
       `uvm_info("loding_data_lcr",$sformatf("LOADING DATA IN LCR %s",req.sprint()),UVM_MEDIUM)
   finish_item(req);
  
   start_item(req);
      assert(req.randomize() with { WB_WE_I == 1; WB_ADDR_I == 0 ; WB_DAT_I == 16 ;}) //LSB OF DLV
      `uvm_info("loading_data_in dlv 1",$sformatf("LOADING DATA IN DLV  %s",req.sprint()),UVM_MEDIUM)

   finish_item(req);
 
   start_item(req); 
      assert(req.randomize() with { WB_WE_I == 1; WB_ADDR_I == 1 ; WB_DAT_I == 0;})  //MSB OF DLV
       `uvm_info("loading_data_in dlv 2",$sformatf("LOADING DATA IN DLV %s",req.sprint()),UVM_MEDIUM)

   finish_item(req);

   start_item(req);
      assert(req.randomize() with {WB_WE_I == 1; WB_ADDR_I == 3 ; WB_DAT_I == 8'b00000011       ;})  //AGAIN LCR
      `uvm_info("UART_WR_SEQ",$sformatf("AGAIN IN lcr  %s",req.sprint()),UVM_MEDIUM)

   finish_item(req);

   start_item(req);
      assert(req.randomize() with {WB_WE_I == 1; WB_ADDR_I == 2 ; WB_DAT_I == 8'b01000110;})  //SETTING UP FCR
   finish_item(req);

   start_item(req);
      assert(req.randomize() with {WB_WE_I == 1; WB_ADDR_I == 1 ; WB_DAT_I == 8'b00000001;}) // IER
      `uvm_info("UART_WR_SEQ",$sformatf("fifo is being rest here %s",req.sprint()),UVM_MEDIUM)

   finish_item(req);

    
  /*
     start_item(req);
       assert(req.randomize() with {WB_WE_I == 1; WB_ADDR_I == 0 ;});// RANDOMIZING DATA
      `uvm_info("UART_WR_SEQ",$sformatf("DATA IS RANDOMIZED HERE %s",req.sprint()),UVM_MEDIUM)
    finish_item(req);
  
   */
   
   start_item(req);
      assert(req.randomize() with {WB_WE_I == 0; WB_ADDR_I == 2 ; }) //GIVING THE ADDRESS FOR IIR SELECTION
   finish_item(req);
  
   get_response(req);
     // req.print();
 
   if(req.IIR[3:1]== 3'b010)
   repeat(4)
   begin
   start_item(req);
    assert(req.randomize() with {WB_WE_I == 0; WB_ADDR_I == 0 ;}) 
   finish_item(req);
   end
  

  endtask
endclass

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////test4 break intrupt heck
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class uart_seqs_7 extends wr_base_seqs;
 
 `uvm_object_utils(uart_seqs_7)
 function new(string name = "uart_seqs_7");
  super.new(name);
 endfunction

 task body();
   req = write_xtn::type_id::create("req");
   start_item(req);
      assert(req.randomize() with { WB_ADDR_I == 3 ; WB_WE_I == 1 ; WB_DAT_I == 8'b10000000; } )
    `uvm_info("loding_data_lcr",$sformatf("LOADING DATA IN LCR %s",req.sprint()),UVM_MEDIUM)
 // LCR SELECTION
   finish_item(req);
  
   start_item(req);
      assert(req.randomize() with { WB_WE_I == 1; WB_ADDR_I == 0 ; WB_DAT_I == 62 ;}) //LSB OF DLV
       `uvm_info("loading_data_in dlv 1",$sformatf("LOADING DATA IN DLV  %s",req.sprint()),UVM_MEDIUM)

   finish_item(req);
 
   start_item(req); 
      assert(req.randomize() with { WB_WE_I == 1; WB_ADDR_I == 1 ; WB_DAT_I == 0;})  //MSB OF DLV
      `uvm_info("loading_data_in dlv 2",$sformatf("LOADING DATA IN DLV %s",req.sprint()),UVM_MEDIUM)

   finish_item(req);

   start_item(req);
      assert(req.randomize() with {WB_WE_I == 1; WB_ADDR_I == 3 ; WB_DAT_I == 8'b01000011;})  //AGAIN SETTING LCR
          `uvm_info("UART_WR_SEQ",$sformatf("AGAIN IN lcr  %s",req.sprint()),UVM_MEDIUM)

   finish_item(req);

   start_item(req);
      assert(req.randomize() with {WB_WE_I == 1; WB_ADDR_I == 2 ; WB_DAT_I == 8'b00000000;})//FCR REGISTER
       `uvm_info("UART_WR_SEQ",$sformatf("fifo is being rest here %s",req.sprint()),UVM_MEDIUM)
   finish_item(req);

   start_item(req);
      assert(req.randomize() with {WB_WE_I == 1; WB_ADDR_I == 1 ; WB_DAT_I == 8'b00000001;})
    `uvm_info("UART_WR_SEQ",$sformatf("ier register %s",req.sprint()),UVM_MEDIUM)
 //SETTING UP THE IER REGISTER
   finish_item(req);
   
   start_item(req);
      assert(req.randomize() with {WB_WE_I == 1; WB_ADDR_I == 0  ;})  //SENDING RANDOMIZE DATA
       `uvm_info("UART_WR_SEQ",$sformatf("DATA IS RANDOMIZED HERE %s",req.sprint()),UVM_MEDIUM)

   finish_item(req);

    
   start_item(req);
      assert(req.randomize() with {WB_WE_I == 0; WB_ADDR_I == 2 ;}) // SELECTING iir REGISTER
   finish_item(req);

  get_response(req);

 case(req.IIR[3:1])
   3'b010     :   begin
                 start_item(req);
                 assert(req.randomize() with {WB_ADDR_I == 0 ; WB_WE_I == 0;} )
                 finish_item(req);
                 end

  3'b011      :  begin
                 start_item(req);
                 assert(req.randomize() with {WB_ADDR_I == 5 ; WB_WE_I == 0;})
                 finish_item(req); 
                 end
  
  3'b110      :  begin
                  start_item(req);
                 assert(req.randomize() with {WB_ADDR_I == 0 ; WB_WE_I == 0;} )
                 finish_item(req);
                 end
  endcase

                  
                                                                                                                                       
   endtask

endclass

class uart_seqs_8 extends  wr_base_seqs;

    `uvm_object_utils(uart_seqs_8)

 function new(string name = "uart_seqs_8");
  super.new(name);
 endfunction

task body();
req = write_xtn::type_id::create("req");
   start_item(req);
      assert(req.randomize() with { WB_ADDR_I == 3 ; WB_WE_I == 1 ; WB_DAT_I == 8'b10000000 ; } ) 
       `uvm_info("loding_data_lcr",$sformatf("LOADING DATA IN LCR %s",req.sprint()),UVM_MEDIUM)
   finish_item(req);
  
   start_item(req);
      assert(req.randomize() with { WB_WE_I == 1; WB_ADDR_I == 0 ; WB_DAT_I == 16 ;}) //LSB OF DLV
      `uvm_info("loading_data_in dlv 1",$sformatf("LOADING DATA IN DLV  %s",req.sprint()),UVM_MEDIUM)

   finish_item(req);
 
   start_item(req); 
      assert(req.randomize() with { WB_WE_I == 1; WB_ADDR_I == 1 ; WB_DAT_I == 0;})  //MSB OF DLV
       `uvm_info("loading_data_in dlv 2",$sformatf("LOADING DATA IN DLV %s",req.sprint()),UVM_MEDIUM)

   finish_item(req);

   start_item(req);
      assert(req.randomize() with {WB_WE_I == 1; WB_ADDR_I == 3 ; WB_DAT_I == 8'b00000011       ;})  //AGAIN LCR
      `uvm_info("UART_WR_SEQ",$sformatf("AGAIN IN lcr  %s",req.sprint()),UVM_MEDIUM)

   finish_item(req);

   start_item(req);
      assert(req.randomize() with {WB_WE_I == 1; WB_ADDR_I == 2 ; WB_DAT_I == 8'b01000110;})  //SETTING UP FCR
   finish_item(req);

   start_item(req);
      assert(req.randomize() with {WB_WE_I == 1; WB_ADDR_I == 1 ; WB_DAT_I == 8'b00000101;}) // IER
      `uvm_info("UART_WR_SEQ",$sformatf("fifo is being rest here %s",req.sprint()),UVM_MEDIUM)

   finish_item(req);

    repeat(5)
   begin
     start_item(req);
       assert(req.randomize() with {WB_WE_I == 1; WB_ADDR_I == 0 ;});// RANDOMIZING DATA
      `uvm_info("UART_WR_SEQ",$sformatf("DATA IS RANDOMIZED HERE %s",req.sprint()),UVM_MEDIUM)
    finish_item(req);
    end 
      
   start_item(req);
      assert(req.randomize() with {WB_WE_I == 0; WB_ADDR_I == 2 ; }) //GIVING THE ADDRESS FOR IIR SELECTION
   finish_item(req);
  
   get_response(req);
  case(req.IIR[3:1])
   3'b010     :   begin
                 start_item(req);
                 assert(req.randomize() with {WB_ADDR_I == 0 ; WB_WE_I == 0;} )
                 finish_item(req);
                 end

  3'b011      :  begin
                 start_item(req);
                 assert(req.randomize() with {WB_ADDR_I == 5 ; WB_WE_I == 0;})
                 finish_item(req); 
                 end
  
  3'b110      :  begin
                  start_item(req);
                 assert(req.randomize() with {WB_ADDR_I == 0 ; WB_WE_I == 0;} )
                 finish_item(req);
                 end
  endcase


  endtask

 endclass
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////test_case5   parity check
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class uart_seqs_9 extends wr_base_seqs;
 
 `uvm_object_utils(uart_seqs_9)
 function new(string name = "uart_seqs_9");
  super.new(name);
 endfunction

 task body();
   req = write_xtn::type_id::create("req");
   start_item(req);
      assert(req.randomize() with { WB_ADDR_I == 3 ; WB_WE_I == 1 ; WB_DAT_I == 8'b10000000; } )
    `uvm_info("loding_data_lcr",$sformatf("LOADING DATA IN LCR %s",req.sprint()),UVM_MEDIUM)
 // LCR SELECTION
   finish_item(req);
  
   start_item(req);
      assert(req.randomize() with { WB_WE_I == 1; WB_ADDR_I == 0 ; WB_DAT_I == 62 ;}) //LSB OF DLV
       `uvm_info("loading_data_in dlv 1",$sformatf("LOADING DATA IN DLV  %s",req.sprint()),UVM_MEDIUM)

   finish_item(req);
 
   start_item(req); 
      assert(req.randomize() with { WB_WE_I == 1; WB_ADDR_I == 1 ; WB_DAT_I == 0;})  //MSB OF DLV
      `uvm_info("loading_data_in dlv 2",$sformatf("LOADING DATA IN DLV %s",req.sprint()),UVM_MEDIUM)

   finish_item(req);

   start_item(req);
      assert(req.randomize() with {WB_WE_I == 1; WB_ADDR_I == 3 ; WB_DAT_I == 8'b01000011;})  //AGAIN SETTING LCR
          `uvm_info("UART_WR_SEQ",$sformatf("AGAIN IN lcr  %s",req.sprint()),UVM_MEDIUM)

   finish_item(req);

   start_item(req);
      assert(req.randomize() with {WB_WE_I == 1; WB_ADDR_I == 2 ; WB_DAT_I == 8'b00000000;})//FCR REGISTER
       `uvm_info("UART_WR_SEQ",$sformatf("fifo is being rest here %s",req.sprint()),UVM_MEDIUM)
   finish_item(req);

   start_item(req);
      assert(req.randomize() with {WB_WE_I == 1; WB_ADDR_I == 1 ; WB_DAT_I == 8'b00000101;})
    `uvm_info("UART_WR_SEQ",$sformatf("ier register %s",req.sprint()),UVM_MEDIUM)
 //SETTING UP THE IER REGISTER
   finish_item(req);
   
   start_item(req);
      assert(req.randomize() with {WB_WE_I == 1; WB_ADDR_I == 0  ;})  //SENDING RANDOMIZE DATA
       `uvm_info("UART_WR_SEQ",$sformatf("DATA IS RANDOMIZED HERE %s",req.sprint()),UVM_MEDIUM)

   finish_item(req);

    
   start_item(req);
      assert(req.randomize() with {WB_WE_I == 0; WB_ADDR_I == 2 ;}) // SELECTING iir REGISTER
   finish_item(req);

  get_response(req);

 case(req.IIR[3:1])
   3'b010     :   begin
                 start_item(req);
                 assert(req.randomize() with {WB_ADDR_I == 0 ; WB_WE_I == 0;} )
                 finish_item(req);
                 end

  3'b011      :  begin
                 start_item(req);
                 assert(req.randomize() with {WB_ADDR_I == 5 ; WB_WE_I == 0;})
                 finish_item(req); 
                 end
  
  3'b110      :  begin
                  start_item(req);
                 assert(req.randomize() with {WB_ADDR_I == 0 ; WB_WE_I == 0;} )
                 finish_item(req);
                 end
  endcase

                  
                                                                                                                                       
   endtask

endclass

class uart_seqs_10 extends  wr_base_seqs;

    `uvm_object_utils(uart_seqs_10)

 function new(string name = "uart_seqs_10");
  super.new(name);
 endfunction

task body();
req = write_xtn::type_id::create("req");
   start_item(req);
      assert(req.randomize() with { WB_ADDR_I == 3 ; WB_WE_I == 1 ; WB_DAT_I == 8'b10000000 ; } ) 
       `uvm_info("loding_data_lcr",$sformatf("LOADING DATA IN LCR %s",req.sprint()),UVM_MEDIUM)
   finish_item(req);
  
   start_item(req);
      assert(req.randomize() with { WB_WE_I == 1; WB_ADDR_I == 0 ; WB_DAT_I == 16 ;}) //LSB OF DLV
      `uvm_info("loading_data_in dlv 1",$sformatf("LOADING DATA IN DLV  %s",req.sprint()),UVM_MEDIUM)

   finish_item(req);
 
   start_item(req); 
      assert(req.randomize() with { WB_WE_I == 1; WB_ADDR_I == 1 ; WB_DAT_I == 0;})  //MSB OF DLV
       `uvm_info("loading_data_in dlv 2",$sformatf("LOADING DATA IN DLV %s",req.sprint()),UVM_MEDIUM)

   finish_item(req);

   start_item(req);
      assert(req.randomize() with {WB_WE_I == 1; WB_ADDR_I == 3 ; WB_DAT_I == 8'b00011011       ;})  //AGAIN LCR
      `uvm_info("UART_WR_SEQ",$sformatf("AGAIN IN lcr  %s",req.sprint()),UVM_MEDIUM)

   finish_item(req);

   start_item(req);
      assert(req.randomize() with {WB_WE_I == 1; WB_ADDR_I == 2 ; WB_DAT_I == 8'b01000110;})  //SETTING UP FCR
   finish_item(req);

   start_item(req);
      assert(req.randomize() with {WB_WE_I == 1; WB_ADDR_I == 1 ; WB_DAT_I == 8'b00000101;}) // IER
      `uvm_info("UART_WR_SEQ",$sformatf("fifo is being rest here %s",req.sprint()),UVM_MEDIUM)

   finish_item(req);

   
   begin
     start_item(req);
       assert(req.randomize() with {WB_WE_I == 1; WB_ADDR_I == 0 ; $countones(WB_DAT_I) == 5;})// RANDOMIZING DATA
      `uvm_info("UART_WR_SEQ",$sformatf("DATA IS RANDOMIZED HERE %s",req.sprint()),UVM_MEDIUM)
    finish_item(req);
    end 
      
   start_item(req);
      assert(req.randomize() with {WB_WE_I == 0; WB_ADDR_I == 2 ; }) //GIVING THE ADDRESS FOR IIR SELECTION
   finish_item(req);
  
   get_response(req);
  case(req.IIR[3:1])
   3'b010     :   begin
                 start_item(req);
                 assert(req.randomize() with {WB_ADDR_I == 0 ; WB_WE_I == 0;} )
                 finish_item(req);
                 end

  3'b011      :  begin
                 start_item(req);
                 assert(req.randomize() with {WB_ADDR_I == 5 ; WB_WE_I == 0;})
                 finish_item(req); 
                 end
  
  3'b110      :  begin
                  start_item(req);
                 assert(req.randomize() with {WB_ADDR_I == 0 ; WB_WE_I == 0;} )
                 finish_item(req);
                 end
  endcase


  endtask

 endclass
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////// test 6  time_out codition  framing error
///////////////you will get when you set LSR FOR BOTH UARTS AND SET 3 WRITES AND ONLY OE READ
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class uart_seqs_11 extends wr_base_seqs;
 
 `uvm_object_utils(uart_seqs_11)
 function new(string name = "uart_seqs_11");
  super.new(name);
 endfunction

 task body();
   req = write_xtn::type_id::create("req");
   start_item(req);
      assert(req.randomize() with { WB_ADDR_I == 3 ; WB_WE_I == 1 ; WB_DAT_I == 8'b10000000; } )
    `uvm_info("loding_data_lcr",$sformatf("LOADING DATA IN LCR %s",req.sprint()),UVM_MEDIUM)
 // LCR SELECTION
   finish_item(req);
  
   start_item(req);
      assert(req.randomize() with { WB_WE_I == 1; WB_ADDR_I == 0 ; WB_DAT_I == 62 ;}) //LSB OF DLV
       `uvm_info("loading_data_in dlv 1",$sformatf("LOADING DATA IN DLV  %s",req.sprint()),UVM_MEDIUM)

   finish_item(req);
 
   start_item(req); 
      assert(req.randomize() with { WB_WE_I == 1; WB_ADDR_I == 1 ; WB_DAT_I == 0;})  //MSB OF DLV
      `uvm_info("loading_data_in dlv 2",$sformatf("LOADING DATA IN DLV %s",req.sprint()),UVM_MEDIUM)

   finish_item(req);

   start_item(req);
      assert(req.randomize() with {WB_WE_I == 1; WB_ADDR_I == 3 ; WB_DAT_I == 8'b00000011;})  //AGAIN SETTING LCR
          `uvm_info("UART_WR_SEQ",$sformatf("AGAIN IN lcr  %s",req.sprint()),UVM_MEDIUM)

   finish_item(req);

   start_item(req);
      assert(req.randomize() with {WB_WE_I == 1; WB_ADDR_I == 2 ; WB_DAT_I == 8'b01000000;})//FCR REGISTER
       `uvm_info("UART_WR_SEQ",$sformatf("fifo is being rest here %s",req.sprint()),UVM_MEDIUM)
   finish_item(req);

   start_item(req);
      assert(req.randomize() with {WB_WE_I == 1; WB_ADDR_I == 1 ; WB_DAT_I == 8'b00000101;})
    `uvm_info("UART_WR_SEQ",$sformatf("ier register %s",req.sprint()),UVM_MEDIUM)
 //SETTING UP THE IER REGISTER
   finish_item(req);

    repeat(3)
    begin
    start_item(req);
           assert(req.randomize() with {WB_WE_I == 1; WB_ADDR_I == 0  ;})  //SENDING RANDOMIZE DATA
       `uvm_info("UART_WR_SEQ",$sformatf("DATA IS RANDOMIZED HERE %s",req.sprint()),UVM_MEDIUM)
   finish_item(req);
   end
    
   start_item(req);
      assert(req.randomize() with {WB_WE_I == 0; WB_ADDR_I == 2 ;}) // SELECTING iir REGISTER
   finish_item(req);

  get_response(req);

 case(req.IIR[3:1])
   3'b010     :   begin
                 start_item(req);
                 assert(req.randomize() with {WB_ADDR_I == 0 ; WB_WE_I == 0;} )
                 finish_item(req);
                 end

  3'b011      :  begin
                 start_item(req);
                 assert(req.randomize() with {WB_ADDR_I == 5 ; WB_WE_I == 0;})
                 finish_item(req); 
                 end
  
  3'b110      :  begin
                  start_item(req);
                 assert(req.randomize() with {WB_ADDR_I == 0 ; WB_WE_I == 0;} )
                 finish_item(req);
                 end
  endcase

                  
                                                                                                                                       
   endtask

endclass

class uart_seqs_12 extends  wr_base_seqs;

    `uvm_object_utils(uart_seqs_12)

 function new(string name = "uart_seqs_12");
  super.new(name);
 endfunction

task body();
req = write_xtn::type_id::create("req");
   start_item(req);
      assert(req.randomize() with { WB_ADDR_I == 3 ; WB_WE_I == 1 ; WB_DAT_I == 8'b10000000 ; } ) 
       `uvm_info("loding_data_lcr",$sformatf("LOADING DATA IN LCR %s",req.sprint()),UVM_MEDIUM)
   finish_item(req);
  
   start_item(req);
      assert(req.randomize() with { WB_WE_I == 1; WB_ADDR_I == 0 ; WB_DAT_I == 16 ;}) //LSB OF DLV
      `uvm_info("loading_data_in dlv 1",$sformatf("LOADING DATA IN DLV  %s",req.sprint()),UVM_MEDIUM)

   finish_item(req);
 
   start_item(req); 
      assert(req.randomize() with { WB_WE_I == 1; WB_ADDR_I == 1 ; WB_DAT_I == 0;})  //MSB OF DLV
       `uvm_info("loading_data_in dlv 2",$sformatf("LOADING DATA IN DLV %s",req.sprint()),UVM_MEDIUM)

   finish_item(req);

   start_item(req);
      assert(req.randomize() with {WB_WE_I == 1; WB_ADDR_I == 3 ; WB_DAT_I == 8'b00000011       ;})  //AGAIN LCR
      `uvm_info("UART_WR_SEQ",$sformatf("AGAIN IN lcr  %s",req.sprint()),UVM_MEDIUM)

   finish_item(req);

   start_item(req);
      assert(req.randomize() with {WB_WE_I == 1; WB_ADDR_I == 2 ; WB_DAT_I == 8'b00000000;})  //SETTING UP FCR
   finish_item(req);

   start_item(req);
      assert(req.randomize() with {WB_WE_I == 1; WB_ADDR_I == 1 ; WB_DAT_I == 8'b00000101;}) // IER
      `uvm_info("UART_WR_SEQ",$sformatf("fifo is being rest here %s",req.sprint()),UVM_MEDIUM)

   finish_item(req);

   
   begin
     start_item(req);
       assert(req.randomize() with {WB_WE_I == 1; WB_ADDR_I == 0 ; $countones(WB_DAT_I) == 5;})// RANDOMIZING DATA
      `uvm_info("UART_WR_SEQ",$sformatf("DATA IS RANDOMIZED HERE %s",req.sprint()),UVM_MEDIUM)
    finish_item(req);
    end 
      
   start_item(req);
      assert(req.randomize() with {WB_WE_I == 0; WB_ADDR_I == 2 ; }) //GIVING THE ADDRESS FOR IIR SELECTION
   finish_item(req);
  
   get_response(req);
  case(req.IIR[3:1])
   3'b010     :// repeat(4)
                 begin
                 start_item(req);
                 assert(req.randomize() with {WB_ADDR_I == 0 ; WB_WE_I == 0;} )
                 finish_item(req);
                 end

  3'b011      :  begin
                 start_item(req);
                 assert(req.randomize() with {WB_ADDR_I == 5 ; WB_WE_I == 0;})
                 finish_item(req); 
                 end
  
  3'b110      :  begin
                  start_item(req);
                 assert(req.randomize() with {WB_ADDR_I == 0 ; WB_WE_I == 0;} )
                 finish_item(req);
                 end
  endcase


  endtask

 endclass
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class uart_seqs_13 extends wr_base_seqs;
 
 `uvm_object_utils(uart_seqs_13)
 function new(string name = "uart_seqs_13");
  super.new(name);
 endfunction

 task body();
   req = write_xtn::type_id::create("req");
   start_item(req);
      assert(req.randomize() with { WB_ADDR_I == 3 ; WB_WE_I == 1 ; WB_DAT_I == 8'b10000000; } )
    `uvm_info("loding_data_lcr",$sformatf("LOADING DATA IN LCR %s",req.sprint()),UVM_MEDIUM)
 // LCR SELECTION
   finish_item(req);
  
   start_item(req);
      assert(req.randomize() with { WB_WE_I == 1; WB_ADDR_I == 0 ; WB_DAT_I == 62 ;}) //LSB OF DLV
       `uvm_info("loading_data_in dlv 1",$sformatf("LOADING DATA IN DLV  %s",req.sprint()),UVM_MEDIUM)

   finish_item(req);
 
   start_item(req); 
      assert(req.randomize() with { WB_WE_I == 1; WB_ADDR_I == 1 ; WB_DAT_I == 0;})  //MSB OF DLV
      `uvm_info("loading_data_in dlv 2",$sformatf("LOADING DATA IN DLV %s",req.sprint()),UVM_MEDIUM)

   finish_item(req);

   start_item(req);
      assert(req.randomize() with {WB_WE_I == 1; WB_ADDR_I == 3 ; WB_DAT_I == 8'b00000011;})  //AGAIN SETTING LCR
          `uvm_info("UART_WR_SEQ",$sformatf("AGAIN IN lcr  %s",req.sprint()),UVM_MEDIUM)

   finish_item(req);

   start_item(req);
      assert(req.randomize() with {WB_WE_I == 1; WB_ADDR_I == 2 ; WB_DAT_I == 8'b01000000;})//FCR REGISTER
       `uvm_info("UART_WR_SEQ",$sformatf("fifo is being rest here %s",req.sprint()),UVM_MEDIUM)
   finish_item(req);

   start_item(req);
      assert(req.randomize() with {WB_WE_I == 1; WB_ADDR_I == 1 ; WB_DAT_I == 8'b00000001;})
    `uvm_info("UART_WR_SEQ",$sformatf("ier register %s",req.sprint()),UVM_MEDIUM)
 //SETTING UP THE IER REGISTER
   finish_item(req);

    
    start_item(req);
           assert(req.randomize() with {WB_WE_I == 1; WB_ADDR_I == 0  ;})  //SENDING RANDOMIZE DATA
       `uvm_info("UART_WR_SEQ",$sformatf("DATA IS RANDOMIZED HERE %s",req.sprint()),UVM_MEDIUM)
   finish_item(req);
   
    
   start_item(req);
      assert(req.randomize() with {WB_WE_I == 0; WB_ADDR_I == 2 ;}) // SELECTING iir REGISTER
   finish_item(req);

  get_response(req);

 case(req.IIR[3:1])
   3'b010     : $display("! !! !! ! ! ! ! ! ! PLEASE READ DATA  YOU GOT RECEIVER DATA INTRUPT!1 !1!! ! !11111! !   1 1 1  !1"); 
                /* begin
                 start_item(req);
                 assert(req.randomize() with {WB_ADDR_I == 0 ; WB_WE_I == 0;} )
                 finish_item(req);
                 end*/

  3'b011      :  $display("! !! !! ! ! ! ! ! ! PLEASE READ DATA  YOU GOT RECEIVER LSR INTRUPT!1 !1!! ! !11111! !   1 1 1  !1");

                 /*begin
                 start_item(req);
                 assert(req.randomize() with {WB_ADDR_I == 5 ; WB_WE_I == 0;})
                 finish_item(req); 
                 end*/
  
  3'b110      : $display("! !! !! ! ! ! ! ! ! PLEASE READ DATA  YOU DATA INTRUPT!1 !1!! ! !11111! ! @@@  1 1 1  !1");

                /* begin
                  start_item(req);
                 assert(req.randomize() with {WB_ADDR_I == 0 ; WB_WE_I == 0;} )
                 finish_item(req);
                 end*/
  endcase
               
                                                                                                                                       
   endtask

endclass

class uart_seqs_14 extends  wr_base_seqs;

    `uvm_object_utils(uart_seqs_14)

 function new(string name = "uart_seqs_14");
  super.new(name);
 endfunction

task body();
req = write_xtn::type_id::create("req");
   start_item(req);
      assert(req.randomize() with { WB_ADDR_I == 3 ; WB_WE_I == 1 ; WB_DAT_I == 8'b10000000 ; } ) 
       `uvm_info("loding_data_lcr",$sformatf("LOADING DATA IN LCR %s",req.sprint()),UVM_MEDIUM)
   finish_item(req);
  
   start_item(req);
      assert(req.randomize() with { WB_WE_I == 1; WB_ADDR_I == 0 ; WB_DAT_I == 16 ;}) //LSB OF DLV
      `uvm_info("loading_data_in dlv 1",$sformatf("LOADING DATA IN DLV  %s",req.sprint()),UVM_MEDIUM)

   finish_item(req);
 
   start_item(req); 
      assert(req.randomize() with { WB_WE_I == 1; WB_ADDR_I == 1 ; WB_DAT_I == 0;})  //MSB OF DLV
       `uvm_info("loading_data_in dlv 2",$sformatf("LOADING DATA IN DLV %s",req.sprint()),UVM_MEDIUM)

   finish_item(req);

   start_item(req);
      assert(req.randomize() with {WB_WE_I == 1; WB_ADDR_I == 3 ; WB_DAT_I == 8'b00000011       ;})  //AGAIN LCR
      `uvm_info("UART_WR_SEQ",$sformatf("AGAIN IN lcr  %s",req.sprint()),UVM_MEDIUM)

   finish_item(req);

   start_item(req);
      assert(req.randomize() with {WB_WE_I == 1; WB_ADDR_I == 2 ; WB_DAT_I == 8'b01000000;})  //SETTING UP FCR
   finish_item(req);

   start_item(req);
      assert(req.randomize() with {WB_WE_I == 1; WB_ADDR_I == 1 ; WB_DAT_I == 8'b00000001;}) // IER
      `uvm_info("UART_WR_SEQ",$sformatf("fifo is being rest here %s",req.sprint()),UVM_MEDIUM)

   finish_item(req);

   repeat(18) 
   begin
     start_item(req);
       assert(req.randomize() with {WB_WE_I == 1; WB_ADDR_I == 0 ; $countones(WB_DAT_I) == 5;})// RANDOMIZING DATA
      `uvm_info("UART_WR_SEQ",$sformatf("DATA IS RANDOMIZED HERE %s",req.sprint()),UVM_MEDIUM)
    finish_item(req);
    end 
      
   start_item(req);
      assert(req.randomize() with {WB_WE_I == 0; WB_ADDR_I == 2 ; }) //GIVING THE ADDRESS FOR IIR SELECTION
   finish_item(req);
  
   get_response(req);
  case(req.IIR[3:1])
   3'b010     : $display("! !! !! ! ! ! ! ! ! PLEASE READ DATA  YOU GOT RECEIVER DATA INTRUPT!1 !1!! ! !11111! !   1 1 1  !1");
                /* repeat(4)
                 begin
                 start_item(req);
                 assert(req.randomize() with {WB_ADDR_I == 0 ; WB_WE_I == 0;} )
                 finish_item(req);
                 end */

  3'b011      :$display("! !! !! ! ! ! ! ! ! PLEASE READ DATA  YOU GOT RECEIVER LSR INTRUPT!1 !1!! ! !11111! !   1 1 1  !1");
       
         /*          begin
                 start_item(req);
                 assert(req.randomize() with {WB_ADDR_I == 5 ; WB_WE_I == 0;})
                 finish_item(req); 
                 end   */
  
  3'b110      : $display("! !! !! ! ! ! ! ! ! PLEASE READ DATA  YOU DATA INTRUPT!1 !1!! ! !11111! ! @@@  1 1 1  !1");

                /*  begin
                  start_item(req);
                 assert(req.randomize() with {WB_ADDR_I == 0 ; WB_WE_I == 0;} )
                 finish_item(req);
                 end */
  endcase


  endtask

 endclass

