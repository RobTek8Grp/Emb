######################################################
#
# XPS Tcl API script generated by PlanAhead
#
######################################################

proc _main_ {} {
  cd "/media/leon/Data/EMB3/git/Emb/PongPowerPlayer.srcs/sources_1/edk/microblaze"
  if { [ catch {xload xmp microblaze.xmp} result ] } {
    exit 10
  }

  # Set host application type
  xset intstyle PA

  # Set design flow type
  xset flow ise

  # Save current language type
  set hdl_bak [xget hdl]

  # Set target language for the template
  xset hdl vhdl

  if { [catch {run mhs2hdl} result] } {
    return -1
  }

  # Restore language type
  xset hdl $hdl_bak

  return $result
}

# Generate Instantiation Template
if { [catch {_main_} result] } {
  exit -1
}

# Check return status and exit
if { [string length $result] == 0 } {
  exit 0
} else {
  exit $result
}
