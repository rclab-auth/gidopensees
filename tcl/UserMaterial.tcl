namespace eval UserMaterial {
	variable script
	variable scriptParent
}

set ::UserMaterialVisited 0

proc UserMaterial::Script { event args } {

	variable script
	variable scriptParent

	switch $event {

		INIT {
				global UserMaterialVisited
				set UserMaterialVisited 1
				set data [GiD_Info Project]
				set ProjectName [lindex $data 1]

				set PARENT [lindex $args 0]
				upvar [lindex $args 1] ROW
				set GDN [lindex $args 2]
				set STRUCT [lindex $args 3]
				set QUESTION [lindex $args 4]
				set childrenwidgets [winfo children $PARENT]

				set MaterialName [lindex [split $STRUCT {,}] 1]
				set scriptParent($MaterialName) $PARENT

				OpenSees::SetProjectNameAndPath
				set GiDProjectDir [OpenSees::GetProjectPath]

					if { $ProjectName != "UNNAMED" } {

						set filename [UserMaterial::GetScriptName $MaterialName]
						set filepath [file join $GiDProjectDir Scripts $filename]
						set fexist [file exists $filepath]

						if { $fexist } {

							set fp [open $filepath r]
							set text [read $fp]
							set ok [UserMaterial::SetScript $MaterialName $text]; # initializing

							close $fp

						} else {

							set eexists [winfo exists $PARENT.e2]

							if {$eexists} {
								set text [$PARENT.$2 get]; # if exists
							} else {
								set text ""
							}

							set ok [UserMaterial::SetScript $MaterialName $text]; # initializing

						}

					} else {

						set eexists [winfo exists $PARENT.e2]

						if {$eexists} {
							set text [$PARENT.e2 get]; # if exists
						} else {
							set text ""
						}

						if {![info exists UserMaterial::script($MaterialName)]} {

							set ok [UserMaterial::SetScript $MaterialName $text]

						}
					}

					set MatNum [expr [lsearch [GiD_Info materials] $MaterialName]+1]

					set label [label $PARENT.info -text [= "\n\nEnter the material script to be inserted in the .tcl file. Use \x24MatTag in script for material number.\n\n"] ]
					grid $label -column 1 -row [expr $ROW] -sticky nw
					grid [text $PARENT.userscript$MaterialName -width 100 -height 16 -font {Calibri -12} ] -column 1 -row [expr $ROW+1]
					$PARENT.userscript$MaterialName delete 1.0 end
					$PARENT.userscript$MaterialName insert 1.0 "$script($MaterialName)"
		}

		SYNC {
				global UserMaterialVisited
				set GDN [lindex $args 0]
				set STRUCT [lindex $args 1]
				set QUESTION [lindex $args 2]

				set MaterialName [lindex [split $STRUCT {,}] 1]

				if {$UserMaterialVisited} {

					set ok [UserMaterial::SetScript $MaterialName ["$scriptParent($MaterialName).userscript$MaterialName" get 1.0 end] ]
					set ok [UserMaterial::SaveScriptFile $MaterialName]

				}
		}

	}
}

proc UserMaterial::SetScript { Material text } {
	variable script

	set script($Material) $text
	return ""
}

proc UserMaterial::SaveScriptFile { Material } {

	variable script

	set data [GiD_Info Project]
	set ProjectName [lindex $data 1]

	OpenSees::SetProjectNameAndPath

	set GiDProjectDir [OpenSees::GetProjectPath]

	set script($Material) [string trim $script($Material)]

	if { $ProjectName != "UNNAMED" } {

		set filename [UserMaterial::GetScriptName $Material]
		set folderpath [file join $GiDProjectDir Scripts]
		set filepath [file join $GiDProjectDir Scripts $filename]

		set fexists [file exists $filepath]
		set folderexists [file exists $folderpath]

		if {!$folderexists} {

			file mkdir $folderpath
		}

		if {$script($Material) != ""} {

			cd "$GiDProjectDir/Scripts"
			set fp [open $filepath w]
			puts $fp $script($Material)
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

proc UserMaterial::UserMaterialFileExists { MaterialName } {

	OpenSees::SetProjectNameAndPath

	set GiDProjectDir [OpenSees::GetProjectPath]

	set filename [UserMaterial::GetScriptName $MaterialName]
	set filepath [file join $GiDProjectDir Scripts $filename]
	set fexists [file exists $filepath]

	if {$fexists} {
		return 1
	}

	return 0
}

proc UserMaterial::GetScriptName { MaterialName } {

	set filename [string map {" " "_"} $MaterialName]
	append filename ".tcl"

	return $filename
}

proc UserMaterial::GetMaterialName { MaterialName } {

	return $MaterialName
}