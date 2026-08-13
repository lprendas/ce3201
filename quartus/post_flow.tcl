# Registered via POST_FLOW_SCRIPT_FILE in adder_top.qsf. Quartus runs this
# automatically after "Compile Design" finishes, regardless of pass/fail, and
# syncs the flow report to the exact path the CI gate checks
# (output_files/adder.flow.rpt at the repo root) so no manual copy step is
# needed. Paths below are relative to the Quartus project directory (quartus/),
# which is Quartus's cwd when it runs this script.

set src "output_files/adder_top.flow.rpt"
set dst_dir "../output_files"
set dst "$dst_dir/adder.flow.rpt"

if {[file exists $src]} {
    file mkdir $dst_dir
    file copy -force $src $dst
    puts "post_flow.tcl: copied $src -> $dst"
} else {
    puts "post_flow.tcl: WARNING - $src not found, report was not synced"
}
