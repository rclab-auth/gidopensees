# Analysis procedures

proc ExecutePost {} {

	set temp1 [OpenSees::GetGiDPath]
	regsub -all {/} $temp1 {\\} temp1
	set temp2 [OpenSees::GetProjectPath]
	regsub -all {/} $temp2 {\\} temp2

	set OutputStep [GiD_AccessValue get gendata Output_step_frequency]
	set OutputStep [lindex [split $OutputStep #] 0]

	set probDir [OpenSees::GetProblemTypePath]

	cd "$probDir/exe"

	# run OpenSeesPost

	if {[GiD_AccessValue get gendata use_binary_format] == 0 } {

		exec {*}[auto_execok start] "OpenSeesPost.exe" "$temp1" "$temp2" "$OutputStep"

	} else {

		exec {*}[auto_execok start] "OpenSeesPost.exe" "$temp1" "$temp2" "$OutputStep" "/b"

	}
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
}

proc ResetAnalysis {w} {

	destroy $w

	set GiDProjectDir [OpenSees::GetProjectPath]
	set GiDProjectName [OpenSees::GetProjectName]

	# clear analysis files

	if {[file exists "$GiDProjectDir/OpenSees"] } {
		file delete -force $GiDProjectDir/OpenSees
	}

	# clear postprocessor files

	if {[file exists "$GiDProjectDir/$GiDProjectName.post.res.ascii"]} {
		file delete -force "$GiDProjectDir/$GiDProjectName.res.post.ascii"
	}

	if {[file exists "$GiDProjectDir/$GiDProjectName.post.res"]} {
		file delete -force "$GiDProjectDir/$GiDProjectName.res"
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
}

# Analysis commands

proc Create_tcl_file {w} {

	destroy $w

	global GidProcWin

	set info [GiD_Info Project]
	set ProjectName [lindex $info 1]

	if { ![info exists GidProcWin(ww)] || \
		![winfo exists $GidProcWin(ww).listbox#1] } {
		set wbase .gid
		set ww ""
	} else {
		set wbase $GidProcWin(ww)
		set ww $GidProcWin(ww).listbox#1
	}

	if { $ProjectName == "UNNAMED" } {

		tk_dialogRAM $wbase.tmpwin [_ "Error"] [_ "Please save project before creating the .tcl file" ] error 0 [_ "Close"]

	} else {

		GiD_Process Mescape Files Save; # save project before creating .tcl file
		file mkdir [OpenSees::GetProjectPath]/OpenSees
		GiD_Process Mescape Files WriteForBAS "[OpenSees::GetProblemTypePath]/../OpenSees.gid/OpenSees.bas" "[OpenSees::GetProjectPath]/OpenSees/[OpenSees::GetProjectName].tcl"
	}

	return ""
}

proc Create_and_open_tcl_file {w} {

	destroy $w

	Create_tcl_file $w

	if {[file exists "[OpenSees::GetProjectPath]/OpenSees/[OpenSees::GetProjectName].tcl"] } {

		# open .tcl file

		exec {*}[auto_execok start] "" "[OpenSees::GetProjectPath]/OpenSees/[OpenSees::GetProjectName].tcl" &
	}

	return ""
}

# This procedure is used in OpenSees.bas

proc LogFile {} {

return [join [list logFile \"[OpenSees::GetProjectName].log\"] ]

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

	return ""
}

proc Run_existing_tcl_and_postprocess {w} {

	destroy $w

	set true 1
	Run_existing_tcl $w $true

	return ""
}

proc Postprocess {} {

	set GiDProjectDir [OpenSees::GetProjectPath]
	set GiDProjectName [OpenSees::GetProjectName]

	if {[file exists "$GiDProjectDir/OpenSees/$GiDProjectName.log"] } {

			CheckLogAndPost $GiDProjectDir $GiDProjectName 1

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

# Analysis dialogs

proc OpenLogFile {w} {

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

proc AnalysisInformationWindow { analResult } {

	if { [GidUtils::AreWindowsDisabled] } {
		return
	}

	switch $analResult {

		"NoRun" {
				set w .gid.win_example
				InitWindow $w [= "Analysis failed"] ErrorInfo "" "" 1
				if { ![winfo exists $w] } return ; # windows disabled || usemorewindows == 0
				ttk::frame $w.top
				ttk::label $w.top.title_text -text [= ""]
				ttk::frame $w.information -relief raised
				ttk::label $w.information.errormessage -text [= "\tAnalysis could not run !\n\n\tPlease check generated .tcl file and report any issues to https://github.com/rclab-auth/gidopensees/issues\t"]
				ttk::frame $w.bottom
				ttk::button $w.bottom.close -text [= "Close"] -command "destroy $w"
				grid $w.top.title_text -sticky ew
				grid $w.top -sticky new
				grid $w.information.errormessage -sticky w -padx 6 -pady 6
				grid $w.information -sticky nsew
				grid $w.bottom.close -padx 6
				grid $w.bottom -sticky sew -padx 6 -pady 6
				if { $::tcl_version >= 8.5 } { grid anchor $w.bottom center }
				grid rowconfigure $w 1 -weight 1
				grid columnconfigure $w 0 -weight 1
		}

		"RunFailed" {
				set w .gid.win_example
				InitWindow $w [= "Analysis failed"] ErrorInfo "" "" 1
				if { ![winfo exists $w] } return ; # windows disabled || usemorewindows == 0
				ttk::frame $w.top
				ttk::label $w.top.title_text -text [= ""]
				ttk::frame $w.information -relief raised
				ttk::label $w.information.errormessage -text [= "\tAnalysis run with errors !\n\n\tErrors were reported during analysis, please check generated .log file for more information.\t"]
				ttk::frame $w.bottom
				ttk::button $w.bottom.openlog -text [= "Open Log file"] -command "OpenLogFile $w"
				ttk::button $w.bottom.close -text [= "Close"] -command "destroy $w"
				grid $w.top.title_text -sticky ew
				grid $w.top -sticky new
				grid $w.information.errormessage -sticky w -padx 6 -pady 6
				grid $w.information -sticky nsew
				grid $w.bottom.openlog $w.bottom.close -padx 6
				grid $w.bottom -sticky sew -padx 6 -pady 6
				if { $::tcl_version >= 8.5 } { grid anchor $w.bottom center }
				grid rowconfigure $w 1 -weight 1
				grid columnconfigure $w 0 -weight 1
		}

		"RunFailedPost" {
				set w .gid.win_example
				InitWindow $w [= "Analysis failed"] ErrorInfo "" "" 1
				if { ![winfo exists $w] } return ; # windows disabled || usemorewindows == 0
				ttk::frame $w.top
				ttk::label $w.top.title_text -text [= ""]
				ttk::frame $w.information -relief raised
				ttk::label $w.information.errormessage -text [= "\tAnalysis run with errors !\n\n\tErrors were reported during analysis, please check generated .log file for more information.\t"]
				ttk::frame $w.bottom
				ttk::button $w.bottom.openlog -text [= "Open Log file"] -command "OpenLogFile $w"
				ttk::button $w.bottom.close -text [= "Close"] -command "destroy $w"
				ttk::button $w.bottom.ignore -text [= "Ignore"] -command "GoToPostProcess $w"
				grid $w.top.title_text -sticky ew
				grid $w.top -sticky new
				grid $w.information.errormessage -sticky w -padx 6 -pady 6
				grid $w.information -sticky nsew
				grid $w.bottom.openlog $w.bottom.ignore $w.bottom.close -padx 6
				grid $w.bottom -sticky sew -padx 6 -pady 6
				if { $::tcl_version >= 8.5 } { grid anchor $w.bottom center }
				grid rowconfigure $w 1 -weight 1
				grid columnconfigure $w 0 -weight 1
		}

		"RunSuccess" {
				global ElapsedTime
				set w .gid.win_example
				InitWindow $w [= "Analysis successful"] ErrorInfo "" "" 1
				if { ![winfo exists $w] } return ;# windows disabled || usemorewindows == 0
				ttk::frame $w.top
				ttk::label $w.top.title_text -text [= ""]
				ttk::frame $w.information -relief raised
				ttk::label $w.information.errormessage -text [= "\tAnalysis completed successfully after $ElapsedTime\t"]
				ttk::frame $w.bottom
				ttk::button $w.bottom.close -text [= "Close"] -command "destroy $w"
				grid $w.top.title_text -sticky ew
				grid $w.top -sticky new
				grid $w.information.errormessage -sticky w -padx 6 -pady 6
				grid $w.information -sticky nsew
				grid $w.bottom.close -padx 6
				grid $w.bottom -sticky sew -padx 6 -pady 6
				if { $::tcl_version >= 8.5 } { grid anchor $w.bottom center }
				grid rowconfigure $w 1 -weight 1
				grid columnconfigure $w 0 -weight 1
		}

		"RunSuccessPost" {
				global ElapsedTime
				set w .gid.win_example
				InitWindow $w [= "Analysis successful"] ErrorInfo "" "" 1
				if { ![winfo exists $w] } return ;# windows disabled || usemorewindows == 0
				ttk::frame $w.top
				ttk::label $w.top.title_text -text [= ""]
				ttk::frame $w.information -relief raised
				ttk::label $w.information.errormessage -text [= "\tAnalysis completed successfully after $ElapsedTime\t\n\n\tContinue to postprocessing ?"]
				ttk::frame $w.bottom
				ttk::button $w.bottom.post -text [= "Postprocess"] -command "GoToPostProcess $w"
				ttk::button $w.bottom.close -text [= "Close"] -command "destroy $w"
				grid $w.top.title_text -sticky ew
				grid $w.top -sticky new
				grid $w.information.errormessage -sticky w -padx 6 -pady 6
				grid $w.information -sticky nsew
				grid $w.bottom.post $w.bottom.close -padx 6
				grid $w.bottom -sticky sew -padx 6 -pady 6
				if { $::tcl_version >= 8.5 } { grid anchor $w.bottom center }
				grid rowconfigure $w 1 -weight 1
				grid columnconfigure $w 0 -weight 1
		}
	}
}

proc WantToRegenMeshMessage {} {

	set answer [tk_messageBox -parent .gid -message "Model has changed without mesh regeneration.\nDo you want to generate the mesh ?" -title "GiD+OpenSees" -type yesno -icon warning]

	switch -- $answer {

		yes {
			GiD_Process Mescape Meshing generate
		}
		no destroy
	}

}

# Pre analysis dialogs

proc Opt1_dialog { } {

	set mustRegenMesh [GiD_Info Project MustReMesh]; # 0 no, 1 yes

	if {$mustRegenMesh} {

		WantToRegenMeshMessage

	} else {

		OpenSees::SetProjectNameAndPath
		set GiDProjectDir [OpenSees::GetProjectPath]

		set file "$GiDProjectDir/OpenSees"
		set fexists [file exist $file]
		set w .gid.warn1

		if { $fexists == 1 } {

			InitWindow $w [= "Warning"] ErrorInfo "" "" 1
			if { ![winfo exists $w] } return ;# windows disabled || usemorewindows == 0
			ttk::frame $w.top
			ttk::label $w.top.title_text -text [= ""]
			ttk::frame $w.information -relief raised
			ttk::label $w.information.warningmessage -text [= "\tCreating the .tcl file and running the analysis will overwrite any user modifications and delete any existing results.\t\n\n\tDo you want to continue ?"]
			ttk::frame $w.bottom
			ttk::button $w.bottom.continue -text [= "Yes"] -command [= "Create_tcl_run_analysis_and_postprocess $w"]
			ttk::button $w.bottom.destroy -text [= "No"] -command "destroy $w"
			grid $w.top.title_text -sticky ew
			grid $w.top -sticky new
			grid $w.information.warningmessage -sticky w -padx 6 -pady 6
			grid $w.information -sticky nsew
			grid $w.bottom.continue $w.bottom.destroy -padx 6
			grid $w.bottom -sticky sew -padx 6 -pady 6
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

		set file "$GiDProjectDir/OpenSees"
		set fexists [file exist $file]
		set w .gid.warn2

		if { $fexists == 1 } {

			InitWindow $w [= "Warning"] ErrorInfo "" "" 1
			if { ![winfo exists $w] } return ;# windows disabled || usemorewindows == 0
			ttk::frame $w.top
			ttk::label $w.top.title_text -text [= ""]
			ttk::frame $w.information -relief raised
			ttk::label $w.information.warningmessage -text [= "\tCreating the .tcl file will overwrite any user modifications.\t\n\n\tDo you want to continue ?"]
			ttk::frame $w.bottom
			ttk::button $w.bottom.continue -text [= "Yes"] -command [= "Create_tcl_file $w"]
			ttk::button $w.bottom.destroy -text [= "No"] -command "destroy $w"
			grid $w.top.title_text -sticky ew
			grid $w.top -sticky new
			grid $w.information.warningmessage -sticky w -padx 6 -pady 6
			grid $w.information -sticky nsew
			grid $w.bottom.continue $w.bottom.destroy -padx 6
			grid $w.bottom -sticky sew -padx 6 -pady 6
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

		set file "$GiDProjectDir/OpenSees"
		set fexists [file exist $file]
		set w .gid.warn3

		if { $fexists == 1 } {

			InitWindow $w [= "Warning"] ErrorInfo "" "" 1
			if { ![winfo exists $w] } return ;# windows disabled || usemorewindows == 0
			ttk::frame $w.top
			ttk::label $w.top.title_text -text [= ""]
			ttk::frame $w.information -relief raised
			ttk::label $w.information.warningmessage -text [= "\tCreating the .tcl file will overwrite any user modifications.\t\n\n\tDo you want to continue ?"]
			ttk::frame $w.bottom
			ttk::button $w.bottom.continue -text [= "Yes"] -command [= "Create_and_open_tcl_file $w"]
			ttk::button $w.bottom.destroy -text [= "No"] -command "destroy $w"
			grid $w.top.title_text -sticky ew
			grid $w.top -sticky new
			grid $w.information.warningmessage -sticky w -padx 6 -pady 6
			grid $w.information -sticky nsew
			grid $w.bottom.continue $w.bottom.destroy -padx 6
			grid $w.bottom -sticky sew -padx 6 -pady 6
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

	set file "$GiDProjectDir/OpenSees"
	set fexists [file exist $file]
	set w .gid.warn4
	set false 0

	if { $fexists == 1 } {

		InitWindow $w [= "Warning"] ErrorInfo "" "" 1
		if { ![winfo exists $w] } return ;# windows disabled || usemorewindows == 0
		ttk::frame $w.top
		ttk::label $w.top.title_text -text [= ""]
		ttk::frame $w.information -relief raised
		ttk::label $w.information.warningmessage -text [= "\tRunning the analysis will delete any existing results.\t\n\n\tDo you want to continue ?"]
		ttk::frame $w.bottom
		ttk::button $w.bottom.continue -text [= "Yes"] -command [= "Run_existing_tcl $w $false"]
		ttk::button $w.bottom.destroy -text [= "No"] -command "destroy $w"
		grid $w.top.title_text -sticky ew
		grid $w.top -sticky new
		grid $w.information.warningmessage -sticky w -padx 6 -pady 6
		grid $w.information -sticky nsew
		grid $w.bottom.continue $w.bottom.destroy -padx 6
		grid $w.bottom -sticky sew -padx 6 -pady 6
		if { $::tcl_version >= 8.5 } { grid anchor $w.bottom center }
		grid rowconfigure $w 1 -weight 1
		grid columnconfigure $w 0 -weight 1

	} else {

		Run_existing_tcl $w $false
	}

	return ""
}

proc Opt5_dialog { } {

	OpenSees::SetProjectNameAndPath

	Postprocess

	return ""
}

proc Opt6_dialog { } {

	OpenSees::SetProjectNameAndPath
	set GiDProjectDir [OpenSees::GetProjectPath]

	set file "$GiDProjectDir/OpenSees"
	set fexists [file exist $file]
	set w .gid.warn6

	if { $fexists == 1 } {

		InitWindow $w [= "Warning"] ErrorInfo "" "" 1
		if { ![winfo exists $w] } return ;# windows disabled || usemorewindows == 0
		ttk::frame $w.top
		ttk::label $w.top.title_text -text [= ""]
		ttk::frame $w.information -relief raised
		ttk::label $w.information.warningmessage -text [= "\tRunning the analysis will delete any existing results.\t\n\n\tDo you want to continue ?"]
		ttk::frame $w.bottom
		ttk::button $w.bottom.continue -text [= "Yes"] -command [= "Run_existing_tcl_and_postprocess $w"]
		ttk::button $w.bottom.destroy -text [= "No"] -command "destroy $w"
		grid $w.top.title_text -sticky ew
		grid $w.top -sticky new
		grid $w.information.warningmessage -sticky w -padx 6 -pady 6
		grid $w.information -sticky nsew
		grid $w.bottom.continue $w.bottom.destroy -padx 6
		grid $w.bottom -sticky sew -padx 6 -pady 6
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

	set file "$GiDProjectDir/OpenSees"
	set fexists [file exist $file]
	set w .gid.warn6

	if { $fexists == 1 } {
		InitWindow $w [= "Warning"] ErrorInfo "" "" 1
		if { ![winfo exists $w] } return ;# windows disabled || usemorewindows == 0
		ttk::frame $w.top
		ttk::label $w.top.title_text -text [= ""]
		ttk::frame $w.information -relief raised
		ttk::label $w.information.warningmessage -text [= "\tResetting analysis will delete any existing .tcl files and results.\t\n\n\tDo you want to continue ?"]
		ttk::frame $w.bottom
		ttk::button $w.bottom.continue -text [= "Yes"] -command [= "ResetAnalysis $w"]
		ttk::button $w.bottom.destroy -text [= "No"] -command "destroy $w"
		grid $w.top.title_text -sticky ew
		grid $w.top -sticky new
		grid $w.information.warningmessage -sticky w -padx 6 -pady 6
		grid $w.information -sticky nsew
		grid $w.bottom.continue $w.bottom.destroy -padx 6
		grid $w.bottom -sticky sew -padx 6 -pady 6
		if { $::tcl_version >= 8.5 } { grid anchor $w.bottom center }
		grid rowconfigure $w 1 -weight 1
		grid columnconfigure $w 0 -weight 1
	}

	return ""
}

# About option in GiD+OpenSees Menu

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

	set tabs [list  \
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

	foreach tab $tabs command $cmds  icon $icons {
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
