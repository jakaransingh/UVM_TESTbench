`define WB_ADDR_I 3
`define WB_DAT_I 8
`define WB_DAT_O 8


interface uart_if(input clock);

  logic WB_RST_I;
   logic [`WB_ADDR_I-1:0]WB_ADDR_I;
   logic [3:0]WB_SEL_I;
   logic [`WB_DAT_I-1:0]WB_DAT_I;
   logic [`WB_DAT_O-1:0]WB_DAT_O;
   logic WB_WE_I;
   logic WB_STB_I;
   logic WB_CYC_I;
   logic WB_ACK_O;
   logic IN_O;
   logic BAUD_OUT;

clocking wr_drv@(posedge clock);
default input #1 output #1;
output WB_RST_I;
output WB_ADDR_I;
output WB_SEL_I;
output WB_DAT_I;
input WB_DAT_O;
output WB_WE_I;
output WB_STB_I;
output WB_CYC_I;
input WB_ACK_O;
input IN_O;
endclocking

/* clocking rd_drv@(posedge clock);
default input #1 output #1;
output WB_RST_I;
output WB_ADDR_I;
output WB_SEL_I;
output WB_DATA_I;
output WB_DATA_O;
output WB_WE_I;
output WB_STB_I;
output WB_CYC_I;
input WB_ACK_O;

endclocking
*/
clocking wr_mon@(posedge clock);
default input #1 output #1;
input WB_RST_I;
input WB_ADDR_I;
input WB_SEL_I;
input WB_DAT_I;
input WB_DAT_O;
input WB_WE_I;
input WB_STB_I;
input WB_CYC_I;
input WB_ACK_O;
input IN_O;
//input BAUD_OUT;
endclocking


/*  clocking rd_mon@(posedge clock);
default input #1 output #1;
input WB_RST_I;
input WB_ADDR_I;
input WB_SEL_I;
input WB_DATA_I;
input WB_DATA_O;
input WB_WE_I;
input WB_STB_I;
input WB_CYC_I;
input WB_ACK_O;

endclocking 
*/
modport wrdrv(clocking wr_drv);
//modport rddrv(clocking rd_drv);
modport wrmon(clocking wr_mon);
//modport rdmon(clocking rd_mon);

endinterface
