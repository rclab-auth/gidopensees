namespace eval UserRecorder {
	variable script
	variable scriptParent
}

set ::RecorderVisited 0

proc UserRecorder::Script { event args } {

	variable script
	variable scriptParent

	switch $event {

		INIT {
				global RecorderVisited
				set RecorderVisited 1

				set data [GiD_Info Project]
				set ProjectName [lindex $data 1]

				set PARENT [lindex $args 0]
				upvar [lindex $args 1] ROW
				set GDN [lindex $args 2]
				set STRUCT [lindex $args 3]
				set QUESTION [lindex $args 4]
				set scriptParent $PARENT

				OpenSees::SetProjectNameAndPath

				set GiDProjectDir [OpenSees::GetProjectPath]

					if { $ProjectName != "UNNAMED" } {

						set filename "Recorders.tcl"
						set filepath [file join $GiDProjectDir Scripts $filename]
						set fexist [file exists $filepath]

						if { $fexist } {

							set fp [open $filepath r]
							set text [read $fp]
							set ok [UserRecorder::SetScript $text]; # initializing

							close $fp

						} else {

							set eexists [winfo exists $PARENT.e2]

							if {$eexists} {
								set text [$PARENT.e2 get]; # if exists
							} else {
								set text ""
							}

							set ok [UserRecorder::SetScript $text]; # initializing

						}

					} else {

						set eexists [winfo exists $PARENT.e2]

						if {$eexists} {
							set text [$PARENT.e2 get]; # if exists
						} else {
							set text ""
						}

						if {![info exists UserRecorder::script]} {

							set ok [UserRecorder::SetScript $text]

						}
					}

					set label [label $PARENT.info -text [= "\n\nEnter the Recorder script to be inserted in the .tcl file.\n\n"] ]
					grid $label -column 1 -row [expr $ROW] -sticky nw
					grid [text $PARENT.userscript -width 150 -height 20 -font {Calibri -12} ] -column 1 -row [expr $ROW+1]
					$PARENT.userscript delete 1.0 end
					$PARENT.userscript insert 1.0 "$text"
		}

		SYNC {
				global RecorderVisited

				if {$RecorderVisited} {

					set eexists [winfo exists $scriptParent.userscript]

					if {$eexists} {
						set ok [UserRecorder::SetScript ["$scriptParent.userscript" get 1.0 end] ]
						set ok [UserRecorder::SaveScriptFile]
					}

				}
		}

	}
}

proc UserRecorder::SetScript { text } {
	variable script

	set script $text
	return ""
}

proc UserRecorder::SaveScriptFile { } {

	variable script

	set data [GiD_Info Project]
	set ProjectName [lindex $data 1]

	OpenSees::SetProjectNameAndPath

	set GiDProjectDir [OpenSees::GetProjectPath]

	set script [string trim $script]

	if { $ProjectName != "UNNAMED" } {

		set filename "Recorders.tcl"
		set folderpath [file join $GiDProjectDir Scripts]
		set filepath [file join $GiDProjectDir Scripts $filename]
		set fexists [file exists $filepath]
		set folderexists [file exists $folderpath]

		if {!$folderexists} {

			file mkdir $folderpath
		}

		if {$script != ""} {

			cd "$GiDProjectDir/Scripts"
			set fp [open $filepath w]
			puts $fp $script
			close $fp

		} else {

			# empty textbox

			if {$fexists} {

				file delete -force $filepath
			}
		}

		# delete folder

		set file_list [glob -nocomplain "$folderpath/*"]
		if {[llength $file_list] == 0} {
			file delete -force $folderpath
		}
	}

	return ""
}

proc UserRecorder::RecorderFileExists { } {

	OpenSees::SetProjectNameAndPath

	set GiDProjectDir [OpenSees::GetProjectPath]

	set filename "Recorders.tcl"
	set filepath [file join $GiDProjectDir Scripts $filename]
	set fexists [file exists $filepath]

	if {$fexists} {
		return 1
	}

	return 0
}