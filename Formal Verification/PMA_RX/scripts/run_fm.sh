mkdir -p reports_fm
mkdir -p log_fm

fm_shell -f fm_script.tcl | tee log_fm/fm.log
