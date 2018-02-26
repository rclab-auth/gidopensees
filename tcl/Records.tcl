namespace eval Records {
	variable filename ""
	variable form "PEER"
	variable type "accel"
	variable dt 0
	variable sclFactor 9.81
	variable linesSkip 0
	variable timeCol 0
	variable valCol 0
}

proc Records::SetValues {rfilename rformat rtype rdt rsclFactor rLinesSkip rtCol rvCol } {

	variable filename;
	variable form;
	variable type;
	variable dt;
	variable sclFactor;
	variable linesSkip;
	variable timeCol;
	variable valCol;

	OpenSees::SetProjectNameAndPath

	set GiDProjectDir [OpenSees::GetProjectPath]

	if {$rfilename != ""} {
		set filename "$GiDProjectDir/Records/$rfilename"
	} else {
		set filename " "
	}

	switch $rformat {

		"PEER_format" {
			variable form "PEER"
			variable dt 0
			variable linesSkip 0
			variable timeCol 0
			variable valCol 0
			variable sclFactor $rsclFactor
		}
		"Single_value_per_line" {
			variable form "sv"; # single value = sv
			variable dt $rdt
			variable linesSkip $rLinesSkip
			variable timeCol 0; # no matter
			variable valCol 0; # no matter
			variable sclFactor $rsclFactor
		}
		"Time_and_value_per_line" {
			variable form "tv"; # time-value = tv
			variable dt 0; # no matter
			variable linesSkip $rLinesSkip
			variable timeCol $rtCol; # no matter
			variable valCol $rvCol; # no matter
			variable sclFactor $rsclFactor
		}
	}

	switch $rtype {
		"Acceleration" {
			variable type "accel"
		}
		"Displacement" {
			variable type "disp"
		}
		"Velocity" {
			variable type "vel"
		}
		"Function" {
			variable type "function"
		}
	}
	return ""
}

proc Records::GetFilename {} {

	variable filename;
	return $filename;

}

proc Records::SetFilename {rfilename} {

	OpenSees::SetProjectNameAndPath

	set GiDProjectDir [OpenSees::GetProjectPath]
	variable filename;

	set filename "$GiDProjectDir/Records/$rfilename"

	return ""
}

proc Records::GetFormat {} {

	variable form;
	return $form;
}

proc Records::GetType {} {

	variable type;
	return $type;
}

proc Records::GetDt {} {

	variable dt;
	return $dt;
}

proc Records::GetSclFactor {} {

	variable sclFactor;
	return $sclFactor;
}

proc Records::GetLinesSkip {} {

	variable linesSkip;
	return $linesSkip;
}

proc Records::GetTimeCol {} {

	variable timeCol;
	return $timeCol;
}

proc Records::GetValCol {} {

	variable valCol;
	return $valCol;
}

proc Records::Display {event args} {

	variable filename;
	variable form;
	variable type;
	variable dt;
	variable sclFactor;
	variable linesSkip;
	variable timeCol;
	variable valCol;

	switch $event {

		INIT {
			set GDN [lindex $args 2]
			set STRUCT [lindex $args 3]
			set QUESTION [lindex $args 4]

			set rfilename [DWLocalGetValue $GDN $STRUCT Record_file]
			set rformat [DWLocalGetValue $GDN $STRUCT Record_file_format]
			set rtype [DWLocalGetValue $GDN $STRUCT Record_type]
			set rdt [DWLocalGetValue $GDN $STRUCT Time_step]
			set rsclFactor [DWLocalGetValue $GDN $STRUCT Scale_factor]
			set rLinesSkip [DWLocalGetValue $GDN $STRUCT Lines_to_skip]
			set rtCol [DWLocalGetValue $GDN $STRUCT Time_column]
			set rvCol [DWLocalGetValue $GDN $STRUCT Value_column]

			# change the parameters of the record
			set ok [Records::SetValues $rfilename $rformat $rtype $rdt $rsclFactor $rLinesSkip $rtCol $rvCol]

			set PARENT [lindex $args 0]
			upvar [lindex $args 1] ROW

			set temp [GiD_Info Project]
			set ProjectName [lindex $temp 1]

			if { $ProjectName == "UNNAMED" } {

			# Need saved project, otherwise no record file is stored in Records folder inside GiD Project Dir

			} else {
				set cmd {

					set fexists [file exist [Records::GetFilename]]
					if {$fexists} {

						set OpenSeesProblemTypePath [OpenSees::GetProblemTypePath]

						cd "$OpenSeesProblemTypePath/exe"

						exec {*}[auto_execok start] "RecordViewer.exe" "[Records::GetFilename]" "[Records::GetFormat]" "[Records::GetType]" [Records::GetSclFactor] [Records::GetLinesSkip] [Records::GetDt] [Records::GetTimeCol] [Records::GetValCol] &

					} else {

						error "File not found\nTry selecting again from filebutton"
					}
				}

				set b [Button $PARENT.displayRecord -text [= " Display record "] -helptext [= "Plot record time history"] -command $cmd -state normal ]
				grid $b -column 1 -row $ROW -sticky nw -pady 5
			}
		}

		SYNC {

			set GDN [lindex $args 0]
			set STRUCT [lindex $args 1]
			set QUESTION [lindex $args 2]

			set rfilename [DWLocalGetValue $GDN $STRUCT Record_file]
			set rformat [DWLocalGetValue $GDN $STRUCT Record_file_format]
			set rtype [DWLocalGetValue $GDN $STRUCT Record_type]
			set rdt [DWLocalGetValue $GDN $STRUCT Time_step]
			set rsclFactor [DWLocalGetValue $GDN $STRUCT Scale_factor]
			set rLinesSkip [DWLocalGetValue $GDN $STRUCT Lines_to_skip]
			set rtCol [DWLocalGetValue $GDN $STRUCT Time_column]
			set rvCol [DWLocalGetValue $GDN $STRUCT Value_column]

			# change the parameters of the record
			set ok [Records::SetValues $rfilename $rformat $rtype $rdt $rsclFactor $rLinesSkip $rtCol $rvCol]
		}
	}
}

proc Records::OpenFile { event args } {

	switch $event {

	INIT {
		set GDN [lindex $args 2]
		set STRUCT [lindex $args 3]
		set QUESTION [lindex $args 4]

		set rfilename [DWLocalGetValue $GDN $STRUCT Record_file]
		set ok [Records::SetFilename $rfilename]

		set PARENT [lindex $args 0]
		upvar [lindex $args 1] ROW

		set temp [GiD_Info Project]
		set ProjectName [lindex $temp 1]

			if { $ProjectName == "UNNAMED" } {

				# Need saved project, otherwise no record file is stored in Records folder inside GiD Project Dir

			} else {

				set cmd {

					set fexists [file exist [Records::GetFilename]]
					if {$fexists} {
						exec {*}[auto_execok start] "" "[Records::GetFilename]" &
					} else {
						error "File not found\nTry selecting again from filebutton"
					}
				}

				set b [Button $PARENT.openRecord -text [= " Open file "] -helptext [= "Open record file"] -command $cmd -state normal ]
				grid $b -column 1 -row $ROW -sticky nw -pady 5
			}
		}
	}

return ""
}

proc Records::FileButton { event args } {

	global tkwidgedprivfilenamebutton
	switch $event {

		INIT {

			lassign $args PARENT current_row_variable GDN STRUCT QUESTION
			upvar $current_row_variable ROW
			#initialize variable to current field value
			set tkwidgedprivfilenamebutton($QUESTION,filename) [DWLocalGetValue $GDN $STRUCT $QUESTION]
			#set entry $PARENT.e$ROW
			set entry ""
			foreach item [grid slaves $PARENT -row [expr $ROW-1]] {
				if { [winfo class $item] == "Entry"  || [winfo class $item] == "TEntry" } {
					#assumed that it is the only entry of this row
					set entry $item
					break
				}
			}
			#trick to fill in the values pressing transfer from an applied condition
			if { [lindex [info level 2] 0] == "DWUpdateConds" } {
				set values [lrange [lindex [info level 2] 2] 3 end]
				set index_field [LabelField $GDN $STRUCT $QUESTION]
				set value [lindex $values $index_field-1]
				set tkwidgedprivfilenamebutton($QUESTION,filename) $value
			}
			set w [ttk::frame $PARENT.cfilenamebutton$QUESTION] ;#use a name depending on $QUESTION to allow more than one row changed
			ttk::entry $w.e1 -textvariable tkwidgedprivfilenamebutton($QUESTION,filename)
			ttk::button $w.b1 -image [gid_themes::GetImage "folder.png"] \
				-command [list Records::GetFilenameCmd tkwidgedprivfilenamebutton($QUESTION,filename) $w.e1 1]
			set tkwidgedprivfilenamebutton($QUESTION,widget) $w
			grid $w.e1 $w.b1 -sticky ew
			grid columnconfigure $w {0} -weight 1
			grid $w -row [expr $ROW-1] -column 1 -sticky ew
			if { $entry != "" } {
				grid remove $entry
			} else {
				#assumed that entry is hidden and then hide the usurpating frame
				#grid remove $w
			}
		}

		SYNC {

			lassign $args GDN STRUCT QUESTION
			if { [info exists tkwidgedprivfilenamebutton($QUESTION,filename)] } {
				DWLocalSetValue $GDN $STRUCT $QUESTION $tkwidgedprivfilenamebutton($QUESTION,filename)
			}
		}

		DEPEND {

			lassign $args GDN STRUCT QUESTION ACTION VALUE
			if { [info exists tkwidgedprivfilenamebutton($QUESTION,widget)] && \
				[winfo exists $tkwidgedprivfilenamebutton($QUESTION,widget)] } {
				if { $ACTION == "HIDE" } {
					grid remove $tkwidgedprivfilenamebutton($QUESTION,widget)
				} else {
					#RESTORE
					grid $tkwidgedprivfilenamebutton($QUESTION,widget)
				}
			} else {
				}
		}

		CLOSE {

			array unset tkwidgedprivfilenamebutton
			UpdateInfoBar
		}
	}

	#a tkwidget procedure must return "" if Ok or [list ERROR $description] or [list WARNING $description]

	return ""
}

proc Records::GetFilenameCmd { varname entry {tail 0}} {

	set aa [GiD_Info Project]
	set ProjectName [lindex $aa 1]

	set types [list [list [_ "All files"] ".*"]]
	set defaultextension ""
	set title [_ "Select file"]
	set current_value [Browser-ramR file read .gid $title [set ::$varname] $types $defaultextension 0]

	if {$current_value != ""} {

		if { $ProjectName == "UNNAMED" } {

			#tk_dialogRAM $wbase.tmpwin [_ "Warning"] [_ "Before using a Record file, you need to save the project" ] warning 0 [_ "OK"]
			set answer [tk_messageBox -message "Before saving a Record file, you need to save the Project" -type ok -icon warning]
			set current_value ""

		} else {

			OpenSees::SetProjectNameAndPath
			set GiDProjectDir [OpenSees::GetProjectPath]
			file mkdir $GiDProjectDir/Records
			file copy -force -- $current_value $GiDProjectDir/Records
		}
	}

	if { $tail } {
		set current_value [file tail $current_value]
	}

	if { $current_value != "" && $entry != "" && [winfo exists $entry] } {
		$entry delete 0 end
		$entry insert end $current_value
	}

	#set variable after change entry, else if variable is the own entry variable then delete 0 end will empty both
	set ::$varname $current_value
	return $current_value
}
