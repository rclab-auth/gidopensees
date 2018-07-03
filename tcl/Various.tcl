proc TK_ActiveIntervalinLoads { event args } {

	switch $event {

		INIT {

			set PARENT [lindex $args 0]
			upvar [lindex $args 1] ROW
			set GDN [lindex $args 2]
			set STRUCT [lindex $args 3]
			set QUESTION [lindex $args 4]
			set data [GiD_Info intvdata num]
			set activeInterval [lindex $data 0]
			#set ok [DWLocalSetValue $GDN $STRUCT "Active_Interval:" $activeInterval]
			set cmd "GiD_Process Mescape Data Intervals ChangeInterval"
			set b [Button $PARENT.changeintv -text [= " Change Interval "] -helptext [= "Change Interval"] -command $cmd -state normal]
			grid $b -column 1 -row [expr $ROW] -sticky nw -pady 5

			return ""
		}

		SYNC {

			set GDN [lindex $args 0]
			set STRUCT [lindex $args 1]
			set QUESTION [lindex $args 2]
			set data [GiD_Info intvdata num]
			set activeInterval [lindex $data 0]
			#set ok [DWLocalSetValue $GDN $STRUCT "Active_Interval:" $activeInterval]

			return ""
		}
	}

	return ""
}

proc TK_EditInterval { event args } {

	switch $event {

		CLOSE {

			UpdateInfoBar

			return ""
		}
	}

	return ""
}

proc TK_UpdateInfoBar { event args } {

	switch $event {

		CLOSE {

			UpdateInfoBar

		}
	}

	return ""
}

global SelectedVerticalAxis

proc TK_EditModelDim { event args } {

	global SelectedVerticalAxis
	set PARENT [lindex $args 0]
	upvar [lindex $args 1] ROW
	set GDN [lindex $args 2]
	set STRUCT [lindex $args 3]
	set QUESTION [lindex $args 4]

	switch $event {

		INIT {

			set SelectedVerticalAxis [GiD_AccessValue get GenData Vertical_axis]
			set dim [OpenSees::ReturnProjectDimensions]
			set dummy [DWLocalSetValue $GDN $STRUCT $QUESTION $dim]

			if {$dim == 2} {
					set dummy [DWLocalSetValue $GDN $STRUCT Vertical_axis "Y"]
			} else {
					set dummy [DWLocalSetValue $GDN $STRUCT Vertical_axis $SelectedVerticalAxis]
			}

			return ""
		}
	}

	return ""
}

proc TK_ElementWikiInfo { event args } {

	switch $event {

		INIT {

			set PARENT [lindex $args 0]
			upvar [lindex $args 1] ROW
			set GDN [lindex $args 2]
			set STRUCT [lindex $args 3]
			set QUESTION [lindex $args 4]
			set ElemType [DWLocalGetValue $GDN $STRUCT "Element_type:"]

			switch $ElemType {

				"ElasticBeamColumn" {
						set cmd "VisitWeb http://opensees.berkeley.edu/wiki/index.php/Elastic_Beam_Column_Element"
				}
				"ElasticTimoshenkoBeamColumn" {
						set cmd "VisitWeb http://opensees.berkeley.edu/wiki/index.php/Elastic_Timoshenko_Beam_Column_Element"
				}
				"forceBeamColumn" {
						set cmd "VisitWeb http://opensees.berkeley.edu/wiki/index.php/Force-Based_Beam-Column_Element"
				}
				"Truss" {
						set cmd "VisitWeb http://opensees.berkeley.edu/wiki/index.php/Truss_Element"
				}
				"CorotationalTruss" {
						set cmd "VisitWeb http://opensees.berkeley.edu/wiki/index.php/Corotational_Truss_Element"
				}
				"Quad" {
						set cmd "VisitWeb http://opensees.berkeley.edu/wiki/index.php/Quad_Element"
				}
				"Shell" {
						set cmd "VisitWeb http://opensees.berkeley.edu/wiki/index.php/Shell_Element"
				}
				"ShellDKGQ" {
						set cmd "VisitWeb http://opensees.berkeley.edu/wiki/index.php/ShellDKGQ"
				}
				"Tri31" {
						set cmd "VisitWeb http://opensees.berkeley.edu/wiki/index.php/Tri31_Element"
				}
				"QuadUP" {
						set cmd "VisitWeb http://opensees.berkeley.edu/wiki/index.php/Four_Node_Quad_u-p_Element"
				}
				"stdBrick" {
						set cmd "VisitWeb http://opensees.berkeley.edu/wiki/index.php/Standard_Brick_Element"
				}
				"dispBeamColumn" {
						set cmd "VisitWeb http://opensees.berkeley.edu/wiki/index.php/Displacement-Based_Beam-Column_Element"
				}
				"dispBeamColumnInt" {
						set cmd "VisitWeb http://opensees.berkeley.edu/wiki/index.php/Flexure-Shear_Interaction_Displacement-Based_Beam-Column_Element"
				}

			}

			image create photo wiki -format PNG -file [file join [OpenSees::GetProblemTypePath] img/Menu/mnu_Wiki.png]
			set b [Button $PARENT.wikiinfo -image wiki -text [= " Element Info "] -helptext [= "Visit OpenSees Wiki for more information"] -command $cmd -state normal -compound left]
			grid $b -column 1 -row [expr $ROW+1] -sticky nw -pady 5

			return ""
		}
	}

	return ""
}

proc TK_MaterialWikiInfo { event args } {

	switch $event {

		INIT {

			set PARENT [lindex $args 0]
			upvar [lindex $args 1] ROW
			set GDN [lindex $args 2]
			set STRUCT [lindex $args 3]
			set QUESTION [lindex $args 4]
			set MatType [DWLocalGetValue $GDN $STRUCT "Material:"]

			switch $MatType {

				"Elastic" {
						set cmd "VisitWeb http://opensees.berkeley.edu/wiki/index.php/Elastic_Uniaxial_Material"
				}
				"ElasticPerfectlyPlastic" {
						set cmd "VisitWeb http://opensees.berkeley.edu/wiki/index.php/Elastic-Perfectly_Plastic_Material"
				}
				"ElasticPerfectlyPlasticwithGap" {
						set cmd "VisitWeb http://opensees.berkeley.edu/wiki/index.php/Elastic-Perfectly_Plastic_Gap_Material"
				}
				"Viscous" {
						set cmd "VisitWeb http://opensees.berkeley.edu/wiki/index.php/Viscous_Material"
				}
				"Concrete01" {
						set cmd "VisitWeb http://opensees.berkeley.edu/wiki/index.php/Concrete01_Material_--_Zero_Tensile_Strength"
				}
				"Concrete02" {
						set cmd "VisitWeb http://opensees.berkeley.edu/wiki/index.php/Concrete02_Material_--_Linear_Tension_Softening"
				}
				"Concrete06" {
						set cmd "VisitWeb http://opensees.berkeley.edu/wiki/index.php/Concrete06_Material"
				}
				"Concrete04" {
						set cmd "VisitWeb http://opensees.berkeley.edu/wiki/index.php/Concrete04_Material_--_Popovics_Concrete_Material"
				}
				"ConcreteCM" {
						set cmd "VisitWeb http://opensees.berkeley.edu/wiki/index.php/ConcreteCM_-_Complete_Concrete_Model_by_Chang_and_Mander_(1994)"
				}
				"Steel01" {
						set cmd "VisitWeb http://opensees.berkeley.edu/wiki/index.php/Steel01_Material"
				}
				"Steel02" {
						set cmd "VisitWeb http://opensees.berkeley.edu/wiki/index.php/Steel02_Material_--_Giuffr%C3%A9-Menegotto-Pinto_Model_with_Isotropic_Strain_Hardening"
				}
				"ReinforcingSteel" {
						set cmd "VisitWeb http://opensees.berkeley.edu/wiki/index.php/Reinforcing_Steel_Material"
				}
				"RambergOsgoodSteel" {
						set cmd "VisitWeb http://opensees.berkeley.edu/wiki/index.php/RambergOsgoodSteel_Material"
				}
				"ElasticIsotropic" {
						set cmd "VisitWeb http://opensees.berkeley.edu/wiki/index.php/Elastic_Isotropic_Material"
				}
				"ElasticOrthotropic" {
						set cmd "VisitWeb http://opensees.berkeley.edu/wiki/index.php/Elastic_Orthotropic_Material"
				}
				"J2Plasticity" {
						set cmd "VisitWeb http://opensees.berkeley.edu/wiki/index.php/J2_Plasticity_Material"
				}
				"Damage2p" {
						set cmd "VisitWeb http://opensees.berkeley.edu/wiki/index.php/Damage2p"
				}
				"PressureIndependMultiYield" {
						set cmd "VisitWeb http://opensees.berkeley.edu/wiki/index.php/PressureIndependMultiYield_Material"
				}
				"PressureDependMultiYield" {
						set cmd "VisitWeb http://opensees.berkeley.edu/wiki/index.php/PressureDependMultiYield_Material"
				}
				"Series" {
						set cmd "VisitWeb http://opensees.berkeley.edu/wiki/index.php/Series_Material"
				}
				"Parallel" {
						set cmd "VisitWeb http://opensees.berkeley.edu/wiki/index.php/Parallel_Material"
				}
				"Hysteretic" {
						set cmd "VisitWeb http://opensees.berkeley.edu/wiki/index.php/Hysteretic_Material"
				}
				"InitStrain" {
						set cmd "VisitWeb http://opensees.berkeley.edu/wiki/index.php/Initial_Strain_Material"
				}
				"InitStress" {
						set cmd "VisitWeb http://opensees.berkeley.edu/wiki/index.php/Initial_Stress_Material"
				}
				"ViscousDamper" {
						set cmd "VisitWeb http://opensees.berkeley.edu/wiki/index.php/ViscousDamper_Material"
				}
				"HyperbolicGap" {
						set cmd "VisitWeb http://opensees.berkeley.edu/wiki/index.php/Hyperbolic_Gap_Material"
				}
				"PySimple1" {
						set cmd "VisitWeb http://opensees.berkeley.edu/wiki/index.php/PySimple1_Material"
				}
				"TzSimple1" {
						set cmd "VisitWeb http://opensees.berkeley.edu/wiki/index.php/TzSimple1_Material"
				}
				"QzSimple1" {
						set cmd "VisitWeb http://opensees.berkeley.edu/wiki/index.php/QzSimple1_Material"
				}
				"MinMax" {
						set cmd "VisitWeb http://opensees.berkeley.edu/wiki/index.php/MinMax_Material"
				}
				"BondSP01" {
						set cmd "VisitWeb http://opensees.berkeley.edu/wiki/index.php/Bond_SP01_-_-_Strain_Penetration_Model_for_Fully_Anchored_Steel_Reinforcing_Bars"
				}
			}

			image create photo wiki -format PNG -file [file join [OpenSees::GetProblemTypePath] img/Menu/mnu_Wiki.png]
			set b [Button $PARENT.wikiinfo -image wiki -text [= " Material info "] -helptext [= "Visit OpenSees Wiki for more information"] -command $cmd -state normal -compound left]
			grid $b -column 1 -row [expr $ROW+1] -sticky nw -pady 5

			return ""
		}
	}

	return ""
}

proc TK_SectionWikiInfo { event args } {

	switch $event {

		INIT {

			set PARENT [lindex $args 0]
			upvar [lindex $args 1] ROW
			set GDN [lindex $args 2]
			set STRUCT [lindex $args 3]
			set QUESTION [lindex $args 4]
			set SecType [DWLocalGetValue $GDN $STRUCT "Section:"]

			switch $SecType {

					"ElasticSection" {
							set cmd "VisitWeb http://opensees.berkeley.edu/wiki/index.php/Elastic_Section"
					}
					"Fiber" {
							set cmd "VisitWeb http://opensees.berkeley.edu/wiki/index.php/Fiber_Section"
					}
					"FiberInt" {
							set cmd "VisitWeb http://opensees.berkeley.edu/wiki/index.php/Flexure-Shear_Interaction_Displacement-Based_Beam-Column_Element"
					}
					"PlateFiber" {
							set cmd "VisitWeb http://opensees.berkeley.edu/wiki/index.php/Plate_Fiber_Section"
					}
					"ElasticMembranePlate" {
							set cmd "VisitWeb http://opensees.berkeley.edu/wiki/index.php/Elastic_Membrane_Plate_Section"
					}
					"SectionAggregator" {
							set cmd "VisitWeb http://opensees.berkeley.edu/wiki/index.php/Section_Aggregator"
					}
					"LayeredShell" {
							set cmd "VisitWeb http://www.luxinzheng.net/publication6/Shell_wall_element_OpenSees_FEAD_2015.htm"
					}
					"FiberCustom" {
							set cmd "VisitWeb http://opensees.berkeley.edu/wiki/index.php/Fiber_Section"
					}
			}

			image create photo wiki -format PNG -file [file join [OpenSees::GetProblemTypePath] img/Menu/mnu_Wiki.png]
			set b [Button $PARENT.wikiinfo -image wiki -text [= " Section info "] -helptext [= "Visit OpenSees Wiki for more information"] -command $cmd -state normal -compound left]
			grid $b -column 1 -row [expr $ROW+1] -sticky nw -pady 5

			return ""
		}
	}

	return ""
}

proc TK_ZeroLengthWikiInfo { event args } {

	switch $event {

		INIT {

			set PARENT [lindex $args 0]
			upvar [lindex $args 1] ROW
			set cmd "VisitWeb http://opensees.berkeley.edu/wiki/index.php/ZeroLength_Element"

			image create photo wiki -format PNG -file [file join [OpenSees::GetProblemTypePath] img/Menu/mnu_Wiki.png]
			set b [Button $PARENT.wikiinfo -image wiki -text [= " Element Info "] -helptext [= "Visit OpenSees Wiki for more information"] -command $cmd -state normal -compound left]
			grid $b -column 1 -row [expr $ROW+1] -sticky nw -pady 5
		}
	}

	return ""
}

proc TK_MassWikiInfo { event args } {

	switch $event {

		INIT {

			set PARENT [lindex $args 0]
			upvar [lindex $args 1] ROW
			set cmd "VisitWeb http://opensees.berkeley.edu/wiki/index.php/Mass_Command"

			image create photo wiki -format PNG -file [file join [OpenSees::GetProblemTypePath] img/Menu/mnu_Wiki.png]
			set b [Button $PARENT.wikiinfo -image wiki -text [= " More info "] -helptext [= "Visit OpenSees Wiki for more information"] -command $cmd -state normal -compound left]
			grid $b -column 1 -row [expr $ROW+1] -sticky nw -pady 5
		}
	}

	return ""
}

proc TK_RigidDiaphragmWikiInfo { event args } {

	switch $event {

		INIT {

			set PARENT [lindex $args 0]
			upvar [lindex $args 1] ROW
			set cmd "VisitWeb http://opensees.berkeley.edu/wiki/index.php/RigidDiaphragm_command"

			image create photo wiki -format PNG -file [file join [OpenSees::GetProblemTypePath] img/Menu/mnu_Wiki.png]
			set b [Button $PARENT.wikiinfo -image wiki -text [= " More Info "] -helptext [= "Visit OpenSees Wiki for more information"] -command $cmd -state normal -compound left]
			grid $b -column 1 -row [expr $ROW+1] -sticky nw -pady 5
		}
	}

	return ""
}

proc TK_RigidLinkWikiInfo { event args } {

	switch $event {

		INIT {

			set PARENT [lindex $args 0]
			upvar [lindex $args 1] ROW
			set cmd "http://opensees.berkeley.edu/wiki/index.php/RigidLink_command"

			image create photo wiki -format PNG -file [file join [OpenSees::GetProblemTypePath] img/Menu/mnu_Wiki.png]
			set b [Button $PARENT.wikiinfo -image wiki -text [= " More Info "] -helptext [= "Visit OpenSees Wiki for more information"] -command $cmd -state normal -compound left]
			grid $b -column 1 -row [expr $ROW+1] -sticky nw -pady 5
		}
	}

	return ""
}

proc TK_EqualDOFWikiInfo { event args } {

	switch $event {

		INIT {

			set PARENT [lindex $args 0]
			upvar [lindex $args 1] ROW
			set cmd "VisitWeb http://opensees.berkeley.edu/wiki/index.php/EqualDOF_command"

			image create photo wiki -format PNG -file [file join [OpenSees::GetProblemTypePath] img/Menu/mnu_Wiki.png]
			set b [Button $PARENT.wikiinfo -image wiki -text [= " More info "] -helptext [= "Visit OpenSees Wiki for more information"] -command $cmd -state normal -compound left]
			grid $b -column 1 -row [expr $ROW+3] -sticky nw -pady 5
		}
	}

	return ""
}

proc TK_LineLoadsWikiInfo { event args } {

	switch $event {

		INIT {

			set PARENT [lindex $args 0]
			upvar [lindex $args 1] ROW
			set cmd "VisitWeb http://opensees.berkeley.edu/wiki/index.php/EleLoad_Command"

			image create photo wiki -format PNG -file [file join [OpenSees::GetProblemTypePath] img/Menu/mnu_Wiki.png]
			set b [Button $PARENT.wikiinfo -image wiki -text [= " More Info "] -helptext [= "Visit OpenSees Wiki for more information"] -command $cmd -state normal -compound left]
			grid $b -column 1 -row [expr $ROW] -sticky nw -pady 5
		}
	}

	return ""
}

proc TK_LoadsWikiInfo { event args } {

	switch $event {

		INIT {

			set PARENT [lindex $args 0]
			upvar [lindex $args 1] ROW
			set cmd "VisitWeb http://opensees.berkeley.edu/wiki/index.php/NodalLoad_Command"

			image create photo wiki -format PNG -file [file join [OpenSees::GetProblemTypePath] img/Menu/mnu_Wiki.png]
			set b [Button $PARENT.wikiinfo -image wiki -text [= " More info "] -helptext [= "Visit OpenSees Wiki for more information"] -command $cmd -state normal -compound left]
			grid $b -column 1 -row [expr $ROW] -sticky nw -pady 5
		}
	}

	return ""
}

proc TK_DisplacementsWikiInfo { event args } {

	switch $event {

		INIT {

			set PARENT [lindex $args 0]
			upvar [lindex $args 1] ROW
			set cmd "VisitWeb http://opensees.berkeley.edu/wiki/index.php/Sp_Command"

			image create photo wiki -format PNG -file [file join [OpenSees::GetProblemTypePath] img/Menu/mnu_Wiki.png]
			set b [Button $PARENT.wikiinfo -image wiki -text [= " More info "] -helptext [= "Visit OpenSees Wiki for more information"] -command $cmd -state normal -compound left]
			grid $b -column 1 -row [expr $ROW] -sticky nw -pady 5
		}
	}

	return ""
}

proc TK_RestraintsWikiInfo { event args } {

	switch $event {

		INIT {

			set PARENT [lindex $args 0]
			upvar [lindex $args 1] ROW
			set cmd "VisitWeb http://opensees.berkeley.edu/wiki/index.php/Fix_command"

			image create photo wiki -format PNG -file [file join [OpenSees::GetProblemTypePath] img/Menu/mnu_Wiki.png]
			set b [Button $PARENT.wikiinfo -image wiki -text [= " More info "] -helptext [= "Visit OpenSees Wiki for more information"] -command $cmd -state normal -compound left]
			grid $b -column 1 -row [expr $ROW+2] -sticky nw -pady 5
		}
	}

	return ""
}

proc TK_AnalWikiInfo { event args } {

	switch $event {

		INIT {

			set PARENT [lindex $args 0]
			upvar [lindex $args 1] ROW
			set cmd "VisitWeb http://opensees.berkeley.edu/wiki/index.php/Analysis_Commands"

			image create photo wiki -format PNG -file [file join [OpenSees::GetProblemTypePath] img/Menu/mnu_Wiki.png]
			set b [Button $PARENT.wikiinfo -image wiki -text [= " Analysis info "] -helptext [= "Visit OpenSees Wiki for more information"] -command $cmd -state normal -compound left]
			grid $b -column 1 -row [expr $ROW+2] -sticky nw -pady 5

		}
	}

	return ""
}

proc TK_RegionWikiInfo { event args } {

	switch $event {

		INIT {

			set PARENT [lindex $args 0]
			upvar [lindex $args 1] ROW
			set cmd "VisitWeb http://opensees.berkeley.edu/wiki/index.php/Region_Command"

			image create photo wiki -format PNG -file [file join [OpenSees::GetProblemTypePath] img/Menu/mnu_Wiki.png]
			set b [Button $PARENT.wikiinfo -image wiki -text [= " More info "] -helptext [= "Visit OpenSees Wiki for more information"] -command $cmd -state normal -compound left]
			grid $b -column 1 -row [expr $ROW+2] -sticky nw -pady 5
		}
	}

	return ""
}

proc TK_OpenRecordsWindow { event args } {

	switch $event {

		INIT {

			set PARENT [lindex $args 0]
			upvar [lindex $args 1] ROW
			set cmd "GidOpenMaterials Records"

			set b [Button $PARENT.buttonRecordwindow -text [= " Open Records window "] -helptext [= "Open the Records dialog"] -command $cmd -state normal]
			grid $b -column 1 -row [expr $ROW+1] -sticky nw -pady 5

		}
	}

	return ""
}

proc TK_RayleighLabel { event args } {

	switch $event {

		INIT {

			set PARENT [lindex $args 0]
			upvar [lindex $args 1] ROW

			set label [label $PARENT.rayleighInfo -text [= "Activating global Rayleigh damping will OVERRIDE all Rayleigh damping\nparameters assigned to specific regions. Use global Rayleigh damping to\nassign damping to ALL defined elements and nodes.\n"] ]
			grid $label -column 1 -row [expr $ROW+0] -sticky nw
		}
	}

	return ""
}

# Use this procedure instead of DWLocalSetValue if you want to modify the State too

proc TK_DWSet { GDN STRUCT QUESTION VALUE {STATE ""}} {

	upvar #0 $GDN GidData

	if { [catch {set ifld $GidData($STRUCT,LABEL,$QUESTION)}] } {
		set ifld [LabelField $GDN $STRUCT $QUESTION]
	}
	if { $ifld == -1 } {
		error [_ "Invalid question access in DWSetValue for : %s" $QUESTION]
	} else {
		if {$STATE eq ""} {
				set GidData($STRUCT,VALUE,$ifld) $VALUE
		} else {
				array set action {
				normal   DepActionRESTORE
				hidden   DepActionHIDE
				disabled DepActionSET
				}
				# no state checking!!!
				$action($STATE) $GDN $STRUCT $ifld $VALUE
		}
	}
}

proc Bas_round { x y } {

	set ans [expr int($x/$y)]
	return $ans

}

proc Bas_mod { x y } {

	set ans [expr fmod ($x,$y)]

return $ans
}

proc TK_PMY-ID { event args } {

	switch $event {

		INIT {

			lassign $args PARENT current_row_variable GDN STRUCT QUESTION

			set ChosenMaterial [DWLocalGetValue $GDN $STRUCT "Material"]
			set MatType [GiD_AccessValue get materials $ChosenMaterial "Material:"]

			if { $MatType == "PressureDependMultiYield" || $MatType == "PressureIndependMultiYield" } {
					set matnumber [expr [lsearch [GiD_Info materials] $ChosenMaterial]+1]
					set ok [DWLocalSetValue $GDN $STRUCT $QUESTION $matnumber]

			} else {
					set ok [DWLocalSetValue $GDN $STRUCT $QUESTION 0]
			}

		}

		SYNC {

			lassign $args GDN STRUCT QUESTION
			set ChosenMaterial [DWLocalGetValue $GDN $STRUCT "Material"]
			set MatType [GiD_AccessValue get materials $ChosenMaterial "Material:"]

			if { $MatType == "PressureDependMultiYield" || $MatType == "PressureIndependMultiYield" } {
					set matnumber [expr [lsearch [GiD_Info materials] $ChosenMaterial]+1]
					set ok [DWLocalSetValue $GDN $STRUCT $QUESTION $matnumber]

			} else {
					set ok [DWLocalSetValue $GDN $STRUCT $QUESTION 0]
			}
		}
	}

	return ""
}

proc TK_LocalAxesInfo { event args } {

	switch $event {

		INIT {

			set PARENT [lindex $args 0]
			upvar [lindex $args 1] ROW

			set cmd {WarnWinText "LOCAL AXES INFO\n\nThe local-x longitudinal axis is always specified by the positive element direction\n(View -> Normals -> Lines)\n\nIN A 2D PROBLEM :\n\nLocal-x axis coincides with the element positive direction\nLocal-z axis coincides with the global Z axis direction\nLocal-y axis is found by the right hand rule\n\nIN A 3D PROBLEM :\n\nVERTICAL axis is user-specified (Y or Z) in Modeling Options\n\nFor a horizontal element :\nLocal-x axis coincides with the element positive direction\nLocal-z coincides with the direction of the defined VERTICAL axis (global Y or Z)\nLocal-y axis is found by the right hand rule\n\nFor a vertical element :\nLocal-x axis coincides with the element positive direction\nLocal-z positive direction coincides with the global X axis negative direction\nLocal-y axis is found by the right hand rule\n\nFor an oblique element :\nVector Vecxz has the direction of the defined VERTICAL axis (global Y or Z)\nLocal-x axis direction (Vx) coincides with the element positive direction\nLocal-y axis direction (Vy) is found by the cross product Vy = Vecxz x Vx\nLocal-z axis direction (Vz) is found by the cross product Vz = Vx x Vy" "Local axes info"}
			image create photo axes -format PNG -file [file join [OpenSees::GetProblemTypePath] img/Menu/btn_Axes.png]
			set b [Button $PARENT.axesinfo -image axes -text [= " Local axes info "] -helptext [= "Display local axes information"] -command $cmd -state normal -compound left]

			grid $b -column 1 -row [expr $ROW] -sticky nw -pady 5
		}
	}

	return ""
}
