
# Analysis procedures

proc ExecutePost {} {
# executes OpenSeesPost.exe from exe folder installed within OpenSees.gid inside GiD installation folder

	set param1 [OpenSees::GetProblemTypePath]
	regsub -all {\\} $param1 {/} param1
	set pos [string last /problemtypes $param1]
	set param1 [string range $param1 0 $pos-1]
	regsub -all {/} $param1 {\\} param1

	set param2 [OpenSees::GetProjectPath]
	regsub -all {/} $param2 {\\} param2

	set OutputStep [GiD_AccessValue get GenData Output_step_frequency]
	set OutputStep [lindex [split $OutputStep #] 0]

	set exe_folder [file join [OpenSees::GetProblemTypePath] "exe" ]
	cd "$exe_folder"

	# Run OpenSeesPost

	if {[GiD_AccessValue get GenData Use_HDF5_binary_output_format] == 0 } {

		exec {*}[auto_execok start] "OpenSeesPost.exe" "$param1" "$param2" "$OutputStep"

	} else {

		exec {*}[auto_execok start] "OpenSeesPost.exe" "$param1" "$param2" "$OutputStep" "/b"

	}

	UpdateInfoBar
	return ""
}

proc checkIfAnalysisFailed { line_data } {
# line_data: data from log file splitted in lines
	set success 1

	foreach line $line_data {

		if { $line == "Analysis FAILED" } {

			set success 0

		}
	}

	return $success
}

proc splitFileDataInLines { file } {

	set fp [open $file r]
	set file_data [read $fp]
	close $fp
	set line_data [split $file_data \n]

	return $line_data
}

proc CheckLogAndPost { projectDir projectName doPost only_post } {

	global ElapsedTime
	set ElapsedTime "interruption"

	set log_file [file join "$projectDir" "OpenSees" "$projectName.log" ]
	set nodes_disp_res_file [file join "$projectDir" "OpenSees" "Node_displacements.out"]

	set data [splitFileDataInLines $log_file]

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

	set nodes_res_file_size [file size $nodes_disp_res_file]

	set success [checkIfAnalysisFailed $data]
	set crashed 0

	if { $success && !$nodes_res_file_size } {
		set success 0
		set crashed 1
	}

	if { $success == 1 } {

		if { $doPost == 0 } {

			AnalysisInformationWindow "RunSuccess"

		} else {

			ExecutePost
			if { !$only_post } {

				AnalysisInformationWindow "RunSuccessPost"

			} else {

				AnalysisInformationWindow "PostSuccess"

			}
		}

	} else {

		if { $crashed } {

			AnalysisInformationWindow "RunCrashed"

			return ""
		}

		if { $doPost == 0 } {

			AnalysisInformationWindow "RunFailed"

		} else {

			ExecutePost
			if { !$only_post } {

				AnalysisInformationWindow "RunFailedPost"

			} else {

				AnalysisInformationWindow "PostFailed"

			}
		}
	}

	return ""
}

proc deleteFiles { files } {
	foreach run_file $files {
		if {[file exists $run_file]} {
			file delete -force -- $run_file
		}
	}
}

proc ResetAnalysis { confirm } {

	set GiDProjectDir [OpenSees::GetProjectPath]
	set GiDProjectName [OpenSees::GetProjectName]

	# clear analysis files

	set opensees_folder [file join "$GiDProjectDir" "OpenSees"]
	if {[file exists  $opensees_folder] } {
		file delete -force -- $opensees_folder; #delete OpenSees folder in project dir
	}

	# clear post-processor files

	set post_files [list [file join "$GiDProjectDir" "$GiDProjectName.post.res.ascii"] \
						 [file join "$GiDProjectDir" "$GiDProjectName.post.res"] \
						 [file join "$GiDProjectDir" "$GiDProjectName.post.png"] \
						 [file join "$GiDProjectDir" "$GiDProjectName.post.vv"] \
						 [file join "$GiDProjectDir" "$GiDProjectName.post.grf"] ]

	deleteFiles $post_files

	if { $confirm } {

		tk_dialog .gid.confirmMsg "Success" "All analysis results have been cleared" info 0 "  Ok  "

	}
	UpdateInfoBar
	return ""
}

# Analysis commands

proc Create_tcl_file { } {

	global GidProcWin

	set info [GiD_Info Project]
	set ProjectName [lindex $info 1]

	if { $ProjectName == "UNNAMED" } {

		tk_dialog .gid.errorMsg "Error" "Please save project before creating the .tcl file." error 0 "  Ok  "

	} else {

		GiD_Process Mescape Files Save; # save project before creating .tcl file
		file mkdir [file join [OpenSees::GetProjectPath] OpenSees]
		GiD_Process Mescape Files WriteForBAS "[OpenSees::GetProblemTypePath]/../OpenSees.gid/OpenSees.bas" "[OpenSees::GetProjectPath]/OpenSees/[OpenSees::GetProjectName].tcl"
	}

	UpdateInfoBar
	return ""
}

proc Open_tcl_file { } {

	set GiDProjectDir [OpenSees::GetProjectPath]
	set GiDProjectName [OpenSees::GetProjectName]

	set filename [file join $GiDProjectDir OpenSees "$GiDProjectName.tcl"]
	set fexists [file exist $filename]

	if { $fexists==1 } {

		exec {*}[auto_execok start] "" "$GiDProjectDir/OpenSees/$GiDProjectName.tcl" &
	}

	return ""
}

proc Create_and_open_tcl_file { } {

	Create_tcl_file

	Open_tcl_file

	return ""
}

proc Run_existing_tcl { doPost } {

	set GiDProjectDir [OpenSees::GetProjectPath]
	set GiDProjectName [OpenSees::GetProjectName]
	set OpenSeesPath [OpenSees::GetOpenSeesPath]
	global GidProcWin

	set tcl_file [file join "$GiDProjectDir" "OpenSees" "$GiDProjectName.tcl" ]
	set opensees_folder [file join "$GiDProjectDir" "OpenSees"]

	if {[file exists $tcl_file] } {

		GiD_Process Mescape Files Save

		cd $opensees_folder

		# run analysis

		exec {*}[auto_execok start] $OpenSeesPath $tcl_file

		if {[file exists "$GiDProjectName.log"] } {

			CheckLogAndPost $GiDProjectDir $GiDProjectName $doPost 0

		} else {

			AnalysisInformationWindow "NoRun"
		}

	} else {

		tk_dialog .gid.errorMsg "Error" "The .tcl file was not created." error 0 "  Ok  "

	}

	UpdateInfoBar
	return ""
}

proc Run_existing_tcl_and_postprocess { } {

	set true 1
	Run_existing_tcl $true

	return ""
}

proc Postprocess_only { } {

	set success 0

	set GiDProjectDir [OpenSees::GetProjectPath]
	set GiDProjectName [OpenSees::GetProjectName]
	set log_file [file join "$GiDProjectDir" "OpenSees" "$GiDProjectName.log" ]

	if {[file exists $log_file] } {

		CheckLogAndPost $GiDProjectDir $GiDProjectName 1 1

	} else {

		tk_dialog .gid.errorMsg "Error" "The analysis has not run yet." error 0 "  Ok  "

	}

	return ""
}

proc Create_tcl_run_analysis_and_postprocess { } {

	set mustRegenMesh [GiD_Info Project MustReMesh]; # 0 no, 1 yes

	if {$mustRegenMesh} {

		WantToRegenMeshMessage

	} else {

		set GiDProjectDir [OpenSees::GetProjectPath]
		set GiDProjectName [OpenSees::GetProjectName]
		set tcl_file [file join "$GiDProjectDir" "OpenSees" "$GiDProjectName.tcl" ]
		ResetAnalysis 0

		Create_tcl_file

		if {[file exists $tcl_file] } {

			# run and postprocess

			Run_existing_tcl_and_postprocess
		}

	}

	return ""
}

proc Open_log_file { } {

	set GiDProjectDir [OpenSees::GetProjectPath]
	set GiDProjectName [OpenSees::GetProjectName]

	set filename [file join $GiDProjectDir OpenSees "$GiDProjectName.log"]
	set fexists [file exist $filename]

	if { $fexists==1 } {

		exec {*}[auto_execok start] "" "$GiDProjectDir/OpenSees/$GiDProjectName.log" &
	}

	return ""
}

proc GoToPostProcess { } {

	GiD_Process Mescape Postprocess

	return ""
}

proc AnalysisInformationWindow { AnalResult } {

	global ElapsedTime

	if { [GidUtils::AreWindowsDisabled] } {
		return
	}

	set w .gid.win_info
	switch -- $AnalResult {

		"NoRun" {
			set response [tk_dialog $w "Analysis failed" "Analysis could not run !\n\nPlease check generated .tcl file and report any issues to https://github.com/rclab-auth/gidopensees/issues" error 0 "  Open .tcl file  " "  Close  " ]

			if { $response == 0 } {

				Open_tcl_file

			}
		}

		"RunFailed" {
			set response [tk_dialog $w "Analysis failed" "Analysis completed with ERRORS after $ElapsedTime.\n\nErrors were reported during analysis, please check generated .log file for more information." error 0 "  Open log file  " "  Close  " ]

			if { $response == 0 } {

				Open_log_file

			}
		}

		"RunFailedPost" {
			set response [tk_dialog $w "Analysis failed" "Analysis completed with ERRORS after $ElapsedTime.\n\nErrors were reported during analysis, please check generated .log file for more information." error 0 "Postprocess anyway" "Open log file" "Close" ]

			if { $response == 0 } {

				GoToPostProcess

			} elseif { $response == 1 } {

				Open_log_file

			}
		}

		"RunSuccess" {
			set response [tk_dialog $w "Analysis successful" "Analysis completed SUCCESSFULLY after $ElapsedTime." info 0 "  Open log file  " "  Close  " ]

			if { $response == 0 } {

				Open_log_file

			}
		}

		"RunSuccessPost" {
			set response [tk_dialog $w "Analysis successful" "Analysis completed SUCCESSFULLY after $ElapsedTime.\n\nContinue to postprocessing ?" info 0 "  Postprocess  " "  Open log file  " "  Close  " ]

			if { $response == 0 } {

				GoToPostProcess

			} elseif { $response == 1 } {

				Open_log_file

			}
		}

		"RunCrashed" {

			set response [tk_dialog $w "Analysis crashed" "Analysis has crashed.\n\nPlease check generated .log file for more information." error 0 "  Open log file  " "  Close  " ]

			if { $response == 0 } {

				Open_log_file

			}
		}

		"PostSuccess" {

			set response [tk_dialog $w "Translation completed" "Proceed to postprocess ?" info 0 "  Yes  " "  No  " ]

			if { $response == 0 } {

				GoToPostProcess

			}
		}

		"PostFailed" {

			set response [tk_dialog $w "Analysis has been completed with ERRORS.\n\nPlease check generated .log file for more information." info 0 " Postprocess anyway " " Open log file " " Close " ]

			if { $response == 0 } {

				GoToPostProcess

			} elseif { $response == 1 } {

				Open_log_file

			}
		}

		default {

			return ""

		}
	}
}

proc WantToRegenMeshMessage { } {

	set response [tk_dialog .gid.errorMsg "Model changed" "Model has changed without mesh updating.\nDo you want to regenerate the mesh ?" error 0 "  Yes  " "  No  " ]

	if { $response == 0 } {

			GiD_Process Mescape Meshing generate

		}
}

# Analysis menu options

proc Opt1_dialog { } {

	set w .gid.warn1
	set mustRegenMesh [GiD_Info Project MustReMesh]; # 0 no, 1 yes

	if {$mustRegenMesh} {

		WantToRegenMeshMessage

	} else {

		OpenSees::SetProjectNameAndPath
		set GiDProjectDir [OpenSees::GetProjectPath]
		set GiDProjectName [OpenSees::GetProjectName]

		set file "$GiDProjectDir/OpenSees/$GiDProjectName.tcl"
		set fexists [file exist $file]

		if { $fexists == 1 } {

			set response [tk_dialog $w "Warning" "Creating the .tcl file and running the analysis will overwrite any user modifications and delete any existing results.\n\nDo you want to continue ?" warning 0 "  Yes  " "  No  " ]

			if { $response == 0 } {

				Create_tcl_run_analysis_and_postprocess

			}
		} else {

			Create_tcl_run_analysis_and_postprocess
		}
	}

	return ""
}

proc Opt2_dialog { } {

	set w .gid.warn2
	set mustRegenMesh [GiD_Info Project MustReMesh]; # 0 no, 1 yes

	if {$mustRegenMesh} {

		WantToRegenMeshMessage

	} else {

		OpenSees::SetProjectNameAndPath
		set GiDProjectDir [OpenSees::GetProjectPath]
		set GiDProjectName [OpenSees::GetProjectName]

		set file "$GiDProjectDir/OpenSees/$GiDProjectName.tcl"
		set fexists [file exist $file]

		if { $fexists == 1 } {

			set response [tk_dialog $w "Warning" "Creating the .tcl file will overwrite any user modifications.\n\nDo you want to continue ?" warning 0 "  Yes  " "  No  " ]

			if { $response == 0 } {

				Create_tcl_file

				set fexists [file exist $file]
				if { $fexists == 1 } {

					tk_dialog $w "Success" "The .tcl file was created" info 0 "  Ok  "
				}

			}
		} else {

			Create_tcl_file

			set fexists [file exist $file]
			if { $fexists == 1 } {

				tk_dialog $w "Success" "The .tcl file was created" info 0 "  Ok  "
			}

		}
	}

	return ""
}

proc Opt3_dialog { } {

	set w .gid.warn3
	set mustRegenMesh [GiD_Info Project MustReMesh]; # 0 no, 1 yes

	if {$mustRegenMesh} {

		WantToRegenMeshMessage

	} else {

		OpenSees::SetProjectNameAndPath
		set GiDProjectDir [OpenSees::GetProjectPath]
		set GiDProjectName [OpenSees::GetProjectName]

		set file "$GiDProjectDir/OpenSees/$GiDProjectName.tcl"
		set fexists [file exist $file]

		if { $fexists == 1 } {

			set response [tk_dialog $w "Warning" "Creating the .tcl file will overwrite any user modifications.\n\nDo you want to continue ?" warning 0 "  Yes  " "  No  " ]

			if { $response == 0 } {

				Create_and_open_tcl_file

			}
		} else {

			Create_and_open_tcl_file
		}
	}

	return ""
}

proc Opt4_dialog { } {

	OpenSees::SetProjectNameAndPath
	set GiDProjectDir [OpenSees::GetProjectPath]
	set GiDProjectName [OpenSees::GetProjectName]

	set log_file "$GiDProjectDir/OpenSees/$GiDProjectName.log"
	set fexists [file exist $log_file]
	set w .gid.warn4
	set false 0

	if { $fexists == 1 } {

		set response [tk_dialog $w "Warning" "Running the analysis will delete any existing results.\n\nDo you want to continue ?" warning 0 "  Yes  " "  No  " ]

		if { $response == 0 } {

			Run_existing_tcl $false

		}

	} else {

		Run_existing_tcl $false
	}

	return ""
}

proc Opt5_dialog { } {

	Postprocess_only

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

		set response [tk_dialog $w "Warning" "Running the analysis will delete any existing results.\n\nDo you want to continue ?" warning 0 "  Yes  " "  No  " ]

		if { $response == 0 } {

			Run_existing_tcl_and_postprocess

		}
	} else {

		Run_existing_tcl_and_postprocess
	}

	return ""
}

proc Opt7_dialog { } {

	OpenSees::SetProjectNameAndPath
	set GiDProjectDir [OpenSees::GetProjectPath]
	set GiDProjectName [OpenSees::GetProjectName]

	set tcl_file [file join "$GiDProjectDir" "OpenSees" "$GiDProjectName.tcl"]
	set post_file [file join "$GiDProjectDir" "$GiDProjectName.post.res"]
	set fexists1 [file exist $tcl_file]
	set fexists2 [file exist $post_file]
	set w .gid.warn6

	if { ($fexists1 == 1) || ($fexists2 == 1) } {

		set response [tk_dialog $w "Warning" "Resetting the analysis will delete any existing .tcl file and corresponding results.\n\nDo you want to continue ?" warning 0 "  Yes  " "  No  " ]

		if { $response == 0 } {

			ResetAnalysis 1
		}
	}

	return ""
}

# Various menu options

proc executeImportExe { tcl_file project_dir units_system } {
	# arguments : file, project dir, units system, flags..
	# flags to include : Geometry, Restraints, Constraints, Loads, Materials, Sections, Elements

	set imp_geom 1
	set imp_rest [GiD_AccessValue get GenData Restraints]
	set imp_cons [GiD_AccessValue get GenData Constraints]
	set imp_load [GiD_AccessValue get GenData Loads]
	set imp_mat  [GiD_AccessValue get GenData Materials]
	set imp_sec  [GiD_AccessValue get GenData Sections]
	set imp_elem [GiD_AccessValue get GenData Elements]
	set imp_intv_data [GiD_AccessValue get GenData Interval_settings]

	exec {*}[auto_execok start] "TclToGiD.exe" \
								"$tcl_file" \
								"$project_dir" \
								"$units_system" \
								$imp_geom \
								$imp_rest \
								$imp_cons \
								$imp_load \
								$imp_mat \
								$imp_sec \
								$imp_elem \
								$imp_intv_data
}

proc Import_tcl_dialog { } {

	set types {
		{{OpenSees .tcl files} {.tcl}}
		{{All Files} *}
	}

	set OpenSeesProblemTypePath [OpenSees::GetProblemTypePath]
	set GiDProjectDir [OpenSees::GetProjectPath]
	set tcl [tk_getOpenFile -filetypes $types]
	regsub -all {/} $tcl {\\} tcl

	set exe_folder [file join "$OpenSeesProblemTypePath" "exe"]

	if {$tcl ne ""} {

		cd $exe_folder

		set units_system [GiD_Units get system]

		executeImportExe $tcl $GiDProjectDir $units_system; # execute TclToGiD.exe

		set bch [file root $tcl]
		append bch ".bch"

		if {[file exists $bch] } {
			# read batch

			GiD_Process Mescape Files BatchFile $bch

			file delete -force -- $bch

			GiD_Process 'Zoom Frame

			tk_dialog .gid.msgImpSuccess "Import finished" "Geometry was successfully imported from $tcl." info 0 "  Ok  "

		} else {

			tk_dialog .gid.msgImpFailed "Import failed" "Could not import model geometry.\n\nPlease report your model to GitHub issues.\n(https://github.com/rclab-auth/gidopensees/issues)" error 0 "  Ok  "

		}
	}

	return ""
}

proc mnu_open_tcl { } {

	set GiDProjectDir [OpenSees::GetProjectPath]
	set GiDProjectName [OpenSees::GetProjectName]
	set OpenSeesPath [OpenSees::GetOpenSeesPath]
	set tcl_file [file join "$GiDProjectDir" "OpenSees" "$GiDProjectName.tcl"]

	if {[file exists $tcl_file]} {

		exec {*}[auto_execok start] "" $tcl_file &

	} else {

		tk_dialog .gid.infoMsg "Error" "The .tcl file was not created." error 0 "  Ok  "
	}

	UpdateInfoBar
	return ""
}

proc mnu_open_log { } {

	set GiDProjectDir [OpenSees::GetProjectPath]
	set GiDProjectName [OpenSees::GetProjectName]
	set OpenSeesPath [OpenSees::GetOpenSeesPath]
	set log_file [file join "$GiDProjectDir" "OpenSees" "$GiDProjectName.log"]

	if {[file exists $log_file]} {

		exec {*}[auto_execok start] "" $log_file &

	} else {

		tk_dialog .gid.infoMsg "Error" "The .log file was not created." error 0 "  Ok  "
	}

	UpdateInfoBar
	return ""
}

proc mnu_open_analysis_folder { } {

	set GiDProjectDir [OpenSees::GetProjectPath]
	set GiDProjectName [OpenSees::GetProjectName]
	set OpenSeesPath [OpenSees::GetOpenSeesPath]
	set tcl_file [file join "$GiDProjectDir" "OpenSees" "$GiDProjectName.tcl"]

	if {[file exists $tcl_file]} {

		exec {*}[auto_execok start] "" $GiDProjectDir &

	} else {

		tk_dialog .gid.infoMsg "Error" "The analysis folder was not created." error 0 "  Ok  "
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
	set exe_folder [file join "$OpenSeesProblemTypePath" "exe"]
	set update_exe "CheckForUpdate.exe"

	cd $exe_folder

	if { [file exists $update_exe] } {

		exec {*}[auto_execok start] $update_exe &
	} else {

		tk_dialog .gid.errorMsg "Error" "The update executable was not found." error  "  Ok  "
	}
}

proc openPdfFile { pdf_file } {
	if { [file exists $pdf_file] } {

		exec {*}[auto_execok start] $pdf_file &
	} else {

		tk_dialog .gid.errorMsg "Error" "The .pdf file was not found." error  "  Ok  "
	}
}

proc OpenGiD+OpenSeesPDF {} {

	set OpenSeesProblemTypePath [OpenSees::GetProblemTypePath]
	set doc_folder [file join "$OpenSeesProblemTypePath" "doc"]
	set pdf_file "GiD+OpenSees_Interface_User_Manual.pdf"

	cd $doc_folder
	openPdfFile $pdf_file
}

proc OpenDesignSafePDF {} {

	set OpenSeesProblemTypePath [OpenSees::GetProblemTypePath]
	set doc_folder [file join "$OpenSeesProblemTypePath" "doc"]
	set pdf_file "DesignSafe_User_Manual.pdf"

	cd $doc_folder
	openPdfFile $pdf_file
}

# Create GiD+OpenSees menu

proc OpenSees_Menu { dir } {

	# Delete the GiD calculate menu - Analysis process is executed through the corresponding button from the OpenSees toolbar

	GiDMenu::Delete "Calculate" PRE

	# Create the Menu named GiD+OpenSees in PRE processing

	GiDMenu::Create "GiD+OpenSees" PRE -1

	# Tab labels

	set tabs [list \
	[= "Import .tcl"] \
	"---" \
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
	[= "Open .tcl file"] \
	[= "Open .log file"] \
	[= "Open analysis folder"] \
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
	[= "Donate"] \
	[= "About"] ]

	# Selection commands

	set cmds { \
	{Import_tcl_dialog} \
	{} \
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
	{mnu_open_tcl} \
	{mnu_open_log} \
	{mnu_open_analysis_folder} \
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
	{VisitWeb "https://tinyurl.com/yyjqplgp"} \
	{AboutOpenSeesProbType} }

	# Tab icons

	set icons { \
	mnu_Import.png \
	"" \
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
	mnu_Open.png \
	mnu_Open.png \
	mnu_Open.png \
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
	mnu_Donate.png \
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

	set ret_val $Value

	if {$Unit == "ksi"} {
		set ret_val [expr 6.89475*$Value]
	} elseif {$Unit == "psi"} {
		set ret_val [expr 0.00689475*$Value]
	} elseif {$Unit == "kPa" || $Unit == "kN/m^2"} {
		set ret_val [expr $Value/1000]
	} elseif {$Unit == "GPa"} {
		set ret_val [expr $Value*1000]
	} elseif {$Unit == "lbf/ft^2"} {
		set ret_val [expr 0.00004788025*$Value]
	} elseif {$Unit=="Pa" || $Unit=="N/m^2"} {
		set ret_val [expr $Value/1000000]
	}

	return $ret_val
}

# This procedure is used in OpenSees.bas

proc LogFile {} {

	return [join [list logFile \"[OpenSees::GetProjectName].log\"] ]

}
