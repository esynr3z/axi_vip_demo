//  (c) Copyright 2016 Xilinx, Inc. All rights reserved.
//
//  This file contains confidential and proprietary information
//  of Xilinx, Inc. and is protected under U.S. and
//  international copyright and other intellectual property
//  laws.
//
//  DISCLAIMER
//  This disclaimer is not a license and does not grant any
//  rights to the materials distributed herewith. Except as
//  otherwise provided in a valid license issued to you by
//  Xilinx, and to the maximum extent permitted by applicable
//  law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
//  WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
//  AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
//  BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
//  INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
//  (2) Xilinx shall not be liable (whether in contract or tort,
//  including negligence, or under any other theory of
//  liability) for any loss or damage of any kind or nature
//  related to, arising under or in connection with these
//  materials, including for any direct, or any indirect,
//  special, incidental, or consequential loss or damage
//  (including loss of data, profits, goodwill, or any type of
//  loss or damage suffered as a result of any action brought
//  by a third party) even if such damage or loss was
//  reasonably foreseeable or Xilinx had been advised of the
//  possibility of the same.
//
//  CRITICAL APPLICATIONS
//  Xilinx products are not designed or intended to be fail-
//  safe, or for use in any application requiring fail-safe
//  performance, such as life-support or safety devices or
//  systems, Class III medical devices, nuclear facilities,
//  applications related to the deployment of airbags, or any
//  other applications that could lead to death, personal
//  injury, or severe property or environmental damage
//  (individually and collectively, "Critical
//  Applications"). Customer assumes the sole risk and
//  liability of any use of Xilinx products in Critical
//  Applications, subject only to applicable laws and
//  regulations governing limitations on product liability.
//
//  THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
//  PART OF THIS FILE AT ALL TIMES. 
`ifndef _AXI_VIP_IF_SV_
`define _AXI_VIP_IF_SV_
`timescale 1ps/1ps
import axi_vip_pkg::*;

  `define XILINX_AW_SUPPORTS_NARROW_BURST "XILINX_AW_SUPPORTS_NARROW_BURST: AW Narrow burst issued from MASTER. Connection has been declared to NOT support narrow bursts."
  `define XILINX_AR_SUPPORTS_NARROW_BURST "XILINX_AR_SUPPORTS_NARROW_BURST: AR Narrow burst issued from MASTER. Connection has been declared to NOT support narrow bursts."
  `define XILINX_AX_SUPPORTS_NARROW_BURST_SOL "To downgrade, use <hierarchy_path to VIP>.IF.set_xilinx_supports_narrow_burst_check_to_warn(), or filter using clr_xilinx_supports_narrow_burst_check()."

  `define XILINX_RESET_PULSE "XILINX_RESET_PULSE_WIDTH: Holding AXI ARESETN asserted for 16 cycles of the slowest AXI clock is generally a sufficient reset pulse width for Xilinx IP. --UG1037."
  `define XILINX_RESET_PULSE_SOL "To downgrade, use <hierarchy_path to VIP>.IF.set_xilinx_reset_check_to_warn(), or filter using clr_xilinx_reset_check()."

  `define  XILINX_NO_STRB_ADDRESS "XILINX_NO_STRB_ADDRESS: Address is not aligned with data width. Connection has been declared to No STRB."
  `define  XILINX_NO_STRB_ADDRESS_SOL "To downgrade, use <hierarchy_path to VIP>.IF.set_xilinx_no_strb_address_check_to_warn(), or filter using clr_xilinx_no_strb_address_check()."

  `define XILINX_AWREADY_RESET "XILINX_AWREADY_RESET: AWREADY must be low for the first clock edge that ARESETn goes high--PG101 XILINX_AWREADY_RESET."
  `define XILINX_ARREADY_RESET "XILINX_ARREADY_RESET: ARREADY must be low for the first clock edge that ARESETn goes high--PG101 XILINX_ARREADY_RESET."
  `define XILINX_WREADY_RESET "XILINX_WREADY_RESET: WREADY must be low for the first clock edge that ARESETn goes high--PG101 XILINX_WREADY_RESET."
  `define XILINX_XREADY_RESET_SOL "To downgrade, use <hierarchy_path to VIP>.IF.clr_xilinx_slave_ready_check()."

  `define XILINX_WREADY_MAX_RESET "XILINX_WREADY_MAX_RESET: WREADY must go low after 8 cycles following the first clock edge that ARESETn goes low--UG1037 Xilinx IP generally deasserts all VALID and READY outputs within eight cycles of reset."
  `define XILINX_ARREADY_MAX_RESET "XILINX_ARREADY_MAX_RESET: ARREADY must go low after 8 cycles following the first clock edge that ARESETn goes low--UG1037 Xilinx IP generally deasserts all VALID and READY outputs within eight cycles of reset."
  `define XILINX_AWREADY_MAX_RESET "XILINX_AWREADY_MAX_RESET: AWREADY must go low after 8 cycles following the first clock edge that ARESETn goes low--UG1037 Xilinx IP generally deasserts all VALID and READY outputs within eight cycles of reset."
   `define XILINX_AR_SUPPORTS_NARROW_CACHE "XILINX_AR_SUPPORTS_NARROW_CACHE: AR Non-modifiable burst issued from MASTER. Connection has been declared to NOT support narrow bursts."
    `define XILINX_AW_SUPPORTS_NARROW_CACHE "XILINX_AW_SUPPORTS_NARROW_CACHE: AW Non-modifiable burst issued from MASTER. Connection has been declared to NOT support narrow bursts."
   `define XILINX_AX_SUPPORTS_NARROW_CACHE_SOL "To downgrade, use <hierarchy_path to VIP>.IF.clr_xilinx_supports_narrow_cache_check()."
   `define XILINX_READ_RESPONSE_SLVERR_CHECK "XILINX_READ_REPONSE_SLVERR_CHECK: READ RESPONSE is SLVERR"
   `define XILINX_READ_RESPONSE_DECERR_CHECK "XILINX_READ_REPONSE_DECERR_CHECK: READ RESPONSE is DECERR"
   `define XILINX_WRITE_RESPONSE_SLVERR_CHECK "XILINX_WRITE_REPONSE_SLVERR_CHECK: WRITE RESPONSE is SLVERR"
   `define XILINX_WRITE_RESPONSE_DECERR_CHECK "XILINX_WRITE_REPONSE_DECERR_CHECK: WRITE RESPONSE is DECERR"
   `define XILINX_READ_RESPONSE_ERROR_SOL "To downgrade, use <hierarchy_path to VIP>.IF.set_xilin_read_response_error_check_to_warn(), or filter using clr_xilinx_read_response_error_check()."
   `define XILINX_WRITE_RESPONSE_ERROR_SOL "To downgrade, use <hierarchy_path to VIP>.IF.set_xilin_write_response_error_check_to_warn(), or filter using clr_xilinx_write_response_error_check()."

   `define AXI_ARESET_XCHECK "ARESET_N can't be X/Z after 1 cycle of clock."
   `define AXI_ARESET_XCHECK_SOL "To downgrade, use <hierarchy_path to VIP>.IF.set_enable_xchecks_to_warn(), or filter using clr_enable_xchecks."

   
   //SEV_NUM is in this order to match legacy APIs
`define REPORT_LOW_LEVEL_MACRO(MSG,SOL,SEV_NUM) \
  if (SEV_NUM ==2'b00) $display("INFO: %0t %m : %s %s",$realtime,MSG,SOL); \
  else if(SEV_NUM ==2'b01) $display("WARNING: %0t %m : %s %s",$realtime,MSG,SOL); \
 
`define REPORT_HIGH_LEVEL_MACRO(MSG,SOL,SEV_NUM) \
  if(SEV_NUM ==2'b01) $display("WARNING: %0t %m : %s %s",$realtime,MSG,SOL); \
  else if (SEV_NUM ==2'b10) $display("ERROR: %0t %m  : %s %s",$realtime,MSG,SOL); \
 


`define RESET_EIGHT_PULSE(CLK,RSTN_DELAY,RSTN,SUPPORT,CLKEN,READY,MESSAGE,SOL,ENABLE,ERR_CNT) \
  initial begin :``READY``_eight_cycle_chk \
    repeat(7) @(posedge CLK); \
    forever begin \
      @(posedge CLK); \
      if ((RSTN_DELAY ==0) && (SUPPORT ==1) && (CLKEN ==1)&& (READY ==1) &&(ERR_CNT==0) && (RSTN ==0)) begin \
        `REPORT_LOW_LEVEL_MACRO(MESSAGE,SOL,ENABLE) \
        ERR_CNT +=1; \
      end \
    end \
  end 

`define RESET_ONE_PULSE(CLK,RSTN_DELAY,RSTN,SUPPORT,CLKEN,READY,MESSAGE,SOL,ENABLE,ERR_CNT) \
  initial begin :``READY``_one_cycle_chk \
    forever begin  \
      @(posedge CLK) begin \
        if ((RSTN_DELAY==0) && (SUPPORT ==1) && (CLKEN ==1)&&(READY ==1) &&(ERR_CNT ==0)&& (RSTN ==1) ) begin \
         `REPORT_LOW_LEVEL_MACRO(MESSAGE,SOL,ENABLE) \
         ERR_CNT +=1; \
       end  \
     end  \
   end  \
 end    

interface axi_vip_if #(
  int C_AXI_PROTOCOL              = 0, 
      C_AXI_ADDR_WIDTH            = 32, 
      C_AXI_WDATA_WIDTH           = 32, 
      C_AXI_RDATA_WIDTH           = 32, 
      C_AXI_WID_WIDTH             = 0,
      C_AXI_RID_WIDTH             = 0, 
      C_AXI_AWUSER_WIDTH          = 0, 
      C_AXI_WUSER_WIDTH           = 0, 
      C_AXI_BUSER_WIDTH           = 0, 
      C_AXI_ARUSER_WIDTH          = 0, 
      C_AXI_RUSER_WIDTH           = 0,
      C_AXI_SUPPORTS_NARROW       = 1,
      C_AXI_HAS_BURST             = 1,
      C_AXI_HAS_LOCK              = 1,
      C_AXI_HAS_CACHE             = 1,
      C_AXI_HAS_REGION            = 1,
      C_AXI_HAS_PROT              = 1,
      C_AXI_HAS_QOS               = 1,
      C_AXI_HAS_WSTRB             = 1,
      C_AXI_HAS_BRESP             = 1,
      C_AXI_HAS_RRESP             = 1,
      C_AXI_HAS_ARESETN           = 1
  ) 
  (input logic ACLK, ACLKEN, ARESET_N);
  parameter time C_HOLD_TIME        = 1ps;
  parameter integer C_MAXRBURSTS    = 64;
  parameter integer C_MAXWBURSTS    = 64;
  parameter integer C_MAXWAITS      = 1024;
  parameter integer C_MAXSTALLWAITS = 1024;

  // write address channel
  wire  [(C_AXI_ADDR_WIDTH-1):0]                                          AWADDR;
  wire  [((C_AXI_WID_WIDTH==0) ? 1:C_AXI_WID_WIDTH)-1:0]                  AWID;
  wire  [7:0]                                                             AWLEN;
  wire  [2:0]                                                             AWSIZE;
  wire  [1:0]                                                             AWBURST;
  wire  [1:0]                                                             AWLOCK;
  wire  [3:0]                                                             AWCACHE;
  wire  [2:0]                                                             AWPROT;
  wire                                                                    AWVALID;
  wire                                                                    AWREADY;
  wire  [3:0]                                                             AWREGION;
  wire  [3:0]                                                             AWQOS;
  wire  [((C_AXI_AWUSER_WIDTH == 0) ? 0 : C_AXI_AWUSER_WIDTH -1):0]       AWUSER;

  // write data channel
  wire  [((C_AXI_WID_WIDTH==0) ? 1:C_AXI_WID_WIDTH)-1:0]                  WID;
  wire                                                                    WLAST;
  wire  [(C_AXI_WDATA_WIDTH-1):0]                                         WDATA;
  wire  [(C_AXI_WDATA_WIDTH/8 ==0 ? 0: C_AXI_WDATA_WIDTH/8)-1:0]          WSTRB;
  wire                                                                    WVALID;
  wire                                                                    WREADY;
  wire  [((C_AXI_WUSER_WIDTH == 0) ? 0 : C_AXI_WUSER_WIDTH -1):0]         WUSER;

  // write response channel
  wire  [1:0]                                                             BRESP;
  wire  [((C_AXI_WID_WIDTH==0) ? 1:C_AXI_WID_WIDTH)-1:0]                  BID;
  wire                                                                    BVALID;
  wire                                                                    BREADY;
  wire  [((C_AXI_BUSER_WIDTH == 0) ? 0 : C_AXI_BUSER_WIDTH -1):0]         BUSER;

  // read address channel
  wire  [(C_AXI_ADDR_WIDTH-1):0]                                          ARADDR;
  wire  [((C_AXI_RID_WIDTH==0) ? 1:C_AXI_RID_WIDTH)-1:0]                  ARID;
  wire  [7:0]                                                             ARLEN;
  wire  [2:0]                                                             ARSIZE;
  wire  [1:0]                                                             ARBURST;
  wire  [1:0]                                                             ARLOCK;
  wire  [3:0]                                                             ARCACHE;
  wire  [2:0]                                                             ARPROT;
  wire                                                                    ARVALID;
  wire                                                                    ARREADY;
  wire  [3:0]                                                             ARREGION;
  wire  [3:0]                                                             ARQOS;
  wire  [((C_AXI_ARUSER_WIDTH == 0) ? 0 : C_AXI_ARUSER_WIDTH -1):0]       ARUSER;

  // read data  channel
  wire  [((C_AXI_RID_WIDTH==0) ? 1:C_AXI_RID_WIDTH)-1:0]                  RID;
  wire                                                                    RLAST;
  wire  [(C_AXI_RDATA_WIDTH-1):0]                                         RDATA;
  wire  [1:0]                                                             RRESP;
  wire                                                                    RVALID;
  wire                                                                    RREADY;
  wire  [((C_AXI_RUSER_WIDTH == 0) ? 0 : C_AXI_RUSER_WIDTH -1):0]         RUSER;

  integer unsigned  awcmd_id = 0;
  integer unsigned  arcmd_id = 0;
  integer unsigned  rcmd_id = 0;
  integer unsigned  wcmd_id = 0;
  integer unsigned  bcmd_id = 0;
  logic intf_is_master = 0;
  logic intf_is_slave  = 0;

  logic supports_write = 1;
  logic supports_read = 1;
  logic [1:0] xilinx_slave_ready_check_enable = 2'b01;
  logic [1:0] xilinx_reset_check_enable = 2'b10;
  logic [1:0] xilinx_supports_narrow_cache_check_enable = 2'b01;
  logic [1:0] xilinx_supports_narrow_burst_check_enable = 2'b10;
  logic [1:0] xilinx_no_strb_address_check_enable = 2'b10;
  logic [1:0] enable_xchecks = 2'b10;
  logic [1:0] xilinx_write_response_check_enable = 2'b00;
  logic [1:0] xilinx_read_response_check_enable = 2'b00;


  integer reset_cnt;
  integer  report_awburst_err_cnt =0;
  integer  report_arburst_err_cnt =0;
  integer  report_awcache_err_cnt =0;
  integer  report_arcache_err_cnt =0;
  integer  report_strb_err_cnt    =0;
  integer  report_reset_pulse_err_cnt =0;
  integer  report_areset_xcheck_err_cnt =0;
  integer  report_wready_one_pulse_err_cnt =0;
  integer  report_awready_one_pulse_err_cnt =0;
  integer  report_arready_one_pulse_err_cnt =0;
  integer  report_wready_eight_pulse_err_cnt =0;
  integer  report_awready_eight_pulse_err_cnt =0;
  integer  report_arready_eight_pulse_err_cnt =0;
  integer  report_rresp_slv_err_cnt =0;
  integer  report_bresp_slv_err_cnt =0;
  integer  report_rresp_dec_err_cnt =0;
  integer  report_bresp_dec_err_cnt =0;

  logic resetn_delay_eight_cycle;
  logic resetn_delay_one_cycle;
  logic fake_reset;
  logic real_reset;
  logic reset_for_assert;
  logic [7:0] resetn_q =8'b0;


  /*
  * Function: set_supports_write
  * Sets supports_write to be 1
  */
  function void set_supports_write();
    supports_write = 1;
  endfunction

  /*
  * Function: clr_supports_write
  * Sets supports_write to be 0
  */
  function void clr_supports_write();
    supports_write = 0;
  endfunction

  /*
  * Function: set_supports_read
  * Sets supports_read to be 1
  */
  function void set_supports_read();
    supports_read = 1;
  endfunction

  /*
  * Function: clr_supports_read
  * Sets supports_read to be 0
  */
  function void clr_supports_read();
    supports_read = 0;
  endfunction

 /*
  *  Function: set_xilinx_slave_ready_check
  *  Sets xilinx_slave_ready_check_enable to turn on warning message when there is a violation of rules which arready/awready/wready 
  *  should follow when the VIP goes into reset mode or comes out of reset mode.
  */
  function void set_xilinx_slave_ready_check();
    xilinx_slave_ready_check_enable = 2'b01;
  endfunction

  /*
  * Function: clr_xilinx_slave_ready_check
  * Sets xilinx_slave_ready_check_enable to turn off warning message when there is a violation of rules which arready/awready/wready 
  * should follow when the VIP goes into reset mode or comes out of reset mode.
  */
  function void clr_xilinx_slave_ready_check();
    xilinx_slave_ready_check_enable = 2'b00;
  endfunction

  
  /*
  *  Function: set_xilinx_reset_check
  *  Sets xilinx_reset_check_enable to turn on error message when there is a violation of rule which is
  *  holding AXI ARESETN asserted for 16 cycles of the slowest AXI clock is generally a sufficient reset
  *  pulse width for Xilinx IP--UG1037
  */
  function void set_xilinx_reset_check();
    xilinx_reset_check_enable = 2'b10;
  endfunction

  /*
  * Function: set_xilinx_reset_check_to_warn
  * Sets xilinx_reset_check_enable to turn on warning message when there is a violation of rule which is
  * holding AXI ARESETN asserted for 16 cycles of the slowest AXI clock is generally a sufficient reset
  * pulse width for Xilinx IP--UG1037
  */
  function void set_xilinx_reset_check_to_warn();
    xilinx_reset_check_enable = 2'b01;
  endfunction

  /*
  * Function: clr_xilinx_reset_check
  * Sets xilinx_reset_check_enable to turn off warning/error message when there is a violation of rule which is
  * holding AXI ARESETN asserted for 16 cycles of the slowest AXI clock is generally a sufficient reset
  * pulse width for Xilinx IP--UG1037
  */
  function void clr_xilinx_reset_check();
    xilinx_reset_check_enable = 2'b00;
  endfunction

  /*
  *  Function: set_xilinx_supports_narrow_burst_check
  *  Sets xilinx_supports_narrow_burst_check_enable to turn on error message when a narrow burst is being
  *  detected while this VIP is in not support narrow burst mode.
  */
  function void set_xilinx_supports_narrow_burst_check();
    xilinx_supports_narrow_burst_check_enable = 2'b10;
  endfunction

  /*
  * Function: set_xilinx_supports_narrow_burst_check_to_warn
  * Sets xilinx_supports_narrow_burst_check_enable to downgrade/upgrade to warning message when a narrow burst 
  * is being detected while this VIP is in not support narrow burst mode.
  */
  function void set_xilinx_supports_narrow_burst_check_to_warn();
    xilinx_supports_narrow_burst_check_enable = 2'b01;
  endfunction

  /*
  * Function: clr_xilinx_supports_narrow_burst_check
  * Sets xilinx_supports_narrow_burst_check_enable to downgrade error/warning into info message when a narrow burst 
  * is being detected while this VIP is in not support narrow burst mode.
  */
  function void clr_xilinx_supports_narrow_burst_check();
    xilinx_supports_narrow_burst_check_enable = 2'b00;
  endfunction

 /*
  *  Function: set_xilinx_no_strb_address_check
  *  Sets xilinx_no_strb_address_check_enable to turn on error message when address is being detected not aligned with 
  *  data width while this VIP is in no strobe mode. 
  */
  function void set_xilinx_no_strb_address_check();
    xilinx_no_strb_address_check_enable = 2'b10;
  endfunction

 /*
  * Function: set_xilinx_no_strb_address_check_to_warn
  * Sets xilinx_no_strb_address_check_enable to downgrade/upgrade to warning message when address is being detected 
  * not aligned with data width while this VIP is in no strobe mode. 
  */
  function void set_xilinx_no_strb_address_check_to_warn();
    xilinx_no_strb_address_check_enable = 2'b01;
  endfunction

  /*
  * Function: clr_xilinx_no_strb_address_check
  * Sets xilinx_no_strb_address_check_enable to downgrade error/warning into info message when address is being detected 
  * not aligned with data width while this VIP is in no strobe mode. 
  */
  function void clr_xilinx_no_strb_address_check();
    xilinx_no_strb_address_check_enable = 2'b00;
  endfunction


  /*
  *  Function: set_xilinx_supports_narrow_cache_check
  *  Sets xilinx_supports_narrow_cache_check_enable to turn on warning message when Cache[1] is not 1 while VIP is in
  *  no supports_narrow, has_cache mode.
  */
  function void set_xilinx_supports_narrow_cache_check();
    xilinx_supports_narrow_cache_check_enable = 2'b01;
  endfunction

  /*
  * Function: clr_xilinx_supports_narrow_cache_check
  * Sets xilinx_supports_narrow_cache_check_enable to downgrade warning into info message when Cache[1] is not 1
  * while VIP is in no supports_narrow, has_cache mode.
  */
  function void clr_xilinx_supports_narrow_cache_check();
    xilinx_supports_narrow_cache_check_enable = 2'b00;
  endfunction

  /*
  * Function: set_enable_xchecks
  * Sets enable_xchecks to turn on error message when reset signal is unknown after 1 cycle of clock.
  */
  function void set_enable_xchecks();
    enable_xchecks = 2'b10;
  endfunction
  
  /*
  * Function: set_enable_xchecks_to_warn
  * Sets enable_xchecks to downgrade/upgrade into warning message when reset signal is unknown after 1 cycle of clock.
  */
  function void set_enable_xchecks_to_warn();
    enable_xchecks = 2'b01;
  endfunction

  /*
  * Function: clr_enable_xchecks
  * Sets enable_xchecks to downgrade error/warning message into info message when reset signal is unknown after 1 cycle of clock.
  */
  function void clr_enable_xchecks();
    enable_xchecks = 2'b00;
  endfunction

  /*
  * Function: set_write_response_error_check
  * Sets xilinx_write_response_check_enable to turn on error message when write response is not OKAY.
  */
  function void set_write_response_error_check();
    xilinx_write_response_check_enable = 2'b10;
  endfunction
  
  /*
  * Function: set_write_response_error_check_to_warn
  * Sets xilinx_write_response_check_enable to downgrade/upgrade into warning message when write response is not OKAY.
  */
  function void set_write_response_error_check_to_warn();
    xilinx_write_response_check_enable = 2'b01;
  endfunction

  /*
  * Function: clr_write_response_error_check
  * Sets xilinx_write_response_check_enable to downgrade error/warning message into info message when write response is not OKAY.
  */
  function void clr_write_response_error_check();
     xilinx_write_response_check_enable = 2'b00;
  endfunction

  /*
  * Function: set_read_response_error_check
  * Sets xilinx_read_response_check_enable  to turn on error message when read response is not OKAY .
  */
  function void set_read_response_error_check();
    xilinx_read_response_check_enable = 2'b10;
  endfunction
  
  /*
  * Function: set_read_response_error_check_to_warn
  * Sets xilinx_read_response_check_enable to downgrade/upgrade into warning message when read response is not OKAY.
  */
  function void set_read_response_error_check_to_warn();
    xilinx_read_response_check_enable = 2'b01;
  endfunction

  /*
  * Function: clr_read_response_error_check
  * Sets xilinx_read_response_check_enable to downgrade error/warning message into info message when read response is not OKAY.
  */
  function void clr_read_response_error_check();
     xilinx_read_response_check_enable = 2'b00;
  endfunction


  // Internal ports 
  bit                                                                      areset_n;
  bit                                                                      aclk;

  // write address channel
  logic  [(C_AXI_ADDR_WIDTH-1):0]                                          awaddr;
  logic  [((C_AXI_WID_WIDTH==0) ? 1:C_AXI_WID_WIDTH)-1:0]                  awid;
  logic  [7:0]                                                             awlen;
  logic  [2:0]                                                             awsize;
  logic  [1:0]                                                             awburst;
  logic  [1:0]                                                             awlock;
  logic  [3:0]                                                             awcache;
  logic  [2:0]                                                             awprot;
  logic                                                                    awvalid = 1'b0;
  logic                                                                    awready = 1'b0;
  logic  [3:0]                                                             awregion;
  logic  [3:0]                                                             awqos;
  logic  [((C_AXI_AWUSER_WIDTH == 0) ? 0 : C_AXI_AWUSER_WIDTH -1):0]       awuser;

  // write data channel
  logic  [((C_AXI_WID_WIDTH==0) ? 1:C_AXI_WID_WIDTH)-1:0]                  wid;
  logic                                                                    wlast;
  logic  [(C_AXI_WDATA_WIDTH-1):0]                                         wdata;
  logic  [(C_AXI_WDATA_WIDTH/8)-1:0]                                       wstrb;
  logic                                                                    wvalid = 1'b0;
  logic                                                                    wready = 1'b0;
  logic  [((C_AXI_WUSER_WIDTH == 0) ? 0 : C_AXI_WUSER_WIDTH -1):0]         wuser;

  // write response channel
  logic  [1:0]                                                             bresp;
  logic  [((C_AXI_WID_WIDTH==0) ? 1:C_AXI_WID_WIDTH)-1:0]                  bid;
  logic                                                                    bvalid = 1'b0;
  logic                                                                    bready = 1'b0;
  logic  [((C_AXI_BUSER_WIDTH == 0) ? 0 : C_AXI_BUSER_WIDTH -1):0]         buser;

  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  // read address channel
  logic  [(C_AXI_ADDR_WIDTH-1):0]                                          araddr;
  logic  [((C_AXI_RID_WIDTH==0) ? 1:C_AXI_RID_WIDTH)-1:0]                  arid;
  logic  [7:0]                                                             arlen;
  logic  [2:0]                                                             arsize;
  logic  [1:0]                                                             arburst;
  logic  [1:0]                                                             arlock;
  logic  [3:0]                                                             arcache;
  logic  [2:0]                                                             arprot;
  logic                                                                    arvalid = 1'b0;
  logic                                                                    arready = 1'b0;
  logic  [3:0]                                                             arregion;
  logic  [3:0]                                                             arqos;
  logic  [((C_AXI_ARUSER_WIDTH == 0) ? 0 : C_AXI_ARUSER_WIDTH -1):0]       aruser;

  // read data  channel
  logic  [((C_AXI_WID_WIDTH==0) ? 1:C_AXI_WID_WIDTH)-1:0]                  rid;
  logic                                                                    rlast;
  logic  [(C_AXI_RDATA_WIDTH-1):0]                                         rdata;
  logic  [1:0]                                                             rresp;
  logic                                                                    rvalid = 1'b0;
  logic                                                                    rready = 1'b0;
  logic  [((C_AXI_RUSER_WIDTH == 0) ? 0 : C_AXI_RUSER_WIDTH -1):0]         ruser;

  /*
  *  Function: set_intf_slave
  *  Sets interface to slave mode
  */
  function void set_intf_slave();
    intf_is_master = 0;
    intf_is_slave = 1;
  endfunction : set_intf_slave

  /*
  *  Function: set_intf_master
  *  Sets interface to master mode
  */
  function void set_intf_master();
    intf_is_master = 1;
    intf_is_slave = 0;
  endfunction : set_intf_master

  /*
  *  Function: set_intf_monitor
  *  Sets interface to monitor mode
  */
  function void set_intf_monitor();
    intf_is_master = 0;
    intf_is_slave = 0;
  endfunction : set_intf_monitor

  assign areset_n = ARESET_N;
  assign aclk     = ACLK;
  assign AWADDR   = intf_is_master ? awaddr   : 'z;
  assign AWID     =  ((C_AXI_PROTOCOL == 2) || (C_AXI_WID_WIDTH == 0)) ? 1'b0 : intf_is_master ? awid     : 'z;
  assign AWLEN    = intf_is_master ? awlen    : 'z;
  assign AWSIZE   = intf_is_master ? awsize   : 'z;
  assign AWBURST  = intf_is_master ? awburst  : 'z;
  assign AWLOCK   = intf_is_master ? awlock   : 'z;
  assign AWCACHE  = intf_is_master ? awcache  : 'z;
  assign AWPROT   = intf_is_master ? awprot   : 'z;
  assign AWVALID  = intf_is_master ? awvalid  : 'z;
  assign AWREADY  = intf_is_slave  ? awready  : 'z;
  assign AWREGION = intf_is_master ? awregion : 'z;
  assign AWQOS    = intf_is_master ? awqos    : 'z;
  assign AWUSER   = (C_AXI_AWUSER_WIDTH == 0) ? 1'b0 : intf_is_master ? awuser   : 'z;
  assign WID      =  ((C_AXI_PROTOCOL == 2) || (C_AXI_WID_WIDTH == 0)) ? 1'b0 : intf_is_master ? wid      : 'z;
  assign WLAST    = intf_is_master ? wlast    : 'z;
  assign WDATA    = intf_is_master ? wdata    : 'z;
  assign WSTRB    = intf_is_master ? wstrb    : 'z;
  assign WVALID   = intf_is_master ? wvalid   : 'z;
  assign WREADY   = intf_is_slave  ? wready   : 'z;
  assign WUSER    = (C_AXI_WUSER_WIDTH == 0) ? 1'b0 :intf_is_master ? wuser   : 'z;
  assign BRESP    = intf_is_slave  ? bresp    : 'z;
  assign BID      = ((C_AXI_PROTOCOL == 2) || (C_AXI_WID_WIDTH == 0)) ? 1'b0 : intf_is_slave  ? bid      : 'z;
  assign BVALID   = intf_is_slave  ? bvalid   : 'z;
  assign BREADY   = intf_is_master ? bready   : 'z;
  assign BUSER    = (C_AXI_BUSER_WIDTH == 0)  ? 1'b0 : intf_is_slave  ? buser   : 'z;
  assign ARADDR   = intf_is_master ? araddr   : 'z;
  assign ARID     = ((C_AXI_PROTOCOL == 2) || (C_AXI_RID_WIDTH == 0)) ? 1'b0 : intf_is_master ? arid     : 'z;
  assign ARLEN    = intf_is_master ? arlen    : 'z;
  assign ARSIZE   = intf_is_master ? arsize   : 'z;
  assign ARBURST  = intf_is_master ? arburst  : 'z;
  assign ARLOCK   = intf_is_master ? arlock   : 'z;
  assign ARCACHE  = intf_is_master ? arcache  : 'z;
  assign ARPROT   = intf_is_master ? arprot   : 'z;
  assign ARVALID  = intf_is_master ? arvalid  : 'z;
  assign ARREADY  = intf_is_slave  ? arready  : 'z;
  assign ARREGION = intf_is_master ? arregion : 'z;
  assign ARQOS    = intf_is_master ? arqos    : 'z;
  assign ARUSER   = (C_AXI_ARUSER_WIDTH == 0) ? 1'b0 : intf_is_master ? aruser   : 'z;
  assign RID      = ((C_AXI_PROTOCOL == 2) || (C_AXI_RID_WIDTH == 0)) ? 1'b0 : intf_is_slave  ? rid      : 'z;
  assign RLAST    = intf_is_slave  ? rlast    : 'z;
  assign RDATA    = intf_is_slave  ? rdata    : 'z;
  assign RRESP    = intf_is_slave  ? rresp    : 'z;
  assign RVALID   = intf_is_slave  ? rvalid   : 'z;
  assign RREADY   = intf_is_master ? rready   : 'z;
  assign RUSER    = (C_AXI_RUSER_WIDTH == 0) ? 1'b0 :intf_is_slave  ? ruser   : 'z;

  wire   awready_internal = (supports_write == 0) ? 1'b0 : AWREADY;
  wire   arready_internal = (supports_read == 0)  ? 1'b0 : ARREADY;
  wire   wready_internal  = (supports_write == 0) ? 1'b0 : WREADY;
  wire   rready_internal  = (supports_read == 0)  ? 1'b0 : RREADY;
  wire   bready_internal  = (supports_write == 0) ? 1'b0 : BREADY;
  wire   awvalid_internal = (supports_write == 0) ? 1'b0 : AWVALID;
  wire   arvalid_internal = (supports_read == 0)  ? 1'b0 : ARVALID;
  wire   wvalid_internal  = (supports_write == 0) ? 1'b0 : WVALID;
  wire   rvalid_internal  = (supports_read == 0)  ? 1'b0 : RVALID;
  wire   bvalid_internal  = (supports_write == 0) ? 1'b0 : BVALID;

  wire  [((C_AXI_RID_WIDTH==0) ? 1:C_AXI_RID_WIDTH)-1:0]      arid_internal;
  wire  [((C_AXI_WID_WIDTH==0) ? 1:C_AXI_WID_WIDTH)-1:0]      wid_internal;
  wire  [((C_AXI_RID_WIDTH==0) ? 1:C_AXI_RID_WIDTH)-1:0]      rid_internal;
  wire  [((C_AXI_WID_WIDTH==0) ? 1:C_AXI_WID_WIDTH)-1:0]      awid_internal;
  wire  [((C_AXI_WID_WIDTH==0) ? 1:C_AXI_WID_WIDTH)-1:0]      bid_internal;

  assign arid_internal  = (C_AXI_RID_WIDTH==0) ? 1'b0 : ARID;
  assign wid_internal   = (C_AXI_WID_WIDTH==0) ? 1'b0 : WID;
  assign rid_internal   = (C_AXI_RID_WIDTH==0) ? 1'b0 : RID;
  assign awid_internal  = (C_AXI_WID_WIDTH==0) ? 1'b0 : AWID;
  assign bid_internal   = (C_AXI_WID_WIDTH==0) ? 1'b0 : BID;

  localparam  LP_ADDR_WIDTH = (C_AXI_ADDR_WIDTH > 12) ? C_AXI_ADDR_WIDTH : 13;
  wire [LP_ADDR_WIDTH-1:0] scaled_awaddr = {LP_ADDR_WIDTH{1'b0}} | AWADDR[C_AXI_ADDR_WIDTH-1:0];
  wire [LP_ADDR_WIDTH-1:0] scaled_araddr = {LP_ADDR_WIDTH{1'b0}} | ARADDR[C_AXI_ADDR_WIDTH-1:0];
  wire aclk_internal = (ACLKEN == 1'b0) ? 1'b0 : aclk;

  wire        wlast_internal  = (C_AXI_PROTOCOL == 2) ? 1'b1 : WLAST;
  wire        rlast_internal  = (C_AXI_PROTOCOL == 2) ? 1'b1 : RLAST;

  wire [7:0]  awlen_internal  = (C_AXI_PROTOCOL == 0) ? AWLEN :
                                (C_AXI_PROTOCOL == 1) ? {4'h0,AWLEN[3:0]} :
                                8'h00;
  wire [7:0]  arlen_internal  = (C_AXI_PROTOCOL == 0) ? ARLEN :
                                (C_AXI_PROTOCOL == 1) ? {4'h0,ARLEN[3:0]} :
                                8'h00;
  wire [3:0]  arregion_internal = (C_AXI_PROTOCOL == 0) ? ARREGION :
                                  (C_AXI_PROTOCOL == 1) ? 4'h0 :
                                  4'h0;
  wire [3:0]  awregion_internal = (C_AXI_PROTOCOL == 0) ? AWREGION :
                                  (C_AXI_PROTOCOL == 1) ? 4'h0 :
                                  4'h0;
  wire [3:0]  arqos_internal =  (C_AXI_PROTOCOL == 0) ? ARQOS :
                                (C_AXI_PROTOCOL == 1) ? 4'h0 :
                                4'h0;
  wire [3:0]  awqos_internal =  (C_AXI_PROTOCOL == 0) ? AWQOS :
                                (C_AXI_PROTOCOL == 1) ? 4'h0 :
                                4'h0;
  wire [1:0]  awlock_internal = (C_AXI_PROTOCOL == 0) ? {1'b0,AWLOCK[0]} :
                                (C_AXI_PROTOCOL == 1) ? AWLOCK :
                                2'h0;
  wire [1:0]  arlock_internal = (C_AXI_PROTOCOL == 0) ? {1'b0,ARLOCK[0]} :
                                (C_AXI_PROTOCOL == 1) ? ARLOCK :
                                2'h0;
  wire [1:0]  awburst_internal =  (C_AXI_PROTOCOL == 0) ? AWBURST :
                                  (C_AXI_PROTOCOL == 1) ? AWBURST :
                                  2'h0;
  wire [1:0]  arburst_internal =  (C_AXI_PROTOCOL == 0) ? ARBURST :
                                  (C_AXI_PROTOCOL == 1) ? ARBURST :
                                  2'h0;
  wire [3:0]  awcache_internal =  (C_AXI_PROTOCOL == 0) ? AWCACHE :
                                  (C_AXI_PROTOCOL == 1) ? AWCACHE :
                                  4'h0;
  wire [3:0]  arcache_internal =  (C_AXI_PROTOCOL == 0) ? ARCACHE :
                                  (C_AXI_PROTOCOL == 1) ? ARCACHE :
                                  4'h0;
  wire [2:0]  awsize_internal = (C_AXI_PROTOCOL == 0) ? AWSIZE :
                                (C_AXI_PROTOCOL == 1) ? AWSIZE :
                                (C_AXI_WDATA_WIDTH == 32 ? 3'b010 : 3'b011);
  wire [2:0]  arsize_internal = (C_AXI_PROTOCOL == 0) ? ARSIZE :
                                (C_AXI_PROTOCOL == 1) ? ARSIZE :
                                (C_AXI_RDATA_WIDTH == 32 ? 3'b010 : 3'b011);

  axi_vip_axi4pc #(
    .PROTOCOL         (C_AXI_PROTOCOL),
    .WADDR_WIDTH      (LP_ADDR_WIDTH), 
    .RADDR_WIDTH      (LP_ADDR_WIDTH),
    .RDATA_WIDTH      (C_AXI_RDATA_WIDTH),
    .WDATA_WIDTH      (C_AXI_WDATA_WIDTH),
    .RID_WIDTH        (C_AXI_WID_WIDTH),
    .WID_WIDTH        (C_AXI_RID_WIDTH),
    .AWUSER_WIDTH     (C_AXI_AWUSER_WIDTH ),
    .WUSER_WIDTH      (C_AXI_WUSER_WIDTH  ),
    .BUSER_WIDTH      (C_AXI_BUSER_WIDTH  ),
    .ARUSER_WIDTH     (C_AXI_ARUSER_WIDTH ),
    .RUSER_WIDTH      (C_AXI_RUSER_WIDTH  ),
    .MAXRBURSTS       ( C_MAXRBURSTS ),
    .MAXWBURSTS       ( C_MAXWBURSTS ),
    .MAXWAITS         ( C_MAXWAITS ),
    .MAXSTALLWAITS    ( C_MAXSTALLWAITS ),
    .RecommendOn      ( 1  ),
    .RecMaxWaitOn     ( 0  ),
    .HAS_ARESETN      ( C_AXI_HAS_ARESETN)
  ) PC (
    .ACLK               (aclk_internal), 
    .ACLKEN             (ACLKEN),
    .ARESETn            (areset_n),
    .AWADDR             (scaled_awaddr),
    .AWID               (awid_internal   ),
    .AWLEN              (awlen_internal  ),
    .AWSIZE             (awsize_internal ),
    .AWBURST            (awburst_internal),
    .AWLOCK             (awlock_internal[0]),
    .AWCACHE            (awcache_internal),
    .AWPROT             (AWPROT ),
    .AWVALID            (awvalid_internal),
    .AWREADY            (awready_internal),
    .AWREGION           (awregion_internal),
    .AWQOS              (awqos_internal),
    .AWUSER             (AWUSER ),

    .WLAST              (wlast_internal ),
    .WDATA              (WDATA ),
    .WSTRB              (WSTRB ),
    .WVALID             (wvalid_internal),
    .WREADY             (wready_internal),
    .WUSER              (WUSER ),

    .BRESP              (BRESP ),
    .BID                (bid_internal   ),
    .BVALID             (bvalid_internal),
    .BREADY             (bready_internal),
    .BUSER              (BUSER ),

    .ARADDR             (scaled_araddr ),
    .ARID               (arid_internal   ),
    .ARLEN              (arlen_internal  ),
    .ARSIZE             (arsize_internal ),
    .ARBURST            (arburst_internal),
    .ARLOCK             (arlock_internal[0]),
    .ARCACHE            (arcache_internal),
    .ARPROT             (ARPROT ),
    .ARVALID            (arvalid_internal),
    .ARREADY            (arready_internal),
    .ARREGION           (arregion_internal),
    .ARQOS              (arqos_internal),
    .ARUSER             (ARUSER ),

    .RID                (rid_internal   ),
    .RLAST              (rlast_internal ),
    .RDATA              (RDATA ),
    .RRESP              (RRESP ),
    .RVALID             (rvalid_internal),
    .RREADY             (rready_internal),
    .RUSER              (RUSER ),
    
    .CACTIVE            ( 1'b1 ),
    .CSYSREQ            ( 1'b1 ),
    .CSYSACK            ( 1'b1 )
  ); 

  integer     bbeat   [int unsigned];
  integer     awbeat  [int unsigned];
  integer     rbeat   [int unsigned];
  integer     arbeat  [int unsigned];
  integer     wbeat = 0;

  longint unsigned  clock_counter = 0;
  longint unsigned  aw_start[int unsigned][$];
  longint unsigned  ar_start[int unsigned][$];

  longint unsigned  aw_max_latency = 0;
  longint unsigned  ar_max_latency = 0;
  longint unsigned  aw_running_avg_latency = 0;
  longint unsigned  ar_running_avg_latency = 0;
  longint unsigned  temp_aw_start;
  longint unsigned  temp_ar_start;

  /*
  * Function: calc_max_latency
  * Determine if the current max latency is greater than the recently completed transaction.
  */
  function longint unsigned calc_max_latency(input longint unsigned start_time, current_time, current_max);
    longint unsigned delta_time;
    delta_time = current_time - start_time;
    if (delta_time > current_max) begin
      return(delta_time);
    end else begin
      return(current_max);
    end
  endfunction : calc_max_latency

  /*
  * Function: calc_running_avg
  * Calculate the running average of the two values.
  */
  function longint unsigned calc_running_avg(input longint unsigned start_time, current_time, current_avg);
    longint unsigned delta_time;
    delta_time = current_time - start_time;
    if (current_avg == 0) begin
      return(delta_time);
    end else begin
      return(((current_time - start_time) + current_avg)/2);
    end
  endfunction : calc_running_avg

  /*
  * Function: get_aw_max_latency
  * Return the current WRITE maximum latency value. Measured between the AW handshake to the B handshake.
  */
  function longint unsigned get_aw_max_latency();
    return(aw_max_latency);
  endfunction : get_aw_max_latency

  /*
  * Function: get_ar_max_latency
  * Return the current READ maximum latency value. Measured between the AR handshake to the R handshake (with RLAST).
  */
  function longint unsigned get_ar_max_latency();
    return(ar_max_latency);
  endfunction : get_ar_max_latency

  /*
  * Function: get_aw_running_avg_latency
  * Return the current WRITE running average latency value. Measured between the AW handshake to the B handshake.
  */
  function longint unsigned get_aw_running_avg_latency();
    return(aw_running_avg_latency);
  endfunction : get_aw_running_avg_latency

  /*
  * Function: get_ar_running_avg_latency
  * Return the current READ running average latency value. Measured between the AR handshake to the R handshake (with RLAST).
  */
  function longint unsigned get_ar_running_avg_latency();
    return(ar_running_avg_latency);
  endfunction : get_ar_running_avg_latency

  default clocking cb @(posedge aclk_internal);
    default input #1step output #C_HOLD_TIME;
    input   areset_n;
    input   ACLKEN;
    inout   AWADDR;
    inout   AWID;
    inout   AWLEN;
    inout   AWSIZE;
    inout   AWBURST;
    inout   AWLOCK;
    inout   AWCACHE;
    inout   AWPROT;
    inout   AWVALID;
    inout   AWREADY;
    inout   AWREGION;
    inout   AWQOS;
    inout   AWUSER;
    inout   WID;
    inout   WLAST;
    inout   WDATA;
    inout   WSTRB;
    inout   WVALID;
    inout   WREADY;
    inout   WUSER;
    inout   BRESP;
    inout   BID;
    inout   BVALID;
    inout   BREADY;
    inout   BUSER;
    inout   ARADDR;
    inout   ARID;
    inout   ARLEN;
    inout   ARSIZE;
    inout   ARBURST;
    inout   ARLOCK;
    inout   ARCACHE;
    inout   ARPROT;
    inout   ARVALID;
    inout   ARREADY;
    inout   ARREGION;
    inout   ARQOS;
    inout   ARUSER;
    inout   RID;
    inout   RLAST;
    inout   RDATA;
    inout   RRESP;
    inout   RVALID;
    inout   RREADY;
    inout   RUSER;
    inout   arid_internal;
    inout   wid_internal ;
    inout   rid_internal ;
    inout   awid_internal;
    inout   bid_internal ;
  endclocking : cb

  always @(cb) begin
    clock_counter++;
    if (cb.areset_n == 0) begin
      ar_start.delete();
      aw_start.delete();
      bbeat.delete();
      awbeat.delete();
      wbeat = 0;
      awcmd_id = 0;
      wcmd_id = 0;
      bcmd_id = 0;
      rbeat.delete();
      arbeat.delete();
      arcmd_id = 0;
      rcmd_id = 0;
      aw_max_latency = 0;
      ar_max_latency = 0;
      aw_running_avg_latency = 0;
      ar_running_avg_latency = 0;
    end else if (cb.ACLKEN == 1) begin
      if (cb.AWVALID && cb.AWREADY) begin
        awcmd_id++;
        if (!awbeat.exists(cb.awid_internal)) begin
          awbeat[cb.awid_internal] = 0;
        end
        awbeat[cb.awid_internal]++;
        aw_start[awid_internal].push_back(clock_counter);
      end
      if (cb.BVALID && cb.BREADY) begin
        bcmd_id++;
        if (!bbeat.exists(cb.bid_internal)) begin
          bbeat[cb.bid_internal] = 0;
        end
        bbeat[cb.bid_internal]++;
        if (aw_start.exists(bid_internal)) begin
          temp_aw_start = aw_start[bid_internal].pop_front();
          aw_max_latency = calc_max_latency(temp_aw_start, clock_counter, aw_max_latency);
          aw_running_avg_latency = calc_running_avg(temp_aw_start, clock_counter, aw_running_avg_latency);
        end
      end
      if (cb.WVALID && cb.WREADY) begin
        if ((C_AXI_PROTOCOL == 2) || (cb.WLAST)) begin
          wcmd_id++;
          wbeat = 0;
        end else begin
          wbeat++;
        end
      end
      if (cb.ARVALID && cb.ARREADY) begin
        arcmd_id++;
        if (!arbeat.exists(cb.arid_internal)) begin
          arbeat[cb.arid_internal] = 0;
        end
        arbeat[cb.arid_internal]++;
        ar_start[arid_internal].push_back(clock_counter);
      end
      if (cb.RVALID && cb.RREADY) begin
        if ((C_AXI_PROTOCOL == 2) || (cb.RLAST)) begin
          rcmd_id++;
          rbeat[cb.rid_internal] = 0;
          if (ar_start.exists(rid_internal)) begin
            temp_ar_start = ar_start[rid_internal].pop_front();
            ar_max_latency = calc_max_latency(temp_ar_start, clock_counter, ar_max_latency);
            ar_running_avg_latency = calc_running_avg(temp_ar_start, clock_counter, ar_running_avg_latency);
          end
        end else begin
          if (!rbeat.exists(cb.rid_internal)) begin
            rbeat[cb.rid_internal] = 0;
          end
          rbeat[cb.rid_internal]++;
        end
      end
    end
  end


  function automatic xil_axi_uint xil_clog2(input xil_axi_uint value);
    if (value !== 0) begin
      value = value - 1;
      for (xil_clog2 = 0; value > 0; xil_clog2 = xil_clog2 + 1) begin
        value = value >> 1;
      end
    end else begin
      xil_clog2 = 0;
    end
  endfunction // xil_clog2

  assign real_reset = !ARESET_N;
  assign reset_for_assert = fake_reset & real_reset;
  initial begin
    fake_reset =0;
    @(posedge ACLK);
    fake_reset =1;
  end

  always @(posedge ACLK) begin
    resetn_q[0] <= ARESET_N;
    resetn_q[1] <= resetn_q[0];
    resetn_q[2] <= resetn_q[1];
    resetn_q[3] <= resetn_q[2];
    resetn_q[4] <= resetn_q[3];
    resetn_q[5] <= resetn_q[4];
    resetn_q[6] <= resetn_q[5];
    resetn_q[7] <= resetn_q[6];
  end

  assign resetn_delay_one_cycle = resetn_q[0];
  assign resetn_delay_eight_cycle = resetn_q[7];

   
   always @(posedge ACLK) begin
     if ($isunknown(ARESET_N) &&(report_areset_xcheck_err_cnt ==0)) begin
       `REPORT_HIGH_LEVEL_MACRO(`AXI_ARESET_XCHECK,`AXI_ARESET_XCHECK_SOL,enable_xchecks)
       report_areset_xcheck_err_cnt +=1;
     end  
   end
  
  initial begin
    forever begin 
      @(posedge ACLK) begin
        if(reset_for_assert) begin
          reset_cnt =0;
          while(reset_for_assert) begin
            @(posedge ACLK);
            reset_cnt = reset_cnt +1;
          end
          if((reset_cnt <16) &&(report_reset_pulse_err_cnt ==0)) begin
            `REPORT_HIGH_LEVEL_MACRO(`XILINX_RESET_PULSE,`XILINX_RESET_PULSE_SOL,xilinx_reset_check_enable)
            report_reset_pulse_err_cnt +=1;
          end
        end  
      end
    end  
  end
  
  //
  always @(posedge ACLK) begin
    if(ARESET_N) begin
      if(C_AXI_SUPPORTS_NARROW ==0) begin
        if ((awlen_internal > 0) && (awvalid_internal ==1)) begin
          if (!((8*(1<<awsize_internal)) == C_AXI_WDATA_WIDTH) && (report_awburst_err_cnt==0)) begin
            `REPORT_HIGH_LEVEL_MACRO(`XILINX_AW_SUPPORTS_NARROW_BURST,`XILINX_AX_SUPPORTS_NARROW_BURST_SOL,xilinx_supports_narrow_burst_check_enable)
            report_awburst_err_cnt +=1;
          end
          if ((awcache_internal[1] !=1) && (C_AXI_HAS_CACHE==1)&& (report_awcache_err_cnt==0))  begin
            `REPORT_HIGH_LEVEL_MACRO(`XILINX_AW_SUPPORTS_NARROW_CACHE,`XILINX_AX_SUPPORTS_NARROW_CACHE_SOL,xilinx_supports_narrow_cache_check_enable)
            report_awcache_err_cnt +=1;
          end 
        end
        if ((arlen_internal > 0) && (arvalid_internal ==1)) begin
          if (!((8*(1<<arsize_internal)) == C_AXI_RDATA_WIDTH) && (report_arburst_err_cnt==0)) begin
            `REPORT_HIGH_LEVEL_MACRO(`XILINX_AR_SUPPORTS_NARROW_BURST,`XILINX_AX_SUPPORTS_NARROW_BURST_SOL,xilinx_supports_narrow_burst_check_enable)
            report_arburst_err_cnt +=1;
          end
          if ((arcache_internal[1] !=1) && (C_AXI_HAS_CACHE==1)&& (report_arcache_err_cnt==0) )  begin
            `REPORT_HIGH_LEVEL_MACRO(`XILINX_AR_SUPPORTS_NARROW_CACHE,`XILINX_AX_SUPPORTS_NARROW_CACHE_SOL,xilinx_supports_narrow_cache_check_enable)
            report_arcache_err_cnt +=1;
          end 
        end
      end  
      if(C_AXI_HAS_WSTRB ==0) begin
        if (awvalid_internal ==1) begin
          if (!(AWADDR%(C_AXI_WDATA_WIDTH/8) ==0) && (report_strb_err_cnt==0)) begin
            `REPORT_HIGH_LEVEL_MACRO(`XILINX_NO_STRB_ADDRESS,`XILINX_NO_STRB_ADDRESS_SOL,xilinx_no_strb_address_check_enable)
            report_strb_err_cnt +=1;
          end 
        end  
      end 
    end  
  end

    `RESET_ONE_PULSE(ACLK,resetn_delay_one_cycle,ARESET_N,supports_write&(C_AXI_HAS_ARESETN==1),ACLKEN,AWREADY,`XILINX_AWREADY_RESET,`XILINX_XREADY_RESET_SOL,xilinx_slave_ready_check_enable,report_awready_one_pulse_err_cnt)
    `RESET_ONE_PULSE(ACLK,resetn_delay_one_cycle,ARESET_N,supports_write&(C_AXI_HAS_ARESETN==1),ACLKEN,WREADY,`XILINX_WREADY_RESET,`XILINX_XREADY_RESET_SOL,xilinx_slave_ready_check_enable,report_wready_one_pulse_err_cnt)
    `RESET_ONE_PULSE(ACLK,resetn_delay_one_cycle,ARESET_N,supports_read&(C_AXI_HAS_ARESETN==1),ACLKEN,ARREADY,`XILINX_ARREADY_RESET,`XILINX_XREADY_RESET_SOL,xilinx_slave_ready_check_enable,report_arready_one_pulse_err_cnt)
    `RESET_EIGHT_PULSE(ACLK,resetn_delay_eight_cycle,ARESET_N,supports_write&(C_AXI_HAS_ARESETN==1),ACLKEN,WREADY,`XILINX_WREADY_MAX_RESET,`XILINX_XREADY_RESET_SOL,xilinx_slave_ready_check_enable,report_wready_eight_pulse_err_cnt)
    `RESET_EIGHT_PULSE(ACLK,resetn_delay_eight_cycle,ARESET_N,supports_write&(C_AXI_HAS_ARESETN==1),ACLKEN,AWREADY,`XILINX_AWREADY_MAX_RESET,`XILINX_XREADY_RESET_SOL,xilinx_slave_ready_check_enable,report_awready_eight_pulse_err_cnt)
    `RESET_EIGHT_PULSE(ACLK,resetn_delay_eight_cycle,ARESET_N,supports_read&(C_AXI_HAS_ARESETN==1),ACLKEN,ARREADY,`XILINX_ARREADY_MAX_RESET,`XILINX_XREADY_RESET_SOL,xilinx_slave_ready_check_enable,report_arready_eight_pulse_err_cnt)

   always @(posedge ACLK) begin
     if ((BRESP ==2'b10) &&(report_bresp_slv_err_cnt ==0)) begin
       `REPORT_HIGH_LEVEL_MACRO(`XILINX_WRITE_RESPONSE_SLVERR_CHECK,`XILINX_WRITE_RESPONSE_ERROR_SOL,xilinx_write_response_check_enable)
       report_bresp_slv_err_cnt +=1;
     end  
     if ((BRESP ==2'b11) &&(report_bresp_dec_err_cnt ==0) ) begin
       `REPORT_HIGH_LEVEL_MACRO(`XILINX_WRITE_RESPONSE_DECERR_CHECK,`XILINX_WRITE_RESPONSE_ERROR_SOL,xilinx_write_response_check_enable)
       report_bresp_dec_err_cnt +=1;
     end  
   end 

   always @(posedge ACLK) begin
     if ((RRESP ==2'b10) && (report_rresp_slv_err_cnt ==0)) begin
       `REPORT_HIGH_LEVEL_MACRO(`XILINX_READ_RESPONSE_SLVERR_CHECK,`XILINX_READ_RESPONSE_ERROR_SOL,xilinx_read_response_check_enable)
       report_rresp_slv_err_cnt +=1;
     end  
     if ((RRESP ==2'b11) && (report_rresp_dec_err_cnt ==0)) begin
       `REPORT_HIGH_LEVEL_MACRO(`XILINX_READ_RESPONSE_DECERR_CHECK,`XILINX_READ_RESPONSE_ERROR_SOL,xilinx_read_response_check_enable)
       report_rresp_dec_err_cnt +=1;
     end  

   end 


endinterface : axi_vip_if

`endif


 
