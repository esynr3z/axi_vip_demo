#! /bin/bash

# prepare elaboration args
cat <<EOT > files.prj
verilog work ../src/axi_ram/axi_ram.v
sv work ../src/xilinx_vip/xil_common_vip_pkg.sv
sv work ../src/xilinx_vip/axi_vip_pkg.sv
sv work ../src/xilinx_vip/axi_vip_axi4pc.sv
sv work ../src/xilinx_vip/axi_vip_if.sv
sv work ../src/axi_vip_master/axi_vip_master_pkg.sv
sv work ../src/axi_vip_master/axi_vip_v1_1_vl_rfs.sv
sv work ../src/axi_vip_master/axi_vip_master.sv
sv work ../src/tb/tb.sv
EOT
XELAB_ARGS="--debug typical --incr --relax --prj files.prj work.tb -i ../src/xilinx_vip"

# do elaboration
xelab ${XELAB_ARGS}