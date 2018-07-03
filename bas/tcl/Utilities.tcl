
# Analysis procedures

proc ExecutePost {} {

	set param1 [OpenSees::GetProblemTypePath]
	regsub -all {\\} $param1 {/} param1
	set pos [string last /problemtypes $param1]
	set param1 [string range $param1 0 $pos-1]
	regsub -all {/} $param1 {\\} param1

	set param2 [OpenSees::GetProjectPath]
	regsub -all {/} $param2 {\\} param2

	set OutputStep [GiD_AccessValue get GenData Output_step_frequency]
	set OutputStep [lindex [split $OutputStep #] 0]

	cd "[OpenSees::GetProblemTypePath]/exe"

	# Run OpenSeesPost

	if {[GiD_AccessValue get GenData Use_HDF5_binary_output_format] == 0 } {

		exec {*}[auto_execok start] "OpenSeesPost.exe" "$param1" "$param2" "$OutputStep"

	} else {

		exec {*}[auto_execok start] "OpenSeesPost.exe" "$param1" "$param2" "$OutputStep" "/b"

	}

	UpdateInfoBar
	return ""
}

proc CheckLogAndPost { projectDir projectName doPost } {

	global ElapsedTime
	set ElapsedTime ""

	set file "$projectDir/OpenSees/$projectName.log"

	set fp [open $file r]
	set file_data [read $fp]
	close $fp
	set data [split $file_data \n]

	foreach line $data {

		if { ([string match *Analysis* $line]) == 1 && ([string match *time* $line] == 1) } {
			set words [split $line]
			if { [lindex $words 0] == "Analysis" && [lindex $words 1] == "time" } {

					set pos [string last ":" $line]
					set ElapsedTime [string range $line $pos+2 $pos+100]

					break
			}
		}
	}

	set success 1

	foreach line $data {

		if { $line == "Analysis FAILED" } {

			set success 0
			break
		}
	}

	if { $success == 1 } {

		if { $doPost == 0 } {

			AnalysisInformationWindow "RunSuccess"

		} else {

			ExecutePost
			AnalysisInformationWindow "RunSuccessPost"

		}

	} else {

		if { $doPost == 0 } {

			AnalysisInformationWindow "RunFailed"

		} else {

			ExecutePost
			AnalysisInformationWindow "RunFailedPost"

		}
	}

	return ""
}

proc ResetAnalysis {w} {

	destroy $w

	set GiDProjectDir [OpenSees::GetProjectPath]
	set GiDProjectName [OpenSees::GetProjectName]

	# clear analysis files

	if {[file exists "$GiDProjectDir/OpenSees"] } {
		file delete -force "$GiDProjectDir/OpenSees"
	}

	# clear postprocessor files

	if {[file exists "$GiDProjectDir/$GiDProjectName.post.res.ascii"]} {
		file delete -force "$GiDProjectDir/$GiDProjectName.post.res.ascii"
	}

	if {[file exists "$GiDProjectDir/$GiDProjectName.post.res"]} {
		file delete -force "$GiDProjectDir/$GiDProjectName.post.res"
	}

	if {[file exists "$GiDProjectDir/$GiDProjectName.post.png"]} {
		file delete -force "$GiDProjectDir/$GiDProjectName.post.png"
	}

	if {[file exists "$GiDProjectDir/$GiDProjectName.post.vv"]} {
		file delete -force "$GiDProjectDir/$GiDProjectName.post.vv"
	}

	if {[file exists "$GiDProjectDir/$GiDProjectName.post.grf"]} {
		file delete -force "$GiDProjectDir/$GiDProjectName.post.grf"
	}

	UpdateInfoBar
	return ""
}

# Analysis commands

proc Create_tcl_file {w} {

	destroy $w

	global GidProcWin

	set info [GiD_Info Project]
	set ProjectName [lindex $info 1]

	if { ![info exists GidProcWin(ww)] || ![winfo exists $GidProcWin(ww).listbox#1] } {
		set wbase .gid
		set ww ""
	} else {
		set wbase $GidProcWin(ww)
		set ww $GidProcWin(ww).listbox#1
	}

	if { $ProjectName == "UNNAMED" } {

		tk_dialogRAM $wbase.tmpwin [_ "Error"] [_ "Please save project before creating the .tcl file." ] error 0 [_ "Close"]

	} else {

		GiD_Process Mescape Files Save; # save project before creating .tcl file
		file mkdir [OpenSees::GetProjectPath]/OpenSees
		GiD_Process Mescape Files WriteForBAS "[OpenSees::GetProblemTypePath]/../OpenSees.gid/OpenSees.bas" "[OpenSees::GetProjectPath]/OpenSees/[OpenSees::GetProjectName].tcl"
	}

	UpdateInfoBar
	return ""
}

proc Open_tcl_file {w} {

	destroy $w

	set GiDProjectDir [OpenSees::GetProjectPath]
	set GiDProjectName [OpenSees::GetProjectName]

	set filename [file join $GiDProjectDir OpenSees "$GiDProjectName.tcl"]
	set fexists [file exist $filename]

	if { $fexists==1 } {

		exec {*}[auto_execok start] "" "$GiDProjectDir/OpenSees/$GiDProjectName.tcl" &
	}

	return ""
}

proc Create_and_open_tcl_file {w} {

	destroy $w

	Create_tcl_file $w

	Open_tcl_file $w

	return ""
}

proc Run_existing_tcl {w doPost} {

	destroy $w
	set GiDProjectDir [OpenSees::GetProjectPath]
	set GiDProjectName [OpenSees::GetProjectName]
	set OpenSeesPath [OpenSees::GetOpenSeesPath]
	global GidProcWin

	if {[file exists "$GiDProjectDir/OpenSees/$GiDProjectName.tcl"] } {

		GiD_Process Mescape Files Save

		cd "$GiDProjectDir/OpenSees"

		# run analysis

		exec {*}[auto_execok start] [OpenSees::GetOpenSeesPath] "$GiDProjectDir/OpenSees/$GiDProjectName.tcl"

		if {[file exists "$GiDProjectName.log"] } {

			CheckLogAndPost $GiDProjectDir $GiDProjectName $doPost

		} else {

			AnalysisInformationWindow "NoRun"
		}

	} else {

		if { ![info exists GidProcWin(ww)] || ![winfo exists $GidProcWin(ww).listbox#1] } {
			set wbase .gid
			set ww ""
		} else {
			set wbase $GidProcWin(ww)
			set ww $GidProcWin(ww).listbox#1
		}

		tk_dialogRAM $wbase.tmpwin [_ "Error"] [_ "The .tcl file was not created." ] error 0 [_ "Close"]
	}

	UpdateInfoBar
	return ""
}

proc Run_existing_tcl_and_postprocess {w} {

	destroy $w

	set true 1
	Run_existing_tcl $w $true

	return ""
}

proc Postprocess_only {} {

	set GiDProjectDir [OpenSees::GetProjectPath]
	set GiDProjectName [OpenSees::GetProjectName]

	if {[file exists "$GiDProjectDir/OpenSees/$GiDProjectName.log"] } {

			ExecutePost

	} else {

		if { ![info exists GidProcWin(ww)] || ![winfo exists $GidProcWin(ww).listbox#1] } {
			set wbase .gid
			set ww ""
		} else {
			set wbase $GidProcWin(ww)
			set ww $GidProcWin(ww).listbox#1
		}

		tk_dialogRAM $wbase.tmpwin [_ "Error"] [_ "The analysis has not run yet." ] error 0 [_ "Close"]
	}

	return ""
}

proc Create_tcl_run_analysis_and_postprocess {w} {

	destroy $w

	set mustRegenMesh [GiD_Info Project MustReMesh]; # 0 no, 1 yes

	if {$mustRegenMesh} {

		WantToRegenMeshMessage

	} else {

		set GiDProjectDir [OpenSees::GetProjectPath]
		set GiDProjectName [OpenSees::GetProjectName]

		ResetAnalysis {w}

		Create_tcl_file $w

		if {[file exists "$GiDProjectDir/OpenSees/$GiDProjectName.tcl"] } {

			# run and postprocess

			Run_existing_tcl_and_postprocess $w
		}

	}

	return ""
}

proc Open_log_file {w} {

	destroy $w

	set GiDProjectDir [OpenSees::GetProjectPath]
	set GiDProjectName [OpenSees::GetProjectName]

	set filename [file join $GiDProjectDir OpenSees "$GiDProjectName.log"]
	set fexists [file exist $filename]

	if { $fexists==1 } {

		exec {*}[auto_execok start] "" "$GiDProjectDir/OpenSees/$GiDProjectName.log" &
	}

	return ""
}

proc GoToPostProcess {w} {

	destroy $w

	GiD_Process Mescape Postprocess

	return ""
}

proc AnalysisInformationWindow { AnalResult } {

	if { [GidUtils::AreWindowsDisabled] } {
		return
	}

	switch $AnalResult {

		"NoRun" {
			set w .gid.win_example
			InitWindow $w [= "Analysis failed"] ErrorInfo "" "" 1
			if { ![winfo exists $w] } return; # windows disabled || usemorewindows == 0
			ttk::frame $w.top
			ttk::label $w.top.title_text -text [= ""]
			ttk::frame $w.information -relief raised
			ttk::label $w.information.errormessage -text [= "Analysis could not run !\n\nPlease check generated .tcl file and report any issues to https://github.com/rclab-auth/gidopensees/issues"]
			ttk::frame $w.bottom
			ttk::button $w.bottom.opentcl -text [= "Open .tcl file"] -command "Open_tcl_file $w"
			ttk::button $w.bottom.close -text [= "Close"] -command "destroy $w"
			grid $w.top.title_text -sticky ew
			grid $w.top -sticky new
			grid $w.information.errormessage -sticky w -padx 20 -pady 10
			grid $w.information -sticky nsew
			grid $w.bottom.opentcl $w.bottom.close -padx 20
			grid $w.bottom -sticky sew -padx 20 -pady 10
			if { $::tcl_version >= 8.5 } { grid anchor $w.bottom center }
			grid rowconfigure $w 1 -weight 1
			grid columnconfigure $w 0 -weight 1
		}

		"RunFailed" {
			global ElapsedTime
			set w .gid.win_example
			InitWindow $w [= "Analysis failed"] ErrorInfo "" "" 1
			if { ![winfo exists $w] } return; # windows disabled || usemorewindows == 0
			ttk::frame $w.top
			ttk::label $w.top.title_text -text [= ""]
			ttk::frame $w.information -relief raised
			ttk::label $w.information.errormessage -text [= "Analysis completed with ERRORS after $ElapsedTime.\n\nErrors were reported during analysis, please check generated .log file for more information."]
			ttk::frame $w.bottom
			ttk::button $w.bottom.openlog -text [= "Open log file"] -command "Open_log_file $w"
			ttk::button $w.bottom.close -text [= "Close"] -command "destroy $w"
			grid $w.top.title_text -sticky ew
			grid $w.top -sticky new
			grid $w.information.errormessage -sticky w -padx 20 -pady 10
			grid $w.information -sticky nsew
			grid $w.bottom.openlog $w.bottom.close -padx 20
			grid $w.bottom -sticky sew -padx 20 -pady 10
			if { $::tcl_version >= 8.5 } { grid anchor $w.bottom center }
			grid rowconfigure $w 1 -weight 1
			grid columnconfigure $w 0 -weight 1
		}

		"RunFailedPost" {
			global ElapsedTime
			set w .gid.win_example
			InitWindow $w [= "Analysis failed"] ErrorInfo "" "" 1
			if { ![winfo exists $w] } return; # windows disabled || usemorewindows == 0
			ttk::frame $w.top
			ttk::label $w.top.title_text -text [= ""]
			ttk::frame $w.information -relief raised
			ttk::label $w.information.errormessage -text [= "Analysis completed with ERRORS after $ElapsedTime.\n\nErrors were reported during analysis, please check generated .log file for more information."]
			ttk::frame $w.bottom
			ttk::button $w.bottom.openlog -text [= "Open log file"] -command "Open_log_file $w"
			ttk::button $w.bottom.close -text [= "Close"] -command "destroy $w"
			ttk::button $w.bottom.ignore -text [= "Postprocess anyway"] -command "GoToPostProcess $w"
			grid $w.top.title_text -sticky ew
			grid $w.top -sticky new
			grid $w.information.errormessage -sticky w -padx 20 -pady 10
			grid $w.information -sticky nsew
			grid $w.bottom.openlog $w.bottom.close $w.bottom.ignore -padx 20
			grid $w.bottom -sticky sew -padx 20 -pady 10
			if { $::tcl_version >= 8.5 } { grid anchor $w.bottom center }
			grid rowconfigure $w 1 -weight 1
			grid columnconfigure $w 0 -weight 1
		}

		"RunSuccess" {
			global ElapsedTime
			set w .gid.win_example
			InitWindow $w [= "Analysis successful"] ErrorInfo "" "" 1
			if { ![winfo exists $w] } return; # windows disabled || usemorewindows == 0
			ttk::frame $w.top
			ttk::label $w.top.title_text -text [= ""]
			ttk::frame $w.information -relief raised
			ttk::label $w.information.errormessage -text [= "Analysis completed SUCCESSFULLY after $ElapsedTime."]
			ttk::frame $w.bottom
			ttk::button $w.bottom.openlog -text [= "Open log file"] -command "Open_log_file $w"
			ttk::button $w.bottom.close -text [= "Close"] -command "destroy $w"
			grid $w.top.title_text -sticky ew
			grid $w.top -sticky new
			grid $w.information.errormessage -sticky w -padx 20 -pady 10
			grid $w.information -sticky nsew
			grid $w.bottom.openlog $w.bottom.close -padx 20
			grid $w.bottom -sticky sew -padx 20 -pady 10
			if { $::tcl_version >= 8.5 } { grid anchor $w.bottom center }
			grid rowconfigure $w 1 -weight 1
			grid columnconfigure $w 0 -weight 1
		}

		"RunSuccessPost" {
			global ElapsedTime
			set w .gid.win_example
			InitWindow $w [= "Analysis successful"] ErrorInfo "" "" 1
			if { ![winfo exists $w] } return; # windows disabled || usemorewindows == 0
			ttk::frame $w.top
			ttk::label $w.top.title_text -text [= ""]
			ttk::frame $w.information -relief raised
			ttk::label $w.information.errormessage -text [= "Analysis completed SUCCESSFULLY after $ElapsedTime.\n\nContinue to postprocessing ?"]
			ttk::frame $w.bottom
			ttk::button $w.bottom.openlog -text [= "Open log file"] -command "Open_log_file $w"
			ttk::button $w.bottom.close -text [= "Close"] -command "destroy $w"
			ttk::button $w.bottom.post -text [= "Postprocess"] -command "GoToPostProcess $w"
			grid $w.top.title_text -sticky ew
			grid $w.top -sticky new
			grid $w.information.errormessage -sticky w -padx 20 -pady 10
			grid $w.information -sticky nsew
			grid $w.bottom.openlog $w.bottom.close $w.bottom.post -padx 20
			grid $w.bottom -sticky sew -padx 20 -pady 10
			if { $::tcl_version >= 8.5 } { grid anchor $w.bottom center }
			grid rowconfigure $w 1 -weight 1
			grid columnconfigure $w 0 -weight 1
		}
	}
}

proc WantToRegenMeshMessage {} {

	set answer [tk_messageBox -parent .gid -message "Model has changed without mesh updating.\nDo you want to regenerate the mesh ?" -title "Mesh update" -type yesno -icon warning]

	switch -- $answer {

		yes {
			GiD_Process Mescape Meshing generate
		}

		no destroy
	}
}

# Analysis menu options

proc Opt1_dialog { } {

	set mustRegenMesh [GiD_Info Project MustReMesh]; # 0 no, 1 yes

	if {$mustRegenMesh} {

		WantToRegenMeshMessage

	} else {

		OpenSees::SetProjectNameAndPath
		set GiDProjectDir [OpenSees::GetProjectPath]
		set GiDProjectName [OpenSees::GetProjectName]

		set file "$GiDProjectDir/OpenSees/$GiDProjectName.tcl"
		set fexists [file exist $file]
		set w .gid.warn1

		if { $fexists == 1 } {

			InitWindow $w [= "Warning"] ErrorInfo "" "" 1
			if { ![winfo exists $w] } return; # windows disabled || usemorewindows == 0
			ttk::frame $w.top
			ttk::label $w.top.title_text -text [= ""]
			ttk::frame $w.information -relief raised
			ttk::label $w.information.warningmessage -text [= "Creating the .tcl file and running the analysis will overwrite any user modifications and delete any existing results.\n\nDo you want to continue ?"]
			ttk::frame $w.bottom
			ttk::button $w.bottom.continue -text [= "Yes"] -command [= "Create_tcl_run_analysis_and_postprocess $w"]
			ttk::button $w.bottom.destroy -text [= "No"] -command "destroy $w"
			grid $w.top.title_text -sticky ew
			grid $w.top -sticky new
			grid $w.information.warningmessage -sticky w -padx 20 -pady 10
			grid $w.information -sticky nsew
			grid $w.bottom.continue $w.bottom.destroy -padx 20
			grid $w.bottom -sticky sew -padx 20 -pady 10
			if { $::tcl_version >= 8.5 } { grid anchor $w.bottom center }
			grid rowconfigure $w 1 -weight 1
			grid columnconfigure $w 0 -weight 1

		} else {

			Create_tcl_run_analysis_and_postprocess $w
		}
	}

	return ""
}

proc Opt2_dialog { } {

	set mustRegenMesh [GiD_Info Project MustReMesh]; # 0 no, 1 yes

	if {$mustRegenMesh} {
		WantToRegenMeshMessage
	} else {

		OpenSees::SetProjectNameAndPath
		set GiDProjectDir [OpenSees::GetProjectPath]
		set GiDProjectName [OpenSees::GetProjectName]

		set file "$GiDProjectDir/OpenSees/$GiDProjectName.tcl"
		set fexists [file exist $file]
		set w .gid.warn2

		if { $fexists == 1 } {

			InitWindow $w [= "Warning"] ErrorInfo "" "" 1
			if { ![winfo exists $w] } return; # windows disabled || usemorewindows == 0
			ttk::frame $w.top
			ttk::label $w.top.title_text -text [= ""]
			ttk::frame $w.information -relief raised
			ttk::label $w.information.warningmessage -text [= "Creating the .tcl file will overwrite any user modifications.\n\nDo you want to continue ?"]
			ttk::frame $w.bottom
			ttk::button $w.bottom.continue -text [= "Yes"] -command [= "Create_tcl_file $w"]
			ttk::button $w.bottom.destroy -text [= "No"] -command "destroy $w"
			grid $w.top.title_text -sticky ew
			grid $w.top -sticky new
			grid $w.information.warningmessage -sticky w -padx 20 -pady 10
			grid $w.information -sticky nsew
			grid $w.bottom.continue $w.bottom.destroy -padx 20
			grid $w.bottom -sticky sew -padx 20 -pady 10
			if { $::tcl_version >= 8.5 } { grid anchor $w.bottom center }
			grid rowconfigure $w 1 -weight 1
			grid columnconfigure $w 0 -weight 1

		} else {

			Create_tcl_file $w
		}
	}

	return ""
}

proc Opt3_dialog { } {

	set mustRegenMesh [GiD_Info Project MustReMesh]; # 0 no, 1 yes

	if {$mustRegenMesh} {
		WantToRegenMeshMessage
	} else {

		OpenSees::SetProjectNameAndPath
		set GiDProjectDir [OpenSees::GetProjectPath]
		set GiDProjectName [OpenSees::GetProjectName]

		set file "$$GiDProjectDir/OpenSees/$GiDProjectName.tcl"
		set fexists [file exist $file]
		set w .gid.warn3

		if { $fexists == 1 } {

			InitWindow $w [= "Warning"] ErrorInfo "" "" 1
			if { ![winfo exists $w] } return; # windows disabled || usemorewindows == 0
			ttk::frame $w.top
			ttk::label $w.top.title_text -text [= ""]
			ttk::frame $w.information -relief raised
			ttk::label $w.information.warningmessage -text [= "Creating the .tcl file will overwrite any user modifications.\n\nDo you want to continue ?"]
			ttk::frame $w.bottom
			ttk::button $w.bottom.continue -text [= "Yes"] -command [= "Create_and_open_tcl_file $w"]
			ttk::button $w.bottom.destroy -text [= "No"] -command "destroy $w"
			grid $w.top.title_text -sticky ew
			grid $w.top -sticky new
			grid $w.information.warningmessage -sticky w -padx 20 -pady 10
			grid $w.information -sticky nsew
			grid $w.bottom.continue $w.bottom.destroy -padx 20
			grid $w.bottom -sticky sew -padx 20 -pady 10
			if { $::tcl_version >= 8.5 } { grid anchor $w.bottom center }
			grid rowconfigure $w 1 -weight 1
			grid columnconfigure $w 0 -weight 1

		} else {

			Create_and_open_tcl_file $w
		}
	}

	return ""
}

proc Opt4_dialog { } {

	OpenSees::SetProjectNameAndPath
	set GiDProjectDir [OpenSees::GetProjectPath]
	set GiDProjectName [OpenSees::GetProjectName]

	set file "$GiDProjectDir/OpenSees/$GiDProjectName.log"
	set fexists [file exist $file]
	set w .gid.warn4
	set false 0

	if { $fexists == 1 } {

		InitWindow $w [= "Warning"] ErrorInfo "" "" 1
		if { ![winfo exists $w] } return; # windows disabled || usemorewindows == 0
		ttk::frame $w.top
		ttk::label $w.top.title_text -text [= ""]
		ttk::frame $w.information -relief raised
		ttk::label $w.information.warningmessage -text [= "Running the analysis will delete any existing results.\n\nDo you want to continue ?"]
		ttk::frame $w.bottom
		ttk::button $w.bottom.continue -text [= "Yes"] -command [= "Run_existing_tcl $w $false"]
		ttk::button $w.bottom.destroy -text [= "No"] -command "destroy $w"
		grid $w.top.title_text -sticky ew
		grid $w.top -sticky new
		grid $w.information.warningmessage -sticky w -padx 20 -pady 10
		grid $w.information -sticky nsew
		grid $w.bottom.continue $w.bottom.destroy -padx 20
		grid $w.bottom -sticky sew -padx 20 -pady 10
		if { $::tcl_version >= 8.5 } { grid anchor $w.bottom center }
		grid rowconfigure $w 1 -weight 1
		grid columnconfigure $w 0 -weight 1

	} else {

		Run_existing_tcl $w $false
	}

	return ""
}

proc Opt5_dialog { } {

	Postprocess_only

	set w .gid.warn6
	InitWindow $w [= "Translation completed"] ErrorInfo "" "" 1
	if { ![winfo exists $w] } return; # windows disabled || usemorewindows == 0
	ttk::frame $w.top
	ttk::label $w.top.title_text -text [= ""]
	ttk::frame $w.information -relief raised
	ttk::label $w.information.warningmessage -text [= "Proceed to postprocess ?"]
	ttk::frame $w.bottom
	ttk::button $w.bottom.continue -text [= "Yes"] -command [= "GoToPostProcess $w"]
	ttk::button $w.bottom.destroy -text [= "No"] -command "destroy $w"
	grid $w.top.title_text -sticky ew
	grid $w.top -sticky new
	grid $w.information.warningmessage -sticky w -padx 20 -pady 0
	grid $w.information -sticky nsew
	grid $w.bottom.continue $w.bottom.destroy -padx 20
	grid $w.bottom -sticky sew -padx 20 -pady 10
	if { $::tcl_version >= 8.5 } { grid anchor $w.bottom center }
	grid rowconfigure $w 1 -weight 1
	grid columnconfigure $w 0 -weight 1

	return ""
}

proc Opt6_dialog { } {

	OpenSees::SetProjectNameAndPath
	set GiDProjectDir [OpenSees::GetProjectPath]
	set GiDProjectName [OpenSees::GetProjectName]

	set file "$GiDProjectDir/OpenSees/$GiDProjectName.log"
	set fexists [file exist $file]
	set w .gid.warn6

	if { $fexists == 1 } {

		InitWindow $w [= "Warning"] ErrorInfo "" "" 1
		if { ![winfo exists $w] } return; # windows disabled || usemorewindows == 0
		ttk::frame $w.top
		ttk::label $w.top.title_text -text [= ""]
		ttk::frame $w.information -relief raised
		ttk::label $w.information.warningmessage -text [= "Running the analysis will delete any existing results.\n\nDo you want to continue ?"]
		ttk::frame $w.bottom
		ttk::button $w.bottom.continue -text [= "Yes"] -command [= "Run_existing_tcl_and_postprocess $w"]
		ttk::button $w.bottom.destroy -text [= "No"] -command "destroy $w"
		grid $w.top.title_text -sticky ew
		grid $w.top -sticky new
		grid $w.information.warningmessage -sticky w -padx 20 -pady 10
		grid $w.information -sticky nsew
		grid $w.bottom.continue $w.bottom.destroy -padx 20
		grid $w.bottom -sticky sew -padx 20 -pady 10
		if { $::tcl_version >= 8.5 } { grid anchor $w.bottom center }
		grid rowconfigure $w 1 -weight 1
		grid columnconfigure $w 0 -weight 1

	} else {

		Run_existing_tcl_and_postprocess $w
	}

	return ""
}

proc Opt7_dialog { } {

	OpenSees::SetProjectNameAndPath
	set GiDProjectDir [OpenSees::GetProjectPath]
	set GiDProjectName [OpenSees::GetProjectName]

	set file1 "$GiDProjectDir/OpenSees/$GiDProjectName.tcl"
	set file2 "$GiDProjectDir/$GiDProjectName.post.res"
	set fexists1 [file exist $file1]
	set fexists2 [file exist $file2]
	set w .gid.warn6

	if { ($fexists1 == 1) || ($fexists1 == 1) } {
		InitWindow $w [= "Warning"] ErrorInfo "" "" 1
		if { ![winfo exists $w] } return; # windows disabled || usemorewindows == 0
		ttk::frame $w.top
		ttk::label $w.top.title_text -text [= ""]
		ttk::frame $w.information -relief raised
		ttk::label $w.information.warningmessage -text [= "Resetting the analysis will delete any existing .tcl files and results.\n\nDo you want to continue ?"]
		ttk::frame $w.bottom
		ttk::button $w.bottom.continue -text [= "Yes"] -command [= "ResetAnalysis $w"]
		ttk::button $w.bottom.destroy -text [= "No"] -command "destroy $w"
		grid $w.top.title_text -sticky ew
		grid $w.top -sticky new
		grid $w.information.warningmessage -sticky w -padx 20 -pady 10
		grid $w.information -sticky nsew
		grid $w.bottom.continue $w.bottom.destroy -padx 20
		grid $w.bottom -sticky sew -padx 20 -pady 10
		if { $::tcl_version >= 8.5 } { grid anchor $w.bottom center }
		grid rowconfigure $w 1 -weight 1
		grid columnconfigure $w 0 -weight 1
	}

	return ""
}

# Various menu options

proc Import_dialog { } {

	set types {
		{{OpenSees .tcl files} {.tcl}}
		{{All Files} *}
	}

	set OpenSeesProblemTypePath [OpenSees::GetProblemTypePath]
	set tcl [tk_getOpenFile -filetypes $types]
	regsub -all {/} $tcl {\\} tcl

	if {$tcl ne ""} {

		# wait message

		global ibarBackgroundColor ibarTextColor ibarLineColor

		if { [winfo exist .wait] } {
			destroy .wait
		}

		toplevel .wait

		wm attributes .wait -topmost 1
		wm overrideredirect .wait 1
		wm transient .wait .gid

		.wait configure -background #292929
		.wait configure -bd 0

		set x [expr [winfo rootx .gid.central.s] + [winfo width .gid.central.s] / 2 - 300 / 2]
		set y [expr [winfo rooty .gid.central.s] + [winfo height .gid.central.s] / 2 - 50 / 2 ]

		set geom "300x50+$x+$y"

		wm geometry .wait $geom

		canvas .wait.c -width 300 -height 50 -background $ibarBackgroundColor

		.wait.c create line   0  0  299   0 -fill $ibarLineColor
		.wait.c create line 299  0  299  49 -fill $ibarLineColor
		.wait.c create line 299  49   0  49 -fill $ibarLineColor
		.wait.c create line   0  49   0   0 -fill $ibarLineColor

		.wait.c create text  150 23 -text "Importing geometry, please wait..." -font "calibri 12" -fill $ibarTextColor -anchor center

		pack .wait.c
		lower .wait .gid
		focus .gid.central.s
		update

		cd "$OpenSeesProblemTypePath/exe"

		set OpenSeesPath [OpenSees::GetOpenSeesPath]
		regsub -all {/} $OpenSeesPath {\\} OpenSeesPath

		exec {*}[auto_execok start] "tcl_Import.exe" "$OpenSeesPath" "$tcl"

		set bch [file root $tcl]
		append bch ".bch"

		if {[file exists $bch] } {

			raise .wait .gid
			focus .gid.central.s
			update

			# read batch

			GiD_Process Mescape Files BatchFile $bch

			file delete -force $bch

			GiD_Process 'Rotate Angle -120 10
			GiD_Process 'Zoom Frame

			lower .wait .gid
			update

			set w .gid.win_example
			InitWindow $w [= "Import finished"] ErrorInfo "" "" 1
			if { ![winfo exists $w] } return; # windows disabled || usemorewindows == 0
			ttk::frame $w.top
			ttk::label $w.top.title_text -text [= ""]
			ttk::frame $w.information -relief raised
			ttk::label $w.information.errormessage -text [= "Geometry was successfully imported from $tcl"]
			ttk::frame $w.bottom
			ttk::button $w.bottom.close -text [= "Close"] -command "destroy $w"
			grid $w.top.title_text -sticky ew
			grid $w.top -sticky new
			grid $w.information.errormessage -sticky w -padx 20 -pady 10
			grid $w.information -sticky nsew
			grid $w.bottom.close -padx 20
			grid $w.bottom -sticky sew -padx 20 -pady 10
			if { $::tcl_version >= 8.5 } { grid anchor $w.bottom center }
			grid rowconfigure $w 1 -weight 1
			grid columnconfigure $w 0 -weight 1

		} else {

			set w .gid.win_example
			InitWindow $w [= "Import failed"] ErrorInfo "" "" 1
			if { ![winfo exists $w] } return; # windows disabled || usemorewindows == 0
			ttk::frame $w.top
			ttk::label $w.top.title_text -text [= ""]
			ttk::frame $w.information -relief raised
			ttk::label $w.information.errormessage -text [= "Could not import model geometry.\n\nPlease report your model to GitHub issues.\n(https://github.com/rclab-auth/gidopensees/issues)"]
			ttk::frame $w.bottom
			ttk::button $w.bottom.close -text [= "Close"] -command "destroy $w"
			grid $w.top.title_text -sticky ew
			grid $w.top -sticky new
			grid $w.information.errormessage -sticky w -padx 20 -pady 10
			grid $w.information -sticky nsew
			grid $w.bottom.close -padx 20
			grid $w.bottom -sticky sew -padx 20 -pady 10
			if { $::tcl_version >= 8.5 } { grid anchor $w.bottom center }
			grid rowconfigure $w 1 -weight 1
			grid columnconfigure $w 0 -weight 1
		}
	}

	return ""
}

proc btn_Open_tcl { } {

	set GiDProjectDir [OpenSees::GetProjectPath]
	set GiDProjectName [OpenSees::GetProjectName]
	set OpenSeesPath [OpenSees::GetOpenSeesPath]
	global GidProcWin

	if {[file exists "$GiDProjectDir/OpenSees/$GiDProjectName.tcl"] } {

		exec {*}[auto_execok start] "" "$GiDProjectDir/OpenSees/$GiDProjectName.tcl" &

	} else {

		if { ![info exists GidProcWin(ww)] || ![winfo exists $GidProcWin(ww).listbox#1] } {
			set wbase .gid
			set ww ""
		} else {
			set wbase $GidProcWin(ww)
			set ww $GidProcWin(ww).listbox#1
		}

		tk_dialogRAM $wbase.tmpwin [_ "Error"] [_ "The .tcl file was not created." ] error 0 [_ "Close"]
	}

	UpdateInfoBar
	return ""
}

proc AboutOpenSeesProbType { } {

	global splashdir
	global keepsplash
	# 1!=0 to keep the Splash
	set keepsplash 1
	OpenSees::Splash $splashdir
	set keepsplash 0
}

proc CheckForUpdate {} {

	set OpenSeesProblemTypePath [OpenSees::GetProblemTypePath]

	cd "$OpenSeesProblemTypePath/exe"
	exec {*}[auto_execok start] "CheckForUpdate.exe" &
}

proc OpenGiD+OpenSeesPDF {} {

	set OpenSeesProblemTypePath [OpenSees::GetProblemTypePath]

	cd "$OpenSeesProblemTypePath/doc"
	exec {*}[auto_execok start] "GiD+OpenSees_Interface_User_Manual.pdf" &
}

proc OpenDesignSafePDF {} {

	set OpenSeesProblemTypePath [OpenSees::GetProblemTypePath]

	cd "$OpenSeesProblemTypePath/doc"
	exec {*}[auto_execok start] "DesignSafe_User_Manual.pdf" &
}

# Create GiD+OpenSees menu

proc OpenSees_Menu { dir } {

	# Create the Menu named GiD+OpenSees in PRE processing

	GiDMenu::Create "GiD+OpenSees" PRE -1

	# Tab labels

	set tabs [list \
	[= "Import geometry from existing .tcl (beta)"] \
	[= "Create .tcl, run analysis and postprocess"] \
	"---" \
	[= "Create .tcl only"] \
	[= "Create and view .tcl only"] \
	[= "Run analysis only"] \
	[= "Postprocess only"] \
	[= "Run analysis and postprocess"] \
	"---" \
	[= "Reset analysis"] \
	"---" \
	[= "GiD+OpenSees Site"] \
	[= "OpenSees Site"] \
	[= "OpenSees Wiki"] \
	"---" \
	[= "GiD+OpenSees User Manual"] \
	[= "DesignSafe-CI User Manual"] \
	[= "DesignSafe-CI Site"] \
	"---" \
	[= "Check for Update"] \
	[= "About"] ]

	# Selection commands

	set cmds { \
	{Import_dialog} \
	{Opt1_dialog} \
	{} \
	{Opt2_dialog} \
	{Opt3_dialog} \
	{Opt4_dialog} \
	{Opt5_dialog} \
	{Opt6_dialog} \
	{} \
	{Opt7_dialog} \
	{} \
	{VisitWeb "http://gidopensees.rclab.civil.auth.gr"} \
	{VisitWeb "http://opensees.berkeley.edu"} \
	{VisitWeb "http://opensees.berkeley.edu/wiki/index.php/Main_Page"} \
	{} \
	{OpenGiD+OpenSeesPDF} \
	{OpenDesignSafePDF} \
	{VisitWeb "https://www.designsafe-ci.org"} \
	{} \
	{CheckForUpdate} \
	{AboutOpenSeesProbType} }

	# Tab icons

	set icons { \
	mnu_Import.png \
	mnu_Analysis.png \
	"" \
	mnu_TCL.png \
	mnu_TCL.png \
	mnu_TCL_Analysis.png \
	mnu_TCL_Analysis.png \
	mnu_TCL_Analysis.png \
	"" \
	mnu_Reset.png \
	"" \
	mnu_Site.png \
	mnu_Site.png \
	mnu_Wiki.png \
	"" \
	mnu_PDF.png \
	mnu_PDF.png \
	mnu_DesignSafe.png \
	"" \
	mnu_Update.png \
	mnu_About.png }

	set position 0

	foreach tab $tabs command $cmds icon $icons {
		set full_path_icon [file normalize [file join $dir img Menu $icon]]
		GiDMenu::InsertOption "GiD+OpenSees" [list $tab] $position PRE $command "" $full_path_icon
		incr position
	}

	GiDMenu::UpdateMenus
}

proc roundUp { num } {

	set roundedNum [expr {round($num)}]

	if { $roundedNum>=$num} {
		return $roundedNum
	} else {
		return [expr {round($num+1)}]
	}
}

proc ConvertToMPa { Value Unit } {

	if {$Unit=="ksi"} {
		set Value [expr 6.89475*$Value]
		} elseif {$Unit=="psi"} {
		set Value [expr 0.00689475*$Value]
		} elseif {$Unit=="kPa" || $Unit=="kN/m^2"} {
		set Value [expr $Value/1000]
		} elseif {$Unit=="GPa"} {
		set Value [expr $Value*1000]
		} elseif {$Unit=="lbf/ft^2"} {
		set Value [expr 0.00004788025*$Value]
		} elseif {$Unit=="Pa" || $Unit=="N/m^2"} {
		set Value [expr $Value/1000000]
		} else {
		return $Value
	}
	return $Value
}

# This procedure is used in OpenSees.bas

proc LogFile {} {

return [join [list logFile \"[OpenSees::GetProjectName].log\"] ]

}
