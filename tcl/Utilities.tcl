# This procedure is called only once, when Problem type is loaded from InitGIDProject

proc GetOpenSeesPath { } {

	global OpenSeesPath GidProcWin OpenSeesProblemDir

	set file "$OpenSeesProblemDir/OpenSees.path"
	set fexists [file exist $file]
	if { $fexists == 1 } {
		set fp [open $file r]
		set file_data [read $fp]
		close $fp
		set data [split $file_data \n]
		set OpenSeesPath [lindex $data 0]
		regsub -all {\\} $OpenSeesPath {/} OpenSeesPath

	} else {
			if { ![info exists GidProcWin(w)] || \
				![winfo exists $GidProcWin(w).listbox#1] } {
				set wbase .gid
				set w ""
			} else {
				set wbase $GidProcWin(w)
				set w $GidProcWin(w).listbox#1
			}
			tk_dialogRAM $wbase.tmpwin [_ "Error"] [_ "OpenSees path was not found" ] error 0 [_ "Close"]
	}
}

# Get project directory path

proc GetProjectDirPath {} {

	set lines [GiD_Info Project]
	set ProblemType [lindex $lines 0]
	set ProjectName [lindex $lines 1]

	global GiDProjectDir
	global GiDProjectName

	# GiD_Info Project returns a list with project information { ProblemType ModelName .. .. .. }

	if { $ProjectName == "UNNAMED" } {

		set GiDProjectName "NONE"
		set GiDProjectDir "NONE"

	} else {

		regsub -all {\\} $ProjectName {/} ProjectName

		if { [file extension $ProjectName] == ".gid" } {
			set ProjectName [file root $ProjectName]
		}

		set pos [string last / $ProjectName]

		# returns the characters between two points in the string

		set GiDProjectName [string range $ProjectName $pos+1 $pos+100]
		set GiDProjectDir [string range $ProjectName 0 $pos-1]

		append GiDProjectDir "/$GiDProjectName.gid"
	}
}

# This procedure sets the GiD installation path

proc GetGiDPath { } {

	global GiDPath

	set temp [GiD_Info problemtypepath]

	regsub -all {\\} $temp {/} temp

	set pos [string last /problemtypes $temp]

	set GiDPath [string range $temp 0 $pos-1]
}

# Analysis procedures

proc ExecutePost {} {

	global GiDPath GiDProjectDir GiDProjectName OpenSeesProblemDir

	GetGiDPath

	set temp1 $GiDPath
	regsub -all {/} $temp1 {\\} temp1
	set temp2 $GiDProjectDir
	regsub -all {/} $temp2 {\\} temp2

	set OutputStep [GiD_AccessValue get gendata Output_step_frequency]
	set OutputStep [lindex [split $OutputStep #] 0]

	cd "$OpenSeesProblemDir/exe"
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

		AnalysisInformationWindow "RunFailed"
	}
}

proc ResetAnalysis {w} {

	destroy $w

	global GiDProjectDir GiDProjectName

	if {[file exists "$GiDProjectDir/OpenSees"] } {
		file delete -force $GiDProjectDir/OpenSees
	}

	if {[file exists "$GiDProjectDir/$GiDProjectName.post.res"] } {
		file delete -force "$GiDProjectDir/$GiDProjectName.post.res"
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

		GiD_Process Mescape Files Save
		global OpenSeesProblemDir GiDProjectDir GiDProjectName
		file mkdir $GiDProjectDir/OpenSees
		GiD_Process Mescape Files WriteForBAS "$OpenSeesProblemDir/../OpenSees.gid/OpenSees.bas" "$GiDProjectDir/OpenSees/$GiDProjectName.tcl"
	}

	return ""
}

proc Create_and_open_tcl_file {w} {

	destroy $w

	global GiDProjectDir GiDProjectName

	Create_tcl_file $w

	if {[file exists "$GiDProjectDir/OpenSees/$GiDProjectName.tcl"] } {

		exec {*}[auto_execok start] "" "$GiDProjectDir/OpenSees/$GiDProjectName.tcl"
	}

	return ""
}

proc Run_existing_tcl {w doPost} {

	destroy $w

	global GiDProjectDir GiDProjectName GidProcWin OpenSeesPath

	if {[file exists "$GiDProjectDir/OpenSees/$GiDProjectName.tcl"] } {

		GiD_Process Mescape Files Save

		cd "$GiDProjectDir/OpenSees"

		exec {*}[auto_execok start] "$OpenSeesPath" "$GiDProjectDir/OpenSees/$GiDProjectName.tcl"

		if {[file exists "log.txt"] } {

			file rename -force -- "log.txt" "$GiDProjectName.log"

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

	global GiDProjectDir GiDProjectName

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

	global GiDProjectDir GiDProjectName

	ResetAnalysis {w}

	Create_tcl_file $w

	if {[file exists "$GiDProjectDir/OpenSees/$GiDProjectName.tcl"] } {

		# run and postprocess

		Run_existing_tcl_and_postprocess $w
	}

	return ""
}

# Analysis dialogs

proc OpenLogFile {w} {

	destroy $w

	GetProjectDirPath

	global GiDProjectDir GiDProjectName
	set filename [file join $GiDProjectDir OpenSees "$GiDProjectName.log"]
	set fexists [file exist $filename]

	if { $fexists==1 } {
		exec {*}[auto_execok start] "" "$GiDProjectDir/OpenSees/$GiDProjectName.log"
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

# Pre analysis dialogs

proc Opt1_dialog { } {

	global GiDProjectDir

	GetProjectDirPath

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

	return ""
}

proc Opt2_dialog { } {

	global GiDProjectDir

	GetProjectDirPath

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

	return ""
}

proc Opt3_dialog { } {

	global GiDProjectDir

	GetProjectDirPath

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

	return ""
}

proc Opt4_dialog { } {

	global GiDProjectDir

	GetProjectDirPath

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

	Postprocess

	return ""
}

proc Opt6_dialog { } {

	global GiDProjectDir

	GetProjectDirPath

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

	global GiDProjectDir

	GetProjectDirPath

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
	Splash $splashdir
	set keepsplash 0
}

# Create GiD+OpenSees menu

proc OpenSees_Menu { dir } {

	# Create the Menu named GiD+OpenSees in PRE processing

	GiDMenu::Create "GiD+OpenSees" PRE -1

	# Tab labels

	set tabs [list  [= "Create .tcl, run analysis and postprocess"] "---" [= "Create .tcl only"] [= "Create and view .tcl only"] [= "Run analysis only"] [= "Postprocess only"] [= "Run analysis and postprocess"] "---" [= "Reset analysis"] "---" [= "Go to GiD+OpenSees Site"] [= "Go to OpenSees Wiki"] [= "About"] ]

	# Selection commands

	set cmds { {Opt1_dialog} {} {Opt2_dialog} {Opt3_dialog} {Opt4_dialog} {Opt5_dialog} {Opt6_dialog} {} {Opt7_dialog} {} {VisitWeb "http://gidopensees.rclab.civil.auth.gr"} \
	{VisitWeb "http://opensees.berkeley.edu/wiki/index.php/Main_Page"} {AboutOpenSeesProbType} }

	# Tab icons

	set icons {mnu_Analysis.png "" mnu_TCL.png mnu_TCL.png mnu_TCL_Analysis.png mnu_TCL_Analysis.png mnu_TCL_Analysis.png "" mnu_Reset.png "" mnu_Site.png mnu_Wiki.png mnu_About.png}

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

# Returns the project dimensions. Checking if there is any point outside the X-Y Plane. If so, the model is considered as 3D

proc ReturnProjectDimensions { } {
	set ndm 2
	foreach layername [GiD_Info layers] {
		foreach i [GiD_Info layers -entities points $layername] {
			set zcoord [lindex [GiD_Geometry get point $i] 3]
				if {$zcoord!=0} {
					set ndm 3
					break
				}
			}
		}
	return $ndm
}