namespace eval GenData {
	variable Description_text ""
	variable Description_Parent
}

proc GenData::Description { event args } {

	variable Description_text
	variable Description_Parent
	OpenSees::SetProjectNameAndPath
	set GiDProjectDir [OpenSees::GetProjectPath]
	set GiDProjectName [OpenSees::GetProjectName]

	switch $event {

		INIT {

			set data [GiD_Info Project]
			set ProjectName [lindex $data 1]

			if { $ProjectName != "UNNAMED" } {

				set filename [file join $GiDProjectDir "$GiDProjectName.txt"]
				set fexist [file exist $filename]
				set Description_text ""

				if { $fexist == 1 } {
					set fp [open $filename r]
					set Description_text [read $fp]
					close $fp
				}
			}

			set PARENT [lindex $args 0]
			set Description_Parent $PARENT
			upvar [lindex $args 1] ROW
			set GDN [lindex $args 2]
			set STRUCT [lindex $args 3]
			set QUESTION [lindex $args 4]
			grid [text $PARENT.description -width 70 -height 13 -font {Calibri -14} ] -column 1 -row [expr $ROW+1]
			$PARENT.description delete 1.0 end
			$PARENT.description insert 1.0 [string trim $Description_text]
			return ""
		}

		SYNC {

			set GDN [lindex $args 0]
			set STRUCT [lindex $args 1]
			set QUESTION [lindex $args 2]
			set Description_text [$Description_Parent.description get 1.0 end]

			if { [string trim $Description_text] != "" } {
				set ok [GenData::SaveDescriptionFile]

			} else {

				set filename [file join $GiDProjectDir "$GiDProjectName.txt"]
				set fexist [file exist $filename]

				if { $fexist == 1 } {
					file delete -force $filename
				}
			}
		}

		DEPEND {

			return ""
		}

		CLOSE {

			OpenSees_Menu [OpenSees::GetProblemTypePath] 0
			OpenSees::Toolbar2
			OpenSees::ChangeData
		}
	}

	return ""
}

proc GenData::SaveDescriptionFile { } {

	set data [GiD_Info Project]
	set ProjectName [lindex $data 1]
	OpenSees::SetProjectNameAndPath
	set GiDProjectDir [OpenSees::GetProjectPath]
	set GiDProjectName [OpenSees::GetProjectName]
	variable Description_text

	set Description_text [string trim $Description_text]

	if { $ProjectName != "UNNAMED" } {

		set file [file join $GiDProjectDir "$GiDProjectName.txt"]

		set fp [open $file w]
		puts $fp $Description_text
		close $fp
	}

	return ""
}

proc GenData::CalcRayleigh {event args} {

	switch $event {

		SYNC {

			set GDN [lindex $args 0]
			set STRUCT [lindex $args 1]
			set QUESTION [lindex $args 2]

			set calcRayleigh [DWLocalGetValue $GDN $STRUCT Calculate_Rayleigh_damping_coefficients_(Accept_to_apply)]

			if { $calcRayleigh } {

				set zeta [DWLocalGetValue $GDN $STRUCT Damping_ratio]
				set T1unit [DWLocalGetValue $GDN $STRUCT First_period]
				set T2unit [DWLocalGetValue $GDN $STRUCT Second_period]

				set temp [GidConvertValueUnit $T1unit]
				set temp [ParserNumberUnit $temp T1 dummy]

				set temp [GidConvertValueUnit $T2unit]
				set temp [ParserNumberUnit $temp T2 dummy]

				if {$T1 && $T2} {

					set pi 3.141592653589793238462643383279
					set omega1 [expr 2.0*$pi/$T1]
					set omega2 [expr 2.0*$pi/$T2]

					set a0 [expr $zeta*(2.0*$omega1*$omega2)/($omega1+$omega2)]
					set a1 [expr $zeta*2.0/($omega1+$omega2)]

					set SMatrix [DWLocalGetValue $GDN $STRUCT Stiffness_Matrix]

					TK_DWSet $GDN $STRUCT alphaM $a0 disabled

					switch $SMatrix {

						Current {
							TK_DWSet $GDN $STRUCT betaKinit 0.0 disabled
							TK_DWSet $GDN $STRUCT betaKcomm 0.0 disabled
							TK_DWSet $GDN $STRUCT betaK $a1	disabled
						}

						Initial {
							TK_DWSet $GDN $STRUCT betaK 0.0 disabled
							TK_DWSet $GDN $STRUCT betaKcomm 0.0 disabled
							TK_DWSet $GDN $STRUCT betaKinit $a1 disabled
						}

						Committed {
							TK_DWSet $GDN $STRUCT betaKinit 0.0 disabled
							TK_DWSet $GDN $STRUCT betaK 0.0 disabled
							TK_DWSet $GDN $STRUCT betaKcomm $a1 disabled
						}

					}
				}
			}
		}
	return ""
	}
}