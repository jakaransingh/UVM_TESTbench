class wr_driver extends uvm_driver#(write_xtn);
 
 `uvm_component_utils(wr_driver)
  virtual uart_if.wrdrv vif;
  wr_config wcfg;
  
  function new(string name = "wr_driver" , uvm_component parent);
   super.new(name,parent);
  endfunction
  extern function void build_phase(uvm_phase phase);
  extern task run_phase(uvm_phase phase);
  extern function void connect_phase(uvm_phase phase);
  extern task send_to_dut(write_xtn w_xtn);
endclass

 function void wr_driver::build_phase(uvm_phase phase);
  super.build_phase(phase);
  
  if(!uvm_config_db#(wr_config)::get(this,"","wr_config",wcfg))
   `uvm_fatal("IN_WR_DRIVER","YOUR GET METHOD IS NOT WORKING")
  $display("good=====%p",wcfg);
 endfunction
 

 function void wr_driver::connect_phase(uvm_phase phase);
  vif = wcfg.vif;
 endfunction
 
 task wr_driver::run_phase(uvm_phase phase);
 super.run_phase(phase);
 @(vif.wr_drv)
   vif.wr_drv.WB_RST_I<=1;
   repeat(2)
 @(vif.wr_drv)
   vif.wr_drv.WB_RST_I<=0;

	
   forever 
    begin
     seq_item_port.get_next_item(req);
          send_to_dut(req);
       // req.print();
         seq_item_port.item_done();

    end

 endtask


  task wr_driver::send_to_dut(write_xtn w_xtn);
  @(vif.wr_drv)
   vif.wr_drv.WB_WE_I   <=  w_xtn.WB_WE_I;
   vif.wr_drv.WB_STB_I  <=  1;
   vif.wr_drv.WB_CYC_I  <=  1;
  // vif.wr_drv.WB_RST_I<= w_xtn.WB_RST_I;
   vif.wr_drv.WB_ADDR_I <=  w_xtn.WB_ADDR_I;
   vif.wr_drv.WB_DAT_I  <=  w_xtn.WB_DAT_I;
   vif.wr_drv.WB_SEL_I  <=  4'b0001 ;
   //vif.wr_drv.WB_DAT_O  <=  w_xtn.WB_DAT_O;

 


  @(vif.wr_drv)
   begin 
   wait(vif.wr_drv.WB_ACK_O)
   vif.wr_drv.WB_STB_I <= 0;
   vif.wr_drv.WB_CYC_I <= 0;
   @(vif.wr_drv);
   end

if(w_xtn.WB_ADDR_I == 2 && w_xtn.WB_WE_I == 0)
  begin
    wait(vif.wr_drv.IN_O)
    @(vif.wr_drv)
    w_xtn.IIR = vif.wr_drv.WB_DAT_O;
    seq_item_port.put_response(w_xtn);
  end




endtask 
   
   
