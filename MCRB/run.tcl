set VERILOG netlist/mcrb.v
set TOP_MODULE mcrb
set LIB_PATH nangate/NangateOpenCellLibrary_slow_conditional_ccs.lib
set LEF_PATH nangate/NangateOpenCellLibrary.lef

read_lib ${LIB_PATH}
read_physical -lef ${LEF_PATH}
read_hdl ${VERILOG}
elaborate ${TOP_MODULE}
read_sdc netlist/constraints.sdc

set_db syn_generic_effort medium
set_db syn_map_effort medium
set_db syn_opt_effort medium

set_db / .syn_generic_effort medium
syn_gen
set_db / .syn_map_effort medium
syn_map
set_db / .syn_opt_effort medium
syn_opt

report_area > REPORTS/${TOP_MODULE}_area.rep
report_power > REPORTS/${TOP_MODULE}_power.rep
report_gates > REPORTS/${TOP_MODULE}_gates.rep
report_timing > REPORTS/${TOP_MODULE}_timing.rep
report_qor -levels_of_logic -power -exclude_constant_nets > REPORTS/${TOP_MODULE}_qor_all.rep

report area
report power
report gates
report timing -unconstrained
gui_show

write_hdl > OUTPUT/${TOP_MODULE}_syn.v
write_sdc > OUTPUT/${TOP_MODULE}_syn.sdc
