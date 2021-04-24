#! /bin/bash

# prepare simulation args
cat <<EOT > reinvoke.tcl
proc rr {} {
    exec xelab ${XELAB_ARGS}
    save_wave_config work
    close_sim
    source xsim.dir/work.tb/xsim_script.tcl
}
EOT
cat <<EOT > work.wcfg
<?xml version="1.0" encoding="UTF-8"?>
<wave_config>
   <wave_state>
   </wave_state>
</wave_config>
EOT
XSIM_ARGS="work.tb --gui --t reinvoke.tcl  --view work.wcfg"

# do simulation
xsim  ${XSIM_ARGS}
