class uart_test extends uvm_test;

 `uvm_component_utils(uart_test)
 
 int no_of_wr_agt = 2;
 int no_of_rd_agt = 0;
 wr_config wcfg[];
 rd_config rcfg[];
 env_config ecfg;
 uart_env u_env;
//////////////////
 seqh2 vseqh2;
//////////////////////
 v_wr_seqs v_seqs;
//////////////////////
 seqh3 vseqh3;
////////////////////
 seqh4 vseqh4;
//////////////////////
 seqh5 vseqh5;
/////////////////////
seqh6 vseqh6;
//////////////////////
seqh7 vseqh7;



 function new(string name ="uart_test" , uvm_component parent);
  super.new(name,parent);
 endfunction


 extern function void build_phase(uvm_phase phase);
 //extern task run_phase(uvm_phase phase);

endclass


function void uart_test::build_phase(uvm_phase phase);
ecfg = env_config::type_id::create("ecfg");
ecfg.no_of_wr_agt = no_of_wr_agt;
ecfg.no_of_rd_agt = no_of_rd_agt;
ecfg.has_scoreboard = 1;

 //super.build_phase(phase);
  wcfg = new[no_of_wr_agt];
  rcfg = new[no_of_rd_agt];
  ecfg.w_cfg =  new[no_of_wr_agt];
  ecfg.r_cfg =  new[no_of_rd_agt];
  

  ecfg.has_wr_agt = 1;
  ecfg.has_rd_agt = 0;

  foreach(wcfg[i])
    begin
   wcfg[i] = wr_config::type_id::create($sformatf("wcfg[%0d]",i));
   if(!uvm_config_db #(virtual uart_if):: get(this,"",$sformatf("vifw_%0d",i),wcfg[i].vif))
       `uvm_fatal("IN_UVM_TEST","!!!!YOUR GET METHOD IS NOT WORKING IN TEST!!!!")

   wcfg[i].is_active = UVM_ACTIVE;
    ecfg.w_cfg[i] = wcfg[i];  
   $display("THE PATH IS %p",wcfg[i]);
    end


 foreach(rcfg[j])
    begin
          rcfg[j] = rd_config::type_id::create($sformatf("rcfg[%0d]",j));

      if(!uvm_config_db #(virtual uart_if):: get(this,"",$sformatf("vifr_%0d",j),rcfg[j].vif))
       `uvm_fatal("IN_UVM_TEST","!!!!!!!!!!!!YOUR GET METHOD IS NOT WORKING!!!!!!!!!!!")
         rcfg[j].is_active = UVM_ACTIVE;
        ecfg.r_cfg[j] = rcfg[j];
        $display("the path is %p",rcfg[j]); 
     end
  
     uvm_config_db #(env_config):: set(this,"*","env_config",ecfg);
 super.build_phase(phase);

     u_env = uart_env::type_id::create("u_env",this);
   factory.set_inst_override_by_type(.full_inst_path("*"), .original_type(write_xtn::get_type()),.override_type(write_xtn_6::get_type()));//, 1);

    // u_seq =  uart_seqs_2::type_id::create("u_seq");
      
endfunction

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class run_test1 extends uart_test;

  `uvm_component_utils(run_test1)
  
 function new(string name = "run_test1" , uvm_component parent);
   super.new(name,parent);
 endfunction
 
function void build_phase(uvm_phase phase);
 super.build_phase(phase);
endfunction
 

task run_phase(uvm_phase phase);
  super.run_phase(phase);
 
   phase.raise_objection(this);
   v_seqs = v_wr_seqs::type_id::create("v_seqs");

     v_seqs.start(u_env.vseqrh);
  
  phase.drop_objection(this);

endtask 

endclass

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class run_test2 extends uart_test;

  `uvm_component_utils(run_test2)
  
 function new(string name = "run_test1" , uvm_component parent);
   super.new(name,parent);
 endfunction
 
function void build_phase(uvm_phase phase);
 super.build_phase(phase);
endfunction
 

task run_phase(uvm_phase phase);
  super.run_phase(phase);
 
   phase.raise_objection(this);
   vseqh2 = seqh2::type_id::create("v_seqs");

     vseqh2.start(u_env.vseqrh);
  #2000000;
  phase.drop_objection(this);

endtask 

endclass

//////////////////////////////////////////////////////////////////////////////////////

class run_test3 extends uart_test;

  `uvm_component_utils(run_test3)
  
 function new(string name = "run_test3" , uvm_component parent);
   super.new(name,parent);
 endfunction
 
function void build_phase(uvm_phase phase);
 super.build_phase(phase);
endfunction
 

task run_phase(uvm_phase phase);
  super.run_phase(phase);
 
   phase.raise_objection(this);
   vseqh3 = seqh3::type_id::create("v_seqs");

     vseqh3.start(u_env.vseqrh);
  #20000;
  phase.drop_objection(this);

endtask 

endclass

///////////////////////////////////////////////////////////////////////////////////////

class run_test4 extends uart_test;

  `uvm_component_utils(run_test4)
  
 function new(string name = "run_test4" , uvm_component parent);
   super.new(name,parent);
 endfunction
 
function void build_phase(uvm_phase phase);
 super.build_phase(phase);
endfunction
 

task run_phase(uvm_phase phase);
  super.run_phase(phase);
 
   phase.raise_objection(this);
   vseqh4 = seqh4::type_id::create("v_seqs");

     vseqh4.start(u_env.vseqrh);
  #2000000;
  phase.drop_objection(this);

endtask 

endclass
//////////////////////////////////////////////////////////////////////////////////////////////
class run_test5 extends uart_test;

  `uvm_component_utils(run_test5)
  
 function new(string name = "run_test5" , uvm_component parent);
   super.new(name,parent);
 endfunction
 
function void build_phase(uvm_phase phase);
 super.build_phase(phase);
endfunction
 

task run_phase(uvm_phase phase);
  super.run_phase(phase);
 
   phase.raise_objection(this);
   vseqh5 = seqh5::type_id::create("v_seqs5");

     vseqh5.start(u_env.vseqrh);
  #2000000;
  phase.drop_objection(this);

endtask 

endclass
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class run_test6 extends uart_test;

  `uvm_component_utils(run_test6)
  
 function new(string name = "run_test6" , uvm_component parent);
   super.new(name,parent);
 endfunction
 
function void build_phase(uvm_phase phase);
 super.build_phase(phase);
endfunction
 

task run_phase(uvm_phase phase);
  super.run_phase(phase);
 
   phase.raise_objection(this);
   vseqh6 = seqh6::type_id::create("v_seqs6");

     vseqh6.start(u_env.vseqrh);
  #2000000;
  phase.drop_objection(this);

endtask 

endclass
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class run_test7 extends uart_test;

  `uvm_component_utils(run_test7)
  
 function new(string name = "run_test7" , uvm_component parent);
   super.new(name,parent);
 endfunction
 
function void build_phase(uvm_phase phase);
 super.build_phase(phase);
endfunction
 

task run_phase(uvm_phase phase);
  super.run_phase(phase);
 
   phase.raise_objection(this);
   vseqh7 = seqh7::type_id::create("v_seqs7");

     vseqh7.start(u_env.vseqrh);
  #2000000;
  phase.drop_objection(this);

endtask 

endclass

