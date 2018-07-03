namespace eval SecAggregator {}

proc SecAggregator::CheckFieldValues { event args } {

	switch $event {

		INIT {

			set PARENT [lindex $args 0]
			upvar [lindex $args 1] ROW

			set label [label $PARENT.info -text [= "Section Force-Deformation response for a particular section DOF:"] ]
			grid $label -column 0 -row [expr $ROW+0] -sticky nw
		}

		SYNC {
			set GDN [lindex $args 0]
			set STRUCT [lindex $args 1]
			set QUESTION [lindex $args 2]

			set thisSectionType [DWLocalGetValue $GDN $STRUCT Section:]
			set SelectSection [DWLocalGetValue $GDN $STRUCT Select_Section]
			set ChosenSection [DWLocalGetValue $GDN $STRUCT $QUESTION]
			set SecType [GiD_AccessValue get materials $ChosenSection "Section:"]

			set CompatibleMaterials " \
			Elastic \
			ElasticPerfectlyPlastic \
			ElasticPerfectlyPlasticwithGap \
			Steel01 \
			ReinforcingSteel \
			Hysteretic \
			Concrete01 \
			Concrete02 \
			Concrete04 \
			Concrete06 \
			InitStrain \
			InitStress \
			Series \
			Parallel \
			"

			if { $SelectSection == 1 } {
			if { $SecType != "Fiber" && $SecType != "ElasticSection" && $SecType != "FiberCustom"} {
				WarnWinText "Section $ChosenSection ($SecType Section) can not be used for Section Aggregator Object."
				WarnWinText "Use a Fiber section instead."

				# Change the value of the field "Section_to_be_aggregated" to Fiber

				DWLocalSetValue $GDN $STRUCT $QUESTION "Fiber"
			}
			}

			# count activated materials
			set MatCounter 0

			if { [DWLocalGetValue $GDN $STRUCT Activate_P]==1 } {
				lappend ChosenMaterials [DWLocalGetValue $GDN $STRUCT Axial_force-deformation]
				incr MatCounter 1
			}
			if { [DWLocalGetValue $GDN $STRUCT Activate_Mz]==1 } {
				lappend ChosenMaterials [DWLocalGetValue $GDN $STRUCT Moment-curvature_about_local_z-z]
				incr MatCounter 1
			}
			if { [DWLocalGetValue $GDN $STRUCT Activate_Vy]==1 } {
				lappend ChosenMaterials [DWLocalGetValue $GDN $STRUCT Shear_force-deformation_along_local_y-y]
				incr MatCounter 1
			}
			if { [DWLocalGetValue $GDN $STRUCT Activate_My]==1 } {
				lappend ChosenMaterials [DWLocalGetValue $GDN $STRUCT Moment-curvature_about_local_y-y]
				incr MatCounter 1
			}
			if { [DWLocalGetValue $GDN $STRUCT Activate_Vz]==1 } {
				lappend ChosenMaterials [DWLocalGetValue $GDN $STRUCT Shear_force-deformation_along_local_z-z]
				incr MatCounter 1
			}
			if { [DWLocalGetValue $GDN $STRUCT Activate_T]==1 } {
				lappend ChosenMaterials [DWLocalGetValue $GDN $STRUCT Torsion_force-deformation]
				incr MatCounter 1
			}

			if {$MatCounter} {
				foreach mat $ChosenMaterials {
					if {![catch {GiD_AccessValue get materials $mat "Material:"}]} {

						set matType [GiD_AccessValue get materials $mat "Material:"]

						if { [lsearch $CompatibleMaterials $matType]==-1 } {

							WarnWinText "Uncompatible Material ($matType) selected for $thisSectionType Section"
						}
					} else {

						WarnWinText "Uncompatible material selected for $thisSectionType Section"
					}
				}
			}
		}
	}

	return ""
}