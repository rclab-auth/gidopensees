# Create GiDProjectDir variable

proc LoadProjectDirPath { filename } {

	set ProjectName 0

	# GiD_Info Project returns a list with project information { ProblemType ModelName .. .. .. }

	set lines [GiD_Info Project]
	set ProblemType [lindex $lines 0]
	set ProjectName [lindex $lines 1]

	if { $ProjectName == "UNNAMED" } {
		set ProjectName $filename
	}

	regsub -all {\\} $ProjectName {/} ProjectName

	if { [file extension $ProjectName] == ".gid" } {
		set ProjectName [file root $ProjectName]
	}

	set pos [string last / $ProjectName]

	global GiDProjectDir
	global GiDProjectName

	# returns the characters between two points in the string

	set GiDProjectName [string range $ProjectName $pos+1 $pos+100]
	set GiDProjectDir [string range $ProjectName 0 $pos-1]

	append GiDProjectDir "/$GiDProjectName.gid"
}

# This procedure is called only once, when Problem type is loaded from InitGIDProject

proc LoadOpenSeesPath { } {

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

# Analysis procedures

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

proc Create_tcl_file {w} {

	destroy $w

	GiD_Process Mescape Files Save

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

	GiD_Process Mescape Files Save

	global GiDProjectDir GiDProjectName GidProcWin OpenSeesPath

	if {[file exists "$GiDProjectDir/OpenSees/$GiDProjectName.tcl"] } {

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

proc ExecutePost {} {

	global GiDProjectDir GiDProjectName OpenSeesProblemDir

	set temp $GiDProjectDir
	regsub -all {/} $temp {\\} temp
	cd "$OpenSeesProblemDir/exe"
	exec {*}[auto_execok start] "OpenSeesPost.exe" "$temp"
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

# Post analysis dialogs

proc OpenLogFile {w} {

	destroy $w

	LoadProjectDirPath { "" }

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
	LoadProjectDirPath { "" }

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
	LoadProjectDirPath { "" }

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
	LoadProjectDirPath { "" }

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
	LoadProjectDirPath { "" }

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

	global GiDProjectDir
	LoadProjectDirPath { "" }

	set file "$GiDProjectDir/OpenSees"
	set fexists [file exist $file]
	set w .gid.warn5

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

proc Opt6_dialog { } {

	global GiDProjectDir
	LoadProjectDirPath { "" }

	set w .gid.warn6

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

	set tabs [list  [= "Create .tcl, run analysis and postprocess"] [= "Create .tcl only"] [= "Create and view .tcl only"] [= "Run analysis only"] [= "Run analysis only and postprocess"] [= "Reset analysis"] "---" [= "Go to GiD+OpenSees Site"] [= "Go to OpenSees Wiki"] [= "About"] ]

	# Selection commands

	set cmds { {Opt1_dialog} {Opt2_dialog} {Opt3_dialog} {Opt4_dialog} {Opt5_dialog} {Opt6_dialog} {} {VisitWeb "http://gidopensees.rclab.civil.auth.gr"} \
	{VisitWeb "http://opensees.berkeley.edu/wiki/index.php/Main_Page"} {AboutOpenSeesProbType} }

	# Tab icons

	set icons {mnu_Analysis.png mnu_TCL.png mnu_TCL.png mnu_TCL_Analysis.png mnu_TCL_Analysis.png mnu_Reset.png "" mnu_Site.png mnu_Wiki.png mnu_About.png}

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

proc ModelessDialog {w title text bitmap default args} {

	global tcl_platform
	variable ::tk::Priv

	# Check that $default was properly given

	if {[string is integer -strict $default]} {
		if {$default >= [llength $args]} {
			return -code error "default button index greater than number of\
			buttons specified for tk_dialog"
		}
	} elseif {"" eq $default} {
		set default -1
	} else {
		set default [lsearch -exact $args $default]
	}

	set windowingsystem [tk windowingsystem]

	if {$windowingsystem eq "aqua"} {
		option add *Dialog*background systemDialogBackgroundActive widgetDefault
		option add *Dialog*Button.highlightBackground \
		systemDialogBackgroundActive widgetDefault
	}

	# 1. Create the top-level window and divide it into top
	# and bottom parts.

	destroy $w
	toplevel $w -class Dialog
	wm title $w $title
	wm iconname $w Dialog
	wm protocol $w WM_DELETE_WINDOW { }

	# Dialog boxes should be transient with respect to their parent,
	# so that they will always stay on top of their parent window.  However,
	# some window managers will create the window as withdrawn if the parent
	# window is withdrawn or iconified.  Combined with the grab we put on the
	# window, this can hang the entire application.  Therefore we only make
	# the dialog transient if the parent is viewable.

	if {[winfo viewable [winfo toplevel [winfo parent $w]]] } {
		wm transient $w [winfo toplevel [winfo parent $w]]
	}

	if {$windowingsystem eq "aqua"} {
		::tk::unsupported::MacWindowStyle style $w moveableModal {}
	} elseif {$windowingsystem eq "x11"} {
		wm attributes $w -type dialog
	}

	frame $w.bot
	frame $w.top

	if {$windowingsystem eq "x11"} {
		$w.bot configure -relief raised -bd 1
		$w.top configure -relief raised -bd 1
	}

	pack $w.bot -side bottom -fill both
	pack $w.top -side top -fill both -expand 1
	grid anchor $w.bot center

	# 2. Fill the top part with bitmap and message (use the option
	# database for -wraplength and -font so that they can be
	# overridden by the caller).

	option add *Dialog.msg.wrapLength 3i widgetDefault
	option add *Dialog.msg.font TkCaptionFont widgetDefault

	label $w.msg -justify left -text $text
	pack $w.msg -in $w.top -side right -expand 1 -fill both -padx 3m -pady 3m
	if {$bitmap ne ""} {
	if {$windowingsystem eq "aqua" && $bitmap eq "error"} {
		set bitmap "stop"
	}
	label $w.bitmap -bitmap $bitmap
	pack $w.bitmap -in $w.top -side left -padx 3m -pady 3m
	}

	# 3. Create a row of buttons at the bottom of the dialog.

	set i 0

	foreach but $args {

		button $w.button$i -text $but -command [list set ::tk::Priv(button) $i]

		if {$i == $default} {
			$w.button$i configure -default active
		} else {
			$w.button$i configure -default normal
		}
		grid $w.button$i -in $w.bot -column $i -row 0 -sticky ew \
			-padx 10 -pady 4
		grid columnconfigure $w.bot $i

		# We boost the size of some Mac buttons for l&f

		if {$windowingsystem eq "aqua"} {
			set tmp [string tolower $but]
			if {$tmp eq "ok" || $tmp eq "cancel"} {
				grid columnconfigure $w.bot $i -minsize 90
			}
			grid configure $w.button$i -pady 7
		}

		incr i
	}

	# 4. Create a binding for <Return> on the dialog if there is a
	# default button.
	# Convention also dictates that if the keyboard focus moves among the
	# the buttons that the <Return> binding affects the button with the focus.

	if {$default >= 0} {

		bind $w <Return> [list $w.button$default invoke]
		}

	bind $w <<PrevWindow>> [list bind $w <Return> {[tk_focusPrev %W] invoke}]
	bind $w <Tab> [list bind $w <Return> {[tk_focusNext %W] invoke}]

	# 5. Create a <Destroy> binding for the window that sets the
	# button variable to -1;  this is needed in case something happens
	# that destroys the window, such as its parent window being destroyed.

	bind $w <Destroy> {set ::tk::Priv(button) -1}

	# 6. Withdraw the window, then update all the geometry information
	# so we know how big it wants to be, then center the window in the
	# display (Motif style) and de-iconify it.

	#::tk::PlaceWindow $w
	#tkwait visibility $w

	# 7. Set a grab and claim the focus too.

	#if {$default >= 0} {
	#   set focus $w.button$default
	#} else {
	#	set focus $w
	#}
	#tk::SetFocusGrab $w $focus

	# 8. Wait for the user to respond, then restore the focus and
	# return the index of the selected button.  Restore the focus
	# before deleting the window, since otherwise the window manager
	# may take the focus away so we can't redirect it.  Finally,
	# restore any grab that was in effect.

	#vwait ::tk::Priv(button)

	#catch {
	# It's possible that the window has already been destroyed,
	# hence this "catch".  Delete the Destroy handler so that
	# Priv(button) doesn't get reset by it.

	#bind $w <Destroy> {}
	#}
	#tk::RestoreFocusGrab $w $focus
	#return $Priv(button)
}