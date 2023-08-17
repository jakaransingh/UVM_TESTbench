
module top();
	import uvm_pkg::*;
	import uart_test_pkg::*;

bit clock1 = 0;
always
#20 clock1 = !clock1;

bit clock2 = 0;
always
#5 clock2 = !clock2;

uart_if in0(clock2); //MASTER1 IS WORKING ACCORDING TO 100MHZ
uart_if in1(clock1); //MASTER2 IS WORKING ACCORDING TO 25MHZ

wire STX_PAD_O,SRX_PAD_I;

uart_top   MASTERDUT1(
	.wb_clk_i(clock2), .wb_rst_i(in0.WB_RST_I), 
        .wb_adr_i(in0.WB_ADDR_I),.wb_dat_i(in0.WB_DAT_I), 
        .wb_dat_o(in0.WB_DAT_O), .wb_we_i(in0.WB_WE_I), 
        .wb_stb_i(in0.WB_STB_I), .wb_cyc_i(in0.WB_CYC_I), 
        .wb_ack_o(in0.WB_ACK_O), .wb_sel_i(in0.WB_SEL_I),
        .int_o(in0.IN_O), // interrupt request
        .stx_pad_o(STX_PAD_O), .srx_pad_i(SRX_PAD_I),
        .baud_o(in0.BAUD_OUT));

uart_top	MASTERDUT2(
	.wb_clk_i(clock1), .wb_rst_i(in1.WB_RST_I),
        .wb_adr_i(in1.WB_ADDR_I), .wb_dat_i(in1.WB_DAT_I),
        .wb_dat_o(in1.WB_DAT_O), .wb_we_i(in1.WB_WE_I), 
        .wb_stb_i(in1.WB_STB_I),.wb_cyc_i(in1.WB_CYC_I), 
         .wb_ack_o(in1.WB_ACK_O), .wb_sel_i(in1.WB_SEL_I),
	.int_o(in1.IN_O), // interrupt request

	// UART	signals
	// serial input/output
	.stx_pad_o(SRX_PAD_I), .srx_pad_i(STX_PAD_O),	
         .baud_o(in1.BAUD_OUT));



initial
begin
  uvm_config_db #(virtual uart_if):: set(null,"*","vifw_0",in0);
  uvm_config_db #(virtual uart_if):: set(null,"*","vifw_1",in1);

  run_test();
end

endmodule


