# 
# Synthesis run script generated by Vivado
# 

set TIME_start [clock seconds] 
proc create_report { reportName command } {
  set status "."
  append status $reportName ".fail"
  if { [file exists $status] } {
    eval file delete [glob $status]
  }
  send_msg_id runtcl-4 info "Executing : $command"
  set retval [eval catch { $command } msg]
  if { $retval != 0 } {
    set fp [open $status w]
    close $fp
    send_msg_id runtcl-5 warning "$msg"
  }
}
set_param xicom.use_bs_reader 1
create_project -in_memory -part xc7a200tfbv676-2

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir D:/vivadoproject/alu/alu.cache/wt [current_project]
set_property parent.project_path D:/vivadoproject/alu/alu.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property ip_output_repo d:/vivadoproject/alu/alu.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
add_files -quiet D:/sourcecode/source_code/lcd_module.dcp
set_property used_in_implementation false [get_files D:/sourcecode/source_code/lcd_module.dcp]
read_verilog -library xil_defaultlib {
  D:/sourcecode/source_code/4_alu/adder.v
  D:/sourcecode/source_code/4_alu/alu.v
  D:/sourcecode/source_code/4_alu/alu_display.v
}
# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
read_xdc D:/sourcecode/source_code/4_alu/alu.xdc
set_property used_in_implementation false [get_files D:/sourcecode/source_code/4_alu/alu.xdc]

set_param ips.enableIPCacheLiteLoad 1
close [open __synthesis_is_running__ w]

synth_design -top alu_display -part xc7a200tfbv676-2


# disable binary constraint mode for synth run checkpoints
set_param constraints.enableBinaryConstraints false
write_checkpoint -force -noxdef alu_display.dcp
create_report "synth_1_synth_report_utilization_0" "report_utilization -file alu_display_utilization_synth.rpt -pb alu_display_utilization_synth.pb"
file delete __synthesis_is_running__
close [open __synthesis_is_complete__ w]
