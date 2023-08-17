//`timescale 1ns/100ps

package uart_test_pkg;

//import uvm_pkg.sv
	import uvm_pkg::*;
//include uvm_macros.sv
	`include "uvm_macros.svh"
`include "tb_def.sv"
`include "write_xtn.sv"
`include "read_xtn.sv"
                     
`include "uart_wr_agent_config.sv"
`include "uart_rd_agent_config.sv"
`include "uart_env_config.sv"
`include "uart_wr_driver.sv"
`include "uart_wr_monitor.sv"
`include "uart_wr_sequencer.sv"
`include "uart_wr_agent.sv"
`include "uart_wr_agt_top.sv"
`include "uart_wr_seqs.sv"

`include "uart_rd_monitor.sv"
`include "uart_rd_sequencer.sv"
//`include "uart_rd_seqs.sv"
`include "uart_rd_driver.sv"
`include "uart_rd_agent.sv"
`include "uart_rd_agt_top.sv"

`include "uart_virtual_sequencer.sv"
`include "uart_virtual_seqs.sv"
`include "uart_scoreboard.sv"

`include "uart_tb.sv"


`include "uart_vtest_lib.sv"
endpackage
