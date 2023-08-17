class virtual_seqs extends uvm_sequence#(uvm_sequence_item);

`uvm_object_utils(virtual_seqs)
  
 function new(string name ="virtual_seqs");
  super.new(name);
 endfunction
  wr_sequencer w_seqrh[];
  env_config e_cfg;
  v_sequencer v_seqrh;

  uart_seqs_1 u_seqs_1;
  uart_seqs_2 u_seqs_2;

  uart_seqs_3 u_seqs_3;
  uart_seqs_4 u_seqs_4;
  
  uart_seqs_6 u_seqs_6;
  uart_seqs_5 u_seqs_5;

 uart_seqs_8 u_seqs_8;
 uart_seqs_7 u_seqs_7;

 uart_seqs_9 u_seqs_9;
 uart_seqs_10 u_seqs_10;

  uart_seqs_11 u_seqs_11;
 uart_seqs_12 u_seqs_12;

  uart_seqs_13 u_seqs_13;
 uart_seqs_14 u_seqs_14;

 

 task body();
   if(!uvm_config_db#(env_config)::get(null,get_full_name(),"env_config",e_cfg))     
     `uvm_fatal("IN_VIRTUA_SEUENCE","your get method is not working ")
  
   w_seqrh = new[e_cfg.no_of_wr_agt];
 
    if(!$cast(v_seqrh,m_sequencer))
     `uvm_fatal("in virtual_seqs","your casting is not working")

     foreach(w_seqrh[i])
	   begin
      w_seqrh[i] = v_seqrh.wseqrh[i];
      end
   endtask

endclass
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

 class v_wr_seqs extends virtual_seqs;

  `uvm_object_utils(v_wr_seqs)
   function new(string name ="v_wr_seqs");
    super.new(name);
   endfunction

  
    task body();
     super.body();
   u_seqs_1 = uart_seqs_1::type_id::create("u_seqsl");
   u_seqs_2 = uart_seqs_2::type_id::create("u_seqsp");

     fork
      u_seqs_1.start(w_seqrh[0]);
      u_seqs_2.start(w_seqrh[1]);
     join

    endtask


endclass
         
  

/////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////////////

class seqh2 extends virtual_seqs;

 
`uvm_object_utils(seqh2)

 function new(string name = "seqh2");
   super.new();
 endfunction

 task body();
  super.body();
    u_seqs_3 = uart_seqs_3::type_id::create("u_seqs_1");
    u_seqs_4 = uart_seqs_4::type_id::create("u_seqh_2");
   fork 
      u_seqs_3.start(w_seqrh[0]);
      u_seqs_4.start(w_seqrh[1]);
    
   join
 endtask 

endclass

//////////////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////////////////////////

class seqh3 extends virtual_seqs;

 
`uvm_object_utils(seqh3)

 function new(string name = "seqh2");
   super.new();
 endfunction

 task body();
  super.body();
    u_seqs_5 = uart_seqs_5::type_id::create("u_seqs_5");
    u_seqs_6 = uart_seqs_6::type_id::create("u_seqh_6");
   fork 
      u_seqs_5.start(w_seqrh[0]);
      u_seqs_6.start(w_seqrh[1]);
    
   join
 endtask 

endclass

///////////////////////////////////////////////////////////////////////////////////////////////////
class seqh4 extends virtual_seqs;

 
`uvm_object_utils(seqh4)

 function new(string name = "seqh4");
   super.new();
 endfunction

 task body();
  super.body();
    u_seqs_8 = uart_seqs_8::type_id::create("u_seqs_8");
    u_seqs_7 = uart_seqs_7::type_id::create("u_seqh_7");
   fork 
      u_seqs_7.start(w_seqrh[0]);
      u_seqs_8.start(w_seqrh[1]);
    
   join
 endtask 

endclass
//////////////////////////////////////////////////////////////////////////////////////////////////////
class seqh5 extends virtual_seqs;

 
`uvm_object_utils(seqh5)

 function new(string name = "seqh5");
   super.new();
 endfunction

 task body();
  super.body();
    u_seqs_9 = uart_seqs_9::type_id::create("u_seqs_9");
    u_seqs_10 = uart_seqs_10::type_id::create("u_seqh_10");
   fork 
      u_seqs_9.start(w_seqrh[0]);
      u_seqs_10.start(w_seqrh[1]);
    
   join
 endtask 

endclass

/////////////////////////////////////////////////////////////////////////////////////////////////////////

class seqh6 extends virtual_seqs;

 
`uvm_object_utils(seqh6)

 function new(string name = "seqh6");
   super.new();
 endfunction

 task body();
  super.body();
    u_seqs_11 = uart_seqs_11::type_id::create("u_seqs_10");
    u_seqs_12 = uart_seqs_12::type_id::create("u_seqh_12");
   fork 
      u_seqs_11.start(w_seqrh[0]);
      u_seqs_12.start(w_seqrh[1]);
    
   join
 endtask 

endclass
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class seqh7 extends virtual_seqs;

 
`uvm_object_utils(seqh7)

 function new(string name = "seqh7");
   super.new();
 endfunction

 task body();
  super.body();
    u_seqs_13 = uart_seqs_13::type_id::create("u_seqs_13");
    u_seqs_14 = uart_seqs_14::type_id::create("u_seqh_14");
   fork 
      u_seqs_13.start(w_seqrh[0]);
      u_seqs_14.start(w_seqrh[1]);
    
   join
 endtask 

endclass

