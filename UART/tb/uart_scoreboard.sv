class uart_scoreboard extends uvm_scoreboard;
  
  `uvm_component_utils(uart_scoreboard)
  write_xtn w_xtn1;
  write_xtn w_xtn2;
  uvm_tlm_analysis_fifo #(write_xtn) master0_fifo;
  uvm_tlm_analysis_fifo #(write_xtn) master1_fifo; 
  
   
   covergroup cg;
   option.per_instance = 1;
    IIR: coverpoint w_xtn1.IIR[3:1]
                             {bins b1 = {3};
                              bins b2 = {2};
                              bins b3 = {6};}
    LCR: coverpoint w_xtn1.LCR;
    FCR: coverpoint w_xtn1.FCR;
    IER: coverpoint w_xtn1.IER;
    LSR: coverpoint w_xtn1.LS;
  endgroup
   
  covergroup cg2;
   option.per_instance = 1;
    IIR1: coverpoint w_xtn2.IIR[3:1]
                              {bins b1 = {3};
                              bins b2 =  {2};
                              bins b3 =  {6};}

    LCR1: coverpoint w_xtn2.LCR;
    FCR1: coverpoint w_xtn2.FCR;
    IER1: coverpoint w_xtn2.IER;
    LSR1: coverpoint w_xtn2.LS;
  endgroup
   


function new(string name = "uart_scoreboard" , uvm_component parent);
        super.new(name,parent);
 	cg= new();
	cg2 = new();

   endfunction

 
  extern function void build_phase(uvm_phase phase);
  extern task run_phase (uvm_phase phase);
  extern function void  check_phase(uvm_phase phase);
endclass

 function void uart_scoreboard::build_phase(uvm_phase phase);
  super.build_phase(phase);
   master0_fifo = new("master0_fifo",this);
   master1_fifo = new("master1_fifo",this);
   
   
   

 endfunction
 
  
  task uart_scoreboard::run_phase(uvm_phase phase);
      
       	forever
	begin
	   	fork   
                        begin
			master0_fifo.get(w_xtn1);
                               $display("xnc kjsdhfkjhr dr fjksfghiwerhgihefs hijdhg");
				w_xtn1.print();
                               $display(" adhh iwuefiusdhfih uikjgdfi d f;lweif klef ");
                        cg.sample();
                        end

                        begin
			master1_fifo.get(w_xtn2);
                                 $display("xnc kjsdhfkjhr dr fjksfghiwerhgihefs hijdhg");
                                  w_xtn2.print();
                                 $display("lwjdk hwhduh iowddi du d oijkld j  eijhijfioi ueih  	");
                         cg2.sample();
                        end
		join
		w_xtn1.print();
		w_xtn2.print();
	end
   
/*forever
      begin
        fork
          master0_fifo.get(w_xtn1);
           w_xtn1.print();
          master1_fifo.get(w_xtn2);
           w_xtn2.print();
         join
        // compa_re();
       end*/
  endtask 

  function void uart_scoreboard ::check_phase(uvm_phase phase);
   begin
      foreach(w_xtn1.THR[i])
          begin
           if(w_xtn1.THR[i] == w_xtn2.RB[i])
            `uvm_info("THE_COMPARE_METHOD",$sformatf("THE DATA IS RECIVERD CORRECTLY %s && %s",w_xtn1.sprint(),w_xtn2.sprint()),UVM_MEDIUM)
           else 
            `uvm_info("THE_COMPARE_METHOD",$sformatf("XXXXXXXXXXXXXXXXTHE DATA IS NOT RECIVERD CORRECTLYXXXXXXXXXXXXX %s && %s",w_xtn1.sprint(),w_xtn2.sprint()),UVM_MEDIUM)
           end
  
      foreach(w_xtn2.THR[j])
          begin
           if(w_xtn2.THR[j] == w_xtn1.RB[j])
            `uvm_info("THE_COMPARE_METHOD",$sformatf("THE DATA IS RECIVERD CORRECTLY %s && %s",w_xtn1.sprint(),w_xtn2.sprint()),UVM_MEDIUM)
           else 
            `uvm_info("THE_COMPARE_METHOD",$sformatf("XXXXXXXXXXXXXXXXTHE DATA IS NOT RECIVERD CORRECTLYXXXXXXXXXXXXX %s && %s",w_xtn1.sprint(),w_xtn2.sprint()),UVM_MEDIUM)
           end
      
   end
   endfunction 
